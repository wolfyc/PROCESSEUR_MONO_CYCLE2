library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------
entity UGI is
port( 
clk_i : in std_logic;
rst : in std_logic;
nPCsel : in std_logic;
pc_offset : in std_logic_vector(23 downto 0);
instruction : out std_logic_vector(31 downto 0));
end UGI; 
---------------------------------------------------------
architecture arch of UGI is

    --Signaux extender
    signal offsetext : std_logic_vector(31 downto 0);
    --Signaux Memoire d'instructions
    --Signaux multiplexeur
    signal PC_1,PC_1_offset: std_logic_vector(31 downto 0);
    signal mult_out : std_logic_vector(31 downto 0);
    --Signaux PC
    signal PC : std_logic_vector(31 downto 0) := (others=> '0');

begin 

    et0 : entity work.sign_extension
        generic map(N=>24)
        port map(
            E=>pc_offset,
            S=>offsetext
        );

    et1 : entity work.mux2
        generic map(N=>32)
        port map(
            A=>PC_1,
            B=>PC_1_offset,
            COM=>nPCsel,
            S=>mult_out
        );

    et2 : entity work.pc
        port map(
            clk=>clk_i,
            rst=>rst,
            PC_i=>mult_out,
            PC_o=>PC
        );

    et3 : entity work.memoire2
        port map(
            clk=>clk_i,
            Addr=>PC(5 downto 0),
            DataOut=>instruction
        );

    PC_1<= std_logic_vector(signed(PC) + 1);
    PC_1_offset<= std_logic_vector(signed(PC_1)+ signed(offsetext));


end architecture;