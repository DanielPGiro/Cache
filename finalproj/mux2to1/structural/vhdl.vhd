-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of mux2to1 is 

component and2
  port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end component;

component or2
  port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end component;

component inverter
  port (
    input   : in std_logic;
    output   : out std_logic);
end component;

for and2_1, and2_2: and2 use entity work.and2(structural);
for or2_1: or2 use entity work.or2(structural);
for inverter_1: inverter use entity work.inverter(structural);

signal temp1, temp2, B_not: std_logic;

begin

    inverter_1: inverter port map (B, B_not);
    and2_1: and2 port map (S1, B_not, temp1);
    and2_2: and2 port map (S0, B, temp2);
    or2_1: or2 port map (temp1, temp2, Y);

end structural;
