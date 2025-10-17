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
    count : in std_logic_vector (2 downto 0);
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
      output : out std_logic;
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

  for inv_1: inverter use entity work.inverter(structural);
  for and2_1: and2 use entity work.and2(structural);
  for decoder_1: decoder_2_4 use entity decoder_2_4.work(structural);

    signal busy_inv

  begin
    inv_1 : inverter port map (busy, next_state[0]);
    and2_1 : and2 port map (curr_state[0], start, next_state[1]);

    decoder_1 : decoder_2_4 port map (curr_state[1], rd_wr, valid, next_state[4], next_state[3], next_state[5], next_state[2]);

  
end structural;
