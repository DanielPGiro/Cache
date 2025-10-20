library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity nand4 is
  port (
    input1 : in std_logic;
    input2 : in std_logic;
    input3 : in std_logic;
    input4 : in std_logic;
    output : out std_logic
  );
end nand4

architecture structural of nand4 is

begin
  output <= input1 nand input2 nand input3 nand input4;

end structural;
