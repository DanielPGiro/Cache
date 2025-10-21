library IEEE;
library STD;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity cache_mem_test is
end cache_mem_test;

architecture test of cache_mem_test is

  component cache_mem
    port (
      byte_in : in std_logic_vector(7 downto 0);
      CA : in std_logic_vector(3 downto 0);
      tag_set : in std_logic_vector(1 downto 0);
      tag_enable : in std_logic;
      valid_set : in std_logic;
      valid_enable : in std_logic;
      clk : in std_logic;
      IE : in std_logic;
      OE : in std_logic;
      VDD : in std_logic;
      reset : in std_logic;
      byte_out : out std_logic_vector(7 downto 0);
      valid_out : out std_logic;
      tag_out : out std_logic_vector(1 downto 0)
    );
  end component;

  for cache_mem_0: cache_mem use entity work.cache_mem(structural);

  signal byte_in, byte_out : std_logic_vector(7 downto 0);
  signal CA : std_logic_vector(3 downto 0);
  signal tag_set, tag_out : std_logic_vector(1 downto 0);
  signal valid_set, valid_enable, tag_enable, valid_out : std_logic;
  signal clk, reset, VDD : std_logic;
  signal IE, OE : std_logic;

  procedure print_output is
    variable outline: line;

  begin
    write(outline, string'("clk = "));
    write(outline, clk);
    write(outline, string'("reset = "));
    write(outline, reset);
    write(outline, string'("CA = "));
    write(outline, CA);
    write(outline, string'("Byte in = "));
    write(outline, byte_in);
    write(outline, string'("IE = "));
    write(outline, IE);
    write(outline, string'("OE = "));
    write(outline, OE);
    write(outline, string'("byte out = "));
    write(outline, byte_out);
    write(outline, string'("Tag set = "));
    write(outline, tag_set);
    write(outline, string'("Tag enable = "));
    write(outline, tag_enable);
    write(outline, string'("tag out = "));
    write(outline, tag_out);
    write(outline, string'("valid set = "));
    write(outline, valid_set);
    write(outline, string'("valid enable = "));
    write(outline, valid_enable);
    write(outline, string'("valid out = "));
    write(outline, valid_out);
    writeline(output, outline);
  end print_output;

begin
  cache_mem_0: cache_mem port map (byte_in, CA, tag_set, tag_enable, valid_set, valid_enable, clk, IE, OE, VDD, reset, byte_out, valid_out, tag_out);

clock : process
begin
  clk <= '0', '1' after 5 ns;
  wait for 10 ns;
end process clock;

sim_process : process
begin

  reset <= '1';
  VDD <= '1';
  tag_enable <= '0';
  valid_enable <= '0';
  IE <= '0';
  OE <= '0';
  print_output;
  wait until falling_edge(clk);

  reset <= '0';
  print_output;
  wait until falling_edge(clk);

  tag_enable <= '1';
  valid_enable <= '1';
  tag_set <= "11";
  valid_set <= '1';
  CA <= "1010";
  print_output;
  wait until falling_edge(clk);

  tag_enable <= '0';
  valid_enable <= '0';
  byte_in <= "10110011";
  print_output;
  wait until falling_edge(clk);

  IE <= '1';
  print_output;
  wait until falling_edge(clk);

  IE <= '0';
  OE <= '1';
  print_output;
  wait until falling_edge(clk);

  OE <= '0';
  print_output;
  wait until falling_edge(clk);

  CA  <= "1100";
  tag_set <= "10";
  valid_set <= '1';
  print_output;
  wait until falling_edge(clk);

  valid_enable <= '1';
  tag_enable <= '1';
  print_output;
  wait until falling_edge(clk);

  tag_enable <= '0';
  valid_enable <= '0';
  print_output;
  wait until falling_edge(clk);

  CA <= "1000";
  byte_in <= "11001100";
  print_output;
  wait until falling_edge(clk);

  IE <= '1';
  tag_set <= "01";
  tag_enable <= '1';
  print_output;
  wait until falling_edge(clk);

  IE <= '0';
  CA <= "1010";
  OE <= '1';
  tag_enable <= '0';
  print_output;
  wait until falling_edge(clk);

  CA <= "1000";
  print_output;
  wait until falling_edge(clk);

  OE <= '0';
  print_output;
  wait until falling_edge(clk);

  CA <= "1100";
  print_output;
  wait until falling_edge(clk);

  OE <= '1';
  print_output;
  wait until falling_edge(clk);

end process sim_process;

end test;
