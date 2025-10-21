--
-- Entity: negative edge triggered cache memory (cache_mem)
-- Architecture: structural
-- Author: Daniel Giro, Ian Lane

library IEEE;
library STD;
use IEEE.std_logic_1164.all;


entity current_state is
  port (
    start       : in std_logic;
    busy        : in std_logic;
    clk         : in std_logic;
    Vdd         : in std_logic;
    Gnd         : in std_logic;
    latch_state : in std_logic_vector(8 downto 0);
    curr_state  : out std_logic_vector(8 downto 0);
    IE          : out std_logic;
    OE          : out std_logic
  );
end current_state;

architecture structural of current_state is
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

  component dff
    port (
      d   : in std_logic;
      clk : in std_logic;
      q   : out std_logic;
      qbar: out std_logic
    );

  for dff_0, dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8: dff use entity work.dff(structural);
  for and_0, and_1, and_2, and_3, and_4, and_5, and_6, and_7, and_8: and2 use entity work.and2(structural);
  for and_0i, and_1i, and_2i, and_3i, and_4i, and_5i, and_6i, and_7i, and_8i: and2 use entity work.and2(structural);

  signal state0, state1, state2, state3, state4, state5, state6, state7, state8: std_logic;
  signal qbar0, qbar1, qbar2, qbar3, qbar4, qbar5, qbar6, qbar7, qbar8: std_logic;


  --NOTE: Start and busy inputs have not been used yet--
  begin
    -- Latch all bits for the state
    dff_0 : dff port map (latch_state(0), clk, curr_state(0), qbar0); 
    dff_1 : dff port map (latch_state(1), clk, curr_state(1), qbar1); 
    dff_2 : dff port map (latch_state(2), clk, curr_state(2), qbar2); 
    dff_3 : dff port map (latch_state(3), clk, curr_state(3), qbar3); 
    dff_4 : dff port map (latch_state(4), clk, curr_state(4), qbar4); 
    dff_5 : dff port map (latch_state(5), clk, curr_state(5), qbar5); 
    dff_6 : dff port map (latch_state(6), clk, curr_state(6), qbar6); 
    dff_7 : dff port map (latch_state(7), clk, curr_state(7), qbar7); 
    dff_8 : dff port map (latch_state(8), clk, curr_state(8), qbar8); 

    -- Control Signals (OE and IE) for each state
    -- Idle
    and_0 : and2 port map (Gnd, latch_state(0), OE);
    and_0i : and2 port map (Gnd, latch_state(0), IE);

    -- Latch
    and_1 : and2 port map (Gnd, latch_state(1), OE);
    and_1i : and2 port map (Gnd, latch_state(1), IE);
    
    -- Read Hit
    and_2 : and2 port map (Vdd, latch_state(2), OE);
    and_2i : and2 port map (Gnd, latch_state(2), IE);
    
    -- Write Hit
    and_3 : and2 port map (Gnd, latch_state(3), OE);
    and_3i : and2 port map (Vdd, latch_state(3), IE);

    -- Write Miss
    and_4 : and2 port map (Gnd, latch_state(4), OE);
    and_4i : and2 port map (Vdd, latch_state(4), IE);

    -- Read Miss
    and_5 : and2 port map (Vdd, latch_state(5), OE);
    and_5i : and2 port map (Gnd, latch_state(5), IE);

    -- Wait for Memory
    and_6 : and2 port map (Gnd, latch_state(6), OE);
    and_6i : and2 port map (Gnd, latch_state(6), IE);

    -- Write to Memory
    and_7 : and2 port map (Gnd, latch_state(7), OE);
    and_7i : and2 port map (Vdd, latch_state(7), IE);

    -- Read from Memory
    and_8 : and2 port map (Vdd, latch_state(8), OE);
    and_8i : and2 port map (Gnd, latch_state(8), IE);

end structural;
