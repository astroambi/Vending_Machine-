`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 17:23:08
// Design Name: 
// Module Name: vending
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


module vending(
input clk ,
input reset ,
input buzzer ,
input [1:0] coin ,
output [1:0] product ,
output [1:0] change
);
    parameter  S0 = 2'b00 , S1 = 2'b01 , S2 = 2'b10 , S3 = 2'b11 ;
    reg [1:0] state , next ;
    
    reg [1:0] result ;
    reg [1:0] hold ;
    
    always @(*) begin
        
        case(state)
            
            S0 : begin
                
                if(coin == 2'b00)  begin
                    next <= S0 ;
                    result <= 2'b0 ;
                    hold <= 2'b00 ;
                end
                
                else if ( coin == 2'b01) begin
                    next <= S1 ;
                    result <= 2'b0 ;
                    hold <= 2'b00 ;
                end
                
                else if ( coin == 2'b10) begin
                     next <= S2 ;
                     result <= 2'b0 ;
                      hold <= 2'b00 ;
                end
                
            end
            
            S1: begin
                
                if( coin == 2'b00)  begin
                    next <= S0 ;
                    result  <= 2'b00 ;
                    hold <= 2'b01 ;
                    
                end
                
                else if ( coin == 2'b01 ) begin
                    next <= S2 ;
                    result <= 2'b00 ;
                    hold <= 2'b00 ;
                end
                
                
                
                else if ( coin == 2'b10 &&  buzzer == 0 ) begin
                
                    result <= 2'b01 ; 
                    hold <= 2'b00 ;
                    next<= S0;
                    
                end
                
                 else if ( coin == 2'b10 &&  buzzer == 1 ) begin
                    
                    result <= 2'b00 ; 
                    hold <= 2'b00 ;
                    next <= S3;
                    
                end
                
                
            
            end
            
            S2: begin
                   
                   if ( coin == 2'b00 ) begin
                        next <= S0 ;
                        result <= 2'b00 ;
                        hold <= 2'b10 ;
                   end
                   else if ( coin == 2'b01 && buzzer == 0 )  begin
                        next <= S0;
                        result <= 2'b01 ;
                        hold <= 2'b00 ;

                   end
                   else if ( coin == 2'b10 ) begin 
                        next <= S0 ;
                        result <= 2'b10;
                        hold <= 2'b00 ;
                   end
                   
 
                   else if ( coin == 2'b01 && buzzer == 1 ) begin
                        next <= S3 ;
                        result <= 2'b00 ;
                        hold <= 2'b00 ;
                   
                   end
                   
        
            end
            
            S3: begin
            
                    if ( coin == 2'b00 ) begin
                        next <= S0 ;
                        result <= 2'b00 ;
                        hold <= 2'b11 ;
                    end
                    
                    else if ( coin == 2'b01 ) begin
                        next <= S0 ;
                        result <= 2'b10 ;
                        hold <= 2'b00 ;
                    
                    end
                    
                    else if ( coin == 2'b10 ) begin
                        next <= S0 ;
                        result <= 2'b10 ;
                        hold <= 2'b01 ;
                    end
            end
            
  
        endcase
     end
    
    
    
    always @( posedge clk ) begin
            
            if ( reset ) begin
                state <= S0 ;
            end
            
            else  begin
                state <= next ;
           end 
    end
    
    
    assign product = result ;
    assign change = hold ;




endmodule


