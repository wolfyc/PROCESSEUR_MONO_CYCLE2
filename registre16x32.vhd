LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity registre16x32 is
    port(
        clk: in std_logic;
        rst: in std_logic;
        w:   in std_logic_vector(31 downto 0);
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        A:   out std_logic_vector(31 downto 0);
        B:   out std_logic_vector(31 downto 0)
    );
end entity;

architecture behav of registre16x32 is
    --Declaration Type Tableau Memoire
    type table is array(15 downto 0) of std_logic_vector(31 downto 0);
    --Fonction d'Initialisation du Banc de Registres
    function init_banc return table is
        variable result : table;
        begin
            for i in 14 downto 0 loop
                result(i) := (others=>'0');
            end loop;
		result(15):=X"00000030";
            return result;
    end init_banc;
    --Déclaration et Initialisation du Banc de Registres 16x32 bits
    signal Banc: table:=init_banc;

    begin
        -- Lecture Asyncrones
            A <= Banc(To_integer(unsigned(RA)));
            B <= Banc(To_integer(unsigned(RB)));
        -- ecriture syncrones
    lecture: process(clk)
        begin
            if (rst = '1') then
                banc <= init_banc;
            elsif rising_edge(clk) then
		if WE = '1' then
                    Banc(To_integer(unsigned(RW))) <= W;
		end if;
            end if;
    end process;
                

        

    end architecture;
