-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of Dlatch is 

 
  
begin
  
  output: process (d,clk)                  

  begin                           
    if clk = '1' then 
    q <= d;
    qbar <= not d ;
 end if; 
 end process output;        
                             
end structural;  
