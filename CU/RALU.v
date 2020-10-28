module RALU (
	input clk,reset,
	input [3:0] DataIn,
	output reg [3:0] Rout,
	
//АЛУ	
	input [3:0] S,
	input M,Pin,
	output Pout,
//AЛУ

//регистры
	input A,
	input [3:0] v,
	input ISR,ISL,
	output reg OSR,OSL,
//регистры

//RAM
	input [2:0] adr,
	input wr
//RAM
);
wire [3:0]R;
// добавление АЛУ в проект
Parallel ALU (
				.A(RgA),
				.B(RgB),
				.S(S),
				.M(M),
				.Pin(Pin),
				.R(R),
				.Pout(Pout)
);
// добавление АЛУ в проект


//описание работы РОН
reg [3:0] RAM_data [0:7];

always @(posedge clk)
begin
	if(reset) 
		begin :rstblk
			integer ind;
			for(ind=0;ind<7;ind=ind+1)
				RAM_data[ind]=0;
		end
	else
		begin
			if(wr) RAM_data[adr] <=R;
		end
end
//описание работы РОН

/*wire [3:0] shitout=RAM_data[adr]; //тестовый сигнал, не обращаем внимания*/

//описание мультиплексора
wire [3:0] MS_output;
assign MS_output=A?(DataIn):(RAM_data[adr]);
//описание мультиплексора

reg [3:0] RgA,RgB; //введение регистров А,В

//описание регистра А
always @(posedge clk)
begin
	if(reset) 
		begin
			RgA=0;
		end
	else
		begin
			if(v[0]) RgA <= MS_output;
		end
end
//описание регистра А

//описание регистра В
always @(posedge clk)
begin
	if(reset) 
		begin
			RgB=0;
		end
	else
		begin
			case(v[2:1])
				2'b00: ;
				2'b11: RgB<=RAM_data[adr];
				2'b01: begin  //сдвиг влево с указанием входного и выходного бита сдвига
								{OSL,RgB}={RgB[3:0],ISL};
						 end
				2'b10: begin //сдвиг вправо с указанием входного и выходного бита сдвига
								{RgB,OSR}={ISR,(RgB[3:0])};
						 end
			endcase
		end
end 
//описание регистра В

//AC
always @(posedge clk)
begin
	if(reset) 
		begin
			Rout=0;
		end
	else
		begin
			if(v[3]) Rout <= R;
		end
end
//AC

endmodule