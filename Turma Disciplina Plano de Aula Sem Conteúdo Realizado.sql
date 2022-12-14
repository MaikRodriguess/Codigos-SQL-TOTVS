--select top (100)* from splanoaula

SELECT 
		STURMADISC.IDTURMADISC,
		SPLANOAULA.CONTEUDOEFETIVO,
		SPLANOAULA.DATA,
		SPLANOAULA.DATAEFETIVA
 FROM STURMADISC (NOLOCK)
INNER JOIN SPLETIVO (NOLOCK) 
		ON STURMADISC.CODCOLIGADA = SPLETIVO.CODCOLIGADA AND STURMADISC.IDPERLET = SPLETIVO.IDPERLET
LEFT JOIN SPLANOAULA (NOLOCK)
		ON SPLANOAULA.CODCOLIGADA = STURMADISC.CODCOLIGADA AND SPLANOAULA.IDTURMADISC = STURMADISC.IDTURMADISC
WHERE SPLANOAULA.CONTEUDOEFETIVO IS NULL
AND CODPERLET LIKE '%' + :PERLET + '%'
AND SPLANOAULA.DATA <= GETDATE()
--AND SPLANOAULA.DATA BETWEEN '01/08/2022' AND '01/09/20222'



