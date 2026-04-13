`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/11 07:48:32
// Design Name: 
// Module Name: adder_tree
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


module adder_tree(
        input [127:0][23:0] i_products, // t3
        output [7:0][27:0] o_netsum,    // t7
        input clk
    );
    
    logic [127:0][23:0] adders_0;
    logic [ 63:0][24:0] adders_1;
    logic [ 31:0][25:0] adders_2;
    logic [ 15:0][26:0] adders_3;
    logic [  7:0][27:0] adders_4;
    integer i;
    
    assign adders_0 = i_products;   // t3
    assign o_netsum = adders_4;     // t7
    
    always @ (posedge clk) begin
        
        // t3 -> t4
        for (i=0; i<64; i++) begin
            adders_1[i] <= $signed(adders_0[i*2]) + $signed(adders_0[i*2+1]); 
        end
        
        // t4 -> t5
        for (i=0; i<32; i++) begin
            adders_2[i] <= $signed(adders_1[i*2]) + $signed(adders_1[i*2+1]); 
        end
        
        // t5 -> t6
        for (i=0; i<16; i++) begin
            adders_3[i] <= $signed(adders_2[i*2]) + $signed(adders_2[i*2+1]); 
        end
        
        // t6 -> t7
        for (i=0; i<8; i++) begin
            adders_4[i] <= $signed(adders_3[i*2]) + $signed(adders_3[i*2+1]); 
        end
        
    end
    
endmodule
