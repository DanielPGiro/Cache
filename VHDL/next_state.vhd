-- File next_state
-- Author: Ian Lane, Daniel Giro
-- Description: Next state logic for the state machine
library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity next_state is
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
end next_state;

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

architecture structural of next_state is
  component and2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  component inverter
    port (
      input : in std_logic;
      output : out std_logic
    );
  end component;
  
  component decoder_2_4
    port (
      E : in std_logic;
      A0 : in std_logic;
      A1 : in std_logic;
      Y0 : out std_logic;
      Y1 : out std_logic;
      Y2 : out std_logic;
      Y3 : out std_logic
    );
  end component;

  component and3
    port (
      A : in std_logic;
      B : in std_logic;
      C : in std_logic;
      Output : out std_logic
    );
  end component;

  component nand3
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      input3 : in std_logic;
      output : out std_logic
    );
  end component;

  component nand4
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      input3 : in std_logic;
      input4 : in std_logic;
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

  for inv_1, inv_2, inv_3, inv_4, inv_5: inverter use entity work.inverter(structural);
  for nand3_1: nand3 use entity work.nand3(structural);
  for and2_1, and2_2, and2_3, and2_4, and2_6, and2_7: and2 use entity work.and2(structural);
  for and3_1, and3_2 : and3 use entity work.and3(structural);
  for decoder_1: decoder_2_4 use entity work.decoder_2_4(structural);
  for or2_1, or2_2, or2_3: or2 use entity work.or2(structural);
  for nand4_1: nand4 use entity work.nand4(structural);

  signal busy_inv, count_nand, count_and, wait_for_mem, stay_write_mem, leave_write_mem, move_write_mem, stay_mem, reset_inv, decoder_enable, wait_for_mem_2, do_write_mem, move_nx_1, count_0_bar : std_logic;


  begin
    inv_4 : inverter port map (reset, reset_inv);

    inv_5 : inverter port map (count(0), count_0_bar);

    inv_1 : inverter port map (busy, busy_inv); -- When busy is 0, always in idle state
    or2_3 : or2 port map (busy_inv, reset, next_state(0));

    and3_1 : and3 port map (curr_state(0), start, reset_inv, move_nx_1); -- latch inputs when we are idling and get the start signal
    and2_1 : and2 port map (curr_state(1), reset_inv, decoder_enable); 
    -- Next_state(1) will go directly into the input enable to the latch inputs.
    -- The decoder must be enabled to get the correct state on the next negative edge after start goes low
    decoder_1 : decoder_2_4 port map (decoder_enable, rd_wr, valid, next_state(4), next_state(5), next_state(3), next_state(2)); -- Move to read/write hit/miss if we have finished latching inputs

    nand3_1: nand3 port map (count(0), count(1), count(2), count_nand); -- Produces 1 when count is not 8 (7)
    inv_2: inverter port map (count_nand, count_and); -- Produces 1 when count is 8 (7)

    and2_2: and2 port map (curr_state(6), count_nand, wait_for_mem);
    or2_1: or2 port map (curr_state(5), wait_for_mem, wait_for_mem_2); -- Move to wait for mem state if we get a read miss or the count has not finished its 8 clock cycles
    and2_6: and2 port map (wait_for_mem_2, reset_inv, next_state(6));

    and2_3: and2 port map (curr_state(6), count_and, move_write_mem); -- Move to write mem if we are done waiting for mem

    nand4_1: nand4 port map (count(0), count(1), count(2), count(3), stay_write_mem); -- Waiting for mem and writing memory to cache takes a total of 16 clock cycles.

    and2_4: and2 port map(curr_state(7), stay_write_mem, stay_mem);

    or2_2: or2 port map(stay_mem, move_write_mem, do_write_mem); -- Move to write mem if we get a read miss, or we are still writing memory to cache

    and2_7 : and2 port map (do_write_mem, reset_inv, next_state(7));

    inv_3: inverter port map(stay_write_mem, leave_write_mem);

    and3_2: and3 port map(curr_state(7), leave_write_mem, reset_inv, next_state(8)); -- Move to read mem once we are done writting all the memory

    next_state(1) <= move_nx_1;
  
end structural;
