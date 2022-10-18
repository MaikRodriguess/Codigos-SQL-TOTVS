--Coordenadores de matriz aplicada

/*
Exemplo de consulta:
Periodo = 2022/1, 2022/2, etc..
Sigla_Filial = SP, EC, HT e EAD
*/

select distinct
	
	HF.CODPERLET Periodo,
	HF.NomFilial AS 'Filial',
	ppessoa.nome AS 'Coordenador',
	scoordenador.funcao AS 'Função',
	HF.NomTipoCurso AS 'Nível Ensino',
	HF.NomCurso AS 'Curso',
	HF.CODCURSO AS 'Cod. Curso',
	HF.NomGrade AS 'Matriz', 
	HF.CODGRADE AS 'Cod. Matriz',
	HF.CODHABILITACAO AS 'Cod. Habilitação',
	HF.NomTurno AS 'Turno',
	HF.status AS 'Status'
	 
from v_Unasp_SHABILITACAOFILIALPL HF (NOLOCK)
	left join  scoordenador (NOLOCK)
		ON HF.IDHABILITACAOFILIAL = SCOORDENADOR.IDHABILITACAOFILIAL
	left join ppessoa (NOLOCK) 
		ON scoordenador.codpessoa = ppessoa.codigo
	
where 
		codperlet like  '%' + :Periodo + '%'
		
order by HF.NomCurso

