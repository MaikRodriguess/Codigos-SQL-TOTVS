/* Relatório apresenta dados de professores por curso e disciplina 
  
 By: Maik
*/

SELECT 
		DISTINCT
	v_unasp_STURMADISC.CODPERLET AS 'Periodo Letivo',
	NOMFILIAL AS 'Filial', 
	NOMCURSO AS 'Curso',
	CODCURSO,
	v_unasp_STURMADISC.NomDisciplina AS 'Disciplina',
	PPESSOA.NOME AS 'Nome',
	PPESSOA.CPF AS CPF,
	STITULACAO.NOME AS 'Titulação',
    RP.NUMEROREGISTRO AS 'Reg. Profissional',
	PPESSOA.EMAIL AS 'E-mail Comercial',
	PPESSOA.EMAILPESSOAL AS 'E-mail Pessoal',
	PPESSOA.TELEFONE1 AS 'Celular',
	PPESSOA.TELEFONE2 AS 'Residencial',
	PPESSOA.TELEFONE3 AS 'Comercial'
	
	
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
    LEFT JOIN VREGISTROPROFISSIONAL RP (NOLOCK)
        ON PPESSOA.CODIGO = RP.CODPESSOA
    
WHERE
	CODPERLET = :CODPERLET
	and NOMCURSO  IS NOT NULL
	and CODCURSO = :CODCURSO

GROUP BY v_unasp_STURMADISC.CODPERLET ,
	NOMFILIAL, 
	NOMTIPOCURSO , 
	v_unasp_STURMADISC.NomDisciplina,
	v_unasp_STURMADISC.IDTURMADISC,
	NOMCURSO,
	CODCURSO,
	PPESSOA.NOME ,
	PPESSOA.CPF ,
	STITULACAO.NOME,
    RP.NUMEROREGISTRO,
	PPESSOA.EMAIL,
	PPESSOA.EMAILPESSOAL ,
	PPESSOA.TELEFONE1 ,
	PPESSOA.TELEFONE2 ,
	PPESSOA.TELEFONE3
ORDER BY NomCurso, NOME
