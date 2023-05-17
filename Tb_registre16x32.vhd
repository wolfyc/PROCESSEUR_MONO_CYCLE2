LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity Tb_registre16x32 is
end entity;

architecture arc_Tb_registre16x32 of Tb_registre16x32 is

  component registre16x32 is
    port(
    	clk: in std_logic;
        rst: in std_logic;
        w:   in std_logic_vector(31 downto 0);
        RA:  in std_logic_vector(3 downto 0);
        RB:  in std_logic_vector(3 downto 0);
        RW:  in std_logic_vector(3 downto 0);
        WE:  in std_logic;
        A:   out std_logic_vector(31 downto 0);
        B:   out std_logic_vector(31 downto 0)
    );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal w:   std_logic_vector(31 downto 0);
  signal RA:  std_logic_vector(3 downto 0);
  signal RB:  std_logic_vector(3 downto 0);
  signal RW:  std_logic_vector(3 downto 0);
  signal WE:  std_logic;
  signal A:   std_logic_vector(31 downto 0);
  signal B:   std_logic_vector(31 downto 0);

begin

  UUT: registre16x32 port map(
    clk => clk,
    rst => rst,
    w => w,
    RA => RA,
    RB => RB,
    RW => RW,
    WE => WE,
    A => A,
    B => B
  );

  -- Cr�ation de l'horloge
	Horloge: process
        begin
            clk <= '1';
            wait for 1 NS;
            clk <= '0';
            wait for 1 NS;
    end process;

  -- Tests
  stim_proc : process
  begin
    rst <= '1';              -- Reset des registres
    we <= '0';               -- Write Desable
    w <= x"0000000A";
    ra <= "0001";            -- Lecture du registre 1 dans A
    rb <= "1111";            -- Lecture du registre 15 dans B
    rw <= "0001";            -- Ecriture dans le registre 1

    WAIT FOR 10 ns;

    rst <= '0';
    we <= '1';               -- Write Enable
    w <= x"00000001";
    ra <= "0001";            -- Lecture du registre 1 dans A
    rb <= "1111";            -- Lecture du registre 15 dans B
    rw <= "0001";            -- Ecriture dans le registre 1

    WAIT FOR 10 ns;


wait;

    end process;
    
end architecture;
