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
    busy_in    : in std_logic;
    latch_enable : out std_logic;
    tag_enable : out std_logic;
    valid_enable : out std_logic;
    CD_MD      : out std_logic; -- High we access cpu data low we access memory data
    mem_enable : out std_logic;
    MA         : out std_logic_vector(1 downto 0);
   states     : out std_logic_vector(8 downto 0); -- debug
    MA_select  : out std_logic; -- When 1, MA goes through, when 0, CA goes through
    busy_out   : out std_logic;
    IE         : out std_logic;
    OE         : out std_logic
  );
end state_machine;


-- States:
-- states[0] idle
-- states[1] latch inputs
-- states[2] read hit
-- states[3] write hit
-- states[4] write miss
-- states[5] read miss
-- states[6] wait for mem
-- states[7] write mem
-- states[8] read mem


architecture structural of state_machine is
  
  component current_state
    port (
      clk : in std_logic;
      gnd : in std_logic;
      vdd : in std_logic;
      reset : in std_logic;
      latch_state : in std_logic_vector(8 downto 0);
      curr_state : out std_logic_vector(8 downto 0)
    );
  end component;

  component next_state
    port (
      busy : in std_logic;
      start : in std_logic;
      reset : in std_logic;
      count : in std_logic_vector (3 downto 0);
      valid : in std_logic;
      rd_wr : in std_logic;
      curr_state : in std_logic_vector (8 downto 0);
      next_state : out std_logic_vector (8 downto 0)
    );
  end component;

  component mux2to1
    port (
      B : in std_logic;
      S0 : in std_logic;
      S1 : in std_logic;
      Y : out std_logic
    );
  end component;

  component counter
    port (
      clk : in std_logic;
      rst : in std_logic;
      Q : inout std_logic_vector(3 downto 0)
    );
  end component;

  component counter_1_bit
    port (
      clk : in std_logic;
      rst : in std_logic;
      Q : inout std_logic
    );
  end component;

  component counter_2_bit
    port (
      clk : in std_logic;
      rst : in std_logic;
      Q : inout std_logic_vector(1 downto 0)
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
  end component;

  component or7
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      input3 : in std_logic;
      input4 : in std_logic;
      input5 : in std_logic;
      input6 : in std_logic;
      input7 : in std_logic;
      output : out std_logic
    );
  end component;


  component inverter
    port (
      input : in std_logic;
      output : out std_logic
    );
  end component;

  for next_state_1: next_state use entity work.next_state(structural);
  for curr_state_1: current_state use entity work.current_state(structural);
  
  for mux_0 : mux2to1 use entity work.mux2to1(structural);
  for or2_1, or2_2: or2 use entity work.or2(structural);
  for and2_1: and2 use entity work.and2(structural);
  for inv_1, inv_2: inverter use entity work.inverter(structural);

  for counter_1: counter use entity work.counter(structural);

  for or7_1 : or7 use entity work.or7(structural);

  for counter_1_bit_1: counter_1_bit use entity work.counter_1_bit(structural);
  for counter_2_bit_1: counter_2_bit use entity work.counter_2_bit(structural);

  signal tag: std_logic_vector(1 downto 0);
  signal curr_state_sig, next_state_sig : std_logic_vector(8 downto 0);
  signal curr_count : std_logic_vector(3 downto 0);
  signal mem_write_inv : std_logic;
  signal Q_1_bit, Q_1_inv, mem_wr_en : std_logic;
  signal Q_2_bit : std_logic_vector(1 downto 0);
  signal busy_out_0 : std_logic;
  
  begin

    next_state_1: next_state port map (busy_in, start, reset, curr_count, valid, cpu_rd_wrn, curr_state_sig, next_state_sig);
    curr_state_1: current_state port map (clk, gnd, vdd, reset, next_state_sig, curr_state_sig);

    counter_1 : counter port map (clk, next_state_sig(5), curr_count);

    counter_1_bit_1 : counter_1_bit port map (clk, next_state_sig(5), Q_1_bit); -- Reset is asynch so 0 will be clocked at same time we enter the write mem state
    counter_2_bit_1 : counter_2_bit port map (Q_1_bit, next_state_sig(5), Q_2_bit); -- Increment the byte address by 1 when input enabe is high, this new address shoud be clocked on the following clock cycle

    inv_2: inverter port map(Q_1_bit, Q_1_inv);

    or2_1: or2 port map (curr_state_sig(2), curr_state_sig(8), OE); -- Output gets enabled when we are in a read state
    
    and2_1: and2 port map (curr_state_sig(7), Q_1_bit, mem_wr_en);
    or2_2: or2 port map (curr_state_sig(3), mem_wr_en, IE); -- IE if read hit or (writing mem data and counter is 1)

    or7_1: or7 port map (next_state_sig(1), next_state_sig(3), next_state_sig(4), next_state_sig(5), next_state_sig(6), next_state_sig(7), next_state_sig(8), busy_out_0);

    mux_0: mux2to1 port map (reset, gnd, busy_out_0, busy_out);

    inv_1: inverter port map (curr_state_sig(7), mem_write_inv);

    latch_enable <= next_state_sig(1); -- For timing rquirements, we latch the inputs on the negative edge of start going low (one cycle)

    tag_enable <= curr_state_sig(7); -- Write the tag and valid when writing from memory
    valid_enable <= curr_state_sig(7);

    CD_MD <= mem_write_inv; -- When not in meme write state this is a one which means it will always pull cpu data

    mem_enable <= curr_state_sig(5); -- Output mem enable for one clock cycle before waiting for memory

    MA_select <= curr_state_sig(7);

    MA <= Q_2_bit;

    states <= curr_state_sig;
    

end structural;

