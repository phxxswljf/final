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
    input wire clk,               // 输入时钟（100 MHz）
    input wire rst,               // 复位信号
    input wire enable,
    output reg timeout,           // 超时信号
    output reg [7:0] clk_out      // 每秒计数值（直接作为 timeout_counter）
);

   reg [26:0] clk_counter= 27'd99999999;       // 分频计数器
   reg clk_enable;               // 1Hz 时钟使能信号

    // 1Hz 时钟生成
    always @(posedge clk or posedge rst) begin
        if (rst||!enable) begin
            clk_counter <= 0;
            clk_enable <= 0;
       end else if (clk_counter == 27'd99999999) begin
            clk_counter <= 0;
            clk_enable  <= 1;      // 每秒触发一次
        end else begin
            clk_counter <= clk_counter + 1;
            clk_enable <= 0;
        end
    end

    // 超时检测与计数
    always @(posedge clk or posedge rst) begin
        if (rst||!enable) begin
            clk_out <= 16;         // 重置计时器
            timeout <= 0;
        end else if (clk_enable) begin
            if (clk_out >0) begin
                   clk_out <= clk_out - 1; // 每秒递减
                   timeout <= 0;           // 未超时
            end else begin
                   timeout <= 1;           // 超时信号
            end
            end 
          
     end
   

endmodule
