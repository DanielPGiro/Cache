-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity reg is
  port (
   bit_in : in std_logic_vector(7 downto 0);
   clk : in std_logic;
   IE : in std_logic;
   OE : in std_logic;
   bit_out : out std_logic_vector(7 downto 0)
  );
end reg;
