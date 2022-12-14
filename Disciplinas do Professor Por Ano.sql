--Lista as disciplinas do professor do ano
SELECT 
		v_unasp_STURMADISC.IDTURMADISC --Codigo do professor
	
FROM 
	v_unasp_STURMADISC (NOLOCK) 
	INNER JOIN  SPROFESSORTURMA SPROFESSORTURMA (NOLOCK) 
		ON SPROFESSORTURMA.CODCOLIGADA=v_unasp_STURMADISC.CODCOLIGADA and SPROFESSORTURMA.IDTURMADISC=v_unasp_STURMADISC.IDTURMADISC
	LEFT JOIN SPROFESSOR (NOLOCK)
		ON SPROFESSOR.CODPROF = SPROFESSORTURMA.CODPROF
	LEFT JOIN PPESSOA (NOLOCK)
		ON PPESSOA.CODIGO = SPROFESSOR.CODPESSOA
	LEFT JOIN STITULACAO (NOLOCK)
		ON STITULACAO.CODTITULACAO = SPROFESSOR.CODTITULACAO
WHERE
	CODPERLET like '%' + :Ano + '%'-- Apresenta todos os periodos letivos do ano informado 
	and PPESSOA.NOME like '%' + :Nome + '%' --Nome ou parte do nome do professor