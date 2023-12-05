SELECT * FROM CARDATA;

UPDATE cardata
SET Price = ROUND(Price, 2);

--IDENTIFICANDO VALORES NULOS

SELECT * FROM CARDATA
WHERE Engine_Size_L IS NULL
OR Entertainment_Features IS NULL
OR Interior_Features IS NULL
OR Exterior_Features IS NULL
OR Customer_Ratings IS NULL
OR Sales_Figures_Units_Sold IS NULL

--REMOVENDO VALORES NULOS

DELETE FROM CARDATA
WHERE Engine_Size_L IS NULL
OR Entertainment_Features IS NULL
OR Interior_Features IS NULL
OR Exterior_Features IS NULL
OR Customer_Ratings IS NULL
OR Sales_Figures_Units_Sold IS NULL

--MARCA DE CARRO MAIS VENDIDA

SELECT TOP 1
Car_Make,
SUM(Price) AS Vendas
FROM CARDATA
GROUP BY Car_Make
ORDER BY Vendas DESC

--CARRO MAIS VENDIDO --

SELECT TOP 1
Car_Make,
SUM(Sales_Figures_Units_Sold) AS Carro_Mais_Vendido
FROM CARDATA
GROUP BY Car_Make
ORDER BY Carro_Mais_Vendido DESC

--AN�LISE DA PERFORMANCE DE VENDAS

SELECT TOP 10
Car_Make,
Car_Model,
Year,
ROUND(SUM(Sales_Figures_Units_Sold),2) AS Unidades_Vendidas
FROM CARDATA
GROUP BY 
Car_Make,
Car_Model,
Year
ORDER BY Unidades_Vendidas DESC

--PREFER�NCIAS DO CONSUMIDOR
SELECT TOP 10
Car_Make,
Car_Model,
Body_Type,
Color_Options,
ROUND(SUM(Sales_Figures_Units_Sold),2) AS Unidades_Vendidas
FROM CARDATA
GROUP BY 
Car_Make,
Car_Model,
Body_Type,
Color_Options
ORDER BY Unidades_Vendidas DESC

-- TOP 10 CARROS EM AUTONOMIA

SELECT TOP 10
Car_Make,
Car_Model,
Mileage_MPG,
ROUND(SUM(Sales_Figures_Units_Sold),2) AS Unidades_Vendidas
FROM cardata
GROUP BY
Car_Make,
Car_Model,
Mileage_MPG
ORDER BY Unidades_Vendidas DESC

--AN�LISE DA RELA��O DO PRE�O DO CARRO COM A SUA AVALIA��O DO CONSUMIDOR
SELECT TOP 10
Car_Make,
Car_Model,
SUM(Price) AS Vendas_Totais,
ROUND(AVG(TRY_CAST(LEFT(Customer_Ratings , 3) AS FLOAT)),2) AS M�dia_da_Avalia��o
FROM CARDATA
GROUP BY
Car_Make,
Car_Model
ORDER BY
Vendas_Totais DESC

--AN�LISE DA RELA��O DO PRE�O DO CARRO COM A SUA AVALIA��O DO CONSUMIDOR E ITENS DE S�RIE

SELECT TOP 10
Car_Make,
Car_Model,
SUM(Price) AS Vendas_Totais,
ROUND(AVG(TRY_CAST(LEFT(Customer_Ratings , 3) AS FLOAT)),2) AS M�dia_da_Avalia��o,
Safety_Features,
Entertainment_Features
FROM cardata
GROUP BY
Car_Make,
Car_Model,
Safety_Features,
Entertainment_Features
ORDER BY
Vendas_Totais DESC

--AN�LISE GERAL DOS TOP10 CARROS MAIS VENDIDOS
SELECT TOP 10 
Car_Make,
Car_Model,
Body_Type,
Fuel_Type,
Customer_Ratings,
Year,
ROUND(SUM(Sales_Figures_Units_Sold),2) AS Unidades_Vendidas
FROM cardata
GROUP BY
Car_Make,
Car_Model,
Body_Type,
Fuel_Type,
Customer_Ratings,
Year
ORDER BY 
Unidades_Vendidas DESC



