--
-- Entity: negative edge triggered Chip
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--

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
      mem_add    : out std_logic_vector(5 downto 0)
    );
end chip;

architecture structural of chip is
    component state_machine
        port (
            cpu_rd_wrn : in  std_logic;    
            start      : in  std_logic;
            clk        : in  std_logic;
            reset      : in  std_logic;
            Vdd	       : in  std_logic;
            Gnd        : in  std_logic;
            valid      : in std_logic;
            busy       : in std_logic;
            IE         : out std_logic;
            OE         : out std_logic_vector(5 downto 0)
        );
    end component;
        
    component cache_mem
        port (
            byte_in : in std_logic_vector(7 downto 0); -- Mem for write
            CA : in std_logic_vector(3 downto 0); -- for block/byte decode
            tag_set : in std_logic_vector(1 downto 0); -- Data for new tag
            tag_enable : in std_logic; -- High for tag change
            valid_set : in std_logic; 
            valid_enable : in std_logic;
            VDD : in std_logic;
            clk : in std_logic;
            IE : in std_logic; -- Controlled by state machine, mapped to every reg
            OE : in std_logic;
            reset : in std_logic;
            byte_out : out std_logic_vector(7 downto 0); -- For read
            valid_out : out std_logic;
            tag_out : out std_logic_vector(1 downto 0)
        );
    end component;

    for sm: use entity work.state_machine(structural);
    for cmem: use entity work.cache_mem(structural);

   -- signal somethingtoadd
    
    begin 
        sm: port map ();
        cmem: port map();

end structural;
