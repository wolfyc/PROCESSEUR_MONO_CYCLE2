library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extension_tb is
end entity;

architecture sim of sign_extension_tb is
    component sign_extension is
        generic (
            N: INTEGER := 8
        );
        port (
            E: in std_logic_vector((N-1) downto 0);
            S: out std_logic_vector(31 downto 0)
        );
    end component;

    signal E_s: std_logic_vector(7 downto 0) ;
    signal S_s: std_logic_vector(31 downto 0);

begin
    UUT: sign_extension generic map(N => 8)
        port map(E => E_s, S => S_s);

    process
    begin
E_s <= "11110000";
        wait for 10 ns;
        assert S_s = x"FFFFFFF0"
            report "Error: S_sig should be equal to x'FFFFFFF0'" severity error;

        E_s <= "00001111";
        wait for 10 ns;
        assert S_s = x"0000000F"
            report "Error: S_sig should be equal to x'0000000F'" severity error;

        wait;
    end process;

end architecture;
