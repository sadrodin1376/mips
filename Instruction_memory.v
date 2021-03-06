module Instruction_memory(
	input clk, rst,
	input [31:0] address,
	output [31:0] data_out
);

	reg [7:0] inst_mem [1023:0];

	assign data_out = {inst_mem[address + 3], inst_mem[address + 2], inst_mem[address + 1], inst_mem[address]};
/*integer i, file, data;
	initial begin
		file = $fopen("benchmark.txt", "r");
		if (file == 0)  $display("data_file handle was NULL");
		for (i = 0; i < 305; i = i + 1) begin
			$fscanf(file, "%b\n", data);
			if (!$feof(file)) begin
				{inst_mem[3 + i*4], inst_mem[2 + i*4], inst_mem[1 + i*4], inst_mem[i*4]} = data;
			end
		end
	end	*/
	always@(posedge rst)begin
		{inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]}= 32'b100000_00000_00001_00000_11000001010;//-- Addir0   ,r1  ,1546

{inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]}= 32'b000001_00000_00001_00010_00000000000;//-- Add r0   ,r1     ,r2 

{inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]}= 32'b000011_00000_00001_00011_00000000000;//-- subr0   ,r1     ,r3 

{inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]}= 32'b000101_00010_00011_00100_00000000000;//-- Andr2   ,r3     ,r4 

{inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]}= 32'b100001_00011_00101_00000_01000110100;//-- Subir3   ,r5   ,564     

{inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]}= 32'b000110_00011_00100_00101_00000000000;//-- orr3   ,r4     ,r5 

{inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]}= 32'b000111_00101_00000_00110_00000000000;//-- nor r5   ,r0     ,r6 

{inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]}= 32'b000111_00100_00000_01011_00000000000;//-- nor r4   ,r0     ,r11

{inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]}= 32'b000011_00101_00101_00101_00000000000;//-- subr5   ,r5     ,r5 

{inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]}= 32'b100000_00000_00001_00000_10000000000;//-- Addi r0   ,r1     ,1024    

{inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]}= 32'b100101_00001_00010_00000_00000000000;//-- str1   ,r2     ,0       

{inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]}= 32'b100100_00001_00101_00000_00000000000;//-- ldr1   ,r5     ,0      

{inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]}= 32'b101000_01001_00000_00000_00000000001;//-- Bezr5   , 1           

{inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]}= 32'b001000_00101_00001_00111_00000000000;//-- xorr5   ,r1     ,r7 

{inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]}= 32'b001000_00101_00001_00000_00000000000;//-- xorr5   ,r1     ,r0 

{inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]}= 32'b001001_00011_01011_00111_00000000000;//-- slar3   ,r11    ,r7 

{inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]}= 32'b001010_00011_01011_01000_00000000000;//-- sllr3   ,r11    ,r8 

{inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]}= 32'b001011_00011_00100_01001_00000000000;//-- srar3   ,r4     ,r9 

{inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]}= 32'b001100_00011_00100_01010_00000000000;//-- srlr3   ,r4     ,r10

{inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]}= 32'b100101_00001_00011_00000_00000000100;//-- str1   ,r3     ,4       

{inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]}= 32'b100101_00001_00100_00000_00000001000;//-- str1   ,r4     ,8       

{inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]}= 32'b100101_00001_00101_00000_00000001100;//-- str1   ,r5     ,12      

{inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]}= 32'b100101_00001_00110_00000_00000010000;//-- str1   ,r6     ,16      

{inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]}= 32'b100100_00001_01011_00000_00000000100;//-- ldr1   ,r11    ,4      

{inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]}= 32'b100101_00001_00111_00000_00000010100;//-- str1   ,r7     ,20     

{inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]}= 32'b100101_00001_01000_00000_00000011000;//-- str1   ,r8     ,24     

{inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]}= 32'b100101_00001_01001_00000_00000011100;//-- str1   ,r9     ,28     

{inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]}= 32'b100101_00001_01010_00000_00000100000;//-- str1   ,r10    ,32     

{inst_mem[115], inst_mem[114], inst_mem[113], inst_mem[112]}= 32'b100101_00001_01011_00000_00000100100;//-- str1   ,r11    ,36     

{inst_mem[119], inst_mem[118], inst_mem[117], inst_mem[116]}= 32'b100000_00000_00001_00000_00000000011;//-- Addi r0   ,r1     ,3      

{inst_mem[123], inst_mem[122], inst_mem[121], inst_mem[120]}= 32'b100000_00000_00100_00000_10000000000;//-- Addir0   ,r4     ,1024   

{inst_mem[127], inst_mem[126], inst_mem[125], inst_mem[124]}= 32'b100000_00000_00010_00000_00000000000;//-- Addi r0   ,r2     ,0      

{inst_mem[131], inst_mem[130], inst_mem[129], inst_mem[128]}= 32'b100000_00000_00011_00000_00000000001;//-- Addi r0   ,r3     ,1      

{inst_mem[135], inst_mem[134], inst_mem[133], inst_mem[132]}= 32'b100000_00000_01001_00000_00000000010;//-- Addi r0   ,r9     ,2      

{inst_mem[139], inst_mem[138], inst_mem[137], inst_mem[136]}= 32'b001010_00011_01001_01000_00000000000;//-- sllr3   ,r9     ,r8 

{inst_mem[143], inst_mem[142], inst_mem[141], inst_mem[140]}= 32'b000001_00100_01000_01000_00000000000;//-- Add r4   ,r8     ,r8 

{inst_mem[147], inst_mem[146], inst_mem[145], inst_mem[144]}= 32'b100100_01000_00101_00000_00000000000;//-- ldr8   ,r5     ,0       

{inst_mem[151], inst_mem[150], inst_mem[149], inst_mem[148]}= 32'b100100_01000_00110_11111_11111111100;//-- ldr8   ,r6     ,-4      

{inst_mem[155], inst_mem[154], inst_mem[153], inst_mem[152]}= 32'b000011_00101_00110_01001_00000000000;//-- sub r5   ,r6     ,r9 

{inst_mem[159], inst_mem[158], inst_mem[157], inst_mem[156]}= 32'b100000_00000_01010_10000_00000000000;//-- Addi r0   ,r10    ,0x8000 

{inst_mem[163], inst_mem[162], inst_mem[161], inst_mem[160]}= 32'b100000_00000_01011_00000_00000010000;//-- Addir0   ,r11    ,16     

{inst_mem[167], inst_mem[166], inst_mem[165], inst_mem[164]}= 32'b001010_01010_01011_01010_00000000000;//-- sllr10  ,r11    ,r10

{inst_mem[171], inst_mem[170], inst_mem[169], inst_mem[168]}= 32'b000101_01001_01010_01001_00000000000;//-- And r9   ,r10    ,r9 

{inst_mem[175], inst_mem[174], inst_mem[173], inst_mem[172]}= 32'b101000_01001_00000_00000_00000000010;//-- Bezr9   ,2           

{inst_mem[179], inst_mem[178], inst_mem[177], inst_mem[176]}= 32'b100101_01000_00101_11111_11111111100;//-- str8   ,r5     ,-4     

{inst_mem[183], inst_mem[182], inst_mem[181], inst_mem[180]}= 32'b100101_01000_00110_00000_00000000000;//-- str8   ,r6     ,0      

{inst_mem[187], inst_mem[186], inst_mem[185], inst_mem[184]}= 32'b100000_00011_00011_00000_00000000001;//-- Addi r3   ,r3     ,1      

{inst_mem[191], inst_mem[190], inst_mem[189], inst_mem[188]}= 32'b101001_00001_00011_11111_11111110001;//-- BNEr1   ,r3     ,-15    

{inst_mem[195], inst_mem[194], inst_mem[193], inst_mem[192]}= 32'b100000_00010_00010_00000_00000000001;//-- Addi r2   ,r2     ,1      

{inst_mem[199], inst_mem[198], inst_mem[197], inst_mem[196]}= 32'b101001_00001_00010_11111_11111101110;//-- BNEr1   ,r2     ,-18    

{inst_mem[203], inst_mem[202], inst_mem[201], inst_mem[200]}= 32'b100000_00000_00001_00000_10000000000;//-- Addi r0   ,r1     ,1024   

{inst_mem[207], inst_mem[206], inst_mem[205], inst_mem[204]}= 32'b100100_00001_00010_00000_00000000000;//-- ldr1   ,r2     ,0      

{inst_mem[211], inst_mem[210], inst_mem[209], inst_mem[208]}= 32'b100100_00001_00011_00000_00000000100;//-- ldr1   ,r3     ,4      

{inst_mem[215], inst_mem[214], inst_mem[213], inst_mem[212]}= 32'b100100_00001_00100_00000_00000001000;//-- ldr1   ,r4     ,8      

{inst_mem[219], inst_mem[218], inst_mem[217], inst_mem[216]}= 32'b100100_00001_00101_00000_00000001100;//-- ldr1   ,r5     ,12     

{inst_mem[223], inst_mem[222], inst_mem[221], inst_mem[220]}= 32'b100100_00001_00110_00000_00000010000;//-- ldr1   ,r6     ,16     

{inst_mem[227], inst_mem[226], inst_mem[225], inst_mem[224]}= 32'b100100_00001_00111_00000_00000010100;//-- ldr1   ,r7     ,20     

{inst_mem[231], inst_mem[230], inst_mem[229], inst_mem[228]}= 32'b100100_00001_01000_00000_00000011000;//-- ldr1   ,r8     ,24     

{inst_mem[235], inst_mem[234], inst_mem[233], inst_mem[232]}= 32'b100100_00001_01001_00000_00000011100;//-- ldr1   ,r9     ,28     

{inst_mem[239], inst_mem[238], inst_mem[237], inst_mem[236]}= 32'b100100_00001_01010_00000_00000100000;//-- ldr1   ,r10    ,32     

{inst_mem[243], inst_mem[242], inst_mem[241], inst_mem[240]}= 32'b100100_00001_01011_00000_00000100100;//-- ldr1   ,r11    ,36     

{inst_mem[247], inst_mem[246], inst_mem[245], inst_mem[244]}= 32'b101010_00000_00000_11111_11111111111;//-- JMP -1
end
endmodule
