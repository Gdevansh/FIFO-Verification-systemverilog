module fifo #(parameter DEPTH = 8, WIDTH = 8)(
    input clk, rst,
    input wr_en, rd_en,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output full, empty
);

reg [WIDTH-1:0] mem [0:DEPTH-1];
int wr_ptr = 0, rd_ptr = 0, count = 0;

assign full = (count == DEPTH);
assign empty = (count == 0);

always @(posedge clk) begin
    if (rst) begin
        wr_ptr <= 0; rd_ptr <= 0; count <= 0;
    end
    else begin
        if (wr_en && !full) begin
            mem[wr_ptr] <= din;
            wr_ptr <= (wr_ptr + 1) % DEPTH;
            count <= count + 1;
        end
        if (rd_en && !empty) begin
            dout <= mem[rd_ptr];
            rd_ptr <= (rd_ptr + 1) % DEPTH;
            count <= count - 1;
        end
    end
end

endmodule
