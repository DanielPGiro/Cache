--
-- Entity: Mux8 (8 mux2to1)
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux8 is 
    port(
        sel   : in std_logic;
        s0  : in std_logic_vector(7 downto 0);
        s1  : in std_logic_vector(7 downto 0);
        y  : out std_logic_vector(7 downto 0);
    );
end mux8;

architecture structural of mux8 is 

component mux2to1
  port (
    B   : in std_logic;
    S0   : in std_logic;
    S1  : in std_logic;
    Y : out std_logic
  );
end component;

for mux0, mux1, mux2, mux3, mux4, mux5, mux6, mux7: mux2to1 use entity work.mux2to1(structural);

begin
  mux0: mux2to1 port map (sel, s0(0), s1(0), y(0));
  mux1: mux2to1 port map (sel, s0(1), s1(1), y(1));
  mux2: mux2to1 port map (sel, s0(2), s1(2), y(2));
  mux3: mux2to1 port map (sel, s0(3), s1(3), y(3));
  mux4: mux2to1 port map (sel, s0(4), s1(4), y(4));
  mux5: mux2to1 port map (sel, s0(5), s1(5), y(5));
  mux6: mux2to1 port map (sel, s0(6), s1(6), y(6));
  mux7: mux2to1 port map (sel, s0(7), s1(7), y(7));
    
end structural
