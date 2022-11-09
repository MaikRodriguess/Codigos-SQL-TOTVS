/*
Lista os professores que possuem nomes ou CPF duplicados no sistema
*/


SELECT 
	PPESSOA.NOME AS 'Nome',
	PPESSOA.CPF AS CPF,
	COUNT(PPESSOA.NOME) AS QTD_NOME, --Conta nomes iguais 
	COUNT(PPESSOA.CPF) AS QTD_CPF --Conta CPFs iguais 

FROM SPROFESSOR (NOLOCK)
		LEFT JOIN PPESSOA (NOLOCK)
		ON PPESSOA.CODIGO = SPROFESSOR.CODPESSOA 

GROUP BY PPESSOA.NOME,
	PPESSOA.CPF

-- Mostra apenas professores com nomes ou CPF com mais de um regristo no sistema
HAVING COUNT(PPESSOA.NOME) >= 2 OR COUNT(PPESSOA.CPF) >= 2 





