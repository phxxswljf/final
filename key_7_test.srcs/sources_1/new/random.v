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
    
    // 用于生成随机数的计数器
    reg [7:0] counter;
    
    always @(posedge enable) begin
        // 更新计数器
        counter <= counter + 1'b1;
        // 生成0到9之间的随机数
        target <= counter % 10;
    end
    
    endmodule

    
