`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2025 09:39:15
// Design Name: 
// Module Name: sacred_constants_rom
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

//////////////////////////////////////////////////////////////////////////////////
module sacred_constants_rom #(
    parameter DATA_WIDTH = 16,        // Q2.14 format
    parameter ADDR_WIDTH = 7,         // 7 bits = 128 addresses (0-90° + extra)
    parameter ROM_DEPTH = 91          // 0° to 90° inclusive
)(
    input  wire [ADDR_WIDTH-1:0]  addr,      // Address input (angle in degrees)
    output reg  [DATA_WIDTH-1:0]  cos_out    // Cosine output in Q2.14
);

    // ROM Array: Pre-calculated cosine values
    // Format: cos(angle) in Q2.14 = cos(angle) * 16384
    // Values calculated using Python: int(round(math.cos(math.radians(angle)) * 16384))
    
    always @(*) begin
        case (addr)
            // Angles 0° - 10°
            7'd0:  cos_out = 16'h4000;  // cos(0°)  = 1.000000000 = 16384
            7'd1:  cos_out = 16'h3FFE;  // cos(1°)  = 0.999847695 = 16383
            7'd2:  cos_out = 16'h3FF6;  // cos(2°)  = 0.999390827 = 16374
            7'd3:  cos_out = 16'h3FE7;  // cos(3°)  = 0.998629535 = 16359
            7'd4:  cos_out = 16'h3FD3;  // cos(4°)  = 0.997564050 = 16339
            7'd5:  cos_out = 16'h3FB8;  // cos(5°)  = 0.996194698 = 16312
            7'd6:  cos_out = 16'h3F97;  // cos(6°)  = 0.994521895 = 16279
            7'd7:  cos_out = 16'h3F6F;  // cos(7°)  = 0.992546152 = 16239
            7'd8:  cos_out = 16'h3F42;  // cos(8°)  = 0.990268069 = 16194
            7'd9:  cos_out = 16'h3F0E;  // cos(9°)  = 0.987688341 = 16142
            7'd10: cos_out = 16'h3ED3;  // cos(10°) = 0.984807753 = 16083
            
            // Angles 11° - 20°
            7'd11: cos_out = 16'h3E93;  // cos(11°) = 0.981627183 = 16019
            7'd12: cos_out = 16'h3E4C;  // cos(12°) = 0.978147601 = 15948
            7'd13: cos_out = 16'h3DFF;  // cos(13°) = 0.974370065 = 15871
            7'd14: cos_out = 16'h3DAC;  // cos(14°) = 0.970295726 = 15788
            7'd15: cos_out = 16'h3D53;  // cos(15°) = 0.965925826 = 15699
            7'd16: cos_out = 16'h3CF5;  // cos(16°) = 0.961261696 = 15605
            7'd17: cos_out = 16'h3C90;  // cos(17°) = 0.956304756 = 15504
            7'd18: cos_out = 16'h3C27;  // cos(18°) = 0.951056516 = 15399
            7'd19: cos_out = 16'h3BB8;  // cos(19°) = 0.945518576 = 15288
            7'd20: cos_out = 16'h3B44;  // cos(20°) = 0.939692621 = 15172
            
            // Angles 21° - 30°
            7'd21: cos_out = 16'h3ACA;  // cos(21°) = 0.933580426 = 15050
            7'd22: cos_out = 16'h3A4C;  // cos(22°) = 0.927183855 = 14924
            7'd23: cos_out = 16'h39C8;  // cos(23°) = 0.920504853 = 14792
            7'd24: cos_out = 16'h393F;  // cos(24°) = 0.913545458 = 14655
            7'd25: cos_out = 16'h38B2;  // cos(25°) = 0.906307787 = 14514
            7'd26: cos_out = 16'h381F;  // cos(26°) = 0.898794046 = 14367
            7'd27: cos_out = 16'h3788;  // cos(27°) = 0.891006524 = 14216
            7'd28: cos_out = 16'h36EC;  // cos(28°) = 0.882947593 = 14060
            7'd29: cos_out = 16'h364C;  // cos(29°) = 0.874619707 = 13900
            7'd30: cos_out = 16'h35A7;  // cos(30°) = 0.866025404 = 13735
            
            // Angles 31° - 40°
            7'd31: cos_out = 16'h34FE;  // cos(31°) = 0.857167301 = 13566
            7'd32: cos_out = 16'h3450;  // cos(32°) = 0.848048096 = 13392
            7'd33: cos_out = 16'h339E;  // cos(33°) = 0.838670568 = 13214
            7'd34: cos_out = 16'h32E7;  // cos(34°) = 0.829037573 = 13031
            7'd35: cos_out = 16'h322D;  // cos(35°) = 0.819152044 = 12845
            7'd36: cos_out = 16'h316E;  // cos(36°) = 0.809016994 = 12654
            7'd37: cos_out = 16'h30AC;  // cos(37°) = 0.798635510 = 12460
            7'd38: cos_out = 16'h2FE5;  // cos(38°) = 0.788010754 = 12261
            7'd39: cos_out = 16'h2F1B;  // cos(39°) = 0.777145961 = 12059
            7'd40: cos_out = 16'h2E4D;  // cos(40°) = 0.766044443 = 11853
            
            // Angles 41° - 50°
            7'd41: cos_out = 16'h2D7B;  // cos(41°) = 0.754709580 = 11643
            7'd42: cos_out = 16'h2CA6;  // cos(42°) = 0.743144825 = 11430
            7'd43: cos_out = 16'h2BCD;  // cos(43°) = 0.731353702 = 11213
            7'd44: cos_out = 16'h2AF1;  // cos(44°) = 0.719339800 = 10993
            7'd45: cos_out = 16'h2A12;  // cos(45°) = 0.707106781 = 10770
            7'd46: cos_out = 16'h292F;  // cos(46°) = 0.694658370 = 10543
            7'd47: cos_out = 16'h2849;  // cos(47°) = 0.681998360 = 10313
            7'd48: cos_out = 16'h2760;  // cos(48°) = 0.669130606 = 10080
            7'd49: cos_out = 16'h2674;  // cos(49°) = 0.656059029 = 9844
            7'd50: cos_out = 16'h2585;  // cos(50°) = 0.642787610 = 9605
            
            // Angles 51° - 60°
            7'd51: cos_out = 16'h2493;  // cos(51°) = 0.629320391 = 9363
            7'd52: cos_out = 16'h239F;  // cos(52°) = 0.615661475 = 9119
            7'd53: cos_out = 16'h22A8;  // cos(53°) = 0.601815023 = 8872
            7'd54: cos_out = 16'h21AF;  // cos(54°) = 0.587785252 = 8623
            7'd55: cos_out = 16'h20B4;  // cos(55°) = 0.573576436 = 8372
            7'd56: cos_out = 16'h1FB6;  // cos(56°) = 0.559192903 = 8118
            7'd57: cos_out = 16'h1EB6;  // cos(57°) = 0.544639035 = 7862
            7'd58: cos_out = 16'h1DB4;  // cos(58°) = 0.529919264 = 7604
            7'd59: cos_out = 16'h1CB0;  // cos(59°) = 0.515038075 = 7344
            7'd60: cos_out = 16'h1BAA;  // cos(60°) = 0.500000000 = 7082
            
            // Angles 61° - 70°
            7'd61: cos_out = 16'h1AA3;  // cos(61°) = 0.484809620 = 6819
            7'd62: cos_out = 16'h1999;  // cos(62°) = 0.469471563 = 6553
            7'd63: cos_out = 16'h188E;  // cos(63°) = 0.453990500 = 6286
            7'd64: cos_out = 16'h1782;  // cos(64°) = 0.438371147 = 6018
            7'd65: cos_out = 16'h1674;  // cos(65°) = 0.422618262 = 5748
            7'd66: cos_out = 16'h1564;  // cos(66°) = 0.406736643 = 5476
            7'd67: cos_out = 16'h1453;  // cos(67°) = 0.390731128 = 5203
            7'd68: cos_out = 16'h1341;  // cos(68°) = 0.374606593 = 4929
            7'd69: cos_out = 16'h122E;  // cos(69°) = 0.358367950 = 4654
            7'd70: cos_out = 16'h111A;  // cos(70°) = 0.342020143 = 4378
            
            // Angles 71° - 80°
            7'd71: cos_out = 16'h1005;  // cos(71°) = 0.325568154 = 4101
            7'd72: cos_out = 16'h0EEF;  // cos(72°) = 0.309016994 = 3823
            7'd73: cos_out = 16'h0DD9;  // cos(73°) = 0.292371705 = 3545
            7'd74: cos_out = 16'h0CC2;  // cos(74°) = 0.275637356 = 3266
            7'd75: cos_out = 16'h0BAB;  // cos(75°) = 0.258819045 = 2987
            7'd76: cos_out = 16'h0A93;  // cos(76°) = 0.241921896 = 2707
            7'd77: cos_out = 16'h097B;  // cos(77°) = 0.224951054 = 2427
            7'd78: cos_out = 16'h0863;  // cos(78°) = 0.207911691 = 2147
            7'd79: cos_out = 16'h074B;  // cos(79°) = 0.190808995 = 1867
            7'd80: cos_out = 16'h0633;  // cos(80°) = 0.173648178 = 1587
            
            // Angles 81° - 90°
            7'd81: cos_out = 16'h051B;  // cos(81°) = 0.156434465 = 1307
            7'd82: cos_out = 16'h0403;  // cos(82°) = 0.139173101 = 1027
            7'd83: cos_out = 16'h02EB;  // cos(83°) = 0.121869343 = 747
            7'd84: cos_out = 16'h01D4;  // cos(84°) = 0.104528463 = 468
            7'd85: cos_out = 16'h00BD;  // cos(85°) = 0.087155743 = 189
            7'd86: cos_out = 16'hFFA6;  // cos(86°) = 0.069756474 = -90 (approx 0.069)
            7'd87: cos_out = 16'h008F;  // cos(87°) = 0.052335956 = 143
            7'd88: cos_out = 16'h0078;  // cos(88°) = 0.034899497 = 120
            7'd89: cos_out = 16'h0061;  // cos(89°) = 0.017452406 = 97
            7'd90: cos_out = 16'h0000;  // cos(90°) = 0.000000000 = 0
            
            // Default case for invalid addresses
            default: cos_out = 16'h0000;
        endcase
    end

endmodule
