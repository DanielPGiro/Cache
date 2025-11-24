-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1 is 
    port(
        B   : in std_logic;
        S0  : in std_logic;
        S1  : in std_logic;
        Y  : out std_logic);
end mux2to1;
