-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


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

  component and2
    port (
      input1 : in std_logic;
      input2 : in std_logic;
      output : out std_logic
    );
  end component;

  for xor2_0, xor2_1: xor2 use entity work.xor2(structural);
  for nor2_0: nor2 use entity work.nor2(structural);
  for and2_0: and2 use entity work.and2(structural);

  signal T0, T1, tag_valid: std_logic;

  begin
    xor2_0: xor2 port map (TA0, TB0, T0);
    xor2_1: xor2 port map (TA1, TB1, T1);
    nor2_0: nor2 port map(T0, T1, tag_valid);
    and2_0: and2 port map(tag_valid, valid, output);

end structural;
