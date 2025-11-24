-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity and3 is
  port (
    A : in std_logic;
    B : in std_logic;
    C : in std_logic;
    Output : out std_logic
  );
end and3;
