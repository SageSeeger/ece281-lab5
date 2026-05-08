----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
begin 
    process(i_A, i_B, i_op)
        variable v_sum    : unsigned(8 downto 0);
        variable v_result : std_logic_vector(7 downto 0);
        variable v_carry  : std_logic;
        variable v_overflow: std_logic;
        variable v_negative: std_logic;
        variable v_zero : std_logic;
    begin
        v_sum  := (others => '0');
        v_result := (others => '0');
        v_negative := '0';
        v_zero := '0';
        v_carry := '0';
        v_overflow := '0';
        
    case i_op is 
        when "000" =>
            v_sum := ('0' & unsigned(i_A)) + ('0' & unsigned(i_B));
            v_result := std_logic_vector(v_sum(7 downto 0));
            v_carry := v_sum(8);
            
            if(i_A(7) =i_B(7) and v_result(7)/=i_A(7)) then
                v_overflow := '1';
            else    
                v_overflow := '0';
                
            end if;
            
        when "001" =>
            v_sum := ('0' & unsigned(i_A)) +('0' & unsigned(not(i_B)) + to_unsigned(1,9));
            v_result := std_logic_vector(v_sum(7 downto 0));
            v_carry := v_sum(8);
            
            if(i_A(7) /= i_B(7) and v_result(7)/=i_A(7)) then
                v_overflow := '1';
            else
                v_overflow := '0';
            end if;
            
        when "010" =>
            v_result := i_A and i_B;
            v_carry := '0';
            v_overflow := '0';
            
        when "011" =>
            v_result := i_A or i_B;
            v_carry := '0';
            v_overflow := '0';
            
        when others =>
            v_result := (others => '0');
            v_carry := '0';
            v_overflow := '0';
        
        end case;
        
        v_negative := v_result(7);
        
        if v_result = x"00" then
            v_zero := '1';
        else
            v_zero:= '0';
        end if;    
        
        
        o_result <= v_result;
        
        o_flags <= v_negative & v_zero & v_carry & v_overflow;
        
        end process;
   

            
  end Behavioral;