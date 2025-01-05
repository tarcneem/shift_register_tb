// 8-bit Shift Register Design
module slsr (
    input bit sl,    // Shift left control signal
    input bit sr,    // Shift right control signal
    input bit reset, // Reset signal
    input bit clk,   // Clock signal
    input bit din,   // Data input
    output reg [7:0] Q // 8-bit output register
);
    reg [7:0] current_data; // Internal 8-bit register to hold current data

    // Always block triggered on the rising edge of clk or reset
    always @(posedge clk or posedge reset) begin 
        if (reset) begin 
            current_data <= 8'b0; // Clear current_data on reset
        end else begin 
            if (sl && !sr) begin 
                current_data <= {din, current_data[7:1]}; // Shift in din at MSB
            end else if (!sl && sr) begin 
                current_data <= {current_data[6:0], din}; // Shift in din at LSB
            end 
        end
    end 

    // Assign the current_data to output Q
    assign Q = current_data; 
endmodule
