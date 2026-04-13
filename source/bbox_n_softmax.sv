`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 14:05:24
// Design Name: 
// Module Name: bbox_n_softmax
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// composition of o_bbox[95:0]
//            output [15:0] o_prob,     // 16.10
//            output [15:0] o_class,
//            output [15:0] o_sx,
//            output [15:0] o_ex,
//            output [15:0] o_sy,
//            output [15:0] o_ey,
// 

module bbox_n_softmax (
		// SSD bbox
        input i_en,
        input [17:0] i_din,
        input [10:0] i_th,          // 11.10
        output o_en,
        output [95:0] o_bbox,
        output reg o_bbox_done = 1'b0,
        input i_det_reset,
		// Softmax
        input i_sm_en,
        input [15:0] i_sm_half,
        output o_sm_en,
        output [10:0] o_sm_top1_class,	
        output [10:0] o_sm_top1_score,	// 11.10
        input i_sm_restart,
        //
        input [10:0] i_n_classm1,
		input [1:0] i_relu,
		// multi-scale function
		input multiscale,
		input [31:0] scale_offset,
        input clk
    );

	// SSD BBox
	// ========
    
    enum bit [5:0] {S_BOX_IDLE, S_BOX_Z0, S_BOX_Z1, S_BOX_Z2, S_BOX_Z3, S_BOX_P1, S_BOX_P2, S_BOX_P3, S_BOX_P4, S_BOX_P5, S_BOX_P6, S_BOX_P7,
                    S_WAIT_CLASS, S_CLASS_1, S_BOX_DONE} ssd_box_state = S_BOX_IDLE;

    logic [24:0] int_s2414i, int_s2414o, half_test_s2414;
    logic [15:0] coeff, sig_header_out;
    logic [40:0] int_s4028;
    logic [28:0] int_s2816;
    logic [27:0] int_s2716;
    logic [18:0] sig_flag_header, reg_flag_header, reg_din;
    logic [2:0] sig_tab, sig_tab_delayed, sig_tab_delayed2;
    logic [15:0] reg_mul_out, sig_z0z1_out, reg_z2z3_score_out;
    logic [2:0] det_scale, det_ai;
    logic [4:0] det_yi, det_xi;
    logic [2:0] delay_cnt;
    logic [23:0] sig_w_h;
    logic [31:0] sig_gridinfo;
    logic [11:0] sig_w, sig_h;
    logic [15:0] sig_cx, sig_cy, sig_dx, sig_dy;
    logic [15:0] box_mul_a, box_mul_b, box_mul_a2, box_mul_b2;
    logic [16:0] box_cx, box_cy;
    logic [31:0] box_mul_c, box_mul_c_adj, box_mul_c2, box_mul_c_adj2;
    logic [15:0] sig_exp_in, sig_exp_out, delayed_exp, sig_add_out, sig_recip_out, reg_float;
    logic [15:0] sig_Z0, sig_Z1;
    logic signed [15:0] sig_z1mz3, sig_z1pz3;
    logic [10:0] sig_classi;
    logic [15:0] sig_P0, sig_P1, sig_P2, sig_P3;
    logic [15:0] sig_sx, sig_sy, sig_ex, sig_ey;
    logic reg_o_en = 0;
    logic [15:0] reg_prob = 0;
    logic [15:0] reg_class = 0;
    logic [15:0] reg_sx = 0, reg_sy = 0, reg_ex = 0, reg_ey = 0;
    logic reg_last;

    // you also need to change the contents of the tables
    localparam SCR_W = 16'h03E7; // 999
    localparam SCR_H = 16'h03E7; // 999

	// Softmax
	// =======
    
    enum bit [3:0] {S_SM_IDLE, S_SM_MAX_IN, S_DELAY, S_SM_EXP, S_SM_EXP_FLUSH, S_SM_SOFTMAX_DONE} sm_state = S_SM_IDLE;
    
    logic [27:0] sm_int_in, sm_maxq_dout, sm_max_in = 0, sm_reg_x, sm_sig_exp_int, sm_top1_exp_int, sm_sig_top1_score_int;
    logic [17:0] sm_top1_exp_int_18;
    logic signed [27:0] sm_sig_expsum_int;
    logic signed [27:0] sm_reg_x_m_max_int, sm_1over_expsum_int;
    logic [17:0] sm_1over_expsum_int_18;
    logic [15:0] sm_sig_exp_half, sm_top1_exp_half, sm_sig_expsum_half, sm_1over_expsum_half, sm_sig_top1_score_half;
    logic [2:0] sm_en_train_in;
    logic [29:0] sm_en_train_exp;
    logic [6:0] sm_flush_count;
    logic sm_maxq_empty, sm_exp_en = 0;
    logic [10:0] sm_class_count_in = 0, sm_class_count_exp = 0, sm_class_count_expsum = 0, sm_top1_class;
    logic [3:0] sm_delay_count;
    logic sm_reg_sm_o_en = 1'b0;
    logic [10:0] sm_reg_top1_score, sm_reg_top1_class;
    logic [35:0] sm_top1_score_36_24;
    
    logic [10:0] reg_scale;
    logic [9:0] reg_offx, reg_offy;
    

	// SSD BBox
	// ========

    assign o_en = reg_o_en;
    assign o_bbox[15:0] = reg_prob;   // 16.10
    assign o_bbox[31:16] = reg_class;
    assign o_bbox[47:32] = reg_sx;    // pixel (0 - 999)
    assign o_bbox[63:48] = reg_sy;
    assign o_bbox[79:64] = reg_ex;
    assign o_bbox[95:80] = reg_ey;
    
    D_SSD_5 delay5 (    // delay = 2
        .CLK(clk),
        .D({i_en, i_din}),      // t0
        .Q(sig_flag_header)     // t2
    );

    always @ (posedge clk) begin
        reg_flag_header <= sig_flag_header; // t2 -> t3
        reg_din <= reg_flag_header; // t3 -> t4
    end

    D_SSD_0 delay0 (        // w = 3, delay = 34
        .CLK(clk),
        .D(reg_din[18:16]), // t4
        .Q(sig_tab)         // t38
    );

    D_SSD_4 delay4 (        // w = 3, delay = 4
        .CLK(clk),
        .D(sig_tab),        // t38
        .Q(sig_tab_delayed) // t42
    );

    D_SSD_1 delay1 (        // w = 16, delay = 38
        .CLK(clk),
        .D(reg_din[15:0]),  // t4
        .Q(sig_header_out)  // t42
    );

    conv_half_s2414 half2int_i (  // delay = 3
        .clk(clk),
        .i_half(i_din[15:0]),   // t0
        .o_int(int_s2414i)        // t3
    );

    mul_25x16 mul_25x16 (   // delay = 3
      .CLK(clk),        // input wire CLK
      .A(int_s2414i),    // input wire [24 : 0] A   // t3, s24.14 t3
      .B(coeff),        // input wire [15 : 0] B   // s15.14
      .P(int_s4028)     // output wire [40 : 0] P  // t6, s40.28
    );
    
    // convert from s40.28 to s15.10 (t6 -> t7)
    
    always @ (posedge clk) begin
        // 더하거나 빼도 오버플로가 생기지 않게 사인 비트를 두 개 둔다
        if (~int_s4028[40] && int_s4028[39:32]!=8'd0)
            reg_mul_out <= 16'h3fff;
        else if (int_s4028[40] && int_s4028[39:32]!={8{1'b1}})
            reg_mul_out <= 16'hC000;
        else
            reg_mul_out <= {int_s4028[40], int_s4028[40], int_s4028[31:18]};
        
        if (int_s4028[40:39]==2'b01)
            int_s2716 <= 28'h7ffffff;
        else if (int_s4028[40:39]==2'b10)
            int_s2716 <= 28'h8000000;
        else
            int_s2716 <= {int_s4028[40], int_s4028[38:12]};

        case (sig_flag_header[17:16])   // t2 -> t3
        2'b01:      coeff <= 16'h0CCD;   // 0.2
        2'b10:      coeff <= 16'hBFFF;   // -1
        endcase
    end
    
    D_SSD_2 delay2 (        // w = 16, delay = 36
        .CLK(clk),
        .D(reg_mul_out),    // t7
        .Q(sig_z0z1_out)    // t43
    );
    
    conv_s2716real_half int2half (  // delay = 3
        .clk(clk),
        .i_int((i_relu==2'b11)?sm_reg_x_m_max_int:int_s2716),  // t7
        .o_half(sig_exp_in) // t10
    );

    half_exp fp_exp (     // delay = 13
      .aclk(clk),                       // input wire aclk
      .s_axis_a_tvalid(1'b1),           // input wire s_axis_a_tvalid
      .s_axis_a_tdata(sig_exp_in),      // input wire [15 : 0] s_axis_a_tdata,          t10
      .m_axis_result_tvalid(),          // output wire m_axis_result_tvalid
      .m_axis_result_tdata(sig_exp_out)     // output wire [15 : 0] m_axis_result_tdata,    t23
    );
    assign sm_sig_exp_half = sig_exp_out;
    
    D_SSD_3 delay3 (        // w = 16, delay = 15
        .CLK(clk),
        .D(sig_exp_out),    // t23
        .Q(delayed_exp)     // t38
    );

    half_add fp_add (   // delay = 11
      .aclk(clk),                       // input wire aclk
      .s_axis_a_tvalid(1'b1),           // input wire s_axis_a_tvalid
      .s_axis_a_tdata(sig_exp_out),     // input wire [15 : 0] s_axis_a_tdata           t23
      .s_axis_b_tvalid(1'b1),           // input wire s_axis_b_tvalid
      .s_axis_b_tdata(16'h3c00),        // input wire [15 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(),          // output wire m_axis_result_tvalid
      .m_axis_result_tdata(sig_add_out) // output wire [15 : 0] m_axis_result_tdata     t34
    );
    
    half_recip fp_recip (   // delay = 4
      .aclk(clk),                       // input wire aclk
      .s_axis_a_tvalid(1'b1),           // input wire s_axis_a_tvalid
      .s_axis_a_tdata((i_relu==2'b11)?sm_sig_expsum_half:sig_add_out),     // input wire [15 : 0] s_axis_a_tdata           t34, t_expsum(24)
      .m_axis_result_tvalid(),          // output wire m_axis_result_tvalid
      .m_axis_result_tdata(sig_recip_out) // output wire [15 : 0] m_axis_result_tdata   t38, t_expsum(28)
    );
    assign sm_1over_expsum_half = sig_recip_out;    // t_expsum(28)
    
    conv_half_s2414 half2int_o (
        .clk(clk),
        .i_half(reg_float), // t39
        .o_int(int_s2414o)  // t42
    );

    always @ (posedge clk) begin
        // t38 -> t39
        case (sig_tab)
        3'b101: reg_float <= delayed_exp;
        3'b110: reg_float <= sig_recip_out;
        endcase
        
        // s24.14 --> s15.10
        // t42 -> t43
        // 더하거나 빼도 오버플로가 생기지 않게 사인 비트를 두 개 둔다
        if (~int_s2414o[24] && int_s2414o[23:18]!=6'd0)
            reg_z2z3_score_out <= 16'h3fff;
        else if (int_s2414o[24] && int_s2414o[23:18]!={6{1'b1}})
            reg_z2z3_score_out <= 16'hC000;
        else
            reg_z2z3_score_out <= {int_s2414o[24], int_s2414o[24], int_s2414o[17:4]};
    end

    ssd_bbox bbox_db (
        .clk(clk),
        .a({det_scale, det_ai}),    // t42
        .qspo(sig_w_h)
    );

    ssd_grid_1 grid_mem1 (
        .clk(clk),
        .a({1'b0,det_scale}),       // t42
        .qspo(sig_gridinfo)   // t44
    );

    box_mul bbox_mul (  // delay = 1
        .CLK(clk),
        .A(box_mul_a),
        .B(box_mul_b),
        .P(box_mul_c)
    ); 

    box_mul bbox_mul2 ( // delay = 1
        .CLK(clk),
        .A(box_mul_a2),
        .B(box_mul_b2),
        .P(box_mul_c2)
    ); 
   
    // state transition
    // with
    // sig_tab_delayed, sig_header_out(16) at t42
    // sig_tab_delayed2(3), sig_z0z1_out(s20.12), reg_z2z3_score_out(s20.12) at t43

    // available from t45
    assign sig_h = sig_w_h[23:12]; // 12.2 bh (H=1000)
    assign sig_w = sig_w_h[11:0];  // 12.2 bw (W=1000)

    always @ (posedge clk) begin

        sig_dy <= sig_gridinfo[15:0];   // 16.5
        sig_dx <= sig_gridinfo[15:0];   // 16.5
        sig_cy <= sig_gridinfo[31:16];  // 16.5
        sig_cx <= sig_gridinfo[31:16];  // 16.5
        reg_scale <= multiscale ? scale_offset[30:20] : 11'd1024;
        reg_offx <= multiscale ? scale_offset[9:0] : 10'd0;
        reg_offy <= multiscale ? scale_offset[19:10] : 10'd0;

        // t42 -> t43
        sig_tab_delayed2 <= sig_tab_delayed;
        reg_last <= sig_header_out[0];
        
        // t42
        if (sig_tab_delayed==3'b100) begin
            det_scale <= sig_header_out[15:13];
            det_yi <= sig_header_out[12:8];
            det_xi <= sig_header_out[7:3];
            det_ai <= sig_header_out[2:0];
        end

        case (ssd_box_state)
        S_BOX_IDLE: begin
                // t43
                if (sig_tab_delayed2==3'b100)
                    ssd_box_state <= S_BOX_Z0;
                else if (sig_tab_delayed2==3'b111 && reg_last) begin
                    o_bbox_done <= 1'b1;
                    ssd_box_state <= S_BOX_DONE;
                end
                reg_o_en <= 1'b0;
            end
        S_BOX_Z0: begin
                sig_Z0 <= sig_z0z1_out; // s15.10
                // compute cx, cy
                box_mul_a <= {11'd0, det_yi};   // positive by positive multiplication
                box_mul_b <= sig_dy;    // 16.5
                box_mul_a2 <= {11'd0, det_xi};   // positive by positive multiplication
                box_mul_b2 <= sig_dx;    // 16.5
                ssd_box_state <= S_BOX_Z1;
            end
        S_BOX_Z1: begin
                sig_Z1 <= sig_z0z1_out; // s15.10
                ssd_box_state <= S_BOX_Z2;
            end
        S_BOX_Z2: begin
                // compute y1(Z0 - Z2Z3) and y2(Z0 + Z2Z3)
                box_mul_a <= $signed($signed(sig_Z0) - $signed(reg_z2z3_score_out));  // s15.10
                box_mul_b <= {4'd0, sig_h};    // 12.2
                box_mul_a2 <= $signed($signed(sig_Z0) + $signed(reg_z2z3_score_out));  // s15.10
                box_mul_b2 <= {4'd0, sig_h};    // 12.2
                // handle multiplier outputs
                box_cy <= box_mul_c[15:0] + sig_cy;
                box_cx <= box_mul_c2[15:0] + sig_cx;
                ssd_box_state <= S_BOX_Z3;
            end
        S_BOX_Z3: begin
                // compute x1(Z1 - Z2Z3) and x2(Z1 + Z2Z3)
                box_mul_a <= $signed($signed(sig_Z1) - $signed(reg_z2z3_score_out));  // s15.10
                box_mul_b <= {4'd0, sig_w};    // 12.2
                box_mul_a2 <= $signed($signed(sig_Z1) + $signed(reg_z2z3_score_out));  // s15.10
                box_mul_b2 <= {4'd0, sig_w};    // 12.2
                ssd_box_state <= S_BOX_P1;
            end
        S_BOX_P1: begin
                // handle multiplier outputs
                box_mul_c_adj <= box_mul_c + {box_cy, 7'd0};
                box_mul_c_adj2 <= box_mul_c2 + {box_cy, 7'd0};
                ssd_box_state <= S_BOX_P2;
            end
        S_BOX_P2: begin
                box_mul_a <= box_mul_c_adj[23:8];                                   // 16.4
                box_mul_b <= {5'd0, reg_scale};                                     // 16.10
                box_mul_a2 <= box_mul_c_adj2[23:8];                                 // 16.4
                box_mul_b2 <= {5'd0, reg_scale};                                    // 16.10
                // handle multiplier outputs
                box_mul_c_adj <= box_mul_c + {box_cx, 7'd0};
                box_mul_c_adj2 <= box_mul_c2 + {box_cx, 7'd0};
                ssd_box_state <= S_BOX_P3;
            end
        S_BOX_P3: begin
                box_mul_a <= box_mul_c_adj[23:8];                                   // 16.4
                box_mul_b <= {5'd0, reg_scale};                                     // 16.10
                box_mul_a2 <= box_mul_c_adj2[23:8];                                 // 16.4
                box_mul_b2 <= {5'd0, reg_scale};                                    // 16.10
                ssd_box_state <= S_BOX_P4;
            end
        S_BOX_P4: begin
                box_mul_c_adj <= box_mul_c + {reg_offy, 14'd0};
                box_mul_c_adj2 <= box_mul_c2 + {reg_offy, 14'd0};
                ssd_box_state <= S_BOX_P5;
            end
        S_BOX_P5: begin
                box_mul_c_adj <= box_mul_c + {reg_offx, 14'd0};
                box_mul_c_adj2 <= box_mul_c2 + {reg_offx, 14'd0};
                //
                if (box_mul_c_adj[31])                  sig_sy <= 16'd0;
                else if (box_mul_c_adj[29:14]>SCR_H)    sig_sy <= 16'(SCR_H);
                else                                    sig_sy <= box_mul_c_adj[29:14];
                if (box_mul_c_adj2[31])                 sig_ey <= 16'd0;
                else if (box_mul_c_adj2[29:14]>SCR_H)   sig_ey <= 16'(SCR_H);
                else                                    sig_ey <= box_mul_c_adj2[29:14];
                ssd_box_state <= S_BOX_P6;
            end
        S_BOX_P6: begin
                if (box_mul_c_adj[31])                  sig_sx <= 16'd0;
                else if (box_mul_c_adj[29:14]>SCR_W)    sig_sx <= 16'(SCR_W);
                else                                    sig_sx <= box_mul_c_adj[29:14];
                if (box_mul_c_adj2[31])                 sig_ex <= 16'd0;
                else if (box_mul_c_adj2[29:14]>SCR_W)   sig_ex <= 16'(SCR_W);
                else                                    sig_ex <= box_mul_c_adj2[29:14];
                ssd_box_state <= S_BOX_P7;
            end
        S_BOX_P7: begin
                ssd_box_state <= S_WAIT_CLASS;
            end
        S_WAIT_CLASS: begin
                if (sig_tab_delayed2==3'b110) begin
                    sig_classi <= 11'd1;  // ignore first one
                    ssd_box_state <= S_CLASS_1;
                end
            end
        S_CLASS_1:
            if (sig_tab_delayed2==3'b110) begin
                if (reg_z2z3_score_out[10:0]>=i_th) begin   // 16.10
                    reg_o_en <= 1'b1;
                    reg_prob <= reg_z2z3_score_out;         // 16.10
                    reg_class <= {5'd0, sig_classi - 1'b1};
                    reg_sx <= sig_sx;
                    reg_ex <= sig_ex;
                    reg_sy <= sig_sy;
                    reg_ey <= sig_ey;
                end else                        
                    reg_o_en <= 1'b0;
                if (sig_classi==i_n_classm1)
                    ssd_box_state <= S_BOX_IDLE;
                else
                    sig_classi <= sig_classi + 1'b1;
            end
        S_BOX_DONE: begin
                o_bbox_done <= 1'b0;
                ssd_box_state <= S_BOX_IDLE;
            end
        endcase            

    end




	// Softmax
	// =======
    
    assign o_sm_en = sm_reg_sm_o_en;
    assign o_sm_top1_class = sm_reg_top1_class;
    assign o_sm_top1_score = sm_reg_top1_score;

    
    // convert input in half format to integer
    
    conv_half_s2716 h2i_in (
        .clk(clk),
        .i_half(i_sm_half),    // t0
        .o_int(sm_int_in)      // t3
    );
    
    // collect data for max computation

    sm_maxq softmax_maxq (
      .clk(clk),      // input wire clk
      .din(sm_int_in),      // input wire [27 : 0] din
      .wr_en(sm_en_train_in[2]),  // input wire wr_en
      .rd_en(sm_exp_en),  // input wire rd_en
      .dout(sm_maxq_dout),    // output wire [27 : 0] dout
      .srst(i_sm_restart),
      .full(),    // output wire full
      .empty(sm_maxq_empty)  // output wire empty
    );

    // convert exponential in half format to an integer
    
    conv_half_s2716 h2i_exp (
        .clk(clk),
        .i_half(sm_sig_exp_half),                                          // t_exp(17)
        .o_int(sm_sig_exp_int)                                             // t_exp(20)
    );
    
    conv_s2716real_half i2h_exp_expsum (
        .clk(clk),
        .i_int(sm_sig_expsum_int),                                          // t_expsum(21)
        .o_half(sm_sig_expsum_half)                                         // t_expsum(24)
    );
    
    conv_half_s2716 h2i_1over (
        .clk(clk),
        .i_half(sm_1over_expsum_half),      // t_expsum(28)
        .o_int(sm_1over_expsum_int)         // t_expsum(31)
    );

    mul_18x18 mul_18x18 (
      .CLK(clk),  // input wire CLK
      .A(sm_top1_exp_int_18),      // input wire [17 : 0] A  18.12
      .B(sm_1over_expsum_int_18),      // input wire [17 : 0] B  18.12
      .P(sm_top1_score_36_24)      // output wire [35 : 0] P  36.24
    );
    assign sm_top1_exp_int_18 = (sm_top1_exp_int[27:22]!=6'd0) ? 18'h3ffff : sm_top1_exp_int[21:4];
    assign sm_1over_expsum_int_18 = (sm_1over_expsum_int[27:22]!=6'd0) ? 18'h3ffff : sm_1over_expsum_int[21:4];


    
    always @ (posedge clk) begin
        // timing of sm_en_train_in[0] is t1
        sm_en_train_in[2:1] <= sm_en_train_in[1:0];
        sm_en_train_in[0] <= i_sm_en; // t0
        // timing of sm_en_train_exp[0] is t_exp(1)
        sm_en_train_exp[29:1] <= sm_en_train_exp[28:0];
        sm_en_train_exp[0] <= sm_exp_en;                                          // t_exp(0)
        
        sm_reg_x <= sm_maxq_dout;                                                 // t_exp(0)
        sm_reg_x_m_max_int <= $signed($signed(sm_reg_x) - $signed(sm_max_in));   // t_exp(1)
        
        if (sm_en_train_exp[20]) begin                                              // t_exp(21)
            sm_sig_expsum_int <= sm_sig_expsum_int + sm_sig_exp_int;
            if (sm_class_count_expsum==11'd0) begin                                 // initial condition
                sm_top1_exp_int <= sm_sig_exp_int;
                sm_top1_class <= 11'd0;
            end else if (sm_sig_exp_int>sm_top1_exp_int) begin                      // determin top1 class
                sm_top1_exp_int <= sm_sig_exp_int;
                sm_top1_class <= sm_class_count_expsum;
            end
            sm_class_count_expsum <= sm_class_count_expsum + 1'b1;
        end

        if (i_sm_restart) begin
            sm_exp_en <= 1'b0;
            sm_class_count_in <= 11'd0;
            sm_state <= S_SM_MAX_IN;
        end
        
        case (sm_state)
        S_SM_IDLE, S_SM_MAX_IN: begin
                if (sm_en_train_in[2]) begin
                    if (sm_class_count_in==11'd0 || ($signed(sm_int_in)>$signed(sm_max_in)))
                        sm_max_in <= sm_int_in;
                        
                    if (sm_class_count_in==i_n_classm1) begin
                        sm_delay_count <= 4'd0;
                        sm_state <= S_DELAY;
                    end else
                        sm_class_count_in <= sm_class_count_in + 1'b1;
                end
                sm_reg_sm_o_en <= 1'b0;
            end
        S_DELAY: begin
                if (sm_delay_count==4'd4) begin
                    sm_exp_en <= 1'b1;                         // t_exp(-1)
                    sm_class_count_exp <= 11'd0;
                    sm_sig_expsum_int <= 28'd0;
                    sm_class_count_expsum <= 11'd0;
                    sm_state <= S_SM_EXP;
                end else
                    sm_delay_count <= sm_delay_count + 1'b1;
            end
        S_SM_EXP: begin                                         // t_exp(0)
                if (sm_class_count_exp==i_n_classm1) begin
                    sm_exp_en <= 1'b0; 
                    sm_flush_count <= 7'd65;
                    sm_state <= S_SM_EXP_FLUSH;
                end else
                    sm_class_count_exp <= sm_class_count_exp + 1'b1;
            end
        S_SM_EXP_FLUSH:
            if (sm_flush_count==7'd0) begin    // at this point, top1 results are available
                sm_state <= S_SM_SOFTMAX_DONE;
            end else
                sm_flush_count <= sm_flush_count - 1'b1;
        S_SM_SOFTMAX_DONE: begin
                sm_reg_sm_o_en <= 1'b1;
                sm_reg_top1_class <= sm_top1_class;
                sm_reg_top1_score <= sm_top1_score_36_24[24:14];
                sm_state <= S_SM_IDLE;
            end
        endcase
    end
    
endmodule
