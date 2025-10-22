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
    rd_wr      : in  std_logic;
    Vdd	       : in  std_logic;
    Gnd        : in  std_logic;
    valid      : in std_logic;
    busy_in    : in std_logic;
    latch_enable : out std_logic;
    tag_enable : out std_logic;
    busy_out   : out std_logic;
    IE         : out std_logic;
    OE         : out std_logic
  );
end state_machine;

architecture structural of state_machine is
  
  component curr_state
    port (
      latch_state : in std_logic_vector(8 downto 0);
      curr_state : out std_logic_vector(8 downto 0)
    );
  end component;

  component next_state
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

  component and2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  component or2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );

    for next_state_1: next_state use entity work.next_state(structural);
    for curr_state_1: curr_state use entity work.curr_state(structural);
  
    for or2_1: or2 use entity work.or2(structural);

  signal tag: std_logic_vector(1 downto 0);
  signal curr_state, next_state : std_logic_vector(8 downto 0);
  signal curr_count : std_logic_vector(3 downto 0);
  
  begin

    next_state_1: next_state port map (busy, start, curr_count, valid, rd_wr, curr_state, next_state);
    curr_state_1: curr_state port map (next_state, curr_state);

    or2_1: or2 port map (curr_state(2), curr_state(8), OE); -- Output gets enabled when we are in a read state

    latch_enable <= next_state(1); -- For timing rquirements, we latch the inputs on the negative edge of start going low (one cycle)
    

end structural;
