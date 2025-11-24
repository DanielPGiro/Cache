-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of cache_mem is
  component cache_block
    port (
      byte_in : std_logic_vector(7 downto 0);
      byte_0_select : in std_logic;
      byte_1_select : in std_logic;
      byte_2_select : in std_logic;
      byte_3_select : in std_logic;
      clk : in std_logic;
      IE : in std_logic;
      OE : in std_logic;
      reset : in std_logic;
      valid_enable : in std_logic;
      valid_set : in std_logic;
      tag_enable: in std_logic;
      tag_set : in std_logic_vector(1 downto 0);
      tag_valid_out_enable : in std_logic;
      byte_out : out std_logic_vector(7 downto 0);
      valid_out : out std_logic;
      tag_out : out std_logic_vector(1 downto 0)
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

  component and2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  for block_decoder, byte_decoder: decoder_2_4 use entity work.decoder_2_4(structural);
  for block_0, block_1, block_2, block_3: cache_block use entity work.cache_block(structural);
  for and_IE_0, and_IE_1, and_IE_2, and_IE_3, and_OE_0, and_OE_1, and_OE_2, and_OE_3: and2 use entity work.and2(structural);
  for andV_E_0, andV_E_1, andV_E_2, andV_E_3, andT_E_0, andT_E_1, andT_E_2, andT_E_3: and2 use entity work.and2(structural);

  signal block_0_E, block_1_E, block_2_E, block_3_E: std_logic;
  signal byte_0, byte_1, byte_2, byte_3: std_logic;
  signal IE_0, IE_1, IE_2, IE_3, OE_0, OE_1, OE_2, OE_3: std_logic;
  signal V_E_0, V_E_1, V_E_2, V_E_3: std_logic; -- Valid enables
  signal T_E_0, T_E_1, T_E_2, T_E_3: std_logic; -- Tag enables

  begin
    block_decoder: decoder_2_4 port map (VDD, CA(2), CA(3), block_0_E, block_1_E, block_2_E, block_3_E); -- Decodes which block using
    byte_decoder: decoder_2_4 port map (VDD, CA(0), CA(1), byte_0, byte_1, byte_2, byte_3); -- Decode byte using

    and_IE_0: and2 port map (IE, block_0_E, IE_0); -- If input enable is high and the block is selected, we transfer that to the cache_block
    and_IE_1: and2 port map (IE, block_1_E, IE_1);
    and_IE_2: and2 port map (IE, block_2_E, IE_2);
    and_IE_3: and2 port map (IE, block_3_E, IE_3);
    and_OE_0: and2 port map (OE, block_0_E, OE_0);
    and_OE_1: and2 port map (OE, block_1_E, OE_1);
    and_OE_2: and2 port map (OE, block_2_E, OE_2);
    and_OE_3: and2 port map (OE, block_3_E, OE_3); 

    andV_E_0: and2 port map (valid_enable, block_0_E, V_E_0); -- Should only ever be high when changing the tag or valid bits 
    andV_E_1: and2 port map (valid_enable, block_1_E, V_E_1);
    andV_E_2: and2 port map (valid_enable, block_2_E, V_E_2);
    andV_E_3: and2 port map (valid_enable, block_3_E, V_E_3);
    andT_E_0: and2 port map (tag_enable, block_0_E, T_E_0);
    andT_E_1: and2 port map (tag_enable, block_1_E, T_E_1);
    andT_E_2: and2 port map (tag_enable, block_2_E, T_E_2);
    andT_E_3: and2 port map (tag_enable, block_3_E, T_E_3);

    block_0: cache_block port map (byte_in, byte_0, byte_1, byte_2, byte_3, clk, IE_0, OE_0, reset, V_E_0, valid_set, T_E_0, tag_set, block_0_E, byte_out, valid_out, tag_out);

    block_1: cache_block port map (byte_in, byte_0, byte_1, byte_2, byte_3, clk, IE_1, OE_1, reset, V_E_1, valid_set, T_E_1, tag_set, block_1_E, byte_out, valid_out, tag_out);

    block_2: cache_block port map (byte_in, byte_0, byte_1, byte_2, byte_3, clk, IE_2, OE_2, reset, V_E_2, valid_set, T_E_2, tag_set, block_2_E, byte_out, valid_out, tag_out);

    block_3: cache_block port map (byte_in, byte_0, byte_1, byte_2, byte_3, clk, IE_3, OE_3, reset, V_E_3, valid_set, T_E_3, tag_set, block_3_E, byte_out, valid_out, tag_out);


end structural;
