library ieee;
USE ieee.std_logic_1164.all;

Entity alu_f IS

	PORT (
	
	
		A		: IN std_logic_vector(3 DOWNTO 0);
		B		: IN std_logic_vector(3 DOWNTO 0);
		OP_Sel: IN std_logic_vector(2 DOWNTO 0);
		
		Saida  : BUFFER std_logic_vector(3 DOWNTO 0);
		Flag_COUT	 : OUT std_logic;
		Flag_Neg	 : OUT std_logic;
		Flag_Zero	 : OUT std_logic;
		Flag_OVFLW	 : OUT std_logic
		
		);
		
END alu_f;

ARCHITECTURE FUNC OF alu_f IS
 
 --temporariamente usando muitos signals, ver se dá pra diminuir a quantidade dinamizando as operações
	
	signal B_real : std_logic_vector(3 DOWNTO 0);
	signal S_sumsub : std_logic_vector(3 DOWNTO 0);
	signal S_INC: std_logic_vector(3 DOWNTO 0);
	signal S_DEC: std_logic_vector(3 DOWNTO 0);
	signal S_COMP : std_logic_vector(3 DOWNTO 0);
	signal S_AND  : std_logic_vector(3 DOWNTO 0);
	signal S_OR		: std_logic_vector(3 DOWNTO 0);
	signal S_SHIFT : std_logic_vector(3 DOWNTO 0);
	
	signal COUT_INC : std_logic;
	signal COUT_DEC : std_logic;
	signal COUT_sumsub : std_logic;
	signal COUT_COMP : std_logic;
	signal COUT_SHIFT		: std_logic;
	
	
	--usando o componenente de soma e subtração
	Component sumsub IS 
		port(
		
			T1		: IN std_logic_vector(3 DOWNTO 0);
			T2 : IN std_logic_vector(3 DOWNTO 0);
			C_IN   : IN std_logic;
			
			S		 : OUT std_logic_vector(3 DOWNTO 0);
			C_OUT  : OUT std_logic
		
		);
		
	end component;
	

	
	
BEGIN
		--B_real é um sinal criado pra diminuir o número de vezs que chamamos o componente sumsub.
	
	B_real(3) <= OP_Sel(0) xor B(3);
	B_real(2) <= OP_Sel(0) xor B(2);
   B_real(1) <= OP_Sel(0) xor B(1);
	B_real(0) <= OP_Sel(0) xor B(0); 
	
	S_OR <= A or B; 
	S_AND <= A and B;
	
	S_SHIFT <= A(2) & A(1) & A(0) & '0';
	COUT_SHIFT <= A(3);
	
	
	
	resInc : sumsub port map(A, "0001", '0', S_INC, COUT_INC);  --Incremento
	
	resDec : sumsub port map(A, "1111", '0', S_DEC, COUT_DEC); -- Decremento
	
	ressumsub : sumsub port map(A, B_real, OP_Sel(0), S_sumsub, COUT_sumsub); --Soma/Subtração
	
	resCOMP : sumsub port map("0000", B_real, OP_SEL(0), S_COMP, COUT_COMP); -- Complemento
	
	process (OP_Sel, S_INC, S_sumsub, S_COMP, S_OR, S_AND, S_SHIFT, S_DEC) 
	
	begin
	
			case OP_Sel is
			
					when "000" =>
					
						Saida <= S_INC;
						Flag_COUT <= COUT_INC;
						
					when "001" =>
					
						Saida <= S_DEC;
						Flag_COUT <= COUT_DEC;
						
					when "100" => 
					
						Saida <= S_AND;
						Flag_COUT <= '0';
						--Flag_Neg <= '0';
						--Flag_OVFLW <= '0';
						
					when "101" => 
						
						Saida <= S_OR;
						Flag_COUT <= '0';
						--Flag_Neg <= '0';
						--Flag_OVFLW <= '0';
	
					when "110" =>
					
						Saida <= S_SHIFT;
						Flag_COUT <= COUT_SHIFT;
						--Flag_Neg <= '0';
						--Flag_OVFLW <= '0';
						
					when "111" => 
						
						Saida <= S_COMP;
						Flag_COUT <= '0';
						--Flag_Neg <= '0';
						--Flag_OVFLW <= '0';
						
					when others => 
						
						Saida <= S_sumsub;
						Flag_COUT <= COUT_sumsub;
						
						
				end case;
				
			end process;
			
	Flag_Zero <= not (Saida(0) or Saida(1) or Saida(2) or Saida(3));
	Flag_Neg <= Saida(3);
	Flag_OVFLW <= (A(3) xnor B(3)) and (Saida(3) xor A(3));
	

end FUNC;	
		
				