`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 18:34:10
// Design Name: 
// Module Name: test_tb
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


`timescale 1ns / 1ps

module vending_tb;

    // Inputs
    reg clk;
    reg reset;
    reg buzzer;
    reg [1:0] coin;

    // Outputs
    wire [1:0] product;
    wire [1:0] change;

    // Instantiate the Unit Under Test (UUT)
    vending uut (
        .clk(clk),
        .reset(reset),
        .buzzer(buzzer),
        .coin(coin),
        .product(product),
        .change(change)
    );

    // Clock generation
    initial clk = 0; 
    always #5 clk = ~clk;

    initial begin
        $display("Time\tReset\tCoin\tBuzzer\tProduct\tChange");
        $monitor("%g\t%b\t%b\t%b\t%b\t%b", $time, reset, coin, buzzer, product, change);

        // Initialize inputs
        clk =1 ;
        reset = 1;
        buzzer = 0;
        coin = 2'b00;

        #10 reset = 0;

        // Insert 5 ₹ → go to S1
        #10 coin = 2'b01; // 5 ₹
        #10 coin = 2'b00; // Wait
        
     // here we first push the coin 10 rs then we push the 10 rs coin we get the product of 20 rs with no change 
     
        #10 coin = 2'b10;
        #10 coin = 2'b00; // Wait

//        // Insert 5 ₹ → go to S1 then go to the S2 by giving more 10 rs

        #10 coin = 2'b01;
        #10 coin = 2'b10 ; 
        #10 coin = 2'b00 ; 
        

//        // Insert 10 ₹ with buzzer ON → go to S3 (accumulate for ₹20)
        #10 coin = 2'b10;
        #10 coin = 2'b01 ;
        #10 coin = 2'b00;

//        // Insert 10 ₹ → now total ₹25 → get ₹20 product + ₹5 change
        #10 coin = 2'b10;
        #10 coin = 2'b10;
        #10 coin = 2'b00;

       // Try inserting only 10 ₹ → go to S2
        #10 coin = 2'b10;
        #10 coin = 2'b01; buzzer = 2'b01;
        #10 coin = 2'b10; buzzer = 2'b00;
        #10 coin = 2'b00;

        // Insert 10 ₹ again → get ₹20 product
        #10 coin = 2'b10;
        #10 coin = 2'b01; buzzer = 2'b01;
        #10 coin = 2'b01; buzzer = 0;
        #10 coin = 2'b00;





        #10 coin = 2'b01 ;
        #10 coin = 2'b01 ;
        #10 coin = 2'b01 ; buzzer = 2'b01 ;
        #10 coin = 2'b00 ; buzzer = 0 ;
        
        
        
        
        #10 coin = 2'b01 ;
        #10 coin = 2'b01 ;
        #10 coin = 2'b01 ; buzzer = 2'b01 ;
        #10 coin = 2'b01;  buzzer = 0;
        #10 coin = 2'b00 ;
        
        
        
        
        
//        // Reset everything
//        #10 reset = 1;
//        #10 reset = 0;

        #20 $finish;
    end

endmodule
