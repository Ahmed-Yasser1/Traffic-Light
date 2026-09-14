module traffic_light_controller_tb ();
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    parameter DIV = 500;

    reg clk, rst;
    wire LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9, LED10, LED11;

    traffic_light_controller #(.S0(S0), .S1(S1), .S2(S2), .S3(S3), .DIV(DIV)) dut (.*);

    initial begin
        clk = 0;
        forever
            #1 clk = ~ clk;
    end

    initial begin
        rst = 1'b0;
        @(negedge clk);
        rst = 1'b1;

        repeat (100000) begin
            @(negedge clk);
        end
        $stop;
    end
endmodule
