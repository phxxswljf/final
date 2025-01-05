`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/04 23:01:49
// Design Name: 
// Module Name: random
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



    
    module random(
        input enable,
        output reg [3:0] target
    );
    
    // ��������������ļ�����
    reg [7:0] counter;
    
    always @(posedge enable) begin
        // ���¼�����
        counter <= counter + 1'b1;
        // ����0��9֮��������
        target <= counter % 10;
    end
    
    endmodule

    
