library IEEE;
library STD;
use IEEE.std_logic_1164.all;

entity decoder_2_4 is
  port (
    E : in std_logic;
    A0 : in std_logic;
    A1 : in std_logic;
    Y0 : out std_logic;
    Y1 : out std_logic;
    Y2 : out std_logic;
    Y3 : out std_logic
  );
end decoder_2_4;

architecture structural of decoder_2_4 is
  component and3
    port (
      A : in std_logic;
      B : in std_logic;
      C : in std_logic;
      Output : out std_logic
    );
  end component;

  component inv
    port (
      A : in std_logic;
      Output : out std_logic
    );
  end component;

  for and3_1, and3_2, and3_3, and3_4: and3 use entity work.and3(structural);
  for inv_1, inv_2: inv use entity work.inv(structural);
  
  signal A0_n, A1_n: std_logic;

  begin

    inv_1 : inv port map (A0, A0_n);
    inv_2 : inv port map (A1, A1_n);

    and3_1 : and3 port map (E, A0_n, A1_n, Y0);
    and3_2 : and3 port map (E, A0, A1_n, Y1);
    and3_3 : and3 port map (E, A0_n, A1, Y2);
    and3_4 : and3 port map (E, A0, A1, Y3);

  end structural;
