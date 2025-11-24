-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity cache_block is
  port(
    byte_in : in std_logic_vector(7 downto 0);
    byte_0_select : in std_logic;
    byte_1_select : in std_logic;
    byte_2_select : in std_logic;
    byte_3_select : in std_logic;
    clk : in std_logic;
    IE : in std_logic; -- This is controlled externally by a decoder as well as the outputs of this entity's tag and valid bits
    OE : in std_logic;
    reset : in std_logic;
    valid_enable : in std_logic; -- valid and tag enable are only set high on a read miss
    valid_set : in std_logic;
    tag_enable : in std_logic;
    tag_set : in std_logic_vector(1 downto 0);
    tag_valid_out_enable : in std_logic; -- Allows output of tag and valid bits
    byte_out : out std_logic_vector(7 downto 0);
    valid_out : out std_logic;
    tag_out : out std_logic_vector(1 downto 0)
  );
end cache_block;
