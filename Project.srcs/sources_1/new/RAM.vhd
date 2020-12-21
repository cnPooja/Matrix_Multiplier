---------Decoder logic to synchronize data transfer(Matrix A elements)  between RAM generator and matrix multiplier----------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decodeA is

 port(  clk: in std_logic;
        Dina: in integer;
        s0,s1,s2,s3 : out integer := 0);

end decodeA;

architecture bhv of decodeA is
signal count: integer:= 0;
begin
process (clk) is
begin

  if rising_edge(clk)then
  count <=count+1;
  
   ----Output row wise elements of matrix a for every clk cycle ------------------
  for i in 0 to 30 loop
  if (count = 1+4*i) then
      s0 <= Dina;
      s1 <= 0;
      s2 <= 0;
      s3 <= 0;
  elsif (count = 2+4*i) then
      s0 <=0;
      s1 <= Dina;
      s2 <= 0;
      s3 <= 0;
  elsif (count = 3+4*i) then
      s0 <=0;
      s1 <= 0;
      s2 <= Dina;
      s3 <= 0;
   elsif(count = 4+4*i) then
      s0 <=0;
      s1 <= 0;
      s2 <= 0;
      s3 <= Dina;
  end if;
  end loop;
  end if;
end process;

end bhv;

---------Decoder logic to synchronize data transfer(Matrix A elements)  between RAM generator and matrix multiplier----------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decodeB is
port(clk: in std_logic;
        Dinb: in integer;
        s0,s1,s2,s3 : out integer := 0);

end decodeB;

architecture bhv of decodeB is
signal count: integer:= 0;
begin
process (clk) is
begin

  if rising_edge(clk)then
  count <=count+1;
  
  ----Output row wise elements of matrix b for every clk cycle ------------------
  for i in 0 to 30 loop
  if (count = 1+4*i) then
      s0 <= Dinb;
      s1 <= 0;
      s2 <= 0;
      s3 <= 0;
  elsif (count = 2+4*i) then
      s0 <=0;
      s1 <= Dinb;
      s2 <= 0;
      s3 <= 0;
  elsif (count = 3+4*i) then
      s0 <=0;
      s1 <= 0;
      s2 <= Dinb;
      s3 <= 0;
   elsif(count = 4+4*i) then
      s0 <=0;
      s1 <= 0;
      s2 <= 0;
      s3 <= 0;
  end if;
  end loop;
  end if;
end process;

end bhv;

