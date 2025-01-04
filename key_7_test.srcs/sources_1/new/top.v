`timescale 1ps / 1ps
module top (
    input wire clk,               // 时钟信号
    input wire rst,               // 复位信号

    // 键盘
    input wire ps2_clk,           // PS/2时钟信号
    input wire ps2_data,          // PS/2数据线
    
    // 7段数码管
    output wire [6:0] oData ,     // 7段数码管显示信号
    output reg [9:0] led_odata
); 

    wire [3:0] final_input;

    // 实例化 ps2_keyboard 模块
    ps2_keyboard u_ps2_keyboard (
        .clk(clk),                   // 传入系统时钟
        .ps2_clk(ps2_clk),           // 传入PS/2时钟信号
        .ps2_data(ps2_data),         // 传入PS/2数据线信号
        .final_input(final_input),   // 最终输入数字
        .rst(rst)
    );

    // 实例化 seven_seg_mux 模块
    display7 uut (
        .iData(final_input),
        .oData(oData)
    );
    
    timer uut(
        .clk(clk),               // 输入时钟（100 MHz）
        .rst(rst),               // 复位信号
        .timeout(timeout),           // 超时信号
        .clk_out(clk_out)      // 每秒计数值（直接作为 timeout_counter）
    );
    
    
    
    always@(*)begin
       led_odata<=10'd0;
       case(final_input) 
        4'd0:          led_odata[0]<=1;
        4'd1:          led_odata[1]<=1;
        4'd2:          led_odata[2]<=1;
        4'd3:          led_odata[3]<=1; 
        4'd4:          led_odata[4]<=1;
        4'd5:          led_odata[5]<=1;
        4'd6:          led_odata[6]<=1;
        4'd7:          led_odata[7]<=1;
        4'd8:          led_odata[8]<=1; 
        4'd9:          led_odata[9]<=1;
         
       endcase
    end
endmodule
