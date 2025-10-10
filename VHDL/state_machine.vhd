--
-- Entity: negative edge triggered state machine
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--

entity state_machine is
  port( 
    cpu_rd_wrn : in  std_logic;    
    start      : in  std_logic;
    clk        : in  std_logic;
    reset      : in  std_logic;
    Vdd	       : in  std_logic;
    Gnd        : in  std_logic;
    valid      : in std_logic;
    busy       : in std_logic;
    IE         : out std_logic;
    OE         : out std_logic_vector(5 downto 0);
    c
  );
end state_machine;

architecture structural of state_machine is
  component idle
    port (
      start  : in std_logic;
      busy   : in std_logic;
      IE     : out std_logic;
      OE     : out std_logic
    );
  end component;

  component compare
    port (
      valid       : in std_logic;
      cpu_rd_wrn  : in std_logic;
      
    );
  end component;

  component read_miss
    port (
      
    );
  end component;

  component write_miss
    port (
      
    );
  end component;

  component read_hit
    port (
      
    );
  end component;

  component write_hit
    port (
      
    );
  end component;

  component wait_mem
    port (
      
    );
  end component;

  component read_mem
    port (
      
    );
  end component;
  
  begin
    something

end structural;
