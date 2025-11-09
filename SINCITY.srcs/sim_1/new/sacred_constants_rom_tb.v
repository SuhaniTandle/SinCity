`timescale 1ns / 1ps

module sacred_constants_rom_tb;
    parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 7;
    
    reg  [ADDR_WIDTH-1:0]  addr;
    wire [DATA_WIDTH-1:0]  cos_out;
    
    // Instantiate ROM
    sacred_constants_rom #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .addr(addr),
        .cos_out(cos_out)
    );
    
    // Fixed-point conversion function
    function real fixed_to_real;
        input [DATA_WIDTH-1:0] fixed_val;
        begin
            fixed_to_real = $itor($signed(fixed_val)) / 16384.0;
        end
    endfunction
    
    integer i;
    initial begin
        $display("=== Sacred Constants ROM Verification ===");
        $display("Format: Q2.14 (16-bit)");
        $display("Angular Range: 0° to 90°");
        $display("");
        $display("Angle | Hex Value | Decimal | Float Value");
        $display("------|-----------|---------|------------");
        
        // Test key angles
        for (i = 0; i <= 90; i = i + 5) begin
            addr = i;
            #10;
            $display(" %2d°  |  0x%04h  |  %5d  |  %f", 
                     i, cos_out, $signed(cos_out), fixed_to_real(cos_out));
        end
        
        $display("");
        $display("=== Critical Angles ===");
        
        // Test 0°
        addr = 0;
        #10;
        $display("cos(0°)  = %f (expected: 1.0)", fixed_to_real(cos_out));
        
        // Test 30°
        addr = 30;
        #10;
        $display("cos(30°) = %f (expected: 0.866025)", fixed_to_real(cos_out));
        
        // Test 45°
        addr = 45;
        #10;
        $display("cos(45°) = %f (expected: 0.707107)", fixed_to_real(cos_out));
        
        // Test 60°
        addr = 60;
        #10;
        $display("cos(60°) = %f (expected: 0.5)", fixed_to_real(cos_out));
        
        // Test 90°
        addr = 90;
        #10;
        $display("cos(90°) = %f (expected: 0.0)", fixed_to_real(cos_out));
        
        $display("");
        $display("=== ROM Verification Complete ===");
        $finish;
    end

endmodule


