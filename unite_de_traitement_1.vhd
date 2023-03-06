library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_de_traitement is
    port(
        clk,rst: in std_logic;
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        OP:  in std_logic_vector(1 downto 0);
        W: out std_logic_vector(31 downto 0); --output & input
        N:   out std_logic --signe of the output
    );
end entity;

Architecture behav of unite_de_traitement is
    signal Ss,As,Bs : std_logic_vector(31 downto 0);
    
begin

ALUu: entity work.ALU
port map(
	As,
	Bs,
	OP,
	Ss,
	N
	);

banc_de_registreU: entity work.Banc_Registres
    port map(
            clk,
            rst,
            Ss,
            RA,
            RB,
            RW,
            WE,
            As,
            Bs
    	    );

W <= Ss;

end architecture;
