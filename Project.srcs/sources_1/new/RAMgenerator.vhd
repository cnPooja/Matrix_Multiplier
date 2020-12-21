---------------------------RAM generator emulating RAM having 2 read ports and 1 write port-------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity RAMMem is             
    Port ( rst: out std_logic:= '0';
           clk : in STD_LOGIC:='1';
           wr : in integer;
           rdA : out integer := 0;
           rdB : out integer := 0;
           wer:in integer);
end RAMMem;

architecture Behavioral of RAMMem is

type MatA is array (1 to 4, 1 to 5) of integer range 0 to 100;
type MatB is array (1 to 5, 1 to 3) of integer range 0 to 100;
type MatC is array (1 to 4, 1 to 3) of integer range 0 to 100;

type MatAA is array (1 to 4, 1 to 5) of integer range 0 to 100;
type MatBB is array (1 to 5, 1 to 3) of integer range 0 to 100;
type MatCC is array (1 to 4, 1 to 3) of integer range 0 to 100;

type MatAAA is array (1 to 4, 1 to 5) of integer range 0 to 100;
type MatBBB is array (1 to 5, 1 to 3) of integer range 0 to 100;
type MatCCC is array (1 to 4, 1 to 3) of integer range 0 to 100;

type MatAAAA is array (1 to 4, 1 to 5) of integer range 0 to 100;
type MatBBBB is array (1 to 5, 1 to 3) of integer range 0 to 100;
type MatCCCC is array (1 to 4, 1 to 3) of integer range 0 to 100;

-----1st Matrix A ---------------------
constant matrixA : matA:= ((1,2,3,1,2),
                         (4,3,4,2,1),
                         (3,1,4,1,1),
                         (1,2,3,5,1));
                         
-----1st Matrix B ---------------------
constant matrixB : matB:= ((1,1,1),
                         (1,1,1),
                         (1,1,1),
                         (1,1,1),
                         (1,1,1)); 
                         
signal matrixC : matC:= (others => (others => 0));  

-----2nd Matrix A ---------------------
constant matrixAA : matAA:= ((1,2,3,1,2),
                         (2,3,1,2,1),
                         (3,1,2,1,1),
                         (1,2,3,1,1));

-----2nd Matrix A ---------------------                         
constant matrixBB : matBB:= ((1,1,1),
                         (1,1,1),
                         (1,1,1),
                         (1,1,1),
                         (1,1,1)); 
                         
signal matrixCC : matCC:= (others => (others => 0));  

-----3rd Matrix A ---------------------
constant matrixAAA : matAAA:= ((3,4,5,6,7),
                         (8,9,10,11,12),
                         (13,14,15,16,17),
                         (18,19,20,21,22));

-----3rd Matrix B ---------------------                         
constant matrixBBB : matBBB:= ((23,24,25),
                         (26,27,28),
                         (29,30,31),
                         (32,33,34),
                         (35,36,37)); 
                         
signal matrixCCC : matCCC:= (others => (others => 0));

-----4th Matrix A --------------------- 
constant matrixAAAA : matAAAA:= ((3,4,5,6,7),
                         (8,9,10,11,12),
                         (13,14,15,16,17),
                         (18,19,20,21,22));

-----4th Matrix B ---------------------                          
constant matrixBBBB : matBBBB:=  ((23,24,25),
                         (26,27,28),
                         (29,30,31),
                         (32,33,34),
                         (35,36,37)); 
                         
signal matrixCCCC : matCCCC:= (others => (others => 0));

signal i,j,o,r,state:integer := 1;
signal n: integer := 2;
signal p: integer:= 3;
signal q: integer:= 4;
signal k,l,m : integer := 0;
signal count: integer:= 1;
signal count1,count2,count3,count4,count5,wrcount:integer:= 0;     
signal c11,c12,c13: integer:= 0;                                       
                        
begin


process(clk)
begin

  if rising_edge(clk)then
        if wr/= 0 then
            wrcount<= wrcount+1;
            if wrcount = 0 then
            c11 <= wr;
            elsif wrcount =1 then
            c12 <= wr;
              elsif wrcount =2 then
            c13 <= wr;
        end if;
    end if;
        if k=5 then
        rst <= '1';
        k<= k+1;
        else  
        ------------ Output elements a11b11, a12b21, a13b31,a14b41,a15b51 -------------------------------         
         if( (count = 1) or count = 5 or count = 9 or  count =13 or count= 17  or count = 21 or  count =25 or count = 29 or count = 33 or count = 37) then
            if(k < 5) then
            rdA <= matrixA(i,j);
            rdB <= matrixB(j,i); 
            i<= i+1; 
         elsif(k <11)then
            rdA <= matrixAA(i,j);
            rdB <= matrixBB(j,i); 
            i<= i+1; 
          elsif(k < 15)then
            rdA <= matrixAA(i,j);
            rdB <= matrixBB(j,i); 
          end if;                        

     ------------ Output elements a21b12, a22b22, a23b32,a24b42,a25b52 -------------------------------           
    elsif ( (count = 2) or count = 6 or count = 10 or  count =14 or count= 18  or count = 22 or count = 26 or count=30 or count = 34 or count = 38) then
          if(k < 5) then
            rdA <= matrixA(i,j);
            rdB <= matrixB(j,i); 
            i<= i+1;
           elsif(i= 1 and j =1) then 
            rdA <= matrixAA(i,j);
            rdB <= matrixBB(j,i);
            i<= i+1; 
          elsif(k <15)then
            rdA <= matrixAA(i,j);
            rdB <= matrixBB(j,i); 
          end if;
             
     ------------ Output elements a31b13, a32b23, a33b33,a34b43,a35b53 -------------------------------       
    elsif ( (count = 3) or count = 7 or count = 11 or  count =15 or count= 19  or count = 23 or count = 27 or count=31 or count = 35 or count = 39 ) then
        if(k < 5) then
            rdA <= matrixA(i,j);
            rdB <= matrixB(j,i);
            i<= i+1; 
            elsif(i= 1 and j =1) then
            rdA <= matrixAA(i,j);
            rdB <= matrixBB(j,i); 
            i<= i+1;
          elsif(k < 15)then
            rdA <= matrixAA(i,j);
            rdB <= matrixBB(j,i); 
          end if;   
          
      ------------ Output elements a41b14, a42b24, a43b34,a44b44,a45b54 -------------------------------       
     elsif ( (count = 4) or count = 8 or count = 12 or  count =16 or count= 20  or count =24 or  count = 28 or count=32 or count = 36 or count = 40 ) then
        if(k < 5) then
            rdA <= matrixA(i,j); 
            elsif(i= 4 and j =5) then
            rdA <= matrixAA(i,j);
          elsif(k < 15)then
            rdA <= matrixAA(i,j);
          end if;       

            i <= 1;
            if(k = 4 or k =9 or k= 14 or k =19 or k =24 or k = 29 or k = 34) then
                j <= 1;
                l <= l +1;
             else   
                j <= j +1;
             end if;   
            k <= k +1;      


end if; 
count <= count +1; 
end if;             
end if;             
        

end process;
end behavioral;
