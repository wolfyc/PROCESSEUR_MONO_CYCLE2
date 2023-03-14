library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AUT is

    port(
        -- Banc de registre
        clk: in std_logic;
        rst: in std_logic;
        w:   in std_logic_vector(31 downto 0);
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        -- ALU
        ALUsrc : in std_logic_vector(1 downto 0);
        ALUflag:  : out std_logic;
        -- Memoire
        WrEn:  in std_logic;
        -- Mux2
        memToReg : in std_logic;
        -- Signe Ext
        imm8 : in std_logic_vector((7) downto 0);
        -- 
    );
end entity;

Architecture behav of AUT is

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

MemoireU: entity work.memoire 
    port map(
            clk => clk,
            rst => rst,
            WeEn  => Ss,
            dataIn=> RA,
            Addr=> RB,
            dataOut=> RW
    );
ALUsrcu: entity work.mux2
port map(
    A  => As,
    B  => Bs,
	com => OP,
	S  => Ss,
);

memory_to_registeru: entity work.mux2
port map(
    A  => As,
    B  => Bs,
	com => OP,
	S  => Ss,
);

signExtu: entity work.sign_extension
port map(
   E =>
   S =>
);

S <= Ss;

end architecture;