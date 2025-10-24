library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity or7 is
  port (
      input1 : in std_logic;
      input2 : in std_logic;
      input3 : in std_logic;
      input4 : in std_logic;
      input5 : in std_logic;
      input6 : in std_logic;
      input7 : in std_logic;
      output : out std_logic
    );
end or7;

architecture structural of or7 is
begin
  output <= input1 or input2 or input3 or input4 or input5 or input6 or input7;

end structural;
