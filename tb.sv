`timescale 1ns / 1ps
module tb;
    logic [31:0] a, b, sum;
    bit rst, clk;
    top uut (.a(a), .b(b), .result(sum));

    initial begin
        clk = 0;
        rst = 1;
        a = 32'h3fc00000; // 1.5
        b = 32'h40200000; // 2.5  ANS: 4
        #10;
        rst = 0;
        #10;
        rst = 1;
        a = 32'hc0400000; // -3.0
        b = 32'h40400000; // 3.0  ANS: 0
        #10;
        rst = 0;
        #10;
        rst = 1;
        a = 32'h40300000; // 2.75
        b = 32'h3fa66666; // 1.3  ANS: 4.05
        #10;
        rst = 0;
        #10;
        rst = 1;
        a = 32'hbf99999a; // -1.2
        b = 32'hc0000000; // -2.0  ANS: 3.2
        #10;
        rst = 0;
        #10;
        rst = 1;
        a = 32'h4048f5c3; // 3.14
        b = 32'h4010a3d7; // 2.26  ANS: 5.4
        #10;
        rst = 0;
        #10;
        rst = 1;
        a = 32'hc0e00000; // -7.0
        b = 32'hbf99999a; // -1.2  ANS: 8.2
        #10;
        rst = 0;
        #10;
        #100;
        $display("sum = %h", sum);
        $finish;
    end

    always #5 clk = ~clk;
endmodule
