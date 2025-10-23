--
-- Entity: negative edge triggered cache memory (cache_mem)
-- Architecture: structural
-- Author: Daniel Giro, Ian Lane

library IEEE;
library STD;
use IEEE.std_logic_1164.all;


entity current_state is
  port (
    clk : in std_logic;
    gnd : in std_logic;
    vdd : in std_logic;
    reset : in std_logic;
    latch_state : in std_logic_vector(8 downto 0);
    curr_state  : out std_logic_vector(8 downto 0)
  );
end current_state;

architecture structural of current_state is
  
  component dff
    port (
      d   : in std_logic;
      clk : in std_logic;
      q   : out std_logic;
      qbar: out std_logic
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

  for dff_0, dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8: dff use entity work.dff(structural);
  for mux_0, mux_1, mux_2, mux_3, mux_4, mux_5, mux_6, mux_7, mux_8: mux2to1 use entity work.mux2to1(structural);

  signal state0, state1, state2, state3, state4, state5, state6, state7, state8: std_logic;
  signal qbar0, qbar1, qbar2, qbar3, qbar4, qbar5, qbar6, qbar7, qbar8: std_logic;
  signal I0, I1, I2, I3, I4, I5, I6, I7, I8 : std_logic;


  --NOTE: Start and busy inputs have not been used yet--
  begin
    -- Reset logic
    mux_0 : mux2to1 port map (reset, vdd, latch_state(0), I0);
    mux_1 : mux2to1 port map (reset, gnd, latch_state(1), I1);
    mux_2 : mux2to1 port map (reset, gnd, latch_state(2), I2);
    mux_3 : mux2to1 port map (reset, gnd, latch_state(3), I3);
    mux_4 : mux2to1 port map (reset, gnd, latch_state(4), I4);
    mux_5 : mux2to1 port map (reset, gnd, latch_state(5), I5);
    mux_6 : mux2to1 port map (reset, gnd, latch_state(6), I6);
    mux_7 : mux2to1 port map (reset, gnd, latch_state(7), I7);
    mux_8 : mux2to1 port map (reset, gnd, latch_state(8), I8);

    -- Latch all bits for the state
    dff_0 : dff port map (I0, clk, curr_state(0), qbar0); 
    dff_1 : dff port map (I1, clk, curr_state(1), qbar1); 
    dff_2 : dff port map (I2, clk, curr_state(2), qbar2); 
    dff_3 : dff port map (I3, clk, curr_state(3), qbar3); 
    dff_4 : dff port map (I4, clk, curr_state(4), qbar4); 
    dff_5 : dff port map (I5, clk, curr_state(5), qbar5); 
    dff_6 : dff port map (I6, clk, curr_state(6), qbar6); 
    dff_7 : dff port map (I7, clk, curr_state(7), qbar7); 
    dff_8 : dff port map (I8, clk, curr_state(8), qbar8); 

    -- Control Signals (OE and IE) for each state
    -- Idle

end structural;
