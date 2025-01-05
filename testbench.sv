module slsr_tb();
    // Declare signals for the testbench
    bit sl, sr, reset, clk, din;
    bit [7:0] Q;

    // Instantiate the Device Under Test (DUT)
    slsr dut (
        .sl(sl),
        .sr(sr),
        .reset(reset),
        .clk(clk),
        .din(din),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Toggle clock every 10 ns
    end
    
    // Stimulus
    initial begin 
        reset = 1;  // Initially, assert reset
        sl = 0;     // Initialize shift left to 0
        sr = 0;     // Initialize shift right to 0
        din = 0;    // Initialize data input to 0
        #11;        // Wait for some time
        reset = 0;  // De-assert reset
        #10;
        reset = 1;  // Assert reset again
        #10;
        
        // First scenario: RESET is HIGH
        // Shift left is high and shift right is low
        sl = 1;
        sr = 0;
        din = 1;
        #15;

        sl = 1;
        sr = 0;
        din = 0;
        #15;

        // Shift right is high and shift left is low
        sl = 0;
        sr = 1;
        din = 1;
        #15;

        sl = 0;
        sr = 1;
        din = 0;
        #15;
     
        // Second scenario: RESET is LOW
        reset = 0;
        #10;
         
        sl = 1;
        sr = 0;
        din = 1;
        #15;

        sl = 1;
        sr = 0;
        din = 0;
        #15;

        // Shift right is high and shift left is low
        sl = 0;
        sr = 1;
        din = 1;
        #15;

        sl = 0;
        sr = 1;
        din = 0;
        #15;
     
        // Border situation
        sr = 1;
        sl = 1;
        din = 1;
        #5;
        sr = 0;
        sl = 0;
        din = 1;
        #5;
     
        reset = 1;
        #10;
     
        sr = 1;
        sl = 1;
        din = 1;
        #5;
        sr = 0;
        sl = 0;
        din = 1;
        #5;
     
        $finish; // End the simulation
    end 

    // Monitor output
    initial begin 
        $monitor("At time %0t: Q = %b, din = %b, sl = %b, sr = %b, reset = %b", 
                 $time, Q, din, sl, sr, reset);
    end
  
    // Dump waveforms to a file for viewing
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, slsr_tb);
    end
endmodule
