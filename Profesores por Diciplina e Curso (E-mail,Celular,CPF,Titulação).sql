/*Lista informaçãoes importantes sobre professores, como:
	Periodo Letivo
	Filial
	Tipo do Curso
	Curso
	Disciplina
	Código da disciplina
	Nome
	CPF
	Titulação,
	E-mail Comercial
	E-mail Pessoal
	Celular
	Residencial
	Comercial
*/

SELECT 
		DISTINCT
	v_unasp_STURMADISC.CODPERLET AS 'Periodo Letivo',
	NOMFILIAL AS 'Filial', 
	NOMTIPOCURSO AS 'Tipo Curso',
	NOMCURSO AS 'Curso',
	v_unasp_STURMADISC.NomDisciplina AS 'Disciplina',
	v_unasp_STURMADISC.IDTURMADISC AS 'IDTURMADISC', 
	PPESSOA.NOME AS 'Nome',
	PPESSOA.CPF AS CPF,
	STITULACAO.NOME AS 'Titulação',
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
WHERE
	CODPERLET like '%' + :CodPerlet + '%'
	and NOMCURSO  IS NOT NULL

GROUP BY v_unasp_STURMADISC.CODPERLET ,
	NOMFILIAL, 
	NOMTIPOCURSO ,
	v_unasp_STURMADISC.NomDisciplina,
	v_unasp_STURMADISC.IDTURMADISC,
	NOMCURSO,
	PPESSOA.NOME ,
	PPESSOA.CPF ,
	STITULACAO.NOME,
	PPESSOA.EMAIL,
	PPESSOA.EMAILPESSOAL ,
	PPESSOA.TELEFONE1 ,
	PPESSOA.TELEFONE2 ,
	PPESSOA.TELEFONE3
ORDER BY NomCurso, NOME

	
