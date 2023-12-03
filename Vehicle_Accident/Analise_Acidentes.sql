--QUANTOS ACIDENTES ACONTECERAM EM CADA �REA (URBANA E RURAL)?

SELECT
	[Area], --coluna que ser� retornada na consulta
	COUNT([AccidentIndex]) AS 'Total de Acidentes' --conta o n�mero de ocorr�ncias na coluna "AccidentIndex"
FROM 
	[dbo].[accident] --a tabela da qual os dados ser�o recuperados
GROUP BY 
	[Area]; --contagem de acidentes ser� agrupada por diferentes valores nessa coluna


--QUAL DIA DA SEMANA TEM MAIS ACIDENTES?

SELECT 
	[Day],
	COUNT([AccidentIndex]) 'Total de Acidentes'
FROM 
	[dbo].[accident]
GROUP BY 
	[Day]
ORDER BY 
	'Total de Acidentes' DESC;


--QUAL � A IDADE M�DIA DOS VEICULOS ENVOLVIDOS NOS ACIDENTES?

SELECT 
	[VehicleType], 
	COUNT([AccidentIndex]) AS 'Total de Acidentes', 
	AVG([AgeVehicle]) AS 'Idade M�dia' --calcula a m�dia
FROM 
	[dbo].[vehicle]
WHERE 
	[AgeVehicle] IS NOT NULL -- filtragem para incluir apenas as linhas em que a coluna "AgeVehicle" n�o � nula
GROUP BY 
	[VehicleType]
ORDER BY 
	'Total de Acidentes' DESC;

--EXISTE ALGUMA RELA��O DA IDADE DOS VE�CULOS COM OS ACIDENTES?
SELECT 
	AgeGroup,
	COUNT([AccidentIndex]) AS 'Total de Acidentes',
	AVG([AgeVehicle]) AS 'Ano M�dio'
FROM (
	SELECT
		[AccidentIndex],
		[AgeVehicle],
		CASE
			WHEN [AgeVehicle] BETWEEN 0 AND 5 THEN 'Novo'
			WHEN [AgeVehicle] BETWEEN 6 AND 10 THEN 'Meia Idade'
			ELSE 'Velho'
		END AS AgeGroup
		FROM [dbo].[vehicle]
) AS SubQuery
GROUP BY 
	AgeGroup;

--H� ALGUMA CONDI��O METEREOL�GICA QUE CONTRIBUI NOS ACIDENTES?

DECLARE @Sevierity varchar(100) -- Declara uma vari�vel com capacidade de armazenar at� 100 caracteres
SET @Sevierity = 'Fatal' --significa que a consulta ir� contar o n�mero total de acidentes com gravidade 'Fatal'

SELECT 
	[WeatherConditions],
	COUNT([Severity]) AS 'Total de Acidentes'
FROM 
	[dbo].[accident]
WHERE 
	[Severity] = @Sevierity
GROUP BY 
	[WeatherConditions]
ORDER BY 
	'Total de Acidentes' DESC;

--OS ACIDENTES ENVOLVEM FREQUENTEMENTE IMPACTOS NO LADO ESQUERDO DO VE�CULO?

SELECT 
	[LeftHand], 
	COUNT([AccidentIndex]) AS 'Total de Acidentes'
FROM 
	[dbo].[vehicle]
GROUP BY 
	[LeftHand] -- 0 = n�o e 1 = sim
HAVING
	[LeftHand] IS NOT NULL


--EXISTE ALGUMA RELA��O NOS MOTIVOS DAS VIAGENS E A GRAVIDADE DELAS?

SELECT 
	V.[JourneyPurpose], 
	COUNT(A.[Severity]) AS 'Total de Acidentes',
	CASE -- categoriza os diferentes n�veis com base na contagem de acidentes
		WHEN COUNT(A.[Severity]) BETWEEN 0 AND 1000 THEN 'Baixo'
		WHEN COUNT(A.[Severity]) BETWEEN 1001 AND 3000 THEN 'Moderado'
		ELSE 'Alto'
	END AS 'N�vel'
FROM 
	[dbo].[accident] A
JOIN --dados ser�o obtidos a partir das tabelas "accident" e "vehicle", onde as linhas s�o combinadas com base nos �ndices de acidentes 
	[dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY 
	V.[JourneyPurpose]
ORDER BY 
	'Total de Acidentes' DESC;
