library IEEE;
library STD;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity state_machine_tb is
end state_machine_tb;

architecture test of state_machine_tb is
  component state_machine
    port (
      cpu_rd_wrn : in  std_logic;    
      cpu_add    : in std_logic_vector(5 downto 0);  -- for tag
      start      : in  std_logic;
      clk        : in  std_logic;
      reset      : in  std_logic;
      Vdd	       : in  std_logic;
      Gnd        : in  std_logic;
      valid      : in std_logic;
      busy_in    : in std_logic;
      latch_enable : out std_logic;
      tag_enable : out std_logic;
      valid_enable : out std_logic;
      CD_MD      : out std_logic; -- High we access cpu data low we access memory data
      mem_enable : out std_logic;
      MA         : out std_logic_vector(1 downto 0);
      MA_select  : out std_logic; -- When 1, MA goes through, when 0, CA goes through
      busy_out   : out std_logic;
      IE         : out std_logic;
      OE         : out std_logic
    );
  end component;

  for state_machine_0: state_machine use entity work.state_machine(structural);



  signal start, clk, reset, vdd, gnd, rd_wr, valid, busy_in, latch_enable, tag_enable, valid_enable, CD_MD, mem_enable, MA_select, busy_out, IE, OE : std_logic;
  signal MA : std_logic_vector(1 downto 0);
  signal CA : std_logic_vector(5 downto 0);

  procedure print_output is
    variable outline: line;

  begin
    write(outline, string'("clk = "));
    write(outline, clk);
    write(outline, string'("reset = "));
    write(outline, reset);
    write(outline, string'("start = "));
    write(outline, start);
    write(outline, string'("CA = "));
    write(outline, CA);
    write(outline, string'("rd_wr = "));
    write(outline, rd_wr);
    write(outline, string'("busy in = "));
    write(outline, busy_in);
    write(outline, string'("valid = "));
    write(outline, valid);
    write(outline, string'("busy out = "));
    write(outline, busy_out);
    write(outline, string'("latch enalbe = "));
    write(outline, latch_enable);
    write(outline, string'("tag_enable = "));
    write(outline, tag_enable);
    write(outline, string'("valid enable = "));
    write(outline, valid_enable);
    write(outline, string'("CD_MD = "));
    write(outline, CD_MD);
    write(outline, string'("mem enable = "));
    write(outline, mem_enable);
    write(outline, string'("MA select = "));
    write(outline, MA_select);
    write(outline, string'("MA = "));
    write(outline, MA);
    write(outline, string'("IE = "));
    write(outline, IE);
    write(outline, string'("OE = "));
    write(outline, OE);
    writeline(output, outline);
  end print_output;

begin
  state_machine_0: state_machine port map (rd_wr, CA, start, clk, reset, vdd, gnd, valid, busy_in, latch_enable, tag_enable, valid_enable, CD_MD, mem_enable, MA, MA_select, busy_out, IE, OE);

clock : process
begin
  clk <= '0', '1' after 5 ns;
  wait for 10 ns;
end process clock;

sim_process : process 
begin
  
  vdd <= '1';
  gnd <= '0';
  start <= '0';
  reset <= '1';
  CA <= "111000";
  -- busy_in <= busy_out; -- probably wont work
  busy_in <= '0';
  print_output;
  wait until falling_edge(clk);

  reset <= '0';
  print_output;
  wait until falling_edge(clk);

  start <= '1';
  print_output;
  wait until rising_edge(clk);

  rd_wr <= '1'; -- read hit
  valid <= '1';
  busy_in <= '1';
  wait until falling_edge(clk);

  start <= '0';
  print_output;
  wait until rising_edge(clk);

  busy_in <= '0';
  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk);

  start <= '1';
  print_output;
  wait until rising_edge(clk);

  rd_wr <= '0'; -- write hit
  valid <= '1';
  busy_in <= '1';
  print_output;
  wait until falling_edge(clk);

  start <= '0';
  print_output;
  wait until rising_edge(clk);
  
  print_output;
  wait until falling_edge(clk);

  busy_in <= '0';
  print_output;
  wait until falling_edge(clk);

  start <= '1';
  print_output;
  wait until rising_edge(clk);

  rd_wr <= '0'; -- write miss
  valid <= '0';
  wait until falling_edge(clk);

  start <= '0';
  wait until rising_edge(clk);

  print_output;
  wait until falling_edge(clk);

  busy_in <= '0';
  print_output;
  wait until falling_edge(clk);

  start <= '1';
  print_output;
  wait until rising_edge(clk);

  rd_wr <= '1'; -- read miss
  valid <= '0';
  busy_in <= '1';
  print_output;
  wait until falling_edge(clk);

  start <= '0';
  print_output;
  wait until rising_edge(clk);

  print_output;
  wait until falling_edge(clk); -- mem enable should go high

  print_output;
  wait until falling_edge(clk); -- mem enable should go low

  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk);

  print_output;
  wait until falling_edge(clk); -- Should end mem wait 

  print_output;
  wait until falling_edge(clk); -- IE High

  print_output;
  wait until falling_edge(clk); -- IE low

  print_output;
  wait until falling_edge(clk); -- IE high

  print_output;
  wait until falling_edge(clk); -- IE low

  print_output;
  wait until falling_edge(clk); -- IE high

  print_output;
  wait until falling_edge(clk); -- IE low

  print_output;
  wait until falling_edge(clk); -- IE high

  print_output;
  wait until falling_edge(clk); -- IE low

  print_output;
  busy_in <= '0';
  wait until falling_edge(clk); -- OE high

  print_output;
  wait until falling_edge(clk); -- OE low


end process sim_process;
end test;








