`timescale 1ns / 1ps

module cordic #(
    parameter WIDTH       = 16,   
    parameter ITERATIONS  = 12,
    parameter SHIFT_WIDTH = 4
)(
    input  wire                     clk,
    input  wire                     rst,
    input  wire                     start,
    input  wire signed [WIDTH-1:0]  angle,     
    output reg  signed [WIDTH-1:0]  cos_out,   
    output reg  signed [WIDTH-1:0]  sin_out,   
    output reg                      done
);

   
    localparam signed [WIDTH-1:0] K_INIT = 16'd9957;   

    reg  signed [WIDTH-1:0] x, y, z;
    reg  [SHIFT_WIDTH-1:0]  i;
    reg  signed [WIDTH-1:0] atan_table [0:ITERATIONS-1];

    
    initial begin
        atan_table[0]  = 16'd12868; 
        atan_table[1]  = 16'd7596; 
        atan_table[2]  = 16'd4013;  
        atan_table[3]  = 16'd2037;  
        atan_table[4]  = 16'd1021; 
        atan_table[5]  = 16'd512;   
        atan_table[6]  = 16'd256;
        atan_table[7]  = 16'd128;
        atan_table[8]  = 16'd64;
        atan_table[9]  = 16'd32;
        atan_table[10] = 16'd16;
        atan_table[11] = 16'd8;
    end

    
    wire signed [WIDTH-1:0] x_shifted, y_shifted;
    BarrelShifter #(.WIDTH(WIDTH), .SHIFT_WIDTH(SHIFT_WIDTH)) 
        bs_x (.data_in(x), .shift_amt(i), .shift_dir(1'b0), .data_out(x_shifted)); // right shift
    BarrelShifter #(.WIDTH(WIDTH), .SHIFT_WIDTH(SHIFT_WIDTH)) 
        bs_y (.data_in(y), .shift_amt(i), .shift_dir(1'b0), .data_out(y_shifted)); // right shift

    
    wire signed [WIDTH-1:0] x_next_addsub, y_next_addsub, z_next_addsub;
    wire overflow_dummy1, overflow_dummy2, overflow_dummy3;
    wire carry_dummy1, carry_dummy2, carry_dummy3;

   
    adder_subtractor #(.WIDTH(WIDTH)) add_x (
        .a(x),
        .b(y_shifted),
        .sub(z[WIDTH-1]==0 ? 1'b1 : 1'b0), 
        .result(x_next_addsub),
        .overflow(overflow_dummy1),
        .carry_out(carry_dummy1)
    );

    
    adder_subtractor #(.WIDTH(WIDTH)) add_y (
        .a(y),
        .b(x_shifted),
        .sub(z[WIDTH-1]==0 ? 1'b0 : 1'b1), 
        .result(y_next_addsub),
        .overflow(overflow_dummy2),
        .carry_out(carry_dummy2)
    );

    
    adder_subtractor #(.WIDTH(WIDTH)) add_z (
        .a(z),
        .b(atan_table[i]),
        .sub(z[WIDTH-1]==0 ? 1'b1 : 1'b0),
        .result(z_next_addsub),
        .overflow(overflow_dummy3),
        .carry_out(carry_dummy3)
    );

    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x    <= 0;
            y    <= 0;
            z    <= 0;
            i    <= 0;
            done <= 0;
            cos_out <= 0;
            sin_out <= 0;
        end 
        else if (start) begin
            x    <= K_INIT;
            y    <= 0;
            z    <= angle;
            i    <= 0;
            done <= 0;
        end 
        else if (i < ITERATIONS) begin
            x <= x_next_addsub;
            y <= y_next_addsub;
            z <= z_next_addsub;
            i <= i + 1'b1;
        end 
        else begin
            cos_out <= x;
            sin_out <= y;
            done <= 1'b1;
        end
    end

endmodule
