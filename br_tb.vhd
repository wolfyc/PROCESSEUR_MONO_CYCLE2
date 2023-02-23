LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity br_tb is
end entity;

architecture behav of br_tb is
        clk: in std_logic;
        rst: in std_logic;
        w:   in std_logic_vector(31 downto 0);
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        A:   out std_logic_vector(31 downto 0);
        B:   out std_logic_vector(31 downto 0)
    begin
            A <= Banc(To_integer(unsigned(RA)));
            B <= banc(To_integer(unsigned(RB)));
            
    lecture: process(clk)
        begin
            if (rst = '1') then
                A <= (others =>'0');
                B <= (others =>'0');
            else
                if rising_edge(clk) then
                    banc(To_integer(unsigned(RW))) <= W;
                end if;
            end if;
    end process;
                

        

    end architecture;
