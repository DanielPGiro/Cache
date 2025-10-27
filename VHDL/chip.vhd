--
-- Entity: negative edge triggered Chip
-- Architecture : structural
-- Author: Daniel Giro, Ian Lane
--

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;

entity chip is
    port (
      cpu_add    : in  std_logic_vector(5 downto 0); 
      cpu_data   : inout  std_logic_vector(7 downto 0);
      cpu_rd_wrn : in  std_logic;    
      start      : in  std_logic;
      clk        : in  std_logic;
      reset      : in  std_logic;
      mem_data   : in  std_logic_vector(7 downto 0);
      Vdd	     : in  std_logic;
      Gnd        : in  std_logic;
      busy       : out std_logic;
      mem_en     : out std_logic;
      --OE         : out std_logic;
      --byte_out   : out std_logic_vector(7 downto 0);
      --states     : out std_logic_vector(8 downto 0);
      --CA_4_0 : out std_logic_vector(3 downto 0);
      --Ie : out std_logic;
      mem_add    : out std_logic_vector(5 downto 0)
    );
end chip;

architecture structural of chip is
    component state_machine
        port (
            cpu_rd_wrn : in  std_logic;    
            cpu_add    : in std_logic_vector(5 downto 0);  -- for tag
            start      : in  std_logic;
            clk        : in  std_logic;
            reset      : in  std_logic;
            Vdd	       : in  std_logic;
            Gnd        : in  std_logic;
            valid      : in std_logic;
            busy_in    : in std_logic;
            latch_enable : out std_logic;
            tag_enable : out std_logic;
            valid_enable : out std_logic;
            CD_MD        : out std_logic;
            mem_enable  : out std_logic;
            MA         : out std_logic_vector(1 downto 0);
            --states : out std_logic_vector (8 downto 0);
            MA_select  : out std_logic;
            busy_out   : out std_logic;
            IE         : out std_logic;
            OE         : out std_logic        
        );
    end component;
    

    component cache_mem
        port (
            byte_in : in std_logic_vector(7 downto 0); -- Mem for write
            CA : in std_logic_vector(3 downto 0); -- for block/byte decode
            tag_set : in std_logic_vector(1 downto 0); -- Data for new tag
            tag_enable : in std_logic; -- High for tag change
            valid_set : in std_logic; 
            valid_enable : in std_logic;
            clk : in std_logic;
            IE : in std_logic; -- Controlled by state machine, mapped to every reg
            OE : in std_logic;
            VDD : in std_logic;
            reset : in std_logic;
            byte_out : out std_logic_vector(7 downto 0); -- For read
            valid_out : out std_logic;
            tag_out : out std_logic_vector(1 downto 0)
        );
    end component;


    component cache_cell 
      port (
            data_in : in std_logic;
            clk : in std_logic;
            IE : in std_logic; -- Input enable
            OE : in std_logic; -- Output enable
            data_out : out std_logic
         );
      end component;


    component mux8 
        port (
            sel : in std_logic;
            s0: in std_logic_vector(7 downto 0);
            s1: in std_logic_vector(7 downto 0);
            y : out std_logic_vector(7 downto 0)
          );
    end component; 


    component mux2 
        port (
            sel : in std_logic;
            s0: in std_logic_vector(1 downto 0);
            s1: in std_logic_vector(1 downto 0);
            y : out std_logic_vector(1 downto 0)
          );
    end component; 


   

        -- Cpu address --
    component dff                       
      port ( 
        d   : in  std_logic;
        clk : in  std_logic;
        q   : out std_logic;
        qbar: out std_logic
      ); 
    end component;
        
    
    component tag_comparator 
      port (
        TA0 : in std_logic; -- TA is the tag in the address
        TA1 : in std_logic;
        TB0 : in std_logic; -- TB is the tag in the block index
        TB1 : in std_logic;
        valid : in std_logic;
        output : out std_logic
      );
    end component;

    component reg
      port (
        bit_in : in std_logic_vector(7 downto 0);
        clk : in std_logic;
        IE : in std_logic;
        OE : in std_logic;
        bit_out : out std_logic_vector(7 downto 0)
      );
    end component;

    component tx
      port (
        sel : in std_logic;
        selnot : in std_logic;
        input : in std_logic;
        output : out std_logic
      );
    end component;

    component inverter
      port (
        input : in std_logic;
        output : out std_logic
      );
    end component;
 
    -- Instantiate components --
    for sm: state_machine use entity work.state_machine(structural);
    for cmem: cache_mem use entity work.cache_mem(structural);
    for mux0: mux8 use entity work.mux8(structural);
    for mux2_0: mux2 use entity work.mux2(structural);
    for tag0: tag_comparator use entity work.tag_comparator(structural);
    for dff0: dff use entity work.dff(structural);
    for cache_cell0, cache_cell1, cache_cell2, cache_cell3, cache_cell4, cache_cell5, cache_cell6: cache_cell use entity work.cache_cell(structural);
    for reg_1 : reg use entity work.reg(structural);

    for inv_1 : inverter use entity work.inverter(structural);
    for tx_0, tx_1, tx_2, tx_3, tx_4, tx_5: tx use entity work.tx(structural);

    -- Signals --
    signal mux8_out, cmem_byte, cc_data: std_logic_vector(7 downto 0);
    signal cc_add: std_logic_vector(5 downto 0);  -- latched cpu address
    signal ca_4: std_logic_vector(3 downto 0);  -- cpu address
    signal state_ma, cmem_tag, mux2_out: std_logic_vector(1 downto 0);
    signal state_tag_en, state_valid_en, state_cd_md, state_mem_en, state_latch_en, state_ma_sel, state_IE, state_OE, state_bsy_in, state_bsy_out: std_logic;   -- state machine signals
    signal cmem_valid, tag_out, cc_rw: std_logic;  -- cache signals
    signal dummy, mem_enable_inv: std_logic;
        
    begin 
        -- State machine and Cache memory mapping --
        sm: state_machine port map (cc_rw, cc_add, start, clk, reset, Vdd, Gnd, tag_out, state_bsy_in, state_latch_en, state_tag_en, state_valid_en, state_cd_md, state_mem_en, state_ma, state_ma_sel, state_bsy_out, state_IE, state_OE);
        cmem: cache_mem port map (mux8_out, ca_4, cc_add(5 downto 4), state_tag_en, Vdd, state_valid_en, clk, state_IE, state_OE, Vdd, reset, cmem_byte, cmem_valid, cmem_tag);

        inv_1 : inverter port map (state_mem_en, mem_enable_inv);
        tx_0 : tx port map (state_mem_en, mem_enable_inv, cc_add(0), mem_add(0));
        tx_1 : tx port map (state_mem_en, mem_enable_inv, cc_add(1), mem_add(1));
        tx_2 : tx port map (state_mem_en, mem_enable_inv, cc_add(2), mem_add(2));
        tx_3 : tx port map (state_mem_en, mem_enable_inv, cc_add(3), mem_add(3));
        tx_4 : tx port map (state_mem_en, mem_enable_inv, cc_add(4), mem_add(4));
        tx_5 : tx port map (state_mem_en, mem_enable_inv, cc_add(5), mem_add(5));


        -- Latch CPU Address and the Read/Write -- 
        cache_cell0: cache_cell port map (cpu_add(0), clk, state_latch_en, Vdd, cc_add(0));  -- cpu address latching
        cache_cell1: cache_cell port map (cpu_add(1), clk, state_latch_en, Vdd, cc_add(1));
        cache_cell2: cache_cell port map (cpu_add(2), clk, state_latch_en, Vdd, cc_add(2));
        cache_cell3: cache_cell port map (cpu_add(3), clk, state_latch_en, Vdd, cc_add(3));
        cache_cell4: cache_cell port map (cpu_add(4), clk, state_latch_en, Vdd, cc_add(4));
        cache_cell5: cache_cell port map (cpu_add(5), clk, state_latch_en, Vdd, cc_add(5));
        cache_cell6: cache_cell port map (cpu_rd_wrn, clk, state_latch_en, Vdd, cc_rw);  -- latch read/write

        reg_1 : reg port map (cpu_data, clk, state_latch_en, VDD, cc_data);

        -- Smaller component mapping --
        mux0: mux8 port map (state_cd_md, cc_data, mem_data, mux8_out);  -- mux for 2 8-bit input vectors
        mux2_0: mux2 port map (state_ma_sel, state_ma, cc_add(1 downto 0),  mux2_out);  -- mux for 2 2-bit input vectors
        tag0: tag_comparator port map (cc_add(4), cc_add(5), cmem_tag(0), cmem_tag(1), cmem_valid, tag_out);  --tag comparator
        dff0: dff port map (state_bsy_out, clk, state_bsy_in, dummy);  -- latch busy

        -- Cpu address --
        ca_4(3 downto 2) <= cc_add(3 downto 2);
        ca_4(1 downto 0) <= mux2_out;

        busy <= state_bsy_in;
        cpu_data <= cmem_byte;
        --mem_add <= cc_add;
        mem_en <= state_mem_en;
        --OE <= state_OE;
        --byte_out <= cmem_byte;
        --CA_4_0 <= ca_4;
        --IE <= state_IE;
end structural;
