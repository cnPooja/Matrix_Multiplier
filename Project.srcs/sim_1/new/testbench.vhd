------------TestBench ----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity TestBench is
end TestBench;

architecture Behavioral of TestBench is

component matrixmul is             
    Port (clk : in STD_LOGIC);
end component;

component RAMMem is             
    Port ( clk : in STD_LOGIC;
           wr : in integer;
           rdA : out integer;
           rdB : out integer);
end component;

component pe is
    Port ( reset : in std_logic;
           clk : in STD_LOGIC;
           ina: in integer range 0 to 100;
           inb: in integer range 0 to 100;
           outa, outb,outc : inout  integer range 0 to 100);
end component;


signal clk_tb,rst_tb:std_logic := '0';
constant clk_period : time := 1 ns;  

begin 

uut : matrixmul port map(clk => clk_tb); 

process
begin
    clk_tb <= '1';
    wait for clk_period/2;
    clk_tb <= '0';
    wait for clk_period/2;
end process;

end Behavioral;
