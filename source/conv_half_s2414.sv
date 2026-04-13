`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/28 19:45:36
// Design Name: 
// Module Name: conv_half_s2414
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


module conv_half_s2414 (
    input clk,
    input [15:0] i_half,
    output [24:0] o_int
    );

    logic [1:0] reg_sign;
    logic [4:0] reg_exponent;
    logic [9:0] reg_fraction;
    logic [24:0] reg_ival, reg_ival2;
    
    assign o_int = reg_ival2;

    always @ (posedge clk) begin
    
        // t0
        reg_sign[0] <= i_half[15];
        reg_exponent <= i_half[14:10];
        reg_fraction <= i_half[9:0];
    
        // t1
        reg_sign[1] <= (reg_exponent==5'd0) ? 1'b0 : reg_sign[0];
        case (reg_exponent)
        5'd0 : reg_ival <= 25'd0;
        5'd1 : reg_ival <= 25'd1;
        5'd2 : reg_ival <= {23'd0, 1'b1, reg_fraction[9]};
        5'd3 : reg_ival <= {22'd0, 1'b1, reg_fraction[9:8]};
        5'd4 : reg_ival <= {21'd0, 1'b1, reg_fraction[9:7]};
        5'd5 : reg_ival <= {20'd0, 1'b1, reg_fraction[9:6]};
        5'd6 : reg_ival <= {19'd0, 1'b1, reg_fraction[9:5]};
        5'd7 : reg_ival <= {18'd0, 1'b1, reg_fraction[9:4]};
        5'd8 : reg_ival <= {17'd0, 1'b1, reg_fraction[9:3]};
        5'd9 : reg_ival <= {16'd0, 1'b1, reg_fraction[9:2]};
        5'd10: reg_ival <= {15'd0, 1'b1, reg_fraction[9:1]};
        5'd11: reg_ival <= {14'd0, 1'b1, reg_fraction[9:0]};
        5'd12: reg_ival <= {13'd0, 1'b1, reg_fraction[9:0], 1'd0};
        5'd13: reg_ival <= {12'd0, 1'b1, reg_fraction[9:0], 2'd0};
        5'd14: reg_ival <= {11'd0, 1'b1, reg_fraction[9:0], 3'd0};
        5'd15: reg_ival <= {10'd0, 1'b1, reg_fraction[9:0], 4'd0};
        5'd16: reg_ival <= { 9'd0, 1'b1, reg_fraction[9:0], 5'd0};
        5'd17: reg_ival <= { 8'd0, 1'b1, reg_fraction[9:0], 6'd0};
        5'd18: reg_ival <= { 7'd0, 1'b1, reg_fraction[9:0], 7'd0};
        5'd19: reg_ival <= { 6'd0, 1'b1, reg_fraction[9:0], 8'd0};
        5'd20: reg_ival <= { 5'd0, 1'b1, reg_fraction[9:0], 9'd0};
        5'd21: reg_ival <= { 4'd0, 1'b1, reg_fraction[9:0],10'd0};
        5'd22: reg_ival <= { 3'd0, 1'b1, reg_fraction[9:0],11'd0};
        5'd23: reg_ival <= { 2'd0, 1'b1, reg_fraction[9:0],12'd0};
        5'd24: reg_ival <= { 1'd0, 1'b1, reg_fraction[9:0],13'd0};
        default: reg_ival <= 25'hffffff;
        endcase
        
        // t2
        reg_ival2 <= (reg_sign[1]) ? -reg_ival : reg_ival;
    end
    
endmodule
