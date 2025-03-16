`timescale 1ns / 1ps
module top(
    input logic [31:0] a,
    input logic [31:0] b,
    output logic [31:0] result
);

    //Code starts here... 

    //Register declarations
    wire sign_a, sign_b, sign_res;
    logic [7:0] exp_a, exp_b, exp_res;
    logic [23:0] mant_a, mant_b;
    logic [47:0] mant_res;
    logic [7:0] final_exp;
    logic [22:0] final_mant;
    wire overflow, underflow, denorm;

    // Extract sign, exponent, and mantissa
    assign sign_a = a[31];
    assign sign_b = b[31];
    assign exp_a  = a[30:23];
    assign exp_b  = b[30:23];
    assign mant_a = {1'b1, a[22:0]}; // Implicit leading 1
    assign mant_b = {1'b1, b[22:0]}; // Implicit leading 1

    // Calculate sign of result
    assign sign_res = sign_a ^ sign_b;

    // Calculate exponent with bias adjustment
    assign exp_res = exp_a + exp_b - 8'd127;

    // Calculate Mantissa
    assign mant_res = mant_a * mant_b;

    // Normalization
    always_comb begin
        if (mant_res[47]) begin
            final_mant = mant_res[46:24]; // Shift right by 1
            final_exp = exp_res + 1;
        end else begin
            final_mant = mant_res[45:23]; // Already normalized
            final_exp = exp_res;
        end
    end

    // Overflow and underflow check
    assign overflow  = (final_exp > 8'hFE);
    assign underflow = (final_exp < 8'h01);

    // Special cases handling
    always_comb begin
        if (exp_a == 8'hFF || exp_b == 8'hFF) begin
            // NaN or Infinity handling
            if ((exp_a == 8'hFF && mant_a != 24'h800000) || (exp_b == 8'hFF && mant_b != 24'h800000)) 
                result = {1'b0, 8'hFF, 23'h400000}; // NaN
            else
                result = {sign_res, 8'hFF, 23'h0}; // Infinity
        end else if (underflow) begin
            result = 32'b0;                       // Zero
        end else if (overflow) begin
            result = {sign_res, 8'hFF, 23'h0};    // Infinity
        end else begin
            result = {sign_res, final_exp, final_mant}; // Normal result
        end
    end
endmodule
