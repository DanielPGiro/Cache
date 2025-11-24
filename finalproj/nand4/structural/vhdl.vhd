-- Created by @(#)$CDS: vhdlin version IC23.1-64b 06/21/2023 09:20 (cpgbld16) $
-- on Mon Nov  3 12:21:32 2025


architecture structural of nand4 is

begin
  output <= not (input1 and input2 and input3 and input4);

end structural;
