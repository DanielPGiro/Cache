-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity next_state is
  port (
    busy : in std_logic;
    start : in std_logic;
    reset : in std_logic;
    count : in std_logic_vector (3 downto 0);
    valid : in std_logic;
    rd_wr : in std_logic;
    curr_state : in std_logic_vector (8 downto 0);
    next_state : out std_logic_vector (8 downto 0)
  );
end next_state;
