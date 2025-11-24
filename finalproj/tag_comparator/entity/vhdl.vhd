-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
use IEEE.std_logic_1164.all;

entity tag_comparator is
  port (
    TA0 : in std_logic; -- TA is the tag in the address
    TA1 : in std_logic;
    TB0 : in std_logic; -- TB is the tag in the block index
    TB1 : in std_logic;
    valid : in std_logic;
    output : out std_logic
  );
end tag_comparator;
