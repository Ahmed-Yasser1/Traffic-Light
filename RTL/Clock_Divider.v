module clock_divider (rst, clk, clk_b);
    parameter DIV = 500;
    localparam WIDTH = $clog2(DIV);

    input rst, clk;
    output reg clk_b;

    reg [WIDTH - 1 : 0] count;

    always @ (posedge clk, negedge rst) begin
        if (! rst) begin
            count <= 0;
            clk_b <= 0;
        end
        else begin
            if (count == (DIV - 1)) begin
                count <= 0;
                clk_b <= ~ clk_b;
            end
            else begin
                count <= count + 1;
            end
        end
    end
endmodule