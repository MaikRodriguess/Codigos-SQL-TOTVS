select * from smatricpl
select * from SPLETIVO
select * from sstatus
select * from shabilitacaofilial --codcurso
select * from scurso
--select * from v_Unasp_SMATRICPL
select * from gfilial --nome (Campus)
select * from stipocurso --nome (Tipo curso)
select * from salunocompl --religiao



select 
	
	spletivo.codperlet AS 'Periodo Letivo',
	gfilial.nome AS 'Filial',
	scurso.nome AS 'Curso',
	stipocurso.nome AS 'Nível de Ensino',
	COUNT(distinct scurso.codcurso) AS 'Qtd. Cursos'
	

	

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
	spletivo.codperlet like '%' + :Ano_PerLet + '%'
	and scurso.complemento like '%' + :BacharelOuLicencia + '%'
	and scurso.complemento not like '%' + 'Pensionato' + '%'
	and sstatus.descricao in ('Concluído', 'Cursando', 'Contrato Assinado')
	
	
group by spletivo.codperlet ,
	gfilial.nome,
	scurso.nome,
	stipocurso.nome 