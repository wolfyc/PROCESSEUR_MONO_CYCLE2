LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity memoire is
    port(
        clk:      in std_logic;
        rst:      in std_logic;
        dataIn:   in std_logic_vector(31 downto 0);
        WrEn:  in std_logic;
        Addr:   in std_logic_vector(5 downto 0);
        dataOut:   out std_logic_vector(31 downto 0)
    );
end entity;

architecture behav of memoire is
    type table is array(63 downto 0) of
    std_logic_vector(31 downto 0);
    -- Fonction d'Initialisation du Banc de Registres
    function init_banc return table is
    variable result : table;
    begin
    for i in 63 downto 0 loop
    result(i) := (others=>'0');
    end loop;
    result(15):=X"00000030";
    return result;
    end init_banc;
    -- Déclaration et Initialisation du Banc de Registres 16x32 bits
    signal Banc: table:=init_banc;
    begin
        process (clk)
            begin
                if (rst = '1') then
                    banc <= init_banc;
                elsif rising_edge(clk) then
                    Banc(To_integer(unsigned(Addr))) <= dataIn;
                end if;
        end process;
    end architecture;