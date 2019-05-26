//============================ Counter of Peaple count ======================//
/*

Description:
Inputs:  
  * clk // System Clock
  * rst // System Reset
            
Ouputs     :
*/

module PcountCounter (input clck,rst,FE_photocell , BE_photocell ,output reg [2:0] Pcount);
  reg Bstate, Fstate; //back state, front state
  parameter ON = 1, CUT = 0; 
  
  always @(posedge clck) begin 
    if (rst) begin
      Pcount <= 0;
      Bstate <= ON;
      Fstate <= ON;
    end//if
    else
      case (Bstate)
        ON :  if (BE_photocell == 0) begin
                Bstate <= CUT;
              end//if
        CUT:  if (BE_photocell == 1) begin
                Pcount <= Pcount +1;
                Bstate   <= ON;
              end//if
      endcase//Bstate
      
      case (Fstate)
        ON :  if (FE_photocell == 0) begin
                Fstate <= CUT;
              end//if
        CUT:  if (FE_photocell == 1) begin
                Pcount <= Pcount -1;
                Fstate   <= ON;
              end//if
      endcase//Fstate
  end//always  
endmodule