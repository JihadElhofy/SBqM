module WtimeLUT (input [4:0] Address, output reg [4:0] Wtime);
  
  always @(*) begin
    
    case (Address)//Address = {T_count,P_count}
      //T_Count = 1        
      5'b01_001 : Wtime = 3;
      5'b01_010 : Wtime = 6;
      5'b01_011 : Wtime = 9;
      5'b01_100 : Wtime = 12;
      5'b01_101 : Wtime = 15;
      5'b01_110 : Wtime = 18;
      5'b01_111 : Wtime = 21;
      //T_Count = 2
      5'b10_001 : Wtime = 3;
      5'b10_010 : Wtime = 4;
      5'b10_011 : Wtime = 6;
      5'b10_100 : Wtime = 7;
      5'b10_101 : Wtime = 9;
      5'b10_110 : Wtime = 10;
      5'b10_111 : Wtime = 12;
      //T_Count = 3
      5'b11_001 : Wtime = 3;
      5'b11_010 : Wtime = 4;
      5'b11_011 : Wtime = 5;
      5'b11_100 : Wtime = 6;
      5'b11_101 : Wtime = 7;
      5'b11_110 : Wtime = 8;
      5'b11_111 : Wtime = 9;
      //Pcount = 0
      default   : Wtime = 0;
    endcase
  
  end//always
endmodule 