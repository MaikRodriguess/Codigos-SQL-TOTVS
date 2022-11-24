/* Verifica a quantidade de alunos por turma e turmas por curso*/

select 
	
	spletivo.codperlet AS 'Periodo Letivo',
	gfilial.nome AS 'Filial',
	scurso.nome AS 'Curso',
	stipocurso.nome AS 'Nível de Ensino',
	codturma AS Turma,
	count(smatricpl.ra) AS Matriculas, /*Conta as matriculas na turma*/
	1 AS Conta_turma /*Contador para contar as turma no Cubo*/
	


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
	
	spletivo.codperlet like '%' + :Ano_PerLet + '%' /*Busca ano ou periodo letivo digitado*/
	and scurso.complemento not like '%' + 'Pensionato' + '%' /* Não considera as matriculas no curso de pensionato*/
	and smatricpl.CODSTATUS = 2 /* Somente Alunos com o status cursando */
	
group by spletivo.codperlet ,
	gfilial.nome,
	scurso.nome,
	stipocurso.nome,
	codturma