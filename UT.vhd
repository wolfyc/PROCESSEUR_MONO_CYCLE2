library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UT is
    port(
        clk,rst: in std_logic;
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        OP:  in std_logic_vector(1 downto 0);
        S,W: out std_logic_vector(31 downto 0); --output & input
        N:   out std_logic --signe of the output
    );
end entity;

Architecture behav of UT is
    signal Ss,As,Bs : std_logic_vector(31 downto 0);
    
begin

ALUu: entity work.ALU
    port map(
        A  => As,
        B  => Bs,
        OP => OP,
        S  => Ss,
        N  => N
        );

banc_de_registreU: entity work.banc_de_registre
    port map(
            clk => clk,
            rst => rst,
            W  => Ss,
            RA=> RA,
            RB=> RB,
            RW=> RW,
            WE=> WE,
            A=> As,
            B=> Bs
    );

S <= Ss;

end architecture;