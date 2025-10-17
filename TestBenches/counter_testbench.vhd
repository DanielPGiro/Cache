
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

begin
  
counter_0 : counter port map (clock, reset, Qout);
  
io_process: process
  file infile  : text is in  "counter_test_in.txt";
  file outfile : text is out "counter_test_out.txt";
  variable op1 : std_logic;
  variable buf : line;
    
begin

while not (endfile(infile)) loop
    readline(infile, buf);
    read(buf, op1);
    clock<=op1;

    readline(infile, buf);
    read(buf, op1);
    reset<=op1;

    wait for 10 ns;

    write(buf, string'("--------------"));
    writeline(outfile, buf);

    write(buf, string'("Clk = "));
    write(buf, clock);
    writeline(outfile, buf);

    write(buf, string'("Rst = "));
    write(buf, reset);
    writeline(outfile, buf);

    write(buf, string'("Q = "));
    write(buf, Qout);
    writeline(outfile, buf);

end loop; 
end process io_process;

end test;


