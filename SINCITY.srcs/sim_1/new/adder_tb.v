`timescale 1ns / 1ps

/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2025 09:37:40
// Design Name: 
// Module Name: adder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module adder_subtractor_tb;
    parameter WIDTH = 16;
    
    reg  [WIDTH-1:0]  a;
    reg  [WIDTH-1:0]  b;
    reg               sub;
    wire [WIDTH-1:0]  result;
    wire              overflow;
    wire              carry_out;
    
    // Instantiate DUT
    adder_subtractor #(
        .WIDTH(WIDTH)
    ) dut (
        .a(a),
        .b(b),
        .sub(sub),
        .result(result),
        .overflow(overflow),
        .carry_out(carry_out)
    );
    
    // Fixed-point conversion function for display
    function real fixed_to_real;
        input [WIDTH-1:0] fixed_val;
        begin
            fixed_to_real = $itor($signed(fixed_val)) / 16384.0;  // Divide by 2^14
        end
    endfunction
    
    initial begin
        $display("=== Adder/Subtractor Testbench ===");
        $display("Format: Q2.14 (16-bit)");
        $display("");
        
        // Test 1: Basic Addition
        $display("Test 1: Basic Addition");
        a = 16'h2000;    // +0.5
        b = 16'h1000;    // +0.25
        sub = 0;
        #10;
        $display("  %f + %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 2: Basic Subtraction
        $display("Test 2: Basic Subtraction");
        a = 16'h2000;    // +0.5
        b = 16'h1000;    // +0.25
        sub = 1;
        #10;
        $display("  %f - %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 3: Negative Numbers
        $display("Test 3: Adding Negative Numbers");
        a = 16'hE000;    // -0.5
        b = 16'hF000;    // -0.25
        sub = 0;
        #10;
        $display("  %f + %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 4: Mixed Sign Addition
        $display("Test 4: Mixed Sign Addition");
        a = 16'h4000;    // +1.0
        b = 16'hE000;    // -0.5
        sub = 0;
        #10;
        $display("  %f + %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 5: Subtracting Negative (equivalent to addition)
        $display("Test 5: Subtracting Negative Number");
        a = 16'h2000;    // +0.5
        b = 16'hE000;    // -0.5
        sub = 1;
        #10;
        $display("  %f - (%f) = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 6: CORDIC Typical Operations
        $display("Test 6: CORDIC-Style Operations");
        a = 16'h4000;    // cos(0) = 1.0
        b = 16'h0000;    // y_shifted = 0
        sub = 0;
        #10;
        $display("  x_new = x - y_shifted");
        $display("  %f - %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("");
        
        // Test 7: Overflow Test - Positive
        $display("Test 7: Overflow Test (Positive)");
        a = 16'h6000;    // +1.5
        b = 16'h6000;    // +1.5
        sub = 0;
        #10;
        $display("  %f + %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 8: Overflow Test - Negative
        $display("Test 8: Overflow Test (Negative)");
        a = 16'hA000;    // -1.5
        b = 16'hA000;    // -1.5
        sub = 0;
        #10;
        $display("  %f + %f = %f (0x%04h)", 
                 fixed_to_real(a), fixed_to_real(b), fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        // Test 9: Zero Operations
        $display("Test 9: Zero Operations");
        a = 16'h0000;
        b = 16'h0000;
        sub = 0;
        #10;
        $display("  0.0 + 0.0 = %f (0x%04h)", fixed_to_real(result), result);
        sub = 1;
        #10;
        $display("  0.0 - 0.0 = %f (0x%04h)", fixed_to_real(result), result);
        $display("");
        
        // Test 10: Maximum Values
        $display("Test 10: Maximum Values");
        a = 16'h7FFF;    // Maximum positive (~1.999)
        b = 16'h0001;    // Minimum positive
        sub = 0;
        #10;
        $display("  MAX + MIN = %f (0x%04h)", fixed_to_real(result), result);
        $display("  Overflow: %b, Carry: %b", overflow, carry_out);
        $display("");
        
        $display("=== Test Complete ===");
        $finish;
    end

endmodule
