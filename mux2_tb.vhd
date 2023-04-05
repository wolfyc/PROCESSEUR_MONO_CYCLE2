library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_tb is
end entity;

architecture arc_mux2_tb of mux2_tb is
    component mux2 is
        generic (
            N: INTEGER := 32
        );

        port (
            A, B: in std_logic_vector((N-1) downto 0);
            Com: in std_logic;
            S: out std_logic_vector((N-1) downto 0)
        );
    end component;

    signal A_s: std_logic_vector(31 downto 0) := "10101010101010101010101010101010";
    signal B_s: std_logic_vector(31 downto 0) := "01010101010101010101010101010101";
    signal Com_s: std_logic := '0';
    signal S_s: std_logic_vector(31 downto 0);

begin
    UUT: mux2 generic map(N => 32)
        port map(A => A_s, B => B_s, Com => Com_s, S => S_s);

    process
    begin
        Com_s <= '0';
        wait for 10 ns;
        assert S_s = A_s
            report "Error: S_sig should be equal to A_sig" severity error;

        Com_s <= '1';
        wait for 10 ns;
        assert S_s = B_s
            report "Error: S_sig should be equal to B_sig" severity error;

        wait;
    end process;

end architecture;