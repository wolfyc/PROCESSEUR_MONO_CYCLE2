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
        OP : in std_logic_vector(1 downto 0);--
        ALUflag:  : out std_logic;
        -- Memoire
        WrEn:  in std_logic;
        -- Mux2
        ALUsrc : in std_logic;--
        -- Mux2
        memToReg : in std_logic;
        -- Signe Ext
        imm8 : in std_logic_vector((7) downto 0);--
        -- 
    );
end entity;

Architecture behav of AUT is
signal busA,busB,extendedImm8: std_logic_vector(31 downto 0);

begin

ALUu: entity work.ALU
    port map(
        A  => busA,
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
            A=> busA,
            B=> busB
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
ALUsrcu: entity work.mux2 -- selects B when com = 1
port map(
    A  => busB, -- selected when com = zero
    B  => extendedImm8, -- selected when com = one
	com => ALUsrc,
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
   E =>imm8,
   S => extendedImm8
);

S <= Ss;

end architecture;