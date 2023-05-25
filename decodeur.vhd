library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------
entity decodeur is 
port (
    instruction,PSR_in : in std_logic_vector(31 downto 0);
    ALUCtr : out std_logic_vector(1 downto 0);
    ALUSrc,WrSrc,nPCSel,RegSel,PSREn,MemWr,RegWr : out std_logic;
    offset : out std_logic_vector(23 downto 0);
    Rn, Rd, Rm: out std_logic_vector(3 downto 0);
    Imm : out std_logic_vector(7 downto 0) );
end entity decodeur;
---------------------------------------------------------
architecture arc_decodeur of decodeur is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT); 
    signal instr_courante: enum_instruction;  
    begin 
    -- Processus 1 : But : Fixer la valeur du signal instr_courante
    proc1 : process(instruction)
    begin
        if instruction(27) = '0' then
            case instruction(31 downto 20) is
                when "111000101000" => instr_courante <= ADDi;
                when "111000001000" => instr_courante <= ADDr;
                when "111000110101" => instr_courante <= CMP;
                when "111001100001" => instr_courante <= LDR;
                when "111000111010" => instr_courante <= MOV;
                when "111001100000" => instr_courante <= STR;
                when others => NULL;
            end case; 
        else 
            case instruction(31 downto 24) is
                when "11101010" => instr_courante <= BAL;
                when "10111010" => instr_courante <= BLT;
                when others => NULL;
            end case;
        end if;
        end process;
    -- Processus 2 : But : Donner la valeur des commandes des registres et opérateurs du processeur
    proc2 : process(instruction,instr_courante)
    begin 
            case instr_courante is
                when ADDi => nPCSel  <= '0';
                            RegWr <= '1';
                            ALUSrc <= '1';
                            ALUCtr <= "00";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            Rn <= instruction(19 downto 16);
                            Rd <= instruction(15 downto 12);
                            Imm <= instruction(7 downto 0);
                when ADDr => nPCSel <= '0';
                            RegWr <= '1';
                            ALUSrc <= '0';
                            ALUCtr <= "00";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            Rn <= instruction(19 downto 16);
                            Rd <= instruction(15 downto 12);
                            Rm<= instruction(3 downto 0);
                when BAL => nPCSel <= '1';
                            RegWr <= '0';
                            ALUSrc <= '0';
                            ALUCtr <= "00";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            offset <= instruction(23 downto 0);
                when BLT => nPCSel <= PSR_in(31);
                            RegWr <= '0';
                            ALUSrc <= '0';
                            ALUCtr <= "00";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            offset <= instruction(23 downto 0);
                when CMP => nPCSel <= '0';
                            RegWr <= '0';
                            ALUSrc <= '1';
                            ALUCtr <= "10";
                            PSREn <= '1';
                            MemWr<= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            Rn <= instruction(19 downto 16);
                            Imm <= instruction(7 downto 0);
                when LDR => nPCSel <= '0';
                            RegWr <= '1';
                            ALUSrc <= '1';
                            ALUCtr <= "00";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '1';
                            RegSel <= '0';
                            Rn <= instruction(19 downto 16);
                            Rd <= instruction(15 downto 12);
                            offset(11 downto 0) <= instruction(11 downto 0);
			                offset(23 downto 12) <= (others => '0');
                when MOV => nPCSel <= '0';
                            RegWr <= '1';
                            ALUSrc <= '1';
                            ALUCtr <= "01";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            Rd <= instruction(15 downto 12);
                            Imm <= instruction(7 downto 0);
                when STR => nPCSel <= '0';
                            RegWr <= '0';
                            ALUSrc <= '1';
                            ALUCtr <= "00";
                            PSREn <= '0';
                            MemWr <= '1';
                            WrSrc <= '0';
                            RegSel <= '1';
                            Rn <= instruction(19 downto 16);
                            Rd <= instruction(15 downto 12);
                            offset(11 downto 0) <= instruction(11 downto 0);
			    offset(23 downto 12) <= (others => '0');
            end case;
end process;
end architecture arc_decodeur;