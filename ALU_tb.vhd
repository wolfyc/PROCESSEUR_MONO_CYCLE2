library ieee;
use ieee.std_logic_1164.all;

entity Test_Bench_ALU is
end entity;

architecture arc_TB of Test_Bench_ALU is
    component ALU is
        port (
            A, B: in std_logic_vector(31 downto 0);
            OP: in std_logic_vector(1 downto 0);
            S: out std_logic_vector(31 downto 0);
            N: out std_logic
        );
    end component;
    
    signal A, B: std_logic_vector(31  downto 0);
    signal OP: std_logic_vector(1 downto 0);
    signal S: std_logic_vector(31 downto 0);
    signal N: std_logic;

begin
    uut: ALU port map (A => A, B => B, OP => OP, S => S, N => N);
    
    process
    begin
        A <= x"00000001";
        B <= x"00000001";
        OP <= "00";
        wait for 10 ns;
        
        A <= x"00000010";
        B <= x"FFFFFFFF";
        OP <= "01";
        wait for 10 ns;
        
        A <= x"00000002";
        B <= x"00000004";
        OP <= "10";
        wait for 10 ns;
        
        A <= x"00000008";
        B <= x"00000007";
        OP <= "11";
        wait for 10 ns;
        
        assert (S = x"00000002") and (N = '0') report "Test 1 passed" severity warning;
        assert (S = x"FFFFFFFF") and (N = '1') report "Test 2 passed" severity warning;
        assert (S = x"FFFFFFFE") and (N = '1') report "Test 3 passed" severity warning;
        assert (S = x"00000001") and (N = '1') report "Test 4 passed" severity warning;

        wait;
    end process;
    
end architecture;
