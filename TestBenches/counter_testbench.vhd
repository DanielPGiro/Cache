-- Input
-- Line 1: clk
-- Line 2: rst

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
  
entity counter_test is
end counter_test;
  
architecture test of counter_test is

  component counter
    port (
      clk     : in  std_logic;
      rst		: in  std_logic;
      Q       : inout std_logic_vector(3 downto 0));
  end component;
  
  for counter_0 : counter use entity work.counter(structural);
  
  signal Qout : std_logic_vector(3 downto 0);
  signal reset, clock : std_logic;
  
  procedure print_output is
    variable outline: line;
  
  begin
    write(outline, string'("Clk = "));
    write(outline, clk);
    write(outline, string'("Reset = "));
    write(outline, reset);
    write(outline, string'("Q = "));
    write(outline, Qout);
  end print_output;

begin
  counter_0 : counter port map (clock, reset, Qout);
  clk : process
  begin
    clock <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process clk;
    
  sim_process: process
  begin
    reset <= '1';
    wait for 1 ns;
    print_output;
    wait until falling_edge(clock);
    reset <= '0';
    wait until falling_edge(clock);
    print_output;
    wait until falling_edge(clock);
    print_output;
    wait until falling_edge(clock);
    print_output;
    wait until falling_edge(clock);
    print_output;
    wait until falling_edge(clock);
    print_output;
  end process sim_process;
end test;


