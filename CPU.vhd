library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------
entity CPU is 
end entity;
---------------------------------------------------------
architecture arc_CPU of CPU is
signal CLK, RST :   std_logic;
--Signaux decodeur
signal instruction : std_logic_vector(31 downto 0); -- utile aussi pour gestion instru
signal PSR_out :  std_logic_vector(31 downto 0);
signal ALUCtr :  std_logic_vector(1 downto 0);
signal ALUSrc,WrSrc,nPCSel :  std_logic;
signal RegSel: std_logic;
signal PSREn,MemWr : std_logic;
signal RegWr : std_logic;
signal offset : std_logic_vector(23 downto 0);
signal Rn, Rd, Rm: std_logic_vector(3 downto 0);
signal Imm : std_logic_vector(7 downto 0);
--Signaux unité de traitement 
signal N : std_logic;
signal RB  : std_logic_vector(3 downto 0);
--Signaux registre 32
signal N_i : std_logic_vector(31 downto 0);
begin 

et0 : entity work.registre16x32()
	port map(CLK => CLK, WE =>PSREn , RST => RST, DATAIN =>N_i, DATAOUT => PSR_out);
    
et1 : entity work.decodeur()
	port map(instruction => instruction,PSR_out=> PSR_out,ALUCtr=>ALUCtr,ALUSrc=>ALUSrc,WrSrc=>WrSrc,nPCSel=>nPCSel,RegSel=>RegSel,PSREn=>PSREn,MemWr=>MemWr,RegWr=>RegWr,offset=>offset,Rn=>Rn,Rd=>Rd,Rm=>Rm,Imm=>Imm); 
    
et2 : entity work.mux2()
	generic map(N =>4 )
	port map(A=>Rm, B=>Rd,COM=>RegSel, S=>RB); 
	
et3 : entity work.UT()
	port map(CLK_i=>CLK, RA_b=>Rn, RB_b=>RB, RW_b=>Rd, WE_i=>RegWr, WrEn_i=>MemWr, COM1_i=>ALUSrc, COM2_i=>WrSrc, OP_i=>ALUCtr, SI_i=>Imm, N_o=>N); 

et4 : entity work.ugi( )
	port map(clk_i=>CLK, raz=>RST, nPCSel=>nPCSel, pc_offset=>offset, instruction=> instruction);
N_i(0) <= N;
N_i(31 downto 1) <= (others => '0');

Clock : process 
begin 
    CLK <= '0';
    wait for 10 ns;
    CLK <= '1';
    wait for 10 ns;
end process;
Reset : process
begin
	RST <= '1';
	wait for 20 ns;
	RST <= '0';
	wait;
end process;
end arc_CPU;