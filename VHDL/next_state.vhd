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
    curr_states : in std_logic_vector (8 downto 0);
    next_state : out std_logic_vector (8 downto 0)
  );
end next_state;

architecture structural of next_state is
  component and2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic;
    );
  end component;
  
end structural;
