--Trabalhando com IF… ELSE e CASE


--IF e ELSE

-- Declaração da variável
DECLARE @Idade INT;
 
-- Atribuição do valor a variável
SET @Idade = 23;
 
-- Se... for menor que 18 anos
IF @Idade < 18
PRINT 'Menor que 18 anos';
 
-- Se não ...
ELSE
IF @Idade >18
PRINT 'Maior que 18 anos';

---------------------------------------------------------------------------------

--CASE
DECLARE @ContaBancaria AS INT -- Declaracao de variavel
SET @ContaBancaria = 001 -- Atribuindo um valor a variavel
 
SELECT
CASE @ContaBancaria
WHEN 001 THEN
'Conta Corrente'
WHEN 002 THEN
'Conta Poupança'
WHEN 013 THEN
'Conta Jurídica'
ELSE
'Outro tipo de conta'
 
END AS 'Tipo de Conta'

SELECT [IDTURMADISC],[CODTURMA] AS Turma,[Filial] =
CASE
WHEN CODFILIAL = 1 THEN 'São Paulo'
WHEN CODFILIAL = 2 THEN 'Engenheiro Coelho'
WHEN CODFILIAL = 3 THEN 'Hortolandia'
WHEN CODFILIAL = 4 THEN 'Campus EAD'
ELSE 'Campus não localizado'
END, [CODDISC]
FROM STURMADISC