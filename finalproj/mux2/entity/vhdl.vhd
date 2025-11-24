-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is 
    port(
        sel   : in std_logic;
        s0  : in std_logic_vector(1 downto 0);
        s1  : in std_logic_vector(1 downto 0);
        y  : out std_logic_vector(1 downto 0)
    );
end mux2;
