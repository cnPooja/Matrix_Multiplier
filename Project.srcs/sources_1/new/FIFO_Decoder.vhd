

---------------------------FIFO decoder ----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity FIFO_decode is             
    Port (count:inout integer range 0 to 100:= 0;
    clk: in std_logic;
    
           DinA : in integer range 0 to 100:= 0;
           DinB : in integer range 0 to 100:= 0;
           OutAC11 : out integer range 0 to 100;
           OutAc21: out integer range 0 to 100;
           OutAc31: out integer range 0 to 100; 
           OutAc41: out integer range 0 to 100;  
           Outbc11: out integer range 0 to 100;
           Outbc12: out integer range 0 to 100;
           Outbc13: out integer range 0 to 100);
          -- push:inout integer);
end FIFO_decode;



architecture Behavioral of FIFO_decode is

signal p,dinax: integer:= 0;
signal count1: integer := 0; 
begin

process(clk) 
begin
    --dinax <= dina;
--if(DinAx /= dina) then
  if rising_edge(clk)then   
--    if p = 0 then
--        count <= 0;
--        p<= 1;
--    else         
        count1 <= count1 +1;
--    end if;    
        
    if count1 >=  1 then  
    for abc in 0 to 30 loop
    if count1 =  1 + 4 * abc then
        --push <= "0000000011";
        OutAC11 <= DinA;
        Outbc11 <= dinb;
        exit;
    elsif (count1 = 2 + 4* abc) then
       -- push <= "0000001100"; 
       --push <= 12;   
        OutAC21 <= DinA;
        Outbc12 <= dinb; 
        exit;  
    elsif (count1 = 3 + 4* abc) then
        OutAC31 <= DinA;
        Outbc13 <= dinb;
        exit;   
    elsif ( count1 = 4 + 4* abc) then
         OutAC41 <= DinA;
         exit; 
    end if;
    end loop;
    end if;               
--        for i in 0 to 10 loop
--            if(count1 = 4 + 7*i or count1 = 7 + 7*i) then
--              --  push <= "0000000011";
--             -- push <= 3;
--             OutAC11 <= DinA;
--             Outbc11 <= dinb;
--            elsif(count1 = 5 + 7*i or count1 = 8+ 7*i)then
--               -- push <= "0000001100"; 
--               -- push <= 12;
--               OutAC21 <= DinA;
--               Outbc12 <= dinb; 
--            elsif(count1 = 6 + 7*i or count1 = 9 + 7*i)then
--                --push <= "0000110000";
--               -- push <= 48;
--               OutAC31 <= DinA;
--               Outbc13 <= dinb;                
--            elsif(count1 = 10+ 7*i )then
--                OutAC41 <= DinA;
                
--                -- push <= "0011000000";
--               -- push <= 192;
--             end if;
--         end loop;   
--      end if;                 
end if;
--end if;
end process;

end behavioral;