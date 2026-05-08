----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller_fsm is
    Port (
        i_clk   : in STD_LOGIC;
        i_reset : in STD_LOGIC;
        i_adv   : in STD_LOGIC;
        o_cycle : out STD_LOGIC_VECTOR(3 downto 0)
    );
end controller_fsm;

architecture FSM of controller_fsm is
    type sm_state is (S0, S1, S2, S3);
    signal current_state, next_state : sm_state;
begin

next_state <= S0 when current_state = S3 else
              S1 when current_state = S0 else
              S2 when current_state = S1 else
              S3 when current_state = S2 else
              S0;

o_cycle <= "0001" when current_state = S0 else
           "0010" when current_state = S1 else
           "0100" when current_state = S2 else
           "1000" when current_state = S3 else
           "0001";

state_register : process(i_clk)
begin
    if rising_edge(i_clk) then
        if i_reset = '1' then
            current_state <= S0;
        elsif i_adv = '1' then
            current_state <= next_state;
        end if;
    end if;
end process;

end FSM;
