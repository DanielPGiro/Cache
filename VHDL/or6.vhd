library IEEE:
library STD;
use IEEE.std_logic_1164.all;

entity or6 is
  port (
      input1 : in std_logic;
      input2 : in std_logic;
      input3 : in std_logic;
      input4 : in std_logic;
      input5 : in std_logic;
      input6 : in std_logic;
      output : out std_logic
    );
end or6;

architecture structural of or6 is
begin
  output <= input1 or input2 or input3 or input4 or input5 or input6;

end structural;
