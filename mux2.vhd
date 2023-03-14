library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is
    generic (
        N: INTEGER := 32
    );

    port(
        A,B : in std_logic_vector((N-1) downto 0);
        Com : in std_logic;
        S   : out std_logic_vector((N-1) downto 0)
        );
    end entity;

    Architecture behav of mux2 is
    begin
        with Com select 
            s <= A when '0', B when '1',
            (others => '0') when others ;
    end architecture;