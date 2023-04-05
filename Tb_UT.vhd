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
        W:   out std_logic_vector(31 downto 0);      --output & input
        N: out std_logic                      --signe of the output
    );
  end component;

 signal      clk, rst: std_logic;
 signal       RA:  std_logic_vector(3 downto 0);
 signal       RB:  std_logic_vector(3 downto 0);
 signal       RW:  std_logic_vector(3 downto 0);
 signal       WE:  std_logic;
 signal       OP:  std_logic_vector(1 downto 0);
 signal       W:    std_logic_vector(31 downto 0); --output & input
 signal       N:  std_logic;                  --signe of the output

begin

  UUT: Entity work.unite_de_traitement port map(
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
rst <= '1'; --rst
RA <= "0001"; --RA lit dans le registre 1
RB <= "1111"; --RB lit dans le registre 15
RW <= "0001"; --RW ecrit dans le registre 1
WE <= '0'; --write disable
OP <= "01"; --W = B

wait for 10 ns;

clk <= '1';

wait for 10 ns;

clk <= '0';
rst <= '0';
WE <= '1'; --write enable

wait for 10 ns;

clk <= '1'; -- R(1) = R(15)

wait for 10 ns;

clk <= '0';
OP <= "00"; --W = A + B

wait for 10 ns;

clk <= '1'; -- R(1) = R(1) + R(15)

wait for 10 ns;

clk <= '0';
RW <= "0010"; --RW ecrira dans le registre 2

wait for 10 ns;

clk <= '1'; -- R(2) = R(1) + R(15)

wait for 10 ns;

clk <= '0';
RW <= "0011"; --RW ecrira dans le registre 3
OP <= "10"; --W = A - B

wait for 10 ns;

clk <= '1'; -- R(3) = R(1) ? R(15)

wait for 10 ns;

clk <= '0';
RA <= "0111"; --RA lit dans le registre 7
RW <= "0101"; --RW ecrit dans le registre 5

wait for 10 ns;

clk <= '1'; -- R(5) = R(7) - R(15)

--On va maintenat lire dans les registres pour vérifier les bonnes valeurs

wait for 10 ns;

clk <= '0';
RA <= "0010"; --RA lit dans le registre 2
WE <= '0'; --witre desable
OP <= "11"; --W = A

wait for 10 ns;

clk <= '1';

wait for 10 ns;

clk <= '0';
RA <= "0011"; --RA lit dans le registre 3

wait for 10 ns;

clk <= '1';

wait for 10 ns;

clk <= '0';
RA <= "0101"; --RA lit dans le registre 5

wait for 10 ns;

clk <= '1';

wait;


    end process;
   
end architecture;