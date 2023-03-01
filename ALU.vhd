library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port(
	A,B : in std_logic_vector(31 downto 0);
	OP : in std_logic_vector(1 downto 0);
	S : out std_logic_vector(31 downto 0);
	N : out std_logic);
end entity;

architecture arc_ALU of ALU is
signal As,Bs,Ss : signed(31 downto 0);
begin
As <= signed(A);
Bs <= signed(B);
S <= std_logic_vector(Ss);
     with OP select
          Ss <= As + Bs when "00",
                  Bs when "01",
                  As - Bs when "10",
                  As when others;
N <= Ss(31);
end architecture;
