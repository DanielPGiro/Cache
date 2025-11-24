-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity decoder_2_4 is
  port (
    E : in std_logic;
    A0 : in std_logic;
    A1 : in std_logic;
    Y0 : out std_logic;
    Y1 : out std_logic;
    Y2 : out std_logic;
    Y3 : out std_logic
  );
end decoder_2_4;
