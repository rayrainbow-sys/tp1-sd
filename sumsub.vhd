library ieee;
USE ieee.std_logic_1164.all;

Entity SUMSUB IS

	PORT (
	
		
		T1		: IN std_logic_vector(3 DOWNTO 0);
		T2 		: IN std_logic_vector(3 DOWNTO 0);
		C_IN		: IN std_logic;
		
		S		: OUT std_logic_vector(3 DOWNTO 0);
		C_OUT		: OUT std_logic
		
		);
		
END SUMSUB;


Architecture Arq of SUMSUB IS 

signal p : std_logic_vector(3 downto 0);
signal g : std_logic_vector(3 downto 0);
signal c : std_logic_vector(3 downto 0);

BEGIN
	
	p <= T1 xor T2;
	g <= T1 and T2;
	
	c(0) <= C_in;
	c(1) <= (p(0) and c(0)) or g(0);
	c(2) <= (p(1) and ((p(0) and c(0)) or g(0))) or g(1);
	c(3) <= (p(2) and ((p(1) and ((p(0) and c(0)) or g(0))) or g(1))) or g(2);
	
	C_OUT <= (p(3) and ((p(2) and ((p(1) and ((p(0) and c(0)) or g(0))) or g(1))) or g(2))) or g(3);
	S <= p xor c;


end Arq;x