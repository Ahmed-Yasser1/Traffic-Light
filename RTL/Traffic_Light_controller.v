module traffic_light_controller (clk, rst, LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9, LED10, LED11);
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    parameter DIV = 5000000;

    input clk, rst;
    output reg LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9, LED10, LED11;

    (* fsm_encoding = "sequential" *)
    reg [1 : 0] cs, ns;
    reg [25 : 0] count;
    wire clk_b;

    clock_divider #(.DIV(DIV)) div (.rst(rst), .clk(clk), .clk_b(clk_b));

    //Next State Logic
    always @ (*) begin
        case (cs)
            S0 : begin
                if (count == 10)
                    ns = S1;
                else
                    ns = S0;
            end

            S1 : begin
                if (count == 3)
                    ns = S2;
                else
                    ns = S1;
            end

            S2 : if (count == 10)
                    ns = S3;
                else
                    ns = S2;
            
            S3 : if (count == 3)
                    ns = S0;
                else
                    ns = S3;
        endcase
    end

    //State vMemory
    always @ (posedge clk_b, negedge rst) begin
        if (! rst)
            cs <= S0;
        else
            cs <= ns;
    end

    //Output Logic
    always @ (posedge clk_b, negedge rst) begin
        if (! rst) begin
            LED0 <= 1'b0; LED1 <= 1'b0; LED2 <= 1'b1; //North
            LED3 <= 1'b0; LED4 <= 1'b0; LED5 <= 1'b1; //South
            LED6 <= 1'b1; LED7 <= 1'b0; LED8 <= 1'b0; //East
            LED9 <= 1'b1; LED10 <= 1'b0; LED11 <= 1'b0; // West
            count <= 0;
        end
        else begin
            case (cs)
                S0 : begin
                    if (count < 10) begin
                        LED0 <= 1'b0; LED1 <= 1'b0; LED2 <= 1'b1; //North
                        LED3 <= 1'b0; LED4 <= 1'b0; LED5 <= 1'b1; //South
                        LED6 <= 1'b1; LED7 <= 1'b0; LED8 <= 1'b0; //East
                        LED9 <= 1'b1; LED10 <= 1'b0; LED11 <= 1'b0; // West
                        count <= count + 1;
                    end
                    if (count == 10) begin
                        count <= 0;
                    end
                end

                S1 : begin
                    if (count < 3) begin
                        LED0 <= 1'b0; LED1 <= 1'b1; LED2 <= 1'b0; //North
                        LED3 <= 1'b0; LED4 <= 1'b1; LED5 <= 1'b0; //South
                        LED6 <= 1'b1; LED7 <= 1'b0; LED8 <= 1'b0; //East
                        LED9 <= 1'b1; LED10 <= 1'b0; LED11 <= 1'b0; // West
                        count <= count + 1;
                    end
                    if (count == 3) begin
                        count <= 0;
                    end
                end

                S2 : begin
                    if (count < 10) begin
                        LED0 <= 1'b1; LED1 <= 1'b0; LED2 <= 1'b0; //North
                        LED3 <= 1'b1; LED4 <= 1'b0; LED5 <= 1'b0; //South
                        LED6 <= 1'b0; LED7 <= 1'b0; LED8 <= 1'b1; //East
                        LED9 <= 1'b0; LED10 <= 1'b0; LED11 <= 1'b1; // West
                        count <= count + 1;
                    end
                    if (count == 10) begin
                        count <= 0;
                    end
                end

                S3 : begin
                    if (count < 3) begin
                        LED0 <= 1'b1; LED1 <= 1'b0; LED2 <= 1'b0; //North
                        LED3 <= 1'b1; LED4 <= 1'b0; LED5 <= 1'b0; //South
                        LED6 <= 1'b0; LED7 <= 1'b1; LED8 <= 1'b0; //East
                        LED9 <= 1'b0; LED10 <= 1'b1; LED11 <= 1'b0; // West
                        count <= count + 1;
                    end
                    if (count == 3) begin
                        count <= 0;
                    end
                end
            endcase
        end
    end
endmodule