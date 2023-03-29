library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AUT is

    port(
        -- Banc_de_registre
        clk: in std_logic;
        rst: in std_logic;
        w:   in std_logic_vector(31 downto 0);
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        -- ALU
        ALUctr : in std_logic_vector(1 downto 0);--
        ALUflag:   out std_logic;
        --ALUout : out std_logic_vector(31 downto 0);
        -- Memoire
        WrEn:  in std_logic;
        -- Mux2
        ALUsrc : in std_logic;--
        -- Mux2
        memToReg : in std_logic;
        -- Signe_Ext
        imm8 : in std_logic_vector(7 downto 0)--
        );
end entity;

Architecture behav of AUT is

signal busA,busB,busW,extendedImm8,dataIN,dataOUT,banc_alu,ALUout: std_logic_vector(31 downto 0);

begin
    banc_de_registreU: entity work.banc_de_registre
    port map(
            clk => clk,--
            rst => rst,--
            W  => busW,
            RA=> RA,--
            RB=> RB,--
            RW=> RW,--
            WE=> WE,--
            A=> busA,--
            B=> busB--
    );

ALUsrcu: entity work.mux2       -- selects B when com = 1
    port map(
        A  => busB,                 -- selected when com = zero
        B  => extendedImm8,         -- selected when com = one
        com => ALUsrc,
        S  => banc_alu
    );   
ALUu: entity work.ALU
    port map(
        A  => busA,--
        B  => banc_alu,--
        OP => ALUctr,--
        S  => ALUout,--
        N  => ALUflag--
    );

MemoireU: entity work.memoire 
    port map(
            clk => clk,--
            rst => rst,--
            WrEn  => WrEn,--
            dataIn=> dataIN,--
            Addr=> ALUout(5 downto 0),--
            dataOut=> busW
    );


memory_to_registeru: entity work.mux2 
    port map(
        A  => ALUout,
        B  => dataOUT,
        com => memToReg,
        S  => busW
    );

signExtu: entity work.sign_extension
    generic map(N=>8)
    port map(
        E =>imm8,  
        S => extendedImm8
    );
end architecture;