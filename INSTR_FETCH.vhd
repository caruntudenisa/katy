----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2023 12:52:11 PM
-- Design Name: 
-- Module Name: IF - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

 


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

 

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

 

entity INSTR_FETCH is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           jump : in STD_LOGIC;
           pcsrc : in STD_LOGIC;
           branch_address : in STD_LOGIC_VECTOR (15 downto 0);
           jump_address : in STD_LOGIC_VECTOR (15 downto 0);
           pc_plus_one : out STD_LOGIC_VECTOR (15 downto 0);
           instr : out STD_LOGIC_VECTOR (15 downto 0));
end INSTR_FETCH;

 

architecture Behavioral of INSTR_FETCH is

 

    type rom_type is array(0 to 255) of std_logic_vector(15 downto 0);
    signal rom : rom_type := (
    x"1234",
    x"5678",
    x"ABCD",
    x"1337",
    x"F1FA",
    others => x"0000"
    );

    signal mux_result : std_logic_vector(15 downto 0);
    signal adder : std_logic_vector(15 downto 0);
    signal mux_down : std_logic_vector(15 downto 0);
    signal mux_up : std_logic_vector(15 downto 0);
    signal PC : std_logic_vector(15 downto 0);

 

begin

   PC_block: process(clk)

    begin
        if rising_edge(clk) then
        if enable = '1' then
            PC<=mux_up;
        else if reset = '1' then
            PC <= x"0000";
           end if;
        end if;
        end if;
    end process;

    adder <= PC + 1;

    muxdown : process(PCSrc)
            begin
            if PCsrc ='0' then
                mux_down <= adder;
            else
                mux_down<= branch_address;
            end if;
            end process;
    muxup : process(PCsrc)
            begin
            if jump ='0' then
                            mux_up <= mux_down;
                        else
                            mux_up<= jump_address;
                        end if;
                        end process;
    instr <= ROM(conv_integer(unsigned(PC(7 downto 0))));


end Behavioral;


