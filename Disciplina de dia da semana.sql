SELECT
	STURMADISC.IDTURMADISC
FROM 
	STURMADISC
	inner join STURMA (nolock) t on t.CODCOLIGADA = STURMADISC.CODCOLIGADA and t.CODFILIAL = STURMADISC.CODFILIAL and t.CODTURMA = STURMADISC.CODTURMA and t.IDPERLET = STURMADISC.IDPERLET
	inner join SHABILITACAOFILIAL (nolock) hf on hf.CODCOLIGADA = t.CODCOLIGADA and hf.IDHABILITACAOFILIAL = t.IDHABILITACAOFILIAL
	inner join GFILIAL (nolock) f on f.CODCOLIGADA=hf.CODCOLIGADA and f.CODFILIAL = hf.CODFILIAL
	inner join SCURSO (nolock) c on c.CODCOLIGADA=hf.CODCOLIGADA and c.CODCURSO=hf.CODCURSO
	INNER JOIN SPLETIVO (nolock) ON STURMADISC.IDPERLET = SPLETIVO.IDPERLET 
	INNER JOIN SDISCIPLINA (nolock) ON SDISCIPLINA.CODCOLIGADA = STURMADISC.CODCOLIGADA AND SDISCIPLINA.CODDISC = STURMADISC.CODDISC
	LEFT JOIN SHORARIOTURMA (nolock) ON STURMADISC.CODCOLIGADA =  SHORARIOTURMA.CODCOLIGADA AND STURMADISC.IDTURMADISC =  SHORARIOTURMA.IDTURMADISC 
	LEFT JOIN SHORARIO (nolock) ON SHORARIO.CODCOLIGADA = SHORARIOTURMA.CODCOLIGADA AND SHORARIO.CODHOR = SHORARIOTURMA.CODHOR
WHERE 
	CODPERLET IN (:CODPERLET)
AND SHORARIO.DIASEMANA = 5 -- 5 = Quinta
