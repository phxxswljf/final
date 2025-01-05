`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/04 23:01:49
// Design Name: 
// Module Name: timer
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

module timer(
    input wire clk,               // ����ʱ�ӣ�100 MHz��
    input wire rst,               // ��λ�ź�
    input wire enable,
    output reg timeout,           // ��ʱ�ź�
    output reg [7:0] clk_out      // ÿ�����ֵ��ֱ����Ϊ timeout_counter��
);

   reg [26:0] clk_counter= 27'd99999999;       // ��Ƶ������
   reg clk_enable;               // 1Hz ʱ��ʹ���ź�

    // 1Hz ʱ������
    always @(posedge clk or posedge rst) begin
        if (rst||!enable) begin
            clk_counter <= 0;
            clk_enable <= 0;
       end else if (clk_counter == 27'd99999999) begin
            clk_counter <= 0;
            clk_enable  <= 1;      // ÿ�봥��һ��
        end else begin
            clk_counter <= clk_counter + 1;
            clk_enable <= 0;
        end
    end

    // ��ʱ��������
    always @(posedge clk or posedge rst) begin
        if (rst||!enable) begin
            clk_out <= 16;         // ���ü�ʱ��
            timeout <= 0;
        end else if (clk_enable) begin
            if (clk_out >0) begin
                   clk_out <= clk_out - 1; // ÿ��ݼ�
                   timeout <= 0;           // δ��ʱ
            end else begin
                   timeout <= 1;           // ��ʱ�ź�
            end
            end 
          
     end
   

endmodule
