-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of tx is 

begin
	
  txprocess: process (sel, selnot, input)                 
  begin                           
    if (sel = '1' and selnot = '0') then
      output <= input;
    else
      output <= 'Z';
    end if;
  end process txprocess;        
 
end structural;
