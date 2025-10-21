--
-- Entity: negative edge triggered state machine
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--
library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity state_machine is
  port( 
    cpu_rd_wrn : in  std_logic;    
    cpu_add    : in std_logic_vector(5 downto 0);  -- for tag
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
end state_machine;

architecture structural of state_machine is
  
  component curr_state
    port (
      start  : in std_logic;
      busy   : in std_logic;
      clk    : in std_logic;
      IE     : out std_logic;
      OE     : out std_logic
    );
  end component;

  component nxt_state
    port (
      busy : in std_logic;
      start : in std_logic;
      count : in std_logic_vector (3 downto 0);
      valid : in std_logic;
      rd_wr : in std_logic;
      curr_state : in std_logic_vector (8 downto 0);
      next_state : out std_logic_vector (8 downto 0)
    );
  end component;
  
  component idle
    port (
      start  : in std_logic;
      busy   : in std_logic;
      IE     : out std_logic;
      OE     : out std_logic
    );
  end component;

  component compare
    port (
      valid       : in std_logic;
      cpu_rd_wrn  : in std_logic;
      
    );
  end component;

  component read_miss
    port (
      
    );
  end component;

  component write_miss
    port (
      
    );
  end component;

  component read_hit
    port (
      
    );
  end component;

  component write_hit
    port (
      
    );
  end component;

  component wait_mem
    port (
      
    );
  end component;

  component read_mem
    port (
      
    );
  end component;

  signal tag: std_logic_vector(1 downto 0);
  
  begin
    

end structural;
