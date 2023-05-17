-- Projet ARSY ******************* EI2I3-II *************
-- Achraf MOSBAH ***** Yasmine JELASSI ***** Manar BRIRMI
-- **** Registre 32 bits avec commande de chargement*****
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------
entity UC is
    port (
    CLK : in std_logic;
    WE : in std_logic;
    RST : in std_logic;
    DATAIN : in std_logic_vector(31 downto 0);
    DATAOUT : out std_logic_vector(31 downto 0));
end UC;
---------------------------------------------------------
architecture arch of UC is
signal temp : std_logic_vector(31 downto 0);
begin
proc : process(clk,rst)
   begin 
    if RST = '0' then 
        temp <= (others=> '0');
    
    elsif( CLK'event and CLK = '1') then 
        if WE='1' then
            temp <= DATAIN;
        end if;
    end if;
end process;
DATAOUT <= temp;
end architecture arch;