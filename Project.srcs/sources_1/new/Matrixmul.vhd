---------------------------Processing element to perform matrix multiplication------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity pe is
    Port ( reset : inout std_logic:= '0';
           clk : in STD_LOGIC;
           ina: in integer range 0 to 100;
           inb: in integer range 0 to 100;
           outa, outb,outc : inout  integer range 0 to 100:= 0;
           wrt: out integer
           );
end pe;

architecture Behavioral of pe is

type RAM is array (0 to 11) of integer;
signal ram_a: ram := (others =>0);
signal count: integer;

begin 
process(clk,ina)
begin
    

if rising_edge(clk)  then  
    if reset = '1'then 
      outa<=0;
      outb<=0;
      outc<=0;
      reset <= '0';
    else  
    if count <51 then    ---restrict to 2 matrix multiplications------   
      outc <= outc + ina*inb;
      outa <=ina;
      outb <=inb;  
      count <= count+1;   
     end if;   
    end if;
end if;
end process;
end behavioral;



---------------------------Matrix multiply (top module to do matrix multiplication)----------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity matrixmul is             
    Port (clk : in STD_LOGIC);
end matrixmul;

architecture Behavioral of matrixmul is
component RAMMem is             
    Port ( rst: out std_logic;
           clk : in STD_LOGIC;
           wr : in integer;
           rdA : out integer := 0;
           rdB : out integer := 0;
           wer:in integer);
end component;


component pe is
    Port ( 
           reset : inout std_logic;      
           clk : in STD_LOGIC;
           ina: in integer range 0 to 100:= 0;
           inb: in integer range 0 to 100:= 0;
           outa, outb,outc : inout  integer range 0 to 100:= 0;
           wrt: out integer); 
end component;

component decodeB is
port(clk: in std_logic;
        Dinb: in integer;
        s0,s1,s2,s3 : out integer := 0);

end component;

component decodeA is
port(clk: in std_logic;
        Dina: in integer;
        s0,s1,s2,s3 : out integer := 0);

end component;

signal rama,ramb:integer range 0 to 100 := 0;
signal wr11,wr12,wr13,wr21,wr22,wr23,wr31,wr32,wr33,wr41,wr42,wr43,wers: integer range 0 to 100;
signal outa11,outb11,outc11,outa12,outb12,outc12,outa13,outb13,outc13: integer range 0 to 100 := 0;
signal outa21,outb21,outc21,outa22,outb22,outc22,outa23,outb23,outc23: integer range 0 to 100 := 0;
signal outa31,outb31,outc31,outa32,outb32,outc32,outa33,outb33,outc33: integer range 0 to 100 := 0;
signal outa41,outb41,outc41,outa42,outb42,outc42,outa43,outb43,outc43: integer range 0 to 100 := 0;
signal a1,a2,a3,a4,b1,b2,b3 :integer range 0 to 100 := 0;
signal rstt : std_logic:= '0';
signal write,countm: integer:= 0;
begin 

-------port map all the components --------------
rAM: RAMMem port map(rst => rstt,clk => clk,wr =>write, rdA => rama,rdb=>ramb,wer=>wers);
deca:decodeA port map(clk => clk, Dina =>rama, s0 => a1, s1 => a2,s2 => a3, s3 => a4);
decb:decodeB port map(clk => clk, Dinb =>ramb, s0 => b1, s1 => b2,s2 => b3);
pe1: pe port map(reset => rstt ,clk=> clk ,ina =>a1,inb=>b1 ,outa=>outa11,outb=>outb11,outc=>outc11);
pe2: pe port map(reset => rstt,clk =>clk,ina =>outa11,inb =>b2,outa => outa12,outb =>outb12, outc =>outc12);
pe3: pe port map(reset => rstt,clk =>clk,ina =>outa12,inb =>b3,outa => outa13,outb =>outb13,outc =>outc13);
pe4: pe port map(reset => rstt,clk =>clk,ina =>a2,inb =>outb11,outa =>outa21,outb =>outb21,outc =>outc21);
pe5: pe port map(reset => rstt,clk =>clk,ina =>outa21,inb =>outb12,outa =>outa22,outb =>outb22,outc =>outc22);
pe6: pe port map(reset => rstt,clk =>clk,ina =>outa22,inb =>outb13,outa =>outa23,outb =>outb23,outc =>outc23);
pe7: pe port map(reset => rstt,clk =>clk,ina =>a3,inb =>outb21,outa =>outa31,outb =>outb31,outc =>outc31);
pe8: pe port map(reset => rstt,clk =>clk,ina =>outa31,inb =>outb22,outa =>outa32,outb =>outb32,outc =>outc32);
pe9: pe port map(reset => rstt,clk =>clk,ina =>outa32,inb =>outb23,outa =>outa33,outb =>outb33,outc =>outc33);
pe10: pe port map(reset => rstt,clk =>clk,ina =>a4,inb =>outb31,outa =>outa41,outb =>outb41,outc =>outc41);
pe11: pe port map(reset => rstt,clk =>clk,ina =>outa41,inb =>outb32,outa =>outa42,outb =>outb42,outc =>outc42);
pe12: pe port map(reset => rstt,clk =>clk,ina =>outa42,inb =>outb33,outa =>outa43,outb =>outb43,outc =>outc43);

--------Process to transfer output data to RAM---------------------
process(clk)
begin

if(rising_edge(clk))then
countm <= countm +1;
if countm = 19 or countm= 39 then  ---- o/p value of c after every 19 clk cycles ----
write <= outc11;
elsif countm = 20 or countm = 40 then
write <= outc12;
elsif countm = 21 or countm = 41  then
write <= outc21;
elsif countm = 22  or countm = 42 then
write <= outc13;
elsif countm = 23 or countm = 43 then
write <= outc22;
elsif countm = 24 or countm = 44 then
write <= outc31;
elsif countm = 25 or countm = 45 then
write <= outc23;
elsif countm = 26 or countm = 46 then
write <= outc32;
elsif countm =27 or countm = 47 then
write<= outc41;
elsif countm =28 or countm = 48 then
write <= outc33;
elsif countm = 29 or countm = 49 then
write <= outc42;
elsif countm =30 or countm = 50 then
write<= outc43;



end if;
end if;

end process;
end behavioral;
