-- Rascunho Tabelas
select * from ppessoa -- Nome 
select * from SMATRICULA --(IDTURMADISC, RA, IDPERLET, IDHABILITACAOFILIAL, TIPOMAT, TIPODISCIPLINA)
select * from PPESSOA --NOME, RA 
SELECT * FROM SPLETIVO -- Descrição periodo letivo
select * from SDISCIPLINA -- CODDISC, NOME
select * from sstatus -- Status Da diciplina
select * from gfilial -- Nome Filial, codfilial 
select * from stipocurso -- Nome Nível de ensino
select distinct TIPOMAT from smatricula -- Tipo matricula
select * from scurso -- Nome curso 
select * from SHABILITACAOALUNO -- Codigo Status do aluno no curso 
select * from SNOTAETAPA -- Nota de disciplina
select * from STURMADISC -- CODTURMA,CODDISC, IDPERLET,COLIGADA, CODFILIAL
select * from v_Unasp_SHABILITACAOFILIALPL -- IDPERLET, IDHABILITACAOFILIAL

