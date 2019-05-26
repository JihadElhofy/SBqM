`timescale 1ns / 1ps
///
module testbench_1;

reg clck, rst;
reg FE_photocell, BE_photocell;
reg [1:0] T_Count;
wire full_flag,empt_flag;
wire     [2:0] P_Count;
wire     [3:0] Wtime;

integer Bstore, Fstore;// variable for checking counting -last state of Pcount-

event trig;
///DUT
SBqM U0 (FE_photocell, BE_photocell, clck, rst, T_Count, full_flag, empt_flag, P_Count, Wtime);


///intial conditions
initial
begin
clck = 0;
T_Count = 2'b10;
FE_photocell = 1;
BE_photocell = 1;
rst = 1;
#110 rst = 0; //setting
end


///clock gen.
always
#25 clck = ~ clck; 

//

///starting simulation
initial begin
  //forcing back end
repeat (8) begin 
#120 
BE_photocell = 0;
Bstore = P_Count;
#180 
BE_photocell = 1;
@ (posedge clck);
#1
if(P_Count!= Bstore+1) begin
$display ("+ counting error @ time %d", $time);
end//if
end//repeat
#3000 -> trig;
end//initial

  //forcing front end!
always @ (trig) begin
#300;
repeat (9) begin
#210
FE_photocell = 0;
Fstore = P_Count;
#110
FE_photocell = 1;
@ (posedge clck);
#1
if(P_Count!= Bstore-1) $display ("- counting error @ time %d", $time);
end//repeat
end//always

//stopping simulation
always
#6000
$stop;
endmodule
