module SRAM_128x8 (
    input wire [7:0] data_in,        // 8-bit input data
    input wire [6:0] address,        // 7-bit address to select one of 128 rows
    input wire write_enable,         // Write enable signal
    input wire read_enable,          // Read enable signal
    input wire clk,                  // Clock signal
    output reg [7:0] data_out        // 8-bit output data
);
    // Memory array: 128 rows of 8-bit wide memory (128 x 8)
    reg [7:0] memory_array [127:0];

    always @(posedge clk) begin
        if (write_enable) begin
            memory_array[address] <= data_in;  // Write data to selected row
        end
    end

    always @(read_enable or address) begin
        if (read_enable) begin
            data_out = memory_array[address];  // Read data from selected row
        end
    end
endmodule
module SRAM_Cell (
    input wire data_in,      // Input data for write
    input wire write_enable, // Write enable signal
    input wire read_enable,  // Read enable signal
    input wire clk,          // Clock signal
    output reg data_out      // Output data for read
);
    reg bit_value;           // Internal storage of 1 bit

    always @(posedge clk) begin
        if (write_enable) begin
            bit_value <= data_in; // Write operation
        end
    end

    always @(read_enable or bit_value) begin
        if (read_enable) begin
            data_out = bit_value; // Read operation
        end
    end
endmodule

module SRAM_Row (
    input wire [7:0] data_in,      // Input data (1 byte)
    input wire write_enable,       // Write enable signal
    input wire read_enable,        // Read enable signal
    input wire clk,                // Clock signal
    output wire [7:0] data_out     // Output data (1 byte)
);
    // Create 8 SRAM cells for 8-bit storage
    SRAM_Cell sram0 (.data_in(data_in[0]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[0]));
    SRAM_Cell sram1 (.data_in(data_in[1]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[1]));
    SRAM_Cell sram2 (.data_in(data_in[2]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[2]));
    SRAM_Cell sram3 (.data_in(data_in[3]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[3]));
    SRAM_Cell sram4 (.data_in(data_in[4]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[4]));
    SRAM_Cell sram5 (.data_in(data_in[5]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[5]));
    SRAM_Cell sram6 (.data_in(data_in[6]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[6]));
    SRAM_Cell sram7 (.data_in(data_in[7]), .write_enable(write_enable), .read_enable(read_enable), .clk(clk), .data_out(data_out[7]));
endmodule
