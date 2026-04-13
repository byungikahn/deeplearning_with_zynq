`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/25 17:21:12
// Design Name: 
// Module Name: halfadder
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

module halfadder(
        input [15:0] i_half1, // t0
        input [15:0] i_half2, // t0
        output [15:0] o_half_added,  // t8
        input clk
    );
    
    logic [27:0] sig_i_in1_28, sig_i_in2_28;
    logic [31:0] sig_i_in1, sig_i_in2;
    logic signed [32:0] reg_i_added;
    logic [28:0] reg_i_added2;
    
    assign sig_i_in1 = {{4{sig_i_in1_28[27]}}, sig_i_in1_28};
    assign sig_i_in2 = {{4{sig_i_in2_28[27]}}, sig_i_in2_28};
    
    // t0 -> t3
    conv_half_s2716 conv_half2int1 (
        .clk(clk),
        .i_half(i_half1),   // t0
        .o_int(sig_i_in1_28)   // t3
    );
    
    // t0 -> t3
    conv_half_s2716 conv_half2int2 (
        .clk(clk),
        .i_half(i_half2),   // t0
        .o_int(sig_i_in2_28)   // t3
    );
    
    always @ (posedge clk) begin
        // t3 -> t4
        reg_i_added <= $signed($signed({sig_i_in1[31],sig_i_in1}) + $signed(sig_i_in2));
        // check overflow, t4 -> t5
        if (~reg_i_added[32]     && reg_i_added[31:28]!=4'b0000) reg_i_added2 <= 29'h0fffffff;
        else if (reg_i_added[32] && reg_i_added[31:28]!=4'b1111) reg_i_added2 <= 29'h10000000;
        else reg_i_added2 <= reg_i_added[28:0];
    end
    
    // t5 -> t8
    conv_s2716_half conv_int2half (
        .clk(clk),
        .i_int(reg_i_added2),   // t5
        .o_half(o_half_added)   // t8
    );
    
endmodule
