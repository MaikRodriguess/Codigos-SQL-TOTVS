-- Total de Cursos Por Religião
select 
	
	spletivo.codperlet AS 'Periodo Letivo',
	gfilial.nome AS 'Filial',
	stipocurso.nome AS 'Nível de Ensino',
	scurso.nome AS 'Curso',
	smatricpl.codturma AS 'Turma',
	scurso.complemento AS 'Modalidade',
	salunocompl.religiao AS 'Religião',
	COUNT(salunocompl.religiao) AS 'Qtd. Por Religião'

	

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
	--spletivo.codperlet like '%' + :Ano_PerLet + '%'
	and scurso.complemento like '%' + :BacharelOuLicencia + '%'

	
group by spletivo.codperlet ,
	gfilial.nome ,
	stipocurso.nome,
	scurso.nome ,
	smatricpl.codturma,
	salunocompl.religiao,
	scurso.complemento
