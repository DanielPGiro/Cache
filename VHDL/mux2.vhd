--
-- Entity: Mux2 (2 mux2to1)
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is 
    port(
        sel   : in std_logic;
        s0  : in std_logic_vector(1 downto 0);
        s1  : in std_logic_vector(1 downto 0);
        y  : out std_logic_vector(1 downto 0)
    );
end mux2;

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
