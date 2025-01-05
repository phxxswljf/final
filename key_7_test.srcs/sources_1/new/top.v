`timescale 1ps / 1ps
module top (
    input wire clk,               // ʱ���ź�
    input wire rst,               // ��λ�ź�
    //input wire my_start,          // �����ź�
    input wire enable,
    // ����
    input wire ps2_clk,           // PS/2ʱ���ź�
    input wire ps2_data,          // PS/2������
    
    // 7�������
    output wire [6:0] oData,      // 7���������ʾ�ź�
    output reg [15:0] led_odata    // LED��ʾ�ź�
); 

    // ����״̬����״̬
   /* localparam    IDLE = 2'b00;  // ����״̬
    localparam    RUN  = 2'b01;   // ����״̬
  
    
    reg [1:0] state, next_state;   // ��ǰ״̬����һ��״̬*/
    
    wire [3:0] final_input;        // ��������
    wire  [3:0] target;
    wire timeout;                  // ��ʱ�ź�
    wire [7:0] clk_out;             // ��ʱ�����
    
    // ״̬����״̬ת��
    /*always @(posedge clk or posedge rst) begin
        if (rst) 
            state <= IDLE;         // ��λʱ�ص�IDLE״̬
        else 
            state <= next_state;  // ����ת����һ��״̬
    end
*/
    // ״̬���߼�
   /* always @(*) begin
        case (state)
            IDLE: begin
                // ������IDLE״̬ʱ������ģ�鶼������
                next_state = (my_start) ? RUN : IDLE;  // ���my_startΪ��Ч��ת��RUN״̬
            end
            RUN: begin
                // ������RUN״̬ʱ���ж�timeout�ź�
                next_state = (timeout) ? IDLE : RUN;  // ���timeout��Ч��ת��IDLE״̬
            end
            default: next_state = IDLE;
        endcase
    end*/

    // ����ģ�������ź�
   /* wire ps2_keyboard_enable = (state == RUN);  // ��RUN״̬ʱ����PS/2����
    wire display7_enable = (state == RUN);      // ��RUN״̬ʱ����7�������
    wire timer_enable = (state == RUN);         // ��RUN״̬ʱ���ü�ʱ��
    wire random_enable = (state == RUN);        // ��RUN״̬ʱ���������������*/
    
    wire ps2_keyboard_enable = enable;  // ��RUN״̬ʱ����PS/2����
    wire display7_enable = enable;      // ��RUN״̬ʱ����7�������
    wire timer_enable = enable;         // ��RUN״̬ʱ���ü�ʱ��
    wire random_enable = enable; 
    
    // ʵ���� ps2_keyboard ģ��
    ps2_keyboard u_ps2_keyboard (
        .clk(clk),                   // ����ϵͳʱ��
        .ps2_clk(ps2_clk),           // ����PS/2ʱ���ź�
        .ps2_data(ps2_data),         // ����PS/2�������ź�
        .final_input(final_input),   // ������������
        .rst(rst),
        .enable(ps2_keyboard_enable) // ����ps2_keyboard�Ƿ�����
    );

    // ʵ���� display7 ģ��
    display7 uut (
        .iData(final_input),
        .oData(oData),
        .enable(display7_enable)    // ����display7�Ƿ�����
    );

    // ʵ������ʱ��
    timer u_timer(
        .clk(clk),             // ����ʱ�ӣ�100 MHz��
        .rst(rst),             // ��λ�ź�
        .timeout(timeout),     // ��ʱ�ź�
        .clk_out(clk_out),     // ÿ�����ֵ��ֱ����Ϊ timeout_counter��
        .enable(timer_enable)  // ����timer�Ƿ�����
    );
    
    //ʵ����random
    random random(
         .enable(random_enable),
         .target(target)
        );
    
    // ����LED��ʾ
    always @(posedge clk) begin
        if (enable) begin
            if(target==final_input) begin  //����¶���
                   //next_state=IDLE;
                   led_odata <= 16'b1111111111111111;  
            end else begin   //û�в¶Լ�����ʱ
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
                    default:        led_odata <= 10'd0;   // Ĭ�Ϲر�LED
                endcase
            end
        end
        else
        led_odata <= 10'd0; // �����IDLE״̬��LED�ر�        
    end
    
endmodule
