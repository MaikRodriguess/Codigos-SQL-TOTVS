select 
	spletivo.codperlet AS 'Periodo Letivo',
	gfilial.nome AS 'Filial',
	scurso.nome AS 'Curso',
	smatricpl.codturma AS 'Turma',
	stipocurso.nome AS 'Nível de Ensino',
	COUNT(distinct smatricpl.ra) AS 'Qtd. Matriculas'
	
	
from smatricpl (nolock)
INNER JOIN spletivo (NOLOCK) 
		ON spletivo.idperlet = smatricpl.idperlet
INNER JOIN sstatus (NOLOCK)
		ON sstatus.codstatus = smatricpl.codstatus 		
INNER JOIN shabilitacaofilial (NOLOCK)
		ON shabilitacaofilial.idhabilitacaofilial = smatricpl.idhabilitacaofilial
inner JOIN scurso (NOLOCK)
		ON scurso.codcurso = shabilitacaofilial.codcurso
INNER JOIN gfilial (NOLOCK)
		ON gfilial.codfilial = shabilitacaofilial.codfilial
INNER JOIN stipocurso (NOLOCK)
		ON stipocurso.codtipocurso = scurso.codtipocurso
INNER JOIN salunocompl (NOLOCK)
 		ON salunocompl.ra = smatricpl.ra
			
Where
		gfilial.CODFILIAL = 4
	and sstatus.DESCRICAO = 'Cursando' 
	and gfilial.CODFILIAL in ('1','2','3','4') --Filial
	and spletivo.codperlet like '%2022%'
	and stipocurso.CODTIPOCURSO = 1 --Graduação
	

GROUP BY spletivo.codperlet,
	scurso.nome,
	smatricpl.codturma,
	gfilial.nome,
	stipocurso.nome

order by spletivo.codperlet, scurso.nome