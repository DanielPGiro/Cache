-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity nand3 is
  port (
    input1 : in std_logic;
    input2 : in std_logic;
    input3 : in std_logic;
    output : out std_logic
  );
end nand3;
