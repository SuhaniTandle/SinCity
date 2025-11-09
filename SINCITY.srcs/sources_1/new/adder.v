`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2025 09:36:41
// Design Name: 
// Module Name: adder
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


module adder_subtractor #(
    parameter WIDTH = 16          
)(
    input  wire [WIDTH-1:0]  a,          
    input  wire [WIDTH-1:0]  b,        
    input  wire              sub,         
    output wire [WIDTH-1:0]  result,     
    output wire              overflow,    
    output wire              carry_out    
);

  
    wire [WIDTH-1:0] b_modified;
    wire [WIDTH:0]   extended_result;  
    
   
    assign b_modified = sub ? ~b : b;
    
    
    assign extended_result = {1'b0, a} + {1'b0, b_modified} + {{WIDTH{1'b0}}, sub};
    
    
    assign result = extended_result[WIDTH-1:0];
    
   
    assign carry_out = extended_result[WIDTH];
    
   
    wire a_sign = a[WIDTH-1];
    wire b_sign = b[WIDTH-1];
    wire result_sign = result[WIDTH-1];
    wire b_eff_sign = sub ? ~b_sign : b_sign;  
    
    assign overflow = (a_sign == b_eff_sign) && (result_sign != a_sign);

endmodule
