library IEEE;
use IEEE.std_logic_1164.all;

entity tag_comparator is
  port (
    TA0 : in std_logic; -- TA is the tag in the address
    TA1 : in std_logic;
    TB0 : in std_logic; -- TB is the tag in the block index
    TB1 : in std_logic;
    output : out std_logic
  );
end tag_comparator;

architecture structural of tag_comparator is
  component xor2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  component nor2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  for xor2_0, xor2_1: xor2 use entity work.xor2(structural);
  for nor2_0: nor2 use entity work.nor2(structural);

  signal T0, T1: std_logic;

  begin
    xor2_0: xor2 port map (TA0, TB0, T0);
    xor2_1: xor2 port map (TA1, TB1, T1);
    nor2_0: nor2 port map(T0, T1, output);

end structural;
