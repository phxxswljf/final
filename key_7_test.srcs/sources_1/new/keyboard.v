`timescale 1ns / 1ps

module ps2_keyboard (
    input wire clk,                 // FPGA系统时钟
    input wire ps2_clk,             // PS/2时钟信号
    input wire ps2_data,            // PS/2数据线
    input wire rst,
    input wire enable,
    output reg [3:0] final_input  
);

    reg         ps2c;               //clock transfer to slave
    reg         ps2d;               //data ready to slave
    reg  [7:0]  ps2c_fliter;
    reg  [7:0]  ps2d_fliter;
    reg  [10:0] shift1;
    reg  [10:0] shift2;
    wire [15:0] key;
    assign      key = { shift2[8:1], shift1[8:1] };

    always @(posedge clk or posedge rst) begin
        if (rst||!enable) begin
            ps2c            <= 1;
            ps2d            <= 1;
            ps2c_fliter     <= 0;
            ps2d_fliter     <= 0;
        end else begin
            ps2c_fliter <= {ps2c_fliter[6:0], ps2_clk};  // 滤波器更新
            ps2d_fliter <= {ps2d_fliter[6:0], ps2_data}; // 滤波器更新

            if (ps2c_fliter == 8'b11111111)
                ps2c <= 1;
            else if (ps2c_fliter == 8'b00000000)
                ps2c <= 0;

            if (ps2d_fliter == 8'b11111111)
                ps2d <= 1;
            else if (ps2d_fliter == 8'b00000000)
                ps2d <= 0;
        end
    end

    always @(negedge ps2c or posedge rst) begin
        if (rst||!enable) begin
            shift1 <= 0;
            shift2 <= 0;
        end else begin
            shift1 <= { ps2d, shift1[10:1] };
            shift2 <= { shift1[0], shift2[10:1] };
        end
    end 

    always @(posedge clk) begin
        if (!rst && enable) begin
            case (key)
                16'hF045: begin // 0
                    final_input <= 4'b0000;
                   
                end

                16'hF016: begin // 1
                    final_input <= 4'b0001;
                   
                end

                16'hF01E: begin // 2
                    final_input <= 4'b0010;
                   
                end

                16'hF026: begin // 3
                    final_input <= 4'b0011;
                   
                end

                16'hF025: begin // 4
                    final_input <= 4'b0100;
                 
                end

                16'hF02E: begin // 5
                    final_input <= 4'b0101;
                    
                end

                16'hF036: begin // 6
                    final_input <= 4'b0110;
                   
                end

                16'hF03D: begin // 7
                    final_input <= 4'b0111;
                   
                end

                16'hF03E: begin // 8
                    final_input <= 4'b1000;
                    
                end

                16'hF046: begin // 9
                    final_input <= 4'b1001;
                    
                end

                default: begin
                   //final_input <= 4'b0001;
                end
            endcase
        end
    end
endmodule
