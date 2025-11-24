-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of counter_1_bit is

component inverter
  port (
    input  : in  std_logic;
    output : out std_logic);
end component;

component dff
	port ( 
		d   : in  std_logic;
    	clk : in  std_logic;
        q   : out std_logic;
        qbar: out std_logic
	); 
end component;

component and2 
  port (
    input1	: in  std_logic;
	input2	: in  std_logic;
    output  : out std_logic);
end component;


for inv_0, inv_1: inverter use entity work.inverter(structural);
for dff_0: dff use entity work.dff(structural);
for and2_0: and2 use entity work.and2(structural);

signal rst_bar, Q0_bar	: std_logic;
signal Q_temp: std_logic;

begin

inv_0 : inverter port map (rst, rst_bar);

-- Bit 0 --
inv_1 : inverter port map (Q, Q0_bar);
and2_0: and2 port map (Q0_bar, rst_bar, Q_temp);
dff_0: dff port map (Q_temp, clk, Q);

end structural;
