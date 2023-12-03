--QUANTOS ACIDENTES ACONTECERAM EM CADA ÁREA (URBANA E RURAL)?

SELECT
	[Area], --coluna que será retornada na consulta
	COUNT([AccidentIndex]) AS 'Total de Acidentes' --conta o número de ocorrências na coluna "AccidentIndex"
FROM 
	[dbo].[accident] --a tabela da qual os dados serão recuperados
GROUP BY 
	[Area]; --contagem de acidentes será agrupada por diferentes valores nessa coluna


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


--QUAL É A IDADE MÉDIA DOS VEICULOS ENVOLVIDOS NOS ACIDENTES?

SELECT 
	[VehicleType], 
	COUNT([AccidentIndex]) AS 'Total de Acidentes', 
	AVG([AgeVehicle]) AS 'Idade Média' --calcula a média
FROM 
	[dbo].[vehicle]
WHERE 
	[AgeVehicle] IS NOT NULL -- filtragem para incluir apenas as linhas em que a coluna "AgeVehicle" não é nula
GROUP BY 
	[VehicleType]
ORDER BY 
	'Total de Acidentes' DESC;

--EXISTE ALGUMA RELAÇÃO DA IDADE DOS VEÍCULOS COM OS ACIDENTES?
SELECT 
	AgeGroup,
	COUNT([AccidentIndex]) AS 'Total de Acidentes',
	AVG([AgeVehicle]) AS 'Ano Médio'
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

--HÁ ALGUMA CONDIÇÃO METEREOLÓGICA QUE CONTRIBUI NOS ACIDENTES?

DECLARE @Sevierity varchar(100) -- Declara uma variável com capacidade de armazenar até 100 caracteres
SET @Sevierity = 'Fatal' --significa que a consulta irá contar o número total de acidentes com gravidade 'Fatal'

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

--OS ACIDENTES ENVOLVEM FREQUENTEMENTE IMPACTOS NO LADO ESQUERDO DO VEÍCULO?

SELECT 
	[LeftHand], 
	COUNT([AccidentIndex]) AS 'Total de Acidentes'
FROM 
	[dbo].[vehicle]
GROUP BY 
	[LeftHand] -- 0 = não e 1 = sim
HAVING
	[LeftHand] IS NOT NULL


--EXISTE ALGUMA RELAÇÃO NOS MOTIVOS DAS VIAGENS E A GRAVIDADE DELAS?

SELECT 
	V.[JourneyPurpose], 
	COUNT(A.[Severity]) AS 'Total de Acidentes',
	CASE -- categoriza os diferentes níveis com base na contagem de acidentes
		WHEN COUNT(A.[Severity]) BETWEEN 0 AND 1000 THEN 'Baixo'
		WHEN COUNT(A.[Severity]) BETWEEN 1001 AND 3000 THEN 'Moderado'
		ELSE 'Alto'
	END AS 'Nível'
FROM 
	[dbo].[accident] A
JOIN --dados serão obtidos a partir das tabelas "accident" e "vehicle", onde as linhas são combinadas com base nos índices de acidentes 
	[dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY 
	V.[JourneyPurpose]
ORDER BY 
	'Total de Acidentes' DESC;
