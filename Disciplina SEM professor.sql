SELECT STURMADISC.IDTURMADISC

FROM STURMADISC (NOLOCK)
INNER JOIN SPLETIVO  (NOLOCK) ON STURMADISC.IDPERLET = SPLETIVO.IDPERLET
LEFT JOIN SPROFESSORTURMA (NOLOCK) ON SPROFESSORTURMA.IDTURMADISC = STURMADISC.IDTURMADISC

WHERE 
SPROFESSORTURMA.IDPROFESSORTURMA IS NULL 
