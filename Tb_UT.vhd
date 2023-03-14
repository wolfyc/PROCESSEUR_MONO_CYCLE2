LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity TB_UT is
end entity;

architecture arc_TB_UT of TB_UT is

  component UT is
    port(
        clk,rst: in std_logic;
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        OP:  in std_logic_vector(1 downto 0);
        W:   out std_logic_vector(31 downto 0);	      --output & input
        N: out std_logic				                      --signe of the output
    );
  end component;

 signal	      clk, rst: std_logic;
 signal       RA:  std_logic_vector(3 downto 0);
 signal       RB:  std_logic_vector(3 downto 0);
 signal       RW:  std_logic_vector(3 downto 0);
 signal       WE:  std_logic;
 signal       OP:  std_logic_vector(1 downto 0);
 signal       W:    std_logic_vector(31 downto 0);	--output & input
 signal       N:  std_logic;			                  --signe of the output

begin

  UUT: UT port map(
    clk => clk,
    rst => rst,
    w => w,
    RA => RA,
    RB => RB,
    RW => RW,
    WE => WE,
    OP => OP,
    N => N
  );

  -- Tests
  stim_proc : process
  begin

	clk <= '0';
	rst <= '1';
	RA <= "0001";
	RB <= "1111";
	RW <= "0001";
	WE <= '0';
	OP <= "11";

wait for 10 ns;

	clk <= '1';

wait for 10 ns;

	clk <= '0';
	rst <= '0';
	WE <= '1';
	OP <= "01";

wait for 10 ns;

	clk <= '1';

wait for 10 ns;

	clk <= '0';
	OP <= "11";

wait for 10 ns;

	clk <= '1';
wait;

    end process;
    
end architecture;
