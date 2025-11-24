-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of counter_2_bit is

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

component and3
  port (
    input1	: in  std_logic;
	input2	: in  std_logic;
	input3	: in  std_logic;
    output  : out std_logic);
end component;

component xor2
  port (
    input1	: in  std_logic;
	input2	: in  std_logic;
    output  : out std_logic);
end component;



for inv_0, inv_1 : inverter use entity work.inverter(structural);
for dff_0, dff_1: dff use entity work.dff(structural);
for xor2_0: xor2 use entity work.xor2(structural);
for and2_0, and2_1: and2 use entity work.and2(structural);

signal rst_bar, Q0_bar	: std_logic;
signal temp1 	: std_logic;
signal Q_temp  : std_logic_vector (1 downto 0);

begin

inv_0 : inverter port map (rst, rst_bar);

-- Bit 0 --
inv_1 : inverter port map (Q(0), Q0_bar);
and2_0: and2 port map (Q0_bar, rst_bar, Q_temp(0));
dff_0: dff port map (Q_temp(0), clk, Q(0));

-- Bit 1 --
xor2_0: xor2 port map (Q(0), Q(1), temp1);
and2_1: and2 port map (temp1, rst_bar, Q_temp(1));
dff_1: dff port map (Q_temp(1), clk, Q(1));

end structural;
