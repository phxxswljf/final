`timescale 1ps / 1ps
module top (
    input wire clk,               // 时钟信号
    input wire rst,               // 复位信号
    //input wire my_start,          // 启动信号
    input wire enable,
    // 键盘
    input wire ps2_clk,           // PS/2时钟信号
    input wire ps2_data,          // PS/2数据线
    
    // 7段数码管
    output wire [6:0] oData,      // 7段数码管显示信号
    output reg [15:0] led_odata    // LED显示信号
); 

    // 定义状态机的状态
   /* localparam    IDLE = 2'b00;  // 空闲状态
    localparam    RUN  = 2'b01;   // 运行状态
  
    
    reg [1:0] state, next_state;   // 当前状态和下一个状态*/
    
    wire [3:0] final_input;        // 键盘输入
    wire  [3:0] target;
    wire timeout;                  // 超时信号
    wire [7:0] clk_out;             // 计时器输出
    
    // 状态机的状态转换
    /*always @(posedge clk or posedge rst) begin
        if (rst) 
            state <= IDLE;         // 复位时回到IDLE状态
        else 
            state <= next_state;  // 否则转到下一个状态
    end
*/
    // 状态机逻辑
   /* always @(*) begin
        case (state)
            IDLE: begin
                // 当处于IDLE状态时，所有模块都不工作
                next_state = (my_start) ? RUN : IDLE;  // 如果my_start为有效，转到RUN状态
            end
            RUN: begin
                // 当处于RUN状态时，判断timeout信号
                next_state = (timeout) ? IDLE : RUN;  // 如果timeout有效，转到IDLE状态
            end
            default: next_state = IDLE;
        endcase
    end*/

    // 控制模块启用信号
   /* wire ps2_keyboard_enable = (state == RUN);  // 在RUN状态时启用PS/2键盘
    wire display7_enable = (state == RUN);      // 在RUN状态时启用7段数码管
    wire timer_enable = (state == RUN);         // 在RUN状态时启用计时器
    wire random_enable = (state == RUN);        // 在RUN状态时启用随机数生成器*/
    
    wire ps2_keyboard_enable = enable;  // 在RUN状态时启用PS/2键盘
    wire display7_enable = enable;      // 在RUN状态时启用7段数码管
    wire timer_enable = enable;         // 在RUN状态时启用计时器
    wire random_enable = enable; 
    
    // 实例化 ps2_keyboard 模块
    ps2_keyboard u_ps2_keyboard (
        .clk(clk),                   // 传入系统时钟
        .ps2_clk(ps2_clk),           // 传入PS/2时钟信号
        .ps2_data(ps2_data),         // 传入PS/2数据线信号
        .final_input(final_input),   // 最终输入数字
        .rst(rst),
        .enable(ps2_keyboard_enable) // 控制ps2_keyboard是否启用
    );

    // 实例化 display7 模块
    display7 uut (
        .iData(final_input),
        .oData(oData),
        .enable(display7_enable)    // 控制display7是否启用
    );

    // 实例化计时器
    timer u_timer(
        .clk(clk),             // 输入时钟（100 MHz）
        .rst(rst),             // 复位信号
        .timeout(timeout),     // 超时信号
        .clk_out(clk_out),     // 每秒计数值（直接作为 timeout_counter）
        .enable(timer_enable)  // 控制timer是否启用
    );
    
    //实例化random
    random random(
         .enable(random_enable),
         .target(target)
        );
    
    // 控制LED显示
    always @(posedge clk) begin
        if (enable) begin
            if(target==final_input) begin  //如果猜对了
                   //next_state=IDLE;
                   led_odata <= 16'b1111111111111111;  
            end else begin   //没有猜对继续计时
                case(clk_out)    
                    5'd16:          led_odata <= 16'b1000000000000000;
                    4'd15:          led_odata <= 16'b0100000000000000;
                    4'd14:          led_odata <= 16'b0010000000000000;
                    4'd13:          led_odata <= 16'b0001000000000000;
                    4'd12:          led_odata <= 16'b0000100000000000;
                    4'd11:          led_odata <= 16'b0000010000000000;
                    4'd10:          led_odata <= 16'b0000001000000000;
                    4'd9:           led_odata <= 16'b0000000100000000;
                    4'd8:           led_odata <= 16'b0000000010000000;
                    4'd7:           led_odata <= 16'b0000000001000000;
                    4'd6:           led_odata <= 16'b0000000000100000;
                    4'd5:           led_odata <= 16'b0000000000010000;
                    4'd4:           led_odata <= 16'b0000000000001000;
                    4'd3:           led_odata <= 16'b0000000000000100;
                    4'd2:           led_odata <= 16'b0000000000000010;
                    4'd1:           led_odata <= 16'b0000000000000001;  
                    default:        led_odata <= 10'd0;   // 默认关闭LED
                endcase
            end
        end
        else
        led_odata <= 10'd0; // 如果是IDLE状态，LED关闭        
    end
    
endmodule
