`timescale 1ns / 1ps

module cordic_tb;

    // Clock, reset, start
    reg clk;
    reg rst;
    reg start;
    //reg trit;
    // Inputs and outputs
    reg  signed [15:0] angle;       // Q2.14 fixed-point angle (radians)
    wire signed [15:0] cos_out;
    wire signed [15:0] sin_out;
    wire done;

    // Instantiate DUT
    cordic uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .angle(angle),
        .cos_out(cos_out),
        .sin_out(sin_out),
        .done(done)
    );

    // Clock generation: 100 MHz (period = 10 ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Helper: convert degrees → Q2.14 radians
    function signed [15:0] deg_to_q214;
        input real deg;
        real rad;
        begin
            rad = deg * 3.14159265 / 180.0;
            deg_to_q214 = $rtoi(rad * 16384.0);
        end
    endfunction

    // Variables for display
    integer i;
    real deg_list [0:4];
    real real_cos, real_sin;
    real cordic_cos, cordic_sin;
    real error;
    real trit;

    initial begin
        // Initialize
        rst = 1; start = 0; angle = 0;
        #20;
        rst = 0;

        // Test angles
        deg_list[0] = 0.0;
        deg_list[1] = 30.0;
        deg_list[2] = 45.0;
        deg_list[3] = 60.0;
        deg_list[4] = 90.0;

        // Run tests
        for (i = 0; i < 5; i = i + 1) begin
            angle = deg_to_q214(deg_list[i]);
            start = 1; #10; start = 0;

            wait(done == 1);
            #10;

            // Convert back to float for display
            cordic_cos = $itor(cos_out) / 16384.0;
            cordic_sin = $itor(sin_out) / 16384.0;
            real_cos = $cos(deg_list[i] * 3.14159265 / 180.0);
            real_sin = $sin(deg_list[i] * 3.14159265 / 180.0);
            error = real_cos - cordic_cos;
            trit=(cordic_cos*cordic_cos)+(cordic_sin*cordic_sin);

            $display("Angle %0.1f° => CORDIC: cos=%f, sin=%f | Expected: cos=%f, sin=%f,Error: Δcos=%f",
                     deg_list[i], cordic_cos, cordic_sin, real_cos, real_sin, error);
            
        end

        $display("\nSimulation complete.\n");
        $finish;
    end

endmodule
