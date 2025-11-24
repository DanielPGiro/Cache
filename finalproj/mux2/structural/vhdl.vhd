-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of mux2 is 

component mux2to1
  port (
    B   : in std_logic;
    S0   : in std_logic;
    S1  : in std_logic;
    Y : out std_logic
  );
end component;

for mux0, mux1 : mux2to1 use entity work.mux2to1(structural);

begin
  mux0: mux2to1 port map (sel, s0(0), s1(0), y(0));
  mux1: mux2to1 port map (sel, s0(1), s1(1), y(1));
    
end structural;
