`timescale 1ps / 1ps
module top (
    input wire clk,               // ʱ���ź�
    input wire rst,               // ��λ�ź�

    // ����
    input wire ps2_clk,           // PS/2ʱ���ź�
    input wire ps2_data,          // PS/2������
    
    // 7�������
    output wire [6:0] oData ,     // 7���������ʾ�ź�
    output reg [9:0] led_odata
); 

    wire [3:0] final_input;

    // ʵ���� ps2_keyboard ģ��
    ps2_keyboard u_ps2_keyboard (
        .clk(clk),                   // ����ϵͳʱ��
        .ps2_clk(ps2_clk),           // ����PS/2ʱ���ź�
        .ps2_data(ps2_data),         // ����PS/2�������ź�
        .final_input(final_input),   // ������������
        .rst(rst)
    );

    // ʵ���� seven_seg_mux ģ��
    display7 uut (
        .iData(final_input),
        .oData(oData)
    );
    
    timer uut(
        .clk(clk),               // ����ʱ�ӣ�100 MHz��
        .rst(rst),               // ��λ�ź�
        .timeout(timeout),           // ��ʱ�ź�
        .clk_out(clk_out)      // ÿ�����ֵ��ֱ����Ϊ timeout_counter��
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
