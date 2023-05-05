----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2023 12:27:36 PM
-- Design Name: 
-- Module Name: INSTR_DECODE - Behavioral
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

 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

 

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

 

entity INSTR_DECODE is
    Port ( clk : in STD_LOGIC;
           instr : in STD_LOGIC_VECTOR (15 downto 0);
           write_data : in STD_LOGIC_VECTOR (15 downto 0);
           reg_write : in STD_LOGIC;
           reg_dst : in STD_LOGIC;
           ext_op : in STD_LOGIC;
           read_data1 : out STD_LOGIC_VECTOR (15 downto 0);
           read_data2 : out STD_LOGIC_VECTOR (15 downto 0);
           ext_imm : out STD_LOGIC_VECTOR (15 downto 0);
           fc_field : out STD_LOGIC_VECTOR (2 downto 0);
           shift_am : out STD_LOGIC);
end INSTR_DECODE;

 

architecture Behavioral of INSTR_DECODE is

 

component reg_file is
    Port ( clk : in STD_LOGIC;
           ra1 : in STD_LOGIC_VECTOR (3 downto 0);
           ra2 : in STD_LOGIC_VECTOR (3 downto 0);
           wa : in STD_LOGIC_VECTOR (3 downto 0);
           wd : in STD_LOGIC_VECTOR (15 downto 0);
           wen : in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (15 downto 0);
           rd2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

 

signal mux: std_logic_vector(2 downto 0);

 

begin

 

mux <= instr(9 downto 7) when reg_dst='0' else instr(6 downto 4);

 

register_file: component reg_file
                port map(
                    clk=>clk,
                    ra1=>instr(12 downto 10),
                    ra2=>instr(9 downto 7),
                    wa=>mux,
                    wd=>write_data,
                    wen=>reg_write,
                    rd1=>read_data1,
                    rd2=>read_data2
                    );

ext_imm <= "000000000" & instr(6 downto 0);
shift_am<=instr(13);
fc_field<=instr(2 downto 0);

 

end Behavioral;
