`timescale 1ns / 1ps
`define SMALL_SYS
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/11 07:40:48
// Design Name: 
// Module Name: dendrite_unit
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


module dendrite_unit # (
`ifdef SMALL_SYS 
            parameter N_MUL = 128,
            parameter N_SUOUT = 8
`else
            parameter N_MUL = 256,
            parameter N_SUOUT = 16
`endif
        ) (
        input [N_MUL-1:0][23:0] i_products,     // t2
        output [N_SUOUT-1:0][31:0] o_netsum,    // t10
        input [5:0] i_mode,                     // t2
        // for dutip logic
        input [15:0] i_nsum_raddr,              // t1
        input i_firstchan,                      // t6
        input i_nsum_en,                        // t9
        input i_lastchan,                       // t9
        input [15:0] i_nsum_waddr,              // t9
        input clk
    );
    
    logic [15:0][27:0] sig_partsum;
    logic [15:0][31:0] sig_netsum;
    logic [N_MUL-1:0][23:0] prod_in;
    genvar idx;
    integer i;

`ifndef SMALL_SYS 
    adder_tree adders_h (
        .i_products(prod_in[255:128]),
        .o_netsum(sig_partsum[15:8]),
        .clk(clk)
    );
`else
    assign sig_partsum[15:8] = 0;
    assign sig_netsum[15:8] = 0;
`endif
    
    adder_tree adders_l (
        .i_products(prod_in[127:0]),    // t3
        .o_netsum(sig_partsum[7:0]),    // t7
        .clk(clk)
    );
    
    generate
        for (idx = 0; idx < N_SUOUT; idx = idx + 1) begin : gen_dutip
            du_tip du_tip (
                .i_partsum(sig_partsum[idx]),   // t7
                .o_netsum(sig_netsum[idx]),     // t10
                //
                .i_nsum_raddr(i_nsum_raddr),    // t4
                .i_firstchan(i_firstchan),      // t6
                .i_nsum_en(i_nsum_en),          // t9
                .i_lastchan(i_lastchan),        // t9
                .i_nsum_waddr(i_nsum_waddr),    // t9
                .clk(clk)
            );
        end
    endgenerate

    assign o_netsum = sig_netsum[N_SUOUT-1:0];  // t10

    always @ (posedge clk) begin
    
        if (i_mode==6'b001000) prod_in <= i_products;
        else begin
            // t2 -> t3
            for (i=0; i<N_MUL/16; i++) begin
                prod_in[i*16+:9] <= i_products[i*9+:9];
                prod_in[(i*16+9)+:7] <= {7{16'd0}};
            end
        end
        
    end
    
endmodule
