-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of decoder_2_4 is
  component and3
    port (
      A : in std_logic;
      B : in std_logic;
      C : in std_logic;
      Output : out std_logic
    );
  end component;

  component inverter
    port (
      input : in std_logic;
      output : out std_logic
    );
  end component;

  for and3_1, and3_2, and3_3, and3_4: and3 use entity work.and3(structural);
  for inv_1, inv_2: inverter use entity work.inverter(structural);
  
  signal A0_n, A1_n: std_logic;

  begin

    inv_1 : inverter port map (A0, A0_n);
    inv_2 : inverter port map (A1, A1_n);

    and3_1 : and3 port map (E, A0_n, A1_n, Y0);
    and3_2 : and3 port map (E, A0, A1_n, Y1);
    and3_3 : and3 port map (E, A0_n, A1, Y2);
    and3_4 : and3 port map (E, A0, A1, Y3);

  end structural;
