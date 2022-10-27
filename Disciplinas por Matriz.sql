-- Exibe relação de disciplinas por matriz e status
SELECT 
	distinct
	HF.CODPERLET PERIODO_LET,
	HF.NomFilial FILIAL,
	HF.NomCurso NOME_CURSO,
	CODCURSO COD_CURSO,
	CODHABILITACAO COD_HABILITACAO,
	SDISCIPLINA.NOME NOME_DISC,
	HF.NomTurno NOME_TURNO,
	HF.NomGrade NOME_GRADE,
	HF.CODGRADE COD_GRADE,
	Status,
	STURMADISC.CODTURMA COD_TURMA,
	STURMADISC.CODDISC COD_DISCIPLINA,
	STURMADISC.IDTURMADISC ID_TURMADISC,
	GERENCIAL,
	STURMADISCGERENCIADA.IDTURMADISC COD_GERENCIAL,
	STURMA.nome NOME_TURMA, 
	[TIPO_TURMA]=

	/*Verifica se uma turma é ESPECIAL, NORMAL, ou TEMPORARIA*/
	CASE
	WHEN STURMA.NOME like '%Especial%' THEN 'Especial'
	WHEN STURMA.NOME like '%Temp%' THEN 'Temporario'
	WHEN STURMA.NOME IS NOT NULL THEN 'Normal'

	END
FROM v_Unasp_SHABILITACAOFILIALPL HF (NOLOCK)
	LEFT JOIN STURMADISC (NOLOCK) ON STURMADISC.IDHABILITACAOFILIAL = HF.IDHABILITACAOFILIAL
		AND STURMADISC.IDPERLET = HF.IDPERLET
	LEFT JOIN STURMADISCGERENCIADA (NOLOCK) ON STURMADISCGERENCIADA.IDTURMADISCGERENCIADA = STURMADISC.IDTURMADISC
	INNER JOIN SDISCIPLINA (NOLOCK) ON SDISCIPLINA.CODDISC = STURMADISC.CODDISC
	INNER JOIN STURMA (NOLOCK) ON STURMA.IDPERLET = STURMADISC.IDPERLET and STURMA.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
WHERE 
	CODPERLET = :PERIODO_LET
	
	
ORDER BY SDISCIPLINA.NOME