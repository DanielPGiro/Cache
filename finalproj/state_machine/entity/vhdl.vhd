-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 17:50:32 2025


library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity state_machine is
  port( 
    cpu_rd_wrn : in  std_logic;    
    --cpu_add    : in std_logic_vector(5 downto 0);  -- for tag
    start      : in  std_logic;
    clk        : in  std_logic;
    reset      : in  std_logic;
    Vdd	       : in  std_logic;
    Gnd        : in  std_logic;
    valid      : in std_logic;
    busy_in    : in std_logic;
    latch_enable : out std_logic;
    tag_valid_MA_enable : out std_logic;
    --valid_enable : out std_logic;
    CD_MD      : out std_logic; -- High we access cpu data low we access memory data
    mem_enable : out std_logic;
    MA         : out std_logic_vector(1 downto 0);
   --states     : out std_logic_vector(8 downto 0); -- debug
    --MA_select  : out std_logic; -- When 1, MA goes through, when 0, CA goes through
    busy_out   : out std_logic;
    IE         : out std_logic;
    OE         : out std_logic
  );
end state_machine;
