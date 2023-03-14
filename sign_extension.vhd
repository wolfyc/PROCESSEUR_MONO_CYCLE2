library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extension is
    generic (

        N: INTEGER := 8
    );

    port(
        E : in std_logic_vector((N-1) downto 0);
        S : out std_logic_vector(31 downto 0)
        );
    end entity;

    Architecture behav of sign_extension is
        signal sign_bit: std_logic;
    begin
        sign_bit <= E(N-1);
        S((N-1) downto 0) <= E;
        with sign_bit select
                S(31 downto N) <= (others =>'0')  when '0',
                      (others =>'1')  when '1', (others => '0') when others;
    end architecture;