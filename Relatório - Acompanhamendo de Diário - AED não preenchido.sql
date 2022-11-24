/*Verifica as disciplinas que estão sem preenchimendo de as atividades em espaço Diversificados */

SELECT distinct CodPerlet,
		v.NomFilial,
		v.NomCurso,
		v.CODTURMA,
		v.NomDisciplina,
		STURMADISCGERENCIADA.IDTURMADISC ID_Gerencial,
		v.CODCURSO,

		NomTipoTurmaDisc,
		NomProfessor,
       [Tem_AED] = 
	   CASE
         WHEN tb.Total_Licao > 0 THEN 'Preenchido'
         ELSE 'Não Preenchido'
       END                                
                 
FROM   v_Unasp_STURMADISC v (NOLOCK)
       INNER JOIN(SELECT idturmadisc,
                         Count(*) Total_PlanoAula,
                         Sum(CASE
                               WHEN CONTEUDOEFETIVO IS NULL
                                     OR CONVERT(VARCHAR (MAX), CONTEUDOEFETIVO) = '' THEN 1
                               ELSE 0
                             END) Total_Branco,
                         Sum(CASE
                               WHEN LICAOCASA <> '' THEN 1
                               ELSE 0
                             END) Total_Licao
                  FROM   SPLANOAULA (NOLOCK)
                  GROUP  BY IDTURMADISC) tb
               ON tb.IDTURMADISC = v.IDTURMADISC
       INNER JOIN(SELECT idturmadisc,
                         Count(*) Total_PlanoAula,
                         Sum(CASE
                               WHEN CONTEUDOEFETIVO IS NULL
                                    AND DATA < Getdate() THEN 1
                               ELSE 0
                             END) Sem_Preenchimento_Ontem,
                         Sum(CASE
                               WHEN LICAOCASA <> '' THEN 1
                               ELSE 0
                             END) Total_Licao
                  FROM   SPLANOAULA (NOLOCK)
                  GROUP  BY IDTURMADISC) tb2
               ON tb2.IDTURMADISC = v.IDTURMADISC
       INNER JOIN(SELECT idturmadisc,
                         Sum(AULASDADAS) Total_AulasDadas
                  FROM   SETAPAS (NOLOCK)
                  GROUP  BY IDTURMADISC) e
               ON e.IDTURMADISC = v.IDTURMADISC
       LEFT JOIN(SELECT pt.IDTURMADISC,
                        pp.EMAIL,
                        Min(pp.NOME) NomProfessor
                 FROM   SPROFESSORTURMA pt (NOLOCK)
                        INNER JOIN SPROFESSOR p
                                ON p.CODCOLIGADA = pt.CODCOLIGADA
                                   AND p.CODPROF = pt.CODPROF
                        INNER JOIN PPESSOA pp
                                ON pp.CODIGO = p.CODPESSOA
                 WHERE  pt.TIPOPROF = 't'
                 GROUP  BY pt.IDTURMADISC,
                           pp.EMAIL) p
              ON p.IDTURMADISC = v.IDTURMADISC
       LEFT JOIN (SELECT p.IDTURMADISC,
                         Count(*) Total_Provas,
                         Sum(CASE
                               WHEN pc.TIPO = 'C' THEN pc.PESO
                             END) Total_Peso,
                         Sum(CASE
                               WHEN pc.tipo = 'S' THEN pc.PESO
                             END) Total_Bonus
                  FROM   SPROVAS p (NOLOCK)
                         LEFT JOIN SPROVASCOMPL pc
                                ON pc.CODCOLIGADA = p.CODCOLIGADA
                                   AND pc.IDTURMADISC = p.IDTURMADISC
                                   AND pc.CODETAPA = p.CODETAPA
                                   AND pc.TIPOETAPA = p.TIPOETAPA
                                   AND pc.CODPROVA = p.CODPROVA
                  WHERE  p.CODETAPA = 1
                  GROUP  BY p.IDTURMADISC) prova
              ON prova.IDTURMADISC = v.IDTURMADISC
       /*adicionamos a partir daqui*/
       LEFT JOIN STURMADISCGERENCIADA (NOLOCK)
              ON STURMADISCGERENCIADA.CODCOLIGADA = V.CODCOLIGADA
                 AND STURMADISCGERENCIADA.IDTURMADISCGERENCIADA = V.IDTURMADISC
WHERE  v.CODPERLET = :CODPERLET
	   
       AND v.CODCURSO = :CODCURSO
	   AND V.NomTipoTurmaDisc IN ('Junção Turmas Presenciais', 'Presencial', 'Split Parte em Web Class Assíncrona', 'Split Parte em Web Class Síncrona')
	   

GROUP BY TB.Total_Licao,
		CodPerlet,
		v.NomFilial,
		v.CODTURMA,
		v.NomCurso,
		v.NomDisciplina,
		NomProfessor,
		NomTipoTurmaDisc,
		v.CODCURSO,
		STURMADISCGERENCIADA.IDTURMADISC

HAVING TB.Total_Licao = 0