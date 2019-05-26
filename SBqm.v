//============================================ The top module of SBqM IP ==============================//
/*
Description:      The top module of the queue machine
Inputs:
 * clck          // System clock >> 1 bit
 * rst           // System reset >> 1 bit
 * FE_photocell  // Front-end sensor
                 // its value belongs to {0,1} >> 1 bit
 * BE_photocell  // Back-end sensor
                 // its value belongs to {0,1} >> 1 bit
 * T_Count       // The number of tellers currently in service
                 // its value belongs to {1,2,3} >> 2 bits
                 // 2'b00 = not defined, 2'b01 = 1, 2'b10 = 2, 2'b11 = 3
Outputs:
 * Pcount       // The number of people standing in the queue (waiting to be served by a teller)
 * Wtime         // The expected waiting time in the queue before being served
                 // An output specified by the formulas:
                    Wtime(Pcount = 0) = 0
                    Wtime(Pcount = 0) = 3*(Pcount+Tcount-1)/Tcount
 * full_flag     // set at Pcount is maximum
 * empt_flag     // set at Pcount is zero
*/
module SBqM (FE_photocell , BE_photocell ,clck ,rst, T_Count, full_flag, empt_flag, Pcount, Wtime);
  input               FE_photocell , BE_photocell ,clck ,rst;
  input       [1:0]   T_Count;
  output reg          full_flag,empt_flag;
  output      [2:0]   Pcount;
  output      [4:0]   Wtime;
                                              
  reg [4:0] Address;  // Address to be given for the ROM 

///resetting
 // always @(posedge clck) begin 
   // if (rst) begin                         
      //full_flag <= 0;
      //empt_flag <= 1;
      //Pcount <= 0;
      //Address <= 0;
   // end//if
 // end//always
  
///Getting Pcount  
  PcountCounter PcountCounter1 (clck, rst, FE_photocell, BE_photocell, Pcount);  //Counter for Pcount 
///Getting Wtime 
  WtimeLUT WtimeLUT1 (Address, Wtime);
  
///Connections and Getting Flags  
  always @* begin
    Address = {T_Count, Pcount}; //ROM address
    //
    case (Pcount)
      3'b000:   begin empt_flag = 1; full_flag = 0; end
      3'b111:   begin empt_flag = 0; full_flag = 1; end
      default:  begin empt_flag = 0; full_flag = 0; end
    endcase
  end//always
endmodule


