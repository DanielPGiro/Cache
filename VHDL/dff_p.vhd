library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity dff_p is
  port (
    d : in std_logic;
    clk : in std_logic;
    q : out std_logic;
    qbar : out std_logic
  );
end dff_p;

architecture structural of dff_p is

begin
  
  output: process

  begin
    wait until (clk'EVENT and clk = '1');
    q <= d;
    qbar <= not d;
  end process output;

end structural;





