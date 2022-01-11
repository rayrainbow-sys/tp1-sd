LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY alu_f_tb IS
END alu_f_tb;
 
ARCHITECTURE behavior OF alu_f_tb IS
 
--Component Declaration for the Unit Under Test (UUT)
 
COMPONENT alu_f
PORT(
A : IN std_logic_vector(3 downto 0);
B : IN std_logic_vector(3 downto 0);
OP_Sel : IN std_logic_vector(2 downto 0);
Saida  : BUFFER std_logic_vector(3 DOWNTO 0);
Flag_COUT	 : OUT std_logic;
Flag_Neg	 : OUT std_logic;
Flag_Zero	 : OUT std_logic;
Flag_OVFLW	 : OUT std_logic
);
END COMPONENT;
 
--Inputs
signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
signal OP_Sel : std_logic_vector(2 downto 0) := (others => '0');
 
--Outputs
signal Saida       : std_logic_vector(3 DOWNTO 0);
signal Flag_COUT	 : std_logic;
signal Flag_Neg	 : std_logic;
signal Flag_Zero	 : std_logic;
signal Flag_OVFLW	 : std_logic;
 
BEGIN
 
--Instantiate the Unit Under Test (UUT)
uut: alu_f PORT MAP (
A => A,
B => B,
OP_Sel => OP_Sel,
Saida => Saida,
Flag_COUT => Flag_COUT,
Flag_Neg => Flag_Neg,
Flag_Zero => Flag_Zero,
Flag_OVFLW => Flag_OVFLW
);
 
--stimulus process
stim_proc: process
begin
	--hold reset state for 30 ns.
	wait for 30 ns;
	A <= "0110";
	B <= "1100";
	OP_Sel <= "000";
	
	wait for 30 ns;
	A <= "0110";
	B <= "1100";
	OP_Sel <= "001";
	
	wait for 30 ns;
	A <= "0110";
	B <= "1100";
	OP_Sel <= "010";
	
	wait for 30 ns;
	A <= "0110";
	B <= "1100";
	OP_Sel <= "011";	
	
	wait for 30 ns;
	A <= "1111";
	B <= "1100";
	OP_Sel <= "100";
	 
	wait for 30 ns;
	A <= "0110";
	B <= "0111";
	OP_Sel <= "101";
	 
	wait for 30 ns;
	A <= "0110";
	B <= "1110";
	OP_Sel <= "110";
	 
	wait for 30 ns;
	A <= "1111";
	B <= "1111";
	OP_Sel <= "111";
	
	wait for 30 ns;
	A <= "0110";
	B <= "1100";
	OP_Sel <= "010";
	
	wait for 30 ns;
	A <= "0110";
	B <= "1100";
	OP_Sel <= "011";
		 
	wait;
 
end process;
 
END;
