SELECT IDTURMADISC
	FROM
(SELECT STURMADISC.IDTURMADISC,COUNT(CODPROF)QTDE
	FROM STURMADISC
		INNER JOIN SPROFESSORTURMA (NOLOCK) ON
			SPROFESSORTURMA.CODCOLIGADA = STURMADISC.CODCOLIGADA
			AND SPROFESSORTURMA.IDTURMADISC = STURMADISC.IDTURMADISC
			AND SPROFESSORTURMA.TIPOPROF IS NULL
		INNER JOIN SPLETIVO (NOLOCK) ON
			SPLETIVO.CODCOLIGADA = STURMADISC.CODCOLIGADA
			AND SPLETIVO.IDPERLET = STURMADISC.IDPERLET
WHERE SPLETIVO.CODCOLIGADA = 1
AND SPLETIVO.CODPERLET = :Perletivo_S
GROUP BY STURMADISC.IDTURMADISC
HAVING COUNT(CODPROF) >= 1)DISCIPLINAS