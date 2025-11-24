-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


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
    cell_0: cache_cell port map (bit_in(0), clk, IE, OE, bit_out(0));
    cell_1: cache_cell port map (bit_in(1), clk, IE, OE, bit_out(1));
    cell_2: cache_cell port map (bit_in(2), clk, IE, OE, bit_out(2));
    cell_3: cache_cell port map (bit_in(3), clk, IE, OE, bit_out(3));
    cell_4: cache_cell port map (bit_in(4), clk, IE, OE, bit_out(4));
    cell_5: cache_cell port map (bit_in(5), clk, IE, OE, bit_out(5));
    cell_6: cache_cell port map (bit_in(6), clk, IE, OE, bit_out(6));
    cell_7: cache_cell port map (bit_in(7), clk, IE, OE, bit_out(7));

end structural;
