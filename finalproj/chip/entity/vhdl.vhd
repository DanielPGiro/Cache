-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 18:04:40 2025


library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;

entity chip is
    port (
      cpu_add    : in  std_logic_vector(5 downto 0); 
      cpu_data   : inout  std_logic_vector(7 downto 0);
      cpu_rd_wrn : in  std_logic;    
      start      : in  std_logic;
      clk        : in  std_logic;
      reset      : in  std_logic;
      mem_data   : in  std_logic_vector(7 downto 0);
      Vdd	     : in  std_logic;
      Gnd        : in  std_logic;
      busy       : out std_logic;
      mem_en     : out std_logic;
      --OE         : out std_logic;
      --byte_out   : out std_logic_vector(7 downto 0);
      --states     : out std_logic_vector(8 downto 0);
      --CA_4_0 : out std_logic_vector(3 downto 0);
      --Ie : out std_logic;
      mem_add    : out std_logic_vector(5 downto 0)
    );
end chip;
