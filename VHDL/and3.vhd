library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity and3 is
  port (
    A : in std_logic;
    B : in std_logic;
    C : in std_logic;
    Output : out std_logic
  );
end and3;

architecture structural of and3 is
begin
  Output <= A and B and C;

end structural;
