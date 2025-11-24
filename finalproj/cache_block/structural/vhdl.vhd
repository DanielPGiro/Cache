-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of cache_block is
  component cache_cell
    port (
      data_in : in std_logic;
      clk : in std_logic;
      IE : in std_logic;
      OE : in std_logic;
      data_out : out std_logic
    );
  end component;

  component reg
    port (
      bit_in : in std_logic_vector(7 downto 0);
      clk : in std_logic;
      IE : in std_logic;
      OE : in std_logic;
      bit_out : out std_logic_vector(7 downto 0)
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

  component inverter
    port (
      input : in std_logic;
      output : out std_logic
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

  for valid, tag_0, tag_1: cache_cell use entity work.cache_cell(structural); -- Set up latches for the valid and tag bits for each block.
  for byte_0, byte_1, byte_2, byte_3: reg use entity work.reg(structural);
  for and_IE_0, and_IE_1, and_IE_2, and_IE_3, and_OE_0, and_OE_1, and_OE_2, and_OE_3: and2 use entity work.and2(structural);
  for or2_0: or2 use entity work.or2(structural);
  for inverter_0: inverter use entity work.inverter(structural);

  for tx_valid, tx_reset: tx use entity work.tx(structural);

  signal IE_0, IE_1, IE_2, IE_3, OE_0, OE_1, OE_2, OE_3, valid_reset_enable, reset_inv, valid_reset_set: std_logic;

  begin
    inverter_0: inverter port map (reset, reset_inv); -- Inverts reset signal

    tx_reset: tx port map (reset, reset_inv, reset_inv, valid_reset_set); -- Allows reset_inv (0) thorugh to valid_set when reset is 1
    tx_valid: tx port map (reset_inv, reset, valid_set, valid_reset_set); -- When reset is 0, allows valid_set through 

    or2_0: or2 port map (reset, valid_enable, valid_reset_enable);

    valid: cache_cell port map (valid_reset_set, clk, valid_reset_enable, tag_valid_out_enable, valid_out);
    tag_0: cache_cell port map (tag_set(0), clk, tag_enable, tag_valid_out_enable, tag_out(0));
    tag_1: cache_cell port map (tag_set(1), clk, tag_enable, tag_valid_out_enable, tag_out(1));

    and_IE_0: and2 port map (IE, byte_0_select, IE_0);
    and_IE_1: and2 port map (IE, byte_1_select, IE_1);
    and_IE_2: and2 port map (IE, byte_2_select, IE_2);
    and_IE_3: and2 port map (IE, byte_3_select, IE_3);
    and_OE_0: and2 port map (OE, byte_0_select, OE_0);
    and_OE_1: and2 port map (OE, byte_1_select, OE_1);
    and_OE_2: and2 port map (OE, byte_2_select, OE_2);
    and_OE_3: and2 port map (OE, byte_3_select, OE_3);

    byte_0: reg port map (byte_in, clk, IE_0, OE_0, byte_out);
    byte_1: reg port map (byte_in, clk, IE_1, OE_1, byte_out);
    byte_2: reg port map (byte_in, clk, IE_2, OE_2, byte_out);
    byte_3: reg port map (byte_in, clk, IE_3, OE_3, byte_out);

end structural;
