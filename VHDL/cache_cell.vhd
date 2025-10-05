
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell is
  port (
    data_in : in std_logic;
    clk : in std_logic;
    rd_wr : in std_logic;
    data_out : in std_logic
  );
end cache_cell;

architecture structural of cache_cell is
  component inverter
    port (
      input : in std_logic;
      output : out std_logic
    );
  end component;

  component Dlatch 
    port (
      d : in std_logic;
      clk : in std_logic;
      q : out std_logic;
      qbar : out std_logic
    );
  end component;

  component dff
    port (
      d : in std_logic;
      clk : in std_logic;
      q : out std_logic;
      qbar : out std_logic
    );
  end component;

  component tx
    port (
      sel : in std_logic;
      selnot : in std_logic;
      input : in std_logic;
      output : out std_logic
    );
  end component;

  for inverter_1: inverter use entity work.inverter(structural);
  for Dlatch_1: Dlatch use entity work.Dlatch(structural);
  for dff_1: dff use entity work.dff(structural);
  for tx_1: tx use entity work.tx(structural);

  signal rd_wr_inv, Dlatch_q, Dlatch_q_bar, dff_q, dff_q_bar: std_logic;

  begin 

    inverter_1: inverter port map (rd_wr, rd_wr_inv);
    Dlatch_1: Dlatch port map (data_in, rd_wr_inv, Dlatch_q, Dlatch_q_bar); -- We want to latch data on a write, which is active low, so we take the inverse.
    dff_1: dff port map(Dlatch_q, clk, dff_q, dff_q_bar); -- for the edge triggered dff, the output changes every clock cycle based on the input, therefore the input into the dff is the output of the dlatch, since the dlatch will maintain the same q value as long as wr is not enabled.

    tx_1: tx port map(rd_wr, rd_wr_inv, dff_q, data_out); -- tx and Dlatch can not be enabled at the same time. 
    -- Sel will go to pmos gate, selnot will go to nmos gate

end structural;

