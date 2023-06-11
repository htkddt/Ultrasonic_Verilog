module Sensor (clk,trigger, echoPulse, D);
input clk, echoPulse;
output reg trigger;
output reg [15:0] D = 0;
reg [9:0] counter = 0;
reg pre_echo = 0;
reg [15:0] temp = 0;
always@ (posedge clk)
begin
pre_echo <= echoPulse;
if (counter < 11) 
begin
	counter = counter +1;
	trigger = 1;
end
else if (counter >= 11 && counter <= 1000)
	counter = 0;
if (temp < 16'hFFFF) 
	begin
		temp <= temp +1;	
		if ({pre_echo, echoPulse} == 2'b01) 
			temp <= 1;
		else if ({pre_echo, echoPulse} == 2'b10)
			D <= temp;
	end
end
endmodule
