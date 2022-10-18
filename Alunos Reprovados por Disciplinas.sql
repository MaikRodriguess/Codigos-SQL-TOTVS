/*
Mostra as disciplinas que o aluno está reprovado
*/

select DISTINCT
	
	nome AS 'Nome',
	Nomstatus AS 'Status',
	NomDisciplina AS 'Disciplinas', 
	nomfilial AS 'Filial',
	nomtipocurso AS 'Nível',
	nomcurso AS 'Curso',
	CODPERLET AS 'Periodo Letivo',
	CODTURMA AS 'Turma',
	RA 
from 
	v_Unasp_SMATRICULA 

-- Na coluna de status do aluno, procura os alunos que estão reprovados por falta ou por nota
where 
		Nomstatus = 'Reprovado por Falta'
	OR NomStatus = 'Reprovado por Nota'
