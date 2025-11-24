-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;


entity current_state is
  port (
    clk : in std_logic;
    gnd : in std_logic;
    vdd : in std_logic;
    reset : in std_logic;
    latch_state : in std_logic_vector(8 downto 0);
    curr_state  : out std_logic_vector(8 downto 0)
  );
end current_state;
