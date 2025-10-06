--
-- Entity: negative edge triggered registers (reg)
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--

entity reg is
  port (
   bit_0_in : in std_logic; 
   bit_1_in : in std_logic; 
   bit_2_in : in std_logic; 
   bit_3_in : in std_logic; 
   bit_4_in : in std_logic; 
   bit_5_in : in std_logic; 
   bit_6_in : in std_logic; 
   bit_7_in : in std_logic; 
   clk : in std_logic;
   IE : in std_logic;
   OE : in std_logic;
   bit_0_out : out std_logic;
   bit_1_out : out std_logic;
   bit_2_out : out std_logic;
   bit_3_out : out std_logic;
   bit_4_out : out std_logic;
   bit_5_out : out std_logic;
   bit_6_out : out std_logic;
   bit_7_out : out std_logic
  );
end reg;

architecture structural of reg is
  component cache_cell
    port (
      data_in : in std_logic;
      clk : in std_logic;
      IE : in std_logic; -- Input enable, same for every cell
      OE : in std_logic; -- Output enable, same for every cell
      data_out : out std_logic
    );
  end component;

  for cell_0, cell_1, cell_2, cell_3, cell_4, cell_5, cell_6, cell_7: cache_cell use entity work.cache_cell(structural);

  begin
    cell_0: cache_cell port map (bit_0_in, clk, IE, OE, bit_0_out);
    cell_1: cache_cell port map (bit_1_in, clk, IE, OE, bit_1_out);
    cell_2: cache_cell port map (bit_2_in, clk, IE, OE, bit_2_out);
    cell_3: cache_cell port map (bit_3_in, clk, IE, OE, bit_3_out);
    cell_4: cache_cell port map (bit_4_in, clk, IE, OE, bit_4_out);
    cell_5: cache_cell port map (bit_5_in, clk, IE, OE, bit_5_out);
    cell_6: cache_cell port map (bit_6_in, clk, IE, OE, bit_6_out);
    cell_7: cache_cell port map (bit_7_in, clk, IE, OE, bit_7_out);

end structural;



