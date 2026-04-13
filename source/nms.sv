`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 20:02:22
// Design Name: 
// Module Name: nms
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


module nms(
        input i_en,
        input [95:0] i_bbox,
        input i_done,
//        //
//        output o_en,
//        output [111:0] o_bbox,
//        output o_done,
        // ddr
        output o_ddr_we,
        input i_ddr_full,
        output [127:0] o_ddr_data,
        //
        output o_disp_en,
        output [73:0] o_disp_box,
        //
        input [10:0] i_nms_th,  // 11.10
		input multiscale,
        input i_reset,
        input clk
    );

    enum bit [5:0] {S_IDLE, S_S1, S_S2, S_S3, S_S4, S_S5, S_S6, S_S7, S_S8, S_S9, S_S10, S_S9_1,
        S_S9_2, S_S10_1, S_S10_2, S_S10_3, S_S10_4, S_S10_5, S_S10_6, S_FINISH, S_FINISH2, S_DUMMY, S_DUMMY2, S_S2_DELAY, S_SF_DELAY} nms_state;
        
    logic [71:0] inq_din, inq_dout, bbq_din = 0, bbq_dout;
    logic inq_rd_en = 0, inq_valid, bbq_wr_en = 0, bbq_rd_en = 0, bbq_full, bbq_empty, bbq_valid;
    logic [23:0] mul_a = 0, d1 = 0, d3 = 0, d1_p_d2 = 0;
    logic [11:0] mul_b = 0;
    logic [35:0] mul_c, reg_mul_c = 0;
    logic toggle = 1'b0, reg_dummy_en = 1'b0;
    logic reg_o_en = 1'b0, reg_o_done = 1'b0;
    logic [71:0] bbox = 0, auxbox = 0, popbox = 0;
    logic [12:0] popboxsz, bboxsz;
    logic [81:0] nmsout = 0;
    logic [9:0] reg_out_seq;
    logic [3:0] state_delay;
    logic ex1_lt_sx2, ex2_lt_sx1, ey1_lt_sy2, ey2_lt_sy1;
    logic [11:0] sx3 = 0, sy3 = 0, ex3 = 0, ey3 = 0, w1 = 0, h1 = 0, w2 = 0, h2 = 0, w3 = 0, h3 = 0;
    
    logic [10:0] inq_data_count, bboxq_data_count;
    
    logic [12:0] dbg_score;
    logic [9:0] dbg_class;
    logic [11:0] dbg_sx, dbg_ex, dbg_sy, dbg_ey;
    
    logic reg_disp_en = 1'b0;
    logic [73:0] reg_disp_box;


    BBQ inQ (
      .clk(clk),      // input wire clk
      .srst(i_reset), // input wire srst
      .din(inq_din),  // input wire [71 : 0] din
      .wr_en(i_en),   // input wire wr_en
      .rd_en(inq_rd_en),  // input wire rd_en
      .dout(inq_dout),    // output wire [71 : 0] dout
      .full(),    // output wire full
      .empty(),   // output wire empty
      .valid(inq_valid),  // output wire valid
      .data_count(inq_data_count)  // output wire [10 : 0] data_count
    );
    
    assign inq_din[12:0] = i_bbox[12:0];    // probability 13.10
    assign inq_din[22:13] = i_bbox[25:16];  // class(10)
    assign inq_din[34:23] = i_bbox[43:32];  // sx (12)
    assign inq_din[46:35] = i_bbox[59:48];  // sy (12)
    assign inq_din[58:47] = i_bbox[75:64];  // ex (12)
    assign inq_din[70:59] = i_bbox[91:80];  // ey (12)
    assign inq_din[71] = 1'b0;
    

    BBQ bboxQ (
      .clk(clk),      // input wire clk
      .srst(i_reset),    // input wire srst
      .din(bbq_din),      // input wire [71 : 0] din
      .wr_en(bbq_wr_en),  // input wire wr_en
      .rd_en(bbq_rd_en),  // input wire rd_en
      .dout(bbq_dout),    // output wire [71 : 0] dout
      .full(bbq_full),    // output wire full
      .empty(bbq_empty),  // output wire empty
      .valid(bbq_valid),  // output wire valid
      .data_count(bboxq_data_count)  // output wire [10 : 0] data_count
    );
    
    nms_mul nms_mul (
      .CLK(clk),  // input wire CLK
      .A(mul_a),      // input wire [23 : 0] A
      .B(mul_b),      // input wire [11 : 0] B
      .P(mul_c)      // output wire [35 : 0] P
    );
    
    
    always @ (posedge clk) begin
        if (i_reset) begin
        
            toggle <= 1'b0;
            auxbox[71] <= 1'b0;
            popbox[71] <= 1'b0;
            nms_state <= S_IDLE;
            
        end else begin
        
            inq_rd_en <= 1'b0;
            bbq_wr_en <= 1'b0;
            bbq_rd_en <= 1'b0;
            reg_o_en <= 1'b0;
            reg_dummy_en <= 1'b0;
            reg_o_done <= 1'b0;
            reg_mul_c <= mul_c;
        

            case (nms_state)
            S_IDLE: if (i_done) nms_state <= S_S1;  // trigger 
            S_S1: begin
                    if (inq_valid) begin
                        bbox[70:0] <= inq_dout[70:0];
                        bbox[71] <= 1'b1;
                        inq_rd_en <= 1'b1;
                        nms_state <= S_S2;
                    end else begin
                        reg_out_seq <= 10'd0;
                        if (auxbox[71]) begin
                            bbq_din[70:0] <= auxbox[70:0];
                            bbq_wr_en <= 1'b1;
                            auxbox[71] <= 1'b0;
                            state_delay <= 4'h2;
                            nms_state <= S_SF_DELAY;
                        end else
                            nms_state <= S_FINISH;
                    end
                end
            S_S2: begin
                    if ((bbq_empty || bbq_dout[71]!=toggle) && ~auxbox[71]) begin
                        auxbox <= bbox;
                        toggle <= ~toggle;
                        nms_state <= S_S1;
                    end else begin
                        if (auxbox[71] && 
                            (bbq_empty || bbq_dout[71]!=toggle || auxbox[12:0]>=bbq_dout[12:0])) begin
                            popbox <= auxbox;
                            auxbox[71] <= 1'b0;
                        end else begin
                            popbox <= {1'b1, bbq_dout[70:0]};
                            bbq_rd_en <= 1'b1;
                        end
                        nms_state <= S_S3;
                    end
                end
            S_S3: begin
                    if (~bbox[71]) 
                        nms_state <= S_S4;
                    else begin   // start checking overlab(bbox,popbox)
                        ex1_lt_sx2 <= (bbox[58:47] < popbox[34:23]); 
                        ex2_lt_sx1 <= (popbox[58:47] < bbox[34:23]);
                        ey1_lt_sy2 <= (bbox[70:59] < popbox[46:35]);
                        ey2_lt_sy1 <= (popbox[70:59] < bbox[46:35]);
                        nms_state <= S_S6;
                    end
                end
            S_S4: begin // not overlap(keep)
                    bbq_din <= {~toggle, popbox[70:0]};
                    bbq_wr_en <= 1'b1;
                    popbox[71] <= 1'b0;
                    state_delay <= 4'h2;
                    nms_state <= S_S2_DELAY;
                end
            S_S5: begin // overlap(remove the one with lower score)
                    if ((multiscale==1'b0 && popbox[12:0]>=bbox[12:0]) ||
                        (multiscale==1'b1 && popboxsz>=bboxsz)) begin
                        bbox[71] <= 1'b0;
                        nms_state <= S_S4;
                    end else
                        nms_state <= S_S2;
                end
            S_S6: begin
                    if (bbox[22:13]!=popbox[22:13] || // this condition enables objects with different classes can overlap
                        ex1_lt_sx2 || ex2_lt_sx1 || ey1_lt_sy2 || ey2_lt_sy1) 
                        // not intersect
                        nms_state <= S_S4;
                    else begin
                        sx3 <= (bbox[34:23]<popbox[34:23]) ? popbox[34:23] : bbox[34:23];
                        sy3 <= (bbox[46:35]<popbox[46:35]) ? popbox[46:35] : bbox[46:35];
                        ex3 <= (bbox[58:47]<popbox[58:47]) ? bbox[58:47] : popbox[58:47];
                        ey3 <= (bbox[70:59]<popbox[70:59]) ? bbox[70:59] : popbox[70:59];
                        nms_state <= S_S7;
                    end
                end
            S_S7: begin
                    w1 <= bbox[58:47] - bbox[34:23];
                    h1 <= bbox[70:59] - bbox[46:35];
                    w2 <= popbox[58:47] - popbox[34:23];
                    h2 <= popbox[70:59] - popbox[46:35];
                    w3 <= ex3 - sx3;
                    h3 <= ey3 - sy3;
                    nms_state <= S_S8;
                end
            S_S8: begin
                    w1 <= w1 + 1'b1; h1 <= h1 + 1'b1;
                    w2 <= w2 + 1'b1; h2 <= h2 + 1'b1;
                    w3 <= w3 + 1'b1; h3 <= h3 + 1'b1;
                    nms_state <= S_S9;
                end
            S_S9: begin
                    mul_a <= {12'd0, w1};
                    mul_b <= h1;
                    nms_state <= S_S9_1;
                end
            S_S9_1: begin
                    mul_a <= {12'd0, w2};
                    mul_b <= h2;
                    nms_state <= S_S9_2;
                end
            S_S9_2: begin
                    mul_a <= {12'd0, w3};
                    mul_b <= h3;
                    nms_state <= S_S10;
                end
            S_S10: begin
                    d1 <= mul_c[23:0];
                    nms_state <= S_S10_1;
                end
            S_S10_1: begin
                    d1_p_d2 <= d1 + mul_c[23:0];
                    nms_state <= S_S10_2;
                end
            S_S10_2: begin
                    d3 <= mul_c[23:0];
                    mul_a <= d1_p_d2 - mul_c[23:0];
                    mul_b <= {3'd0, i_nms_th[10:2]};  // 11.8 ****
                    nms_state <= S_S10_3;
                end
            S_S10_3: nms_state <= S_S10_4;
            S_S10_4: nms_state <= S_S10_5;
            S_S10_5: nms_state <= S_S10_6;
            S_S10_6: begin
                    // approximate box sizes with W + h
                    popboxsz <= (popbox[58:47] - popbox[34:23]) + (popbox[70:59] - popbox[46:35]);
                    bboxsz <= (bbox[58:47] - bbox[34:23]) + (bbox[70:59] - bbox[46:35]);
                    nms_state <= (d3<reg_mul_c[31:8]) ? S_S4 : S_S5;
                end
            S_FINISH: begin
                    if (~i_ddr_full) begin
                        if (bbq_valid) begin
                            nmsout <= {1'b0, reg_out_seq, bbq_dout[70:0]};
                            reg_o_en <= 1'b1;
                            bbq_rd_en <= 1'b1;
                            nms_state <= S_FINISH2;
                        end else begin
                            // add 10 dummy results for minimum ddr length 
                            state_delay <= 4'd10;
                            nms_state <= S_DUMMY;
                        end
                    end
                end
            S_FINISH2: nms_state <= S_FINISH;
            S_DUMMY: begin
                    if (state_delay==4'h0) begin
                        // save n_bbox in ddr
                        nmsout <= {1'b1, 71'd0, reg_out_seq};
                        reg_o_done <= 1'b1;
                        nms_state <= S_IDLE;
                    end else begin
                        nmsout <= 82'b0;    // dummy
                        reg_o_en <= 1'b1;
                        reg_dummy_en <= 1'b1;
                        state_delay <= state_delay - 1'b1;
                        nms_state <= S_DUMMY2;
                    end
                end
            S_DUMMY2: nms_state <= S_DUMMY;
            S_S2_DELAY:
                if (state_delay==4'h0) 
                    nms_state <= S_S2;
                else
                    state_delay <= state_delay - 1'b1;
            S_SF_DELAY:
                if (state_delay==4'h0) 
                    nms_state <= S_FINISH;
                else
                    state_delay <= state_delay - 1'b1;
            endcase

            if (reg_o_en && ~reg_dummy_en) reg_out_seq <= reg_out_seq + 1'b1;
            
        end
        
        
        reg_disp_en <= ((reg_o_en && ~reg_dummy_en) || reg_o_done);
        reg_disp_box[11:0]  <= nmsout[12:1];
        reg_disp_box[23:12] <= {2'd0, nmsout[22:13]};
        reg_disp_box[35:24] <= {2'd0, nmsout[34:23]};
        reg_disp_box[47:36] <= {2'd0, nmsout[46:35]};
        reg_disp_box[59:48] <= {2'd0, nmsout[58:47]};
        reg_disp_box[71:60] <= {2'd0, nmsout[70:59]};
        reg_disp_box[73:72] <= {1'b0, reg_o_done};
    end
    
//    assign o_en = reg_o_en;
//    assign o_bbox[15:0]  = {3'd0, nmsout[12:0]};
//    assign o_bbox[31:16] = {6'd0, nmsout[22:13]};
//    assign o_bbox[47:32] = {4'd0, nmsout[34:23]};   // sx
//    assign o_bbox[63:48] = {4'd0, nmsout[46:35]};   // sy
//    assign o_bbox[79:64] = {4'd0, nmsout[58:47]};   // ex
//    assign o_bbox[95:80] = {4'd0, nmsout[70:59]};   // ey
//    assign o_bbox[111:96] = {6'd0, nmsout[80:71]};
//    assign o_done = reg_o_done;
    
    // DDR data
    assign o_ddr_we = reg_o_en || reg_o_done;
    assign o_ddr_data[15:0]  = {3'd0, nmsout[12:0]};
    assign o_ddr_data[31:16] = {6'd0, nmsout[22:13]};
    assign o_ddr_data[47:32] = {4'd0, nmsout[34:23]};   // sx
    assign o_ddr_data[63:48] = {4'd0, nmsout[46:35]};   // sy
    assign o_ddr_data[79:64] = {4'd0, nmsout[58:47]};   // ex
    assign o_ddr_data[95:80] = {4'd0, nmsout[70:59]};   // ey
    assign o_ddr_data[111:96] = {6'd0, nmsout[80:71]};
    assign o_ddr_data[127:112] = {nmsout[81], 15'd0};

    assign o_disp_en = reg_disp_en;
    assign o_disp_box = reg_disp_box;
    
//    assign dbg_score = nmsout[12:0];
//    assign dbg_class = nmsout[22:13];
//    assign dbg_sx = nmsout[34:23];
//    assign dbg_sy = nmsout[46:35];
//    assign dbg_ex = nmsout[58:47];
//    assign dbg_ey = nmsout[70:59];
    
endmodule
