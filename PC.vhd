library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------
entity pc is
    port(
        clk : in std_logic;
        rst : in std_logic;
        PC_i : in std_logic_vector(31 downto 0);
        PC_o : out std_logic_vector(31 downto 0));
end pc;

architecture arch of pc is

begin
proc : process(clk,rst)
   begin 
    if (rst = '1') then 
        PC_o <= (others => '0');
    elsif( rising_edge(clk)) then 
        PC_o <= PC_i;
    end if;
end process; 

end arch;