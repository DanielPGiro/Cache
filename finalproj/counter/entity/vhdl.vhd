-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity counter is
  port (
    clk     : in  std_logic;
    rst		: in  std_logic;
    Q       : inout std_logic_vector(3 downto 0));
end counter;
