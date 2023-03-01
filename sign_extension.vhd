library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extension is
    generic (

        N: INTEGER := 32
    );

    port(
        E : in std_logic_vector((N-1) downto 0);
        S : out std_logic_vector(31 downto 0)
        );
    end entity;

    Architecture behav of sign_extension is
    begin
        
        


    end architecture;