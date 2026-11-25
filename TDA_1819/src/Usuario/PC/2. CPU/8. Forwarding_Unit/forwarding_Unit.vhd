--FORWARDING UNIT
--Esta unidad será la que se ocupará del control necesario para decidir cuando y que datos deben ser adelantados.
--Existen 3 opciones posibles: Tomar el dato de ID (cauce sin forwarding). Adelantamiento desde la etapa EX. Adelantamiento desde la etapa WB.
--Datos:
--ExDestReg: Contiene el registro donde se va a almacenar el resultado de la operación que se encuentra realizandose en EX
--WBDestReg: Contiene el registro donde se va a almacenar el resultado de la escritura en registro durante WB
--MASourceReg: Contiene el registro del cual se va a obtener el dato para escribir en memoria.
--EXOp: Contiene la constante que identifica la operación a realizar en EX.
--WBMode: Contiene la información para determinar si WB escribe en registro o no.
--FwdControl: Contiene un valor de 2 bits que sirve como señal de control para decidir por donde se realiza el forwarding

--Procesos:
--Fwd_Evaluation: Este proceso decide si debe haber adelantamiento o no y de donde se debe tomar el dato adelantado, además carga el resultado de esta decisión en la señal Fwd_Control
--para informar al pipeline que dato debe cargar en MA.
--Para ello debe comparar las siguientes condiciones:
--Si el forwarding está deshabilitado o no se cumplen las condiciones de adelantamiento no se adelanta (Dato tomado de ID)
--Si el registro destino de la operación en EX coincide con el registro fuente de datos a usar en MA, y la operación en EX modifica el valor del registro, se adelanta el dato en EX
--Si NO se adelanta en EX, el registro destino de la escritura en WB coincide con el registro fuente de datos a usar en MA y la operación en WB realiza una escritura en registro, se adelanta el dato en WB

library TDA_1819;			 
use TDA_1819.const_cpu.all;
use TDA_1819.tipos_cpu.all;	

library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;
library std;
use std.TEXTIO.all;

entity forwarding_unit is
	
		generic (
			Forwarding	:	BOOLEAN);
		port (
			EXDestReg 	: in std_logic_vector(7 downto 0);
			--WBDestReg 	: in std_logic_vector(7 downto 0);
			MASourceReg : in std_logic_vector(7 downto 0);
			EXOp 		: in std_logic_vector(7 downto 0);
			--WBMode		: in std_logic_vector(7 downto 0);
			FwdControl	: out std_logic_vector(1 downto 0);
			RecInWB     : in  writeback_record -- NUEVO (reemplaza WBDestReg y WBMode)
		);
		
		
		
end Forwarding_Unit;								   


architecture FORWARDING_UNIT_ARCHITECTURE of Forwarding_Unit is
		
begin
	
	
	Fwd_Evaluation: PROCESS (EXDestReg, MASourceReg, EXOp, RecInWB)
        VARIABLE WBDestReg : std_logic_vector(7 downto 0);
        VARIABLE WBMode    : INTEGER;	
	BEGIN
		WBDestReg := std_logic_vector(unsigned(RecInWB.mode) - 1);
        WBMode    := to_integer(unsigned(RecInWB.mode));
	
		if(not Forwarding) then
			FwdControl <= std_logic_vector(to_unsigned(FWD_NULL, FwdControl'length));
		elsif (EXDestReg = MASourceReg) and ((to_integer(unsigned(EXOp)) >= EX_ADD) and (to_integer(unsigned(EXOp)) <= EX_DSR))  then
			FwdControl <= std_logic_vector(to_unsigned(FWD_EX, FwdControl'length));
		elsif (WBDestReg = MASourceReg) and (WBMode /= WB_NULL) then
			FwdControl <= std_logic_vector(to_unsigned(FWD_WB, FwdControl'length));
		else
			FwdControl <= std_logic_vector(to_unsigned(FWD_NULL, FwdControl'length));
		end if;
		
	
	END PROCESS Fwd_Evaluation;


end FORWARDING_UNIT_ARCHITECTURE;
