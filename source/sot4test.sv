`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/14 14:26:28
// Design Name: 
// Module Name: sot4test
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


module sot4test (
        input [9:0] index,
        output [399:0] record,
        input clk
    );
    
    logic [399:0] reg_record;
    logic [5:0] w_mode;
    logic [5:0] r_mode;
    logic tmost;
    logic wsave;
    logic [9:0] sxm1;   // 299
    logic [9:0] osxm1;  // 149
    logic [12:0] ncm1;  // 255
    logic [12:0] nfm1;  // 127
    logic [15:0] nmapm1;    //  16383
    logic [3:0] staddr;
    logic [12:0] shaddr;    // 1472
    logic [17:0] ickpim;    // 1202 --> 12 bits
    logic [17:0] ockpim;    // 1202 --> 12 bits
    logic [17:0] istep;     // 900  --> 12 bits
    logic [17:0] ostep;     // 900  --> 12 bits
    logic [17:0] ickfull;   // 22500
    logic [9:0] ckflush;    // 151
    logic [17:0] raddr;     // 8192
    logic [17:0] waddr;     // 8192
    logic [9:0] goto;
    logic [29:0] paraaddr;
    logic [19:0] paralen;
    logic [7:0] layer;
    logic [1:0] relu;
    
    always @ (posedge clk) begin
        case (index)
//10'd0: begin layer<=8'd0; w_mode<=6'd0;r_mode<=6'd49;tmost<=1'b0;sxm1<=10'd0;  osxm1<=10'd0;  ncm1<=13'd0; nfm1<=13'd0;nmapm1<=16'd0;relu=0;staddr<=4'd0;shaddr<=13'd0;  ickpim<=18'd0;   ockpim<=18'd0;   istep<=18'd0;  ostep<=18'd0;  ickfull<=18'd0;    ckflush<=10'd0;  raddr<=18'd0;   waddr<=18'd0;   goto<=10'd107; paraaddr <= 30'd0 ;paralen<=20'd0     ;end
//
//1	CBN3	300 	300 	2 	3 	32 
//2	DWN3	150 	150 	1 	32 	32 
//3	CBN1	150 	150 	1 	32 	64 
//4	DWN3	150 	150 	2 	64 	64 
//
10'd0  :begin layer<=8'd0  ;w_mode<=6'd4 ;r_mode<=6'd33;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd149;ncm1<=13'd0   ;nfm1<=13'd0   ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd1202 ;ockpim<=18'd1202 ;istep<=18'd0   ;ostep<=18'd1202;ickfull<=18'd0    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd1  :begin layer<=8'd1  ;w_mode<=6'd1 ;r_mode<=6'd21;tmost<=1'b1;sxm1<=10'd299;osxm1<=10'd149;ncm1<=13'd2   ;nfm1<=13'd3   ;nmapm1<=16'd11   ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd1202 ;ockpim<=18'd1051 ;istep<=18'd0   ;ostep<=18'd526 ;ickfull<=18'd22500;ckflush<=10'd151;raddr<=18'd0   ;waddr<=18'd301 ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd120   ;end
10'd2  :begin layer<=8'd2  ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd149;osxm1<=10'd149;ncm1<=13'd7   ;nfm1<=13'd0   ;nmapm1<=16'd7    ;relu=1;staddr<=4'd1;shaddr<=13'd117 ;ickpim<=18'd1051 ;ockpim<=18'd900  ;istep<=18'd526 ;ostep<=18'd450 ;ickfull<=18'd22500;ckflush<=10'd151;raddr<=18'd301 ;waddr<=18'd1353;goto<=10'd0  ;paraaddr<=30'd120  ;paralen<=20'd56    ;end
10'd3  :begin layer<=8'd3  ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd149;osxm1<=10'd149;ncm1<=13'd1   ;nfm1<=13'd7   ;nmapm1<=16'd15   ;relu=1;staddr<=4'd2;shaddr<=13'd733 ;ickpim<=18'd900  ;ockpim<=18'd900  ;istep<=18'd450 ;ostep<=18'd225 ;ickfull<=18'd22500;ckflush<=10'd0  ;raddr<=18'd1353;waddr<=18'd2253;goto<=10'd0  ;paraaddr<=30'd176  ;paralen<=20'd280   ;end
10'd4  :begin layer<=8'd4  ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b1;sxm1<=10'd149;osxm1<=10'd74 ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=1;staddr<=4'd3;shaddr<=13'd733 ;ickpim<=18'd225  ;ockpim<=18'd149  ;istep<=18'd225 ;ostep<=18'd75  ;ickfull<=18'd5625 ;ckflush<=10'd76 ;raddr<=18'd2253;waddr<=18'd981 ;goto<=10'd0  ;paraaddr<=30'd456  ;paralen<=20'd112   ;end
10'd5  :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd7   ;nfm1<=13'd0   ;nmapm1<=16'd7    ;relu=0;staddr<=4'd4;shaddr<=13'd0   ;ickpim<=18'd149  ;ockpim<=18'd149  ;istep<=18'd75  ;ostep<=18'd0   ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd981 ;waddr<=18'd6   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd6  :begin layer<=8'd0  ;w_mode<=6'd4 ;r_mode<=6'd33;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd149;ncm1<=13'd0   ;nfm1<=13'd0   ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd900  ;ockpim<=18'd900  ;istep<=18'd0   ;ostep<=18'd900 ;ickfull<=18'd0    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd7  :begin layer<=8'd1  ;w_mode<=6'd1 ;r_mode<=6'd21;tmost<=1'b0;sxm1<=10'd299;osxm1<=10'd149;ncm1<=13'd2   ;nfm1<=13'd3   ;nmapm1<=16'd11   ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd900  ;ockpim<=18'd900  ;istep<=18'd0   ;ostep<=18'd450 ;ickfull<=18'd22500;ckflush<=10'd151;raddr<=18'd0   ;waddr<=18'd225 ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd120   ;end
10'd8  :begin layer<=8'd2  ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd149;osxm1<=10'd149;ncm1<=13'd7   ;nfm1<=13'd0   ;nmapm1<=16'd7    ;relu=1;staddr<=4'd1;shaddr<=13'd117 ;ickpim<=18'd900  ;ockpim<=18'd900  ;istep<=18'd450 ;ostep<=18'd450 ;ickfull<=18'd22500;ckflush<=10'd151;raddr<=18'd225 ;waddr<=18'd1125;goto<=10'd0  ;paraaddr<=30'd120  ;paralen<=20'd56    ;end
10'd9  :begin layer<=8'd3  ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd149;osxm1<=10'd149;ncm1<=13'd1   ;nfm1<=13'd7   ;nmapm1<=16'd15   ;relu=1;staddr<=4'd2;shaddr<=13'd733 ;ickpim<=18'd900  ;ockpim<=18'd900  ;istep<=18'd450 ;ostep<=18'd225 ;ickfull<=18'd22500;ckflush<=10'd0  ;raddr<=18'd1125;waddr<=18'd2025;goto<=10'd0  ;paraaddr<=30'd176  ;paralen<=20'd280   ;end
10'd10 :begin layer<=8'd4  ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b0;sxm1<=10'd149;osxm1<=10'd74 ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=1;staddr<=4'd3;shaddr<=13'd733 ;ickpim<=18'd225  ;ockpim<=18'd225  ;istep<=18'd225 ;ostep<=18'd151 ;ickfull<=18'd5625 ;ckflush<=10'd76 ;raddr<=18'd2025;waddr<=18'd753 ;goto<=10'd0  ;paraaddr<=30'd456  ;paralen<=20'd112   ;end
10'd11 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd7   ;nfm1<=13'd0   ;nmapm1<=16'd7    ;relu=0;staddr<=4'd4;shaddr<=13'd0   ;ickpim<=18'd225  ;ockpim<=18'd225  ;istep<=18'd151 ;ostep<=18'd0   ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd753 ;waddr<=18'd6   ;goto<=10'd6  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
//
//5	CBN1	75 	75 	1 	64 	128 
//6	DWN3	75 	75 	1 	128 	128 
//7	CBN1	75 	75 	1 	128 	128 
//8	DWN3	75 	75 	2 	128 	128 
//
10'd12 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd74 ;ncm1<=13'd7   ;nfm1<=13'd0   ;nmapm1<=16'd7    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd376  ;ockpim<=18'd376  ;istep<=18'd0   ;ostep<=18'd188 ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd6   ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd13 :begin layer<=8'd5  ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd74 ;osxm1<=10'd74 ;ncm1<=13'd3   ;nfm1<=13'd15  ;nmapm1<=16'd63   ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd376  ;ockpim<=18'd376  ;istep<=18'd188 ;ostep<=18'd188 ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd752 ;goto<=10'd0  ;paraaddr<=30'd568  ;paralen<=20'd1072  ;end
10'd14 :begin layer<=8'd6  ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd74 ;osxm1<=10'd74 ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd376  ;ockpim<=18'd300  ;istep<=18'd188 ;ostep<=18'd150 ;ickfull<=18'd5625 ;ckflush<=10'd76 ;raddr<=18'd752 ;waddr<=18'd2256;goto<=10'd0  ;paraaddr<=30'd1640 ;paralen<=20'd224   ;end
10'd15 :begin layer<=8'd7  ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd74 ;osxm1<=10'd74 ;ncm1<=13'd7   ;nfm1<=13'd15  ;nmapm1<=16'd127  ;relu=1;staddr<=4'd2;shaddr<=13'd1264;ickpim<=18'd300  ;ockpim<=18'd300  ;istep<=18'd150 ;ostep<=18'd76  ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd2256;waddr<=18'd384 ;goto<=10'd0  ;paraaddr<=30'd1864 ;paralen<=20'd2096  ;end
10'd16 :begin layer<=8'd8  ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b1;sxm1<=10'd74 ;osxm1<=10'd37 ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=1;staddr<=4'd3;shaddr<=13'd1264;ickpim<=18'd76   ;ockpim<=18'd75   ;istep<=18'd76  ;ostep<=18'd38  ;ickfull<=18'd1444 ;ckflush<=10'd1  ;raddr<=18'd384 ;waddr<=18'd1600;goto<=10'd0  ;paraaddr<=30'd3960 ;paralen<=20'd224   ;end
10'd17 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd75   ;ockpim<=18'd75   ;istep<=18'd38  ;ostep<=18'd0   ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd1600;waddr<=18'd17  ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd18 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd74 ;ncm1<=13'd7   ;nfm1<=13'd0   ;nmapm1<=16'd7    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd300  ;ockpim<=18'd300  ;istep<=18'd0   ;ostep<=18'd150 ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd6   ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd19 :begin layer<=8'd5  ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd74 ;osxm1<=10'd74 ;ncm1<=13'd3   ;nfm1<=13'd15  ;nmapm1<=16'd63   ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd300  ;ockpim<=18'd300  ;istep<=18'd150 ;ostep<=18'd150 ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd600 ;goto<=10'd0  ;paraaddr<=30'd568  ;paralen<=20'd1072  ;end
10'd20 :begin layer<=8'd6  ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd74 ;osxm1<=10'd74 ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd300  ;ockpim<=18'd300  ;istep<=18'd150 ;ostep<=18'd150 ;ickfull<=18'd5625 ;ckflush<=10'd76 ;raddr<=18'd600 ;waddr<=18'd1800;goto<=10'd0  ;paraaddr<=30'd1640 ;paralen<=20'd224   ;end
10'd21 :begin layer<=8'd7  ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd74 ;osxm1<=10'd74 ;ncm1<=13'd7   ;nfm1<=13'd15  ;nmapm1<=16'd127  ;relu=1;staddr<=4'd2;shaddr<=13'd1264;ickpim<=18'd300  ;ockpim<=18'd300  ;istep<=18'd150 ;ostep<=18'd76  ;ickfull<=18'd5625 ;ckflush<=10'd0  ;raddr<=18'd1800;waddr<=18'd3000;goto<=10'd0  ;paraaddr<=30'd1864 ;paralen<=20'd2096  ;end
10'd22 :begin layer<=8'd8  ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b0;sxm1<=10'd74 ;osxm1<=10'd37 ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=1;staddr<=4'd3;shaddr<=13'd1264;ickpim<=18'd76   ;ockpim<=18'd76   ;istep<=18'd76  ;ostep<=18'd39  ;ickfull<=18'd1444 ;ckflush<=10'd1  ;raddr<=18'd3000;waddr<=18'd1144;goto<=10'd0  ;paraaddr<=30'd3960 ;paralen<=20'd224   ;end
10'd23 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd76   ;ockpim<=18'd76   ;istep<=18'd39  ;ostep<=18'd0   ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd1144;waddr<=18'd17  ;goto<=10'd18 ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
//
//9	CBN1	38 	38 	1 	128 	256 
//10	DWN3	38 	38 	1 	256 	256 
//11	CBN1	38 	38 	1 	256 	256 
//12	DWN3	38 	38 	2 	256 	256 
//
10'd24 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd37 ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd191  ;ockpim<=18'd191  ;istep<=18'd0   ;ostep<=18'd96  ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd17  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd25 :begin layer<=8'd9  ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd37 ;osxm1<=10'd37 ;ncm1<=13'd7   ;nfm1<=13'd31  ;nmapm1<=16'd255  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd191  ;ockpim<=18'd191  ;istep<=18'd96  ;ostep<=18'd96  ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd768 ;goto<=10'd0  ;paraaddr<=30'd4184 ;paralen<=20'd4192  ;end
10'd26 :begin layer<=8'd10 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd37 ;osxm1<=10'd37 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd191  ;ockpim<=18'd152  ;istep<=18'd96  ;ostep<=18'd76  ;ickfull<=18'd1444 ;ckflush<=10'd39 ;raddr<=18'd768 ;waddr<=18'd2304;goto<=10'd0  ;paraaddr<=30'd8376 ;paralen<=20'd448   ;end
10'd27 :begin layer<=8'd11 ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd37 ;osxm1<=10'd37 ;ncm1<=13'd15  ;nfm1<=13'd31  ;nmapm1<=16'd511  ;relu=1;staddr<=4'd2;shaddr<=13'd1344;ickpim<=18'd152  ;ockpim<=18'd152  ;istep<=18'd76  ;ostep<=18'd38  ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd2304;waddr<=18'd448 ;goto<=10'd0  ;paraaddr<=30'd8824 ;paralen<=20'd8288  ;end
10'd28 :begin layer<=8'd12 ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b1;sxm1<=10'd37 ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=1;staddr<=4'd3;shaddr<=13'd1344;ickpim<=18'd38   ;ockpim<=18'd18   ;istep<=18'd38  ;ostep<=18'd9   ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd448 ;waddr<=18'd1664;goto<=10'd0  ;paraaddr<=30'd17112;paralen<=20'd448   ;end
10'd29 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd18   ;ockpim<=18'd18   ;istep<=18'd9   ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd1664;waddr<=18'd23  ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd30 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd37 ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd152  ;ockpim<=18'd152  ;istep<=18'd0   ;ostep<=18'd76  ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd17  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd31 :begin layer<=8'd9  ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd37 ;osxm1<=10'd37 ;ncm1<=13'd7   ;nfm1<=13'd31  ;nmapm1<=16'd255  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd152  ;ockpim<=18'd152  ;istep<=18'd76  ;ostep<=18'd76  ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd608 ;goto<=10'd0  ;paraaddr<=30'd4184 ;paralen<=20'd4192  ;end
10'd32 :begin layer<=8'd10 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd37 ;osxm1<=10'd37 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd152  ;ockpim<=18'd152  ;istep<=18'd76  ;ostep<=18'd76  ;ickfull<=18'd1444 ;ckflush<=10'd39 ;raddr<=18'd608 ;waddr<=18'd1824;goto<=10'd0  ;paraaddr<=30'd8376 ;paralen<=20'd448   ;end
10'd33 :begin layer<=8'd11 ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd37 ;osxm1<=10'd37 ;ncm1<=13'd15  ;nfm1<=13'd31  ;nmapm1<=16'd511  ;relu=1;staddr<=4'd2;shaddr<=13'd1344;ickpim<=18'd152  ;ockpim<=18'd152  ;istep<=18'd76  ;ostep<=18'd38  ;ickfull<=18'd1444 ;ckflush<=10'd0  ;raddr<=18'd1824;waddr<=18'd3040;goto<=10'd0  ;paraaddr<=30'd8824 ;paralen<=20'd8288  ;end
10'd34 :begin layer<=8'd12 ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b0;sxm1<=10'd37 ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=1;staddr<=4'd3;shaddr<=13'd1344;ickpim<=18'd38   ;ockpim<=18'd38   ;istep<=18'd38  ;ostep<=18'd20  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd3040;waddr<=18'd1184;goto<=10'd0  ;paraaddr<=30'd17112;paralen<=20'd448   ;end
10'd35 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd38   ;ockpim<=18'd38   ;istep<=18'd20  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd1184;waddr<=18'd23  ;goto<=10'd30 ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
//
//13	CBN1	19 	19 	1 	256 	512 
//14	DWN3	19 	19 	1 	512 	512 
//15	CBN1	19 	19 	1 	512 	512 
//16	DWN3	19 	19 	1 	512 	512 
//
10'd36 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd104  ;ockpim<=18'd104  ;istep<=18'd0   ;ostep<=18'd52  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd23  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd37 :begin layer<=8'd13 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd15  ;nfm1<=13'd63  ;nmapm1<=16'd1023 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd104  ;ockpim<=18'd104  ;istep<=18'd52  ;ostep<=18'd52  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd832 ;goto<=10'd0  ;paraaddr<=30'd17560;paralen<=20'd16576 ;end
10'd38 :begin layer<=8'd14 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd104  ;ockpim<=18'd84   ;istep<=18'd52  ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd832 ;waddr<=18'd2496;goto<=10'd0  ;paraaddr<=30'd34136;paralen<=20'd896   ;end
10'd39 :begin layer<=8'd15 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd2;shaddr<=13'd1472;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd42  ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2496;waddr<=18'd768 ;goto<=10'd0  ;paraaddr<=30'd35032;paralen<=20'd32960 ;end
10'd40 :begin layer<=8'd16 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd3;shaddr<=13'd1472;ickpim<=18'd84   ;ockpim<=18'd64   ;istep<=18'd42  ;ostep<=18'd32  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd768 ;waddr<=18'd2112;goto<=10'd0  ;paraaddr<=30'd67992;paralen<=20'd896   ;end
10'd41 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd64   ;ockpim<=18'd64   ;istep<=18'd32  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2112;waddr<=18'd26  ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd42 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd0   ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd23  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
10'd43 :begin layer<=8'd13 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd15  ;nfm1<=13'd63  ;nmapm1<=16'd1023 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd42  ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd672 ;goto<=10'd0  ;paraaddr<=30'd17560;paralen<=20'd16576 ;end
10'd44 :begin layer<=8'd14 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd42  ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd672 ;waddr<=18'd2016;goto<=10'd0  ;paraaddr<=30'd34136;paralen<=20'd896   ;end
10'd45 :begin layer<=8'd15 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd2;shaddr<=13'd1472;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd42  ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2016;waddr<=18'd288 ;goto<=10'd0  ;paraaddr<=30'd35032;paralen<=20'd32960 ;end
10'd46 :begin layer<=8'd16 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd3;shaddr<=13'd1472;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd42  ;ostep<=18'd42  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd288 ;waddr<=18'd1632;goto<=10'd0  ;paraaddr<=30'd67992;paralen<=20'd896   ;end
10'd47 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd84   ;ockpim<=18'd84   ;istep<=18'd42  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd1632;waddr<=18'd26  ;goto<=10'd42 ;paraaddr<=30'd0    ;paralen<=20'd0     ;end
//
//17	CBN1	19 	19 	1 	512 	512 
//18	DWN3	19 	19 	1 	512 	512 
//19	CBN1	19 	19 	1 	512 	512 
//20	DWN3	19 	19 	1 	512 	512 
//
10'd48 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd96   ;ockpim<=18'd96   ;istep<=18'd0   ;ostep<=18'd48  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd26  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd49 :begin layer<=8'd17 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd96   ;ockpim<=18'd96   ;istep<=18'd48  ;ostep<=18'd48  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1536;goto<=10'd0  ;paraaddr<=30'd68888 ;paralen<=20'd32960 ;end
10'd50 :begin layer<=8'd18 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd96   ;ockpim<=18'd76   ;istep<=18'd48  ;ostep<=18'd38  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd1536;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd101848;paralen<=20'd896   ;end
10'd51 :begin layer<=8'd19 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd2;shaddr<=13'd1472;ickpim<=18'd76   ;ockpim<=18'd76   ;istep<=18'd38  ;ostep<=18'd38  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1216;goto<=10'd0  ;paraaddr<=30'd102744;paralen<=20'd32960 ;end
10'd52 :begin layer<=8'd20 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd3;shaddr<=13'd1472;ickpim<=18'd76   ;ockpim<=18'd56   ;istep<=18'd38  ;ostep<=18'd28  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd1216;waddr<=18'd2432;goto<=10'd0  ;paraaddr<=30'd135704;paralen<=20'd896   ;end
10'd53 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd56   ;ockpim<=18'd56   ;istep<=18'd28  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2432;waddr<=18'd32  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd54 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd0   ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd26  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd55 :begin layer<=8'd17 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1280;goto<=10'd0  ;paraaddr<=30'd68888 ;paralen<=20'd32960 ;end
10'd56 :begin layer<=8'd18 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd1280;waddr<=18'd2560;goto<=10'd0  ;paraaddr<=30'd101848;paralen<=20'd896   ;end
10'd57 :begin layer<=8'd19 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd2;shaddr<=13'd1472;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2560;waddr<=18'd768 ;goto<=10'd0  ;paraaddr<=30'd102744;paralen<=20'd32960 ;end
10'd58 :begin layer<=8'd20 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd3;shaddr<=13'd1472;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd768 ;waddr<=18'd2048;goto<=10'd0  ;paraaddr<=30'd135704;paralen<=20'd896   ;end
10'd59 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2048;waddr<=18'd32  ;goto<=10'd54 ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
//
//21	CBN1	19 	19 	1 	512 	512 
//22	DWN3	19 	19 	1 	512 	512 
//23	CBN1	19 	19 	1 	512 	512 
//
10'd60 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd96   ;ockpim<=18'd96   ;istep<=18'd0   ;ostep<=18'd48  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd32  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd61 :begin layer<=8'd21 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd96   ;ockpim<=18'd96   ;istep<=18'd48  ;ostep<=18'd48  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1536;goto<=10'd0  ;paraaddr<=30'd136600;paralen<=20'd32960 ;end
10'd62 :begin layer<=8'd22 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd96   ;ockpim<=18'd76   ;istep<=18'd48  ;ostep<=18'd38  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd1536;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd169560;paralen<=20'd896   ;end
10'd63 :begin layer<=8'd23 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd2;shaddr<=13'd1472;ickpim<=18'd76   ;ockpim<=18'd76   ;istep<=18'd38  ;ostep<=18'd38  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1216;goto<=10'd0  ;paraaddr<=30'd170456;paralen<=20'd32960 ;end
10'd64 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd76   ;ockpim<=18'd76   ;istep<=18'd38  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd1216;waddr<=18'd38  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd65 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd0   ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd32  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd66 :begin layer<=8'd21 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1280;goto<=10'd0  ;paraaddr<=30'd136600;paralen<=20'd32960 ;end
10'd67 :begin layer<=8'd22 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd20 ;raddr<=18'd1280;waddr<=18'd2560;goto<=10'd0  ;paraaddr<=30'd169560;paralen<=20'd896   ;end
10'd68 :begin layer<=8'd23 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd63  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd2;shaddr<=13'd1472;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd40  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd2560;waddr<=18'd768 ;goto<=10'd0  ;paraaddr<=30'd170456;paralen<=20'd32960 ;end
10'd69 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd80   ;ockpim<=18'd80   ;istep<=18'd40  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd768 ;waddr<=18'd38  ;goto<=10'd65 ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
//
//26	DWN3	19 	19 	2 	512 	512 
//
10'd70 :begin layer<=8'd0  ;w_mode<=6'd7 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd114  ;ockpim<=18'd114  ;istep<=18'd0   ;ostep<=18'd30  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd38  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd71 :begin layer<=8'd26 ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd9  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd30   ;ockpim<=18'd29   ;istep<=18'd30  ;ostep<=18'd15  ;ickfull<=18'd100  ;ckflush<=10'd1  ;raddr<=18'd0   ;waddr<=18'd1920;goto<=10'd0  ;paraaddr<=30'd203416;paralen<=20'd896   ;end
10'd72 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd29   ;ockpim<=18'd29   ;istep<=18'd15  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd1920;waddr<=18'd44  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd73 :begin layer<=8'd0  ;w_mode<=6'd7 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd114  ;ockpim<=18'd114  ;istep<=18'd0   ;ostep<=18'd30  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd38  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd74 :begin layer<=8'd26 ;w_mode<=6'd2 ;r_mode<=6'd7 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd9  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd30   ;ockpim<=18'd30   ;istep<=18'd30  ;ostep<=18'd15  ;ickfull<=18'd100  ;ckflush<=10'd1  ;raddr<=18'd0   ;waddr<=18'd1920;goto<=10'd0  ;paraaddr<=30'd203416;paralen<=20'd896   ;end
10'd75 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd30   ;ockpim<=18'd30   ;istep<=18'd15  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd1920;waddr<=18'd44  ;goto<=10'd73 ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//27	CBN1	10 	10 	1 	512 	1024 
//28	DWN3	10 	10 	1 	1024 	1024 
//29	CBN1	10 	10 	1 	1024 	1024 

10'd76 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd53   ;ockpim<=18'd53   ;istep<=18'd0   ;ostep<=18'd27  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd44  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd77 :begin layer<=8'd27 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd31  ;nfm1<=13'd127 ;nmapm1<=16'd4095 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd53   ;ockpim<=18'd53   ;istep<=18'd27  ;ostep<=18'd27  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd864 ;goto<=10'd0  ;paraaddr<=30'd204312;paralen<=20'd65920 ;end
10'd78 :begin layer<=8'd28 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd255 ;nfm1<=13'd0   ;nmapm1<=16'd255  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd53   ;ockpim<=18'd42   ;istep<=18'd27  ;ostep<=18'd21  ;ickfull<=18'd100  ;ckflush<=10'd11 ;raddr<=18'd864 ;waddr<=18'd2592;goto<=10'd0  ;paraaddr<=30'd270232;paralen<=20'd1792  ;end
10'd79 :begin layer<=8'd29 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd127 ;nmapm1<=16'd8191 ;relu=1;staddr<=4'd2;shaddr<=13'd1792;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd21  ;ostep<=18'd21  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd2592;waddr<=18'd864 ;goto<=10'd0  ;paraaddr<=30'd272024;paralen<=20'd131456;end
10'd80 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd21  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd864 ;waddr<=18'd46  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd81 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd0   ;ostep<=18'd21  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd44  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd82 :begin layer<=8'd27 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd31  ;nfm1<=13'd127 ;nmapm1<=16'd4095 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd21  ;ostep<=18'd21  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd672 ;goto<=10'd0  ;paraaddr<=30'd204312;paralen<=20'd65920 ;end
10'd83 :begin layer<=8'd28 ;w_mode<=6'd2 ;r_mode<=6'd6 ;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd255 ;nfm1<=13'd0   ;nmapm1<=16'd255  ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd21  ;ostep<=18'd21  ;ickfull<=18'd100  ;ckflush<=10'd11 ;raddr<=18'd672 ;waddr<=18'd2016;goto<=10'd0  ;paraaddr<=30'd270232;paralen<=20'd1792  ;end
10'd84 :begin layer<=8'd29 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd127 ;nmapm1<=16'd8191 ;relu=1;staddr<=4'd2;shaddr<=13'd1792;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd21  ;ostep<=18'd21  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd2016;waddr<=18'd288 ;goto<=10'd0  ;paraaddr<=30'd272024;paralen<=20'd131456;end
10'd85 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd42   ;ockpim<=18'd42   ;istep<=18'd21  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd288 ;waddr<=18'd46  ;goto<=10'd81 ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//32	CBN1	10 	10 	1 	1024 	256 

10'd86 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd60   ;ockpim<=18'd60   ;istep<=18'd0   ;ostep<=18'd30  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd46  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd87 :begin layer<=8'd32 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd31  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd60   ;ockpim<=18'd60   ;istep<=18'd30  ;ostep<=18'd30  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1920;goto<=10'd0  ;paraaddr<=30'd403480;paralen<=20'd32864 ;end
10'd88 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd60   ;ockpim<=18'd60   ;istep<=18'd30  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd1920;waddr<=18'd50  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd89 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd0   ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd46  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd90 :begin layer<=8'd32 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd31  ;nmapm1<=16'd2047 ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd20  ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1920;goto<=10'd0  ;paraaddr<=30'd403480;paralen<=20'd32864 ;end
10'd91 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd20  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd1920;waddr<=18'd50  ;goto<=10'd89 ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//33	CBN3	10 	10 	2 	256 	512 

10'd92 :begin layer<=8'd0  ;w_mode<=6'd7 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd0   ;ostep<=18'd26  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd50  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd93 :begin layer<=8'd33 ;w_mode<=6'd1 ;r_mode<=6'd5 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd4  ;ncm1<=13'd255 ;nfm1<=13'd63  ;nmapm1<=16'd16383;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd19   ;istep<=18'd26  ;ostep<=18'd13  ;ickfull<=18'd25   ;ckflush<=10'd6  ;raddr<=18'd0   ;waddr<=18'd832; goto<=10'd0  ;paraaddr<=30'd436344;paralen<=20'd147648;end
10'd94 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd25   ;istep<=18'd13  ;ostep<=18'd0   ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd832 ;waddr<=18'd51  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//36	CBN1	5 	5 	1 	512 	128 
//37	CBN3	5 	5 	2 	128 	256 

10'd95 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd4  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd25   ;istep<=18'd0   ;ostep<=18'd13  ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd51  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd96 :begin layer<=8'd36 ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd4  ;osxm1<=10'd4  ;ncm1<=13'd31  ;nfm1<=13'd15  ;nmapm1<=16'd511  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd25   ;istep<=18'd13  ;ostep<=18'd9   ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd416 ;goto<=10'd0  ;paraaddr<=30'd583992;paralen<=20'd8240  ;end
10'd97 :begin layer<=8'd37 ;w_mode<=6'd1 ;r_mode<=6'd5 ;tmost<=1'b1;sxm1<=10'd4  ;osxm1<=10'd2  ;ncm1<=13'd127 ;nfm1<=13'd31  ;nmapm1<=16'd4095 ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd8    ;istep<=18'd9   ;ostep<=18'd5   ;ickfull<=18'd9    ;ckflush<=10'd1  ;raddr<=18'd416 ;waddr<=18'd560 ;goto<=10'd0  ;paraaddr<=30'd592232;paralen<=20'd36960 ;end
10'd98 :begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd9    ;istep<=18'd5   ;ostep<=18'd0   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd560 ;waddr<=18'd52  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//40	CBN1	3 	3 	1 	256 	128 
//41	CBN3	3 	3 	2 	128 	256 

10'd99 :begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd2  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd9    ;istep<=18'd0   ;ostep<=18'd5   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd52  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd100:begin layer<=8'd40 ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd2  ;osxm1<=10'd2  ;ncm1<=13'd15  ;nfm1<=13'd15  ;nmapm1<=16'd255  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd9    ;istep<=18'd5   ;ostep<=18'd4   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd80  ;goto<=10'd0  ;paraaddr<=30'd629192;paralen<=20'd4144  ;end
10'd101:begin layer<=8'd41 ;w_mode<=6'd1 ;r_mode<=6'd5 ;tmost<=1'b1;sxm1<=10'd2  ;osxm1<=10'd1  ;ncm1<=13'd127 ;nfm1<=13'd31  ;nmapm1<=16'd4095 ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd4   ;ostep<=18'd2   ;ickfull<=18'd4    ;ckflush<=10'd1  ;raddr<=18'd80  ;waddr<=18'd144 ;goto<=10'd0  ;paraaddr<=30'd633336;paralen<=20'd36960 ;end
10'd102:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd2   ;ostep<=18'd0   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd144 ;waddr<=18'd53  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//44	CBN1	2 	2 	1 	256 	64 
//45	CBN3	2 	2 	2 	64 	128 

10'd103:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd1  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd0   ;ostep<=18'd2   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd53  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd104:begin layer<=8'd44 ;w_mode<=6'd3 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd1  ;osxm1<=10'd1  ;ncm1<=13'd15  ;nfm1<=13'd7   ;nmapm1<=16'd127  ;relu=1;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd2   ;ostep<=18'd1   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd32  ;goto<=10'd0  ;paraaddr<=30'd670296;paralen<=20'd2072  ;end
10'd105:begin layer<=8'd45 ;w_mode<=6'd1 ;r_mode<=6'd5 ;tmost<=1'b1;sxm1<=10'd1  ;osxm1<=10'd0  ;ncm1<=13'd63  ;nfm1<=13'd15  ;nmapm1<=16'd1023 ;relu=1;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd1    ;ockpim<=18'd0    ;istep<=18'd1   ;ostep<=18'd1   ;ickfull<=18'd1    ;ckflush<=10'd2  ;raddr<=18'd32  ;waddr<=18'd40  ;goto<=10'd0  ;paraaddr<=30'd672368;paralen<=20'd9264  ;end
10'd106:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd34;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd1    ;ockpim<=18'd1    ;istep<=18'd1   ;ostep<=18'd0   ;ickfull<=18'd1    ;ckflush<=10'd0  ;raddr<=18'd40  ;waddr<=18'd54  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//24	CBI1	19 	19 	1 	512 	12 

//25	CBI1	19 	19 	1 	512 	273 

10'd107:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd0   ;ostep<=18'd50  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd38  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd108:begin layer<=8'd24 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd1   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd50  ;ostep<=18'd50  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1600;goto<=10'd0  ;paraaddr<=30'd681632;paralen<=20'd1030  ;end
10'd109:begin layer<=8'd25 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd34  ;nmapm1<=16'd1119 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd50  ;ostep<=18'd50  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1650;goto<=10'd0  ;paraaddr<=30'd682662;paralen<=20'd18025 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd110:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b1;sxm1<=10'd18 ;osxm1<=10'd0  ;ncm1<=13'd2   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd0    ;istep<=18'd50  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd1600;waddr<=18'd1650;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd111:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd18 ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd0   ;ostep<=18'd50  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd38  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd112:begin layer<=8'd24 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd1   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd50  ;ostep<=18'd50  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1600;goto<=10'd0  ;paraaddr<=30'd681632;paralen<=20'd1030  ;end
10'd113:begin layer<=8'd25 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd18 ;ncm1<=13'd31  ;nfm1<=13'd34  ;nmapm1<=16'd1119 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd100  ;istep<=18'd50  ;ostep<=18'd50  ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1650;goto<=10'd0  ;paraaddr<=30'd682662;paralen<=20'd18025 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd114:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b0;sxm1<=10'd18 ;osxm1<=10'd0  ;ncm1<=13'd2   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd100  ;ockpim<=18'd0    ;istep<=18'd50  ;ostep<=18'd0   ;ickfull<=18'd361  ;ckflush<=10'd0  ;raddr<=18'd1600;waddr<=18'd1650;goto<=10'd111;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//30	CBI1	10 	10 	1 	1024 	24 

//31	CBI1	10 	10 	1 	1024 	546 

10'd115:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd0   ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd46  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd116:begin layer<=8'd30 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd2   ;nmapm1<=16'd191  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd20  ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1280;goto<=10'd0  ;paraaddr<=30'd700687;paralen<=20'd3081  ;end
10'd117:begin layer<=8'd31 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd68  ;nmapm1<=16'd4415 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd20  ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1340;goto<=10'd0  ;paraaddr<=30'd703768;paralen<=20'd70863 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd118:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b1;sxm1<=10'd9  ;osxm1<=10'd1  ;ncm1<=13'd5   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd0    ;istep<=18'd20  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd1280;waddr<=18'd1340;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd119:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b0;sxm1<=10'd0  ;osxm1<=10'd9  ;ncm1<=13'd127 ;nfm1<=13'd0   ;nmapm1<=16'd127  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd0   ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd46  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd120:begin layer<=8'd30 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd2   ;nmapm1<=16'd191  ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd20  ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1280;goto<=10'd0  ;paraaddr<=30'd700687;paralen<=20'd3081  ;end
10'd121:begin layer<=8'd31 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd9  ;ncm1<=13'd63  ;nfm1<=13'd68  ;nmapm1<=16'd4415 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd40   ;istep<=18'd20  ;ostep<=18'd20  ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd1340;goto<=10'd0  ;paraaddr<=30'd703768;paralen<=20'd70863 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd122:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b0;sxm1<=10'd9  ;osxm1<=10'd1  ;ncm1<=13'd5   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd40   ;ockpim<=18'd0    ;istep<=18'd20  ;ostep<=18'd0   ;ickfull<=18'd100  ;ckflush<=10'd0  ;raddr<=18'd1280;waddr<=18'd1340;goto<=10'd119;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//34	CBI1	5 	5 	1 	512 	24 

//35	CBI1	5 	5 	1 	512 	546 

10'd123:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd4  ;ncm1<=13'd63  ;nfm1<=13'd0   ;nmapm1<=16'd63   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd25   ;istep<=18'd0   ;ostep<=18'd13  ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd51  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd124:begin layer<=8'd34 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd4  ;osxm1<=10'd4  ;ncm1<=13'd31  ;nfm1<=13'd2   ;nmapm1<=16'd95   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd25   ;istep<=18'd13  ;ostep<=18'd13  ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd416 ;goto<=10'd0  ;paraaddr<=30'd774631;paralen<=20'd1545  ;end
10'd125:begin layer<=8'd35 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd4  ;osxm1<=10'd4  ;ncm1<=13'd31  ;nfm1<=13'd68  ;nmapm1<=16'd2207 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd25   ;istep<=18'd13  ;ostep<=18'd13  ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd455 ;goto<=10'd0  ;paraaddr<=30'd776176;paralen<=20'd35535 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd126:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b1;sxm1<=10'd4  ;osxm1<=10'd2  ;ncm1<=13'd5   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd25   ;ockpim<=18'd0    ;istep<=18'd13  ;ostep<=18'd0   ;ickfull<=18'd25   ;ckflush<=10'd0  ;raddr<=18'd416 ;waddr<=18'd455 ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//38	CBI1	3 	3 	1 	256 	24 

//39	CBI1	3 	3 	1 	256 	546 

10'd127:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd2  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd9    ;istep<=18'd0   ;ostep<=18'd5   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd52  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd128:begin layer<=8'd38 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd2  ;osxm1<=10'd2  ;ncm1<=13'd15  ;nfm1<=13'd2   ;nmapm1<=16'd47   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd9    ;istep<=18'd5   ;ostep<=18'd5   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd80  ;goto<=10'd0  ;paraaddr<=30'd811711;paralen<=20'd777   ;end
10'd129:begin layer<=8'd39 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd2  ;osxm1<=10'd2  ;ncm1<=13'd15  ;nfm1<=13'd68  ;nmapm1<=16'd1103 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd9    ;istep<=18'd5   ;ostep<=18'd5   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd95  ;goto<=10'd0  ;paraaddr<=30'd812488;paralen<=20'd17871 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd130:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b1;sxm1<=10'd2  ;osxm1<=10'd3  ;ncm1<=13'd5   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd9    ;ockpim<=18'd0    ;istep<=18'd5   ;ostep<=18'd0   ;ickfull<=18'd9    ;ckflush<=10'd0  ;raddr<=18'd80  ;waddr<=18'd95  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//42	CBI1	2 	2 	1 	256 	24 

//43	CBI1	2 	2 	1 	256 	546 

10'd131:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd1  ;ncm1<=13'd31  ;nfm1<=13'd0   ;nmapm1<=16'd31   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd0   ;ostep<=18'd2   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd53  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd132:begin layer<=8'd42 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd1  ;osxm1<=10'd1  ;ncm1<=13'd15  ;nfm1<=13'd2   ;nmapm1<=16'd47   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd2   ;ostep<=18'd2   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd32  ;goto<=10'd0  ;paraaddr<=30'd830359;paralen<=20'd777   ;end
10'd133:begin layer<=8'd43 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd1  ;osxm1<=10'd1  ;ncm1<=13'd15  ;nfm1<=13'd68  ;nmapm1<=16'd1103 ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd4    ;istep<=18'd2   ;ostep<=18'd2   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd38  ;goto<=10'd0  ;paraaddr<=30'd831136;paralen<=20'd17871 ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd134:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b1;sxm1<=10'd1  ;osxm1<=10'd4  ;ncm1<=13'd5   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd4    ;ockpim<=18'd0    ;istep<=18'd2   ;ostep<=18'd0   ;ickfull<=18'd4    ;ckflush<=10'd0  ;raddr<=18'd32  ;waddr<=18'd38  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

//46	CBI1	1 	1 	1 	128 	24 

//47	CBI1	1 	1 	1 	128 	546 

10'd135:begin layer<=8'd0  ;w_mode<=6'd6 ;r_mode<=6'd35;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd15  ;nfm1<=13'd0   ;nmapm1<=16'd15   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd1    ;ockpim<=18'd1    ;istep<=18'd0   ;ostep<=18'd1   ;ickfull<=18'd1    ;ckflush<=10'd0  ;raddr<=18'd54  ;waddr<=18'd0   ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end
10'd136:begin layer<=8'd46 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd7   ;nfm1<=13'd2   ;nmapm1<=16'd23   ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd1    ;ockpim<=18'd1    ;istep<=18'd1   ;ostep<=18'd1   ;ickfull<=18'd1    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd8   ;goto<=10'd0  ;paraaddr<=30'd849007;paralen<=20'd393   ;end
10'd137:begin layer<=8'd47 ;w_mode<=6'd1 ;r_mode<=6'd8 ;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd0  ;ncm1<=13'd7   ;nfm1<=13'd68  ;nmapm1<=16'd551  ;relu=0;staddr<=4'd1;shaddr<=13'd0   ;ickpim<=18'd1    ;ockpim<=18'd1    ;istep<=18'd1   ;ostep<=18'd1   ;ickfull<=18'd1    ;ckflush<=10'd0  ;raddr<=18'd0   ;waddr<=18'd11  ;goto<=10'd0  ;paraaddr<=30'd849400;paralen<=20'd9039  ;end
// detection layer: rmode --> 36, scale --> osxm1, k --> sxm1, box_addr --> raddr, class_addr --> waddr, ickpim --> ickpim, istep --> istep, n_ar --> ncm1, n_class --> nfm1
10'd138:begin layer<=8'd0  ;w_mode<=6'd0 ;r_mode<=6'd36;tmost<=1'b1;sxm1<=10'd0  ;osxm1<=10'd5  ;ncm1<=13'd5   ;nfm1<=13'd90  ;nmapm1<=16'd0    ;relu=0;staddr<=4'd0;shaddr<=13'd0   ;ickpim<=18'd1    ;ockpim<=18'd0    ;istep<=18'd1   ;ostep<=18'd0   ;ickfull<=18'd1    ;ckflush<=10'd0  ;raddr<=18'd8   ;waddr<=18'd11  ;goto<=10'd0  ;paraaddr<=30'd0     ;paralen<=20'd0     ;end

// bounding box
10'd139:begin layer<=8'd0; w_mode<=6'd0;r_mode<=6'd48;tmost<=1'b0;sxm1<=10'd0;  osxm1<=10'd0;  ncm1<=13'd0; nfm1<=13'd0;nmapm1<=16'd0;relu=0;staddr<=4'd0;shaddr<=13'd0;  ickpim<=18'd0;   ockpim<=18'd0;   istep<=18'd0;  ostep<=18'd0;  ickfull<=18'd0;    ckflush<=10'd0;  raddr<=18'd0;   waddr<=18'd0;   goto<=10'd0; paraaddr <= 30'd0 ;paralen<=20'd0     ;end

// finish
10'd140:begin layer<=8'd0; w_mode<=6'd0;r_mode<=6'd50;tmost<=1'b0;sxm1<=10'd0;  osxm1<=10'd0;  ncm1<=13'd0; nfm1<=13'd0;nmapm1<=16'd0;relu=0;staddr<=4'd0;shaddr<=13'd0;  ickpim<=18'd0;   ockpim<=18'd0;   istep<=18'd0;  ostep<=18'd0;  ickfull<=18'd0;    ckflush<=10'd0;  raddr<=18'd0;   waddr<=18'd0;   goto<=10'd0; paraaddr <= 30'd0 ;paralen<=20'd0     ;end

        endcase
        
        reg_record[5:0] <= w_mode;
        reg_record[11:6] <= r_mode;
        reg_record[12] <= tmost;
        reg_record[22:13] <= sxm1;
        reg_record[32:23] <= osxm1;
        reg_record[45:33] <= ncm1;
        reg_record[58:46] <= nfm1;
        reg_record[74:59] <= nmapm1;
        reg_record[78:75] <= staddr;
        reg_record[91:79] <= shaddr;
        reg_record[109:92] <= ickpim;
        reg_record[127:110] <= ockpim;
        reg_record[145:128] <= istep;
        reg_record[163:146] <= ostep;
        reg_record[181:164] <= ickfull;
        reg_record[191:182] <= ckflush;
        reg_record[209:192] <= raddr;
        reg_record[227:210] <= waddr;
        reg_record[237:228] <= goto;
        reg_record[267:238] <= paraaddr;
        reg_record[287:268] <= paralen;
        reg_record[295:288] <= layer;
        reg_record[297:296] <= relu;
        reg_record[399:298] <= 0;
        
    end
    
    assign record = reg_record;
    
endmodule
