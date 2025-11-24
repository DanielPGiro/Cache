-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell is
  port (
    data_in : in std_logic;
    clk : in std_logic;
    IE : in std_logic; -- Input enable
    OE : in std_logic; -- Output enable
    data_out : out std_logic
  );
end cache_cell;
