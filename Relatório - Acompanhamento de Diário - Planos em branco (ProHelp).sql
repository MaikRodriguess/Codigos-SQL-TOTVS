mTipoCurso
		END                               AS 'Nível Ensino',
		/*Identifica disciplina gerencial na coluna curso*/
	   CASE 
	   WHEN NomCurso IS NULL THEN  'GERENCIAL'
	   ELSE NomCurso 
	   END                                AS 'Curso',

       CODTURMA                           AS 'Turma',
       NomDisciplina,
       p.NomProfessor,
       tb2.Sem_Preenchimento_Ontem        AS 'em atraso',
       CASE
         WHEN tb.Total_Licao > 0 THEN 'Preenchido'
         ELSE 'Não Preenchido'
       END                                AS 'Tem AED',
       Cast(v.NUMCREDITOS * 20 AS BIGINT) AS 'CH',
       e.Total_AulasDadas                 AS 'chamada',
       tb.Total_Branco                    AS 'Planos em branco',
       STURMADISCGERENCIADA.IDTURMADISC   AS 'id Gerencial',
       v.IDTURMADISC                      AS 'Código',
       v.GERENCIAL,
       v.NomTipoTurmaDisc,
       tb.Total_PlanoAula                 AS 'Planos criados',
       prova.Total_Provas                 AS 'Qtd.provas criadas',
       prova.Total_Peso                   AS 'Total Pesos',
       prova.Total_Bonus                  AS 'Bonus na média',
       p.EMAIL
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
		AND tb.Total_Branco > 0 /*Não mostra planos preenchidos*/
/*and tb.Total_PlanoAula <> tb.Total_Branco*/
ORDER  BY NomFilial,
          NomCurso,
          tb.Total_Branco
          
