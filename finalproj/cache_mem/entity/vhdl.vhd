-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;


entity cache_mem is
  port (
    byte_in : in std_logic_vector(7 downto 0); -- Mem for write
    CA : in std_logic_vector(3 downto 0); -- for block/byte decode
    tag_set : in std_logic_vector(1 downto 0); -- Data for new tag
    tag_enable : in std_logic; -- High for tag change
    valid_set : in std_logic; 
    valid_enable : in std_logic;
    clk : in std_logic;
    IE : in std_logic; -- Controlled by state machine, mapped to every reg
    OE : in std_logic;
    VDD : in std_logic;
    reset : in std_logic;
    byte_out : out std_logic_vector(7 downto 0); -- For read
    valid_out : out std_logic;
    tag_out : out std_logic_vector(1 downto 0)
  );

end cache_mem;
