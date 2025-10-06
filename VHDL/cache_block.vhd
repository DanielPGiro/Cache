--
-- Entity: negative edge triggered block (4-byte register)
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
-- There will be four of these in the cache, totaling 16 bytes
--

entity cache_block is
  port(
    byte_0_select : in std_logic;
    byte_1_select : in std_logic;
    byte_2_select : in std_logic;
    byte_3_select : in std_logic;
    clk : in std_logic;
    IE : in std_logic;
    OE : in std_logic;
    valid_enable : in std_logic; -- valid and tag enable are only set high on a read miss
    valid_set : in std_logic;
    tag_enable : in std_logic;
    tag_set : in std_logic_vector(1 downto 0);
    byte_out : out std_logic_vector(7 downto 0);
    valid_out : out std_logic;
    tag_out : out std_logic_vector(1 downto 0)
  );
end cache_block;

architecture structural of cache_block is
  component cache_cell is
    port (
      data_in : in std_logic;
      clk : in std_logic;
      IE : in std_logic;
      OE : in std_logic;
      data_out : out std_logic
    );
  end component;

  component reg is
    port (
      bit_in : in std_logic_vector(7 downto 0);
      clk : in std_logic;
      IE : in std_logic;
      OE : in std_logic;
      bit_out : out std_logic_vector(7 downto 0);
  end component;

  component and2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  for valid, tag_0, tag_1: cache_cell use entity work.cache_cell(structural); -- Set up latches for the valid and tag bits for each block.
  for byte_0, byte_1, byte_2, byte_3: reg use entity work.reg(structural);

  begin
    valid: cache_cell port map (valid_set, clk, valid_enable, OE, valid_out); -- OE may change based on implementation
    tag_0: cache_cell port map (tag_set[0], clk, tag_enable, OE, tag_out[0]);
    tag_1: cache_cell port map(tag_set[1], clk, tag_enable, OE, tag_out[1]);

end structural;
