module tb_SRAM;

    // Testbench signals
    reg [7:0] data_in;
    reg [6:0] address;
    reg write_enable;
    reg read_enable;
    reg clk;
    wire [7:0] data_out;

    // Instantiate the SRAM module
    SRAM_128x8 uut (
        .data_in(data_in),
        .address(address),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .clk(clk),
        .data_out(data_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 time units period
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        data_in = 8'b00000000;
        address = 7'b0000000;
        
        // Wait for the global reset
        #10;

        // Test 1: Write and Read back data
        // Write data to address 0
        write_enable = 1;
        data_in = 8'b10101010;
        address = 7'b0000000;
        #10; // Wait for one clock edge

        // Disable write and enable read
        write_enable = 0;
        read_enable = 1;
        #10; // Wait for one clock edge

        // Check if data read from address 0 is correct
        if (data_out !== 8'b10101010) begin
            $display("Test failed: expected 10101010, got %b", data_out);
        end else begin
            $display("Test passed: Read data %b", data_out);
        end

        // Test 2: Write data to another address
        write_enable = 1;
        data_in = 8'b11001100;
        address = 7'b0000001;
        #10; // Wait for one clock edge

        // Disable write and enable read
        write_enable = 0;
        read_enable = 1;
        #10; // Wait for one clock edge

        // Check if data read from address 1 is correct
        if (data_out !== 8'b11001100) begin
            $display("Test failed: expected 11001100, got %b", data_out);
        end else begin
            $display("Test passed: Read data %b", data_out);
        end

        // Test 3: Write and read back data at the same address
        write_enable = 1;
        data_in = 8'b00110011;
        address = 7'b0000000;
        #10; // Wait for one clock edge

        // Disable write and enable read
        write_enable = 0;
        read_enable = 1;
        #10; // Wait for one clock edge

        // Check if data read from address 0 is updated
        if (data_out !== 8'b00110011) begin
            $display("Test failed: expected 00110011, got %b", data_out);
        end else begin
            $display("Test passed: Read data %b", data_out);
        end

        // Finish simulation
        $stop;
    end

endmodule
