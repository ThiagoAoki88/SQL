SELECT * FROM CUSTOMER

--PROCURANDO VALORES NULOS

SELECT * FROM CUSTOMER
WHERE [index] IS NULL
OR [Date] IS NULL
OR [Year] IS NULL
OR [Month] IS NULL
OR Customer_Age IS NULL
OR Customer_Gender IS NULL
OR Country IS NULL
OR State IS NULL
OR Product_Category IS NULL
OR Sub_Category IS NULL
OR Quantity IS NULL
OR Unit_Cost IS NULL
OR Unit_Price IS NULL
OR Revenue IS NULL

-----------DELETANDO VALORES NULOS-----------------------------------------------------------------------

DELETE FROM CUSTOMER
WHERE 
    [index] = 34866

------------DELETANDO VALORES NULOS------------------------------------------------------------------------------

ALTER TABLE CUSTOMER
DROP COLUMN Column1;

------------ARRUMANDO A COLUNA DAS IDADES DOS CONSUMIDORES-----------------------------------------------------

UPDATE customer
SET Customer_Age = Customer_Age / 10

------------ARRUMANDO A COLUNA DOS ANOS-----------------------------------------------------------------------

UPDATE customer
SET Year = Year / 10

------------ARRUMANDO A COLUNA CUSTOMER_GENDER F(FEMINNO) E M(MASCULINO)-----------------------------------------

UPDATE customer
SET Customer_Gender = 
    CASE 
        WHEN Customer_Gender = 'F' THEN 'Feminino'
        WHEN Customer_Gender = 'M' THEN 'Masculino'
        ELSE Customer_Gender
    END

------------TOTAL DE CONSUMIDORES POR PAÍS-------------------------------------------------------------------------

SELECT
    Country,
    COUNT(*) AS Consumidores
FROM
    customer
GROUP BY
    Country
ORDER BY Consumidores DESC;

------------TOTAL DE CONSUMIDORES POR ESTADO-----------------------------------------------------------------------

SELECT
    State,
    COUNT(*) AS Consumidores
FROM
    customer
GROUP BY
    State
ORDER BY Consumidores DESC;

------------TOTAL DE PRODUTOS VENDIDOS POR TIPO DE PRODUTO-----------------------------------------------------------

SELECT
    Sub_Category,
    COUNT(*) AS Vendas_por_Produto
FROM
    customer
GROUP BY
    Sub_Category
ORDER BY Vendas_por_Produto DESC;

------------TOTAL DE PRODUTOS VENDIDOS POR CATEGORIA------------------------------------------------------------------

SELECT
    Product_Category,
    COUNT(*) AS Vendas_por_Categoria
FROM
    customer
GROUP BY
    Product_Category
ORDER BY Vendas_por_Categoria DESC;

------------SOMA DAS VENDAS DE CADA ITEM(GERAL)------------------------------------------------------------------------------

SELECT Sub_Category, SUM(Quantity) as Soma_Itens_Vendidos
FROM customer
GROUP BY Sub_Category
ORDER BY Soma_Itens_Vendidos DESC;

------------SOMA DOS ITENS VENDIDOS DIVIDO POR PAÍSES-----------------------------------------------------------------

SELECT
    Country,  
	Sub_Category,
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'United States'
GROUP BY Country, Sub_Category
ORDER BY Country, Soma_Itens_Vendidos DESC;

SELECT
    Country,  
	Sub_Category,
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'France'
GROUP BY Country, Sub_Category
ORDER BY Country, Soma_Itens_Vendidos DESC;

SELECT
    Country,  
	Sub_Category,
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'Germany'
GROUP BY Country, Sub_Category
ORDER BY Country, Soma_Itens_Vendidos DESC;

SELECT
    Country,  
	Sub_Category,
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'United Kingdom'
GROUP BY Country, Sub_Category
ORDER BY Country, Soma_Itens_Vendidos DESC;


------------SOMA DOS ITENS VENDIDOS DE ACORDO COM O PAÍS/ESTADO---------------------------------------------------------

SELECT
    Country,
	[State],
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'United States'
GROUP BY [State], Country
ORDER BY Soma_Itens_Vendidos DESC;

------------SOMA DOS ITENS VENDIDOS DE ACORDO COM O PAÍS/ESTADO-------------------------------------------------------------

SELECT
    Country,
	[State],
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'United Kingdom'
GROUP BY [State], Country
ORDER BY Soma_Itens_Vendidos DESC;

------------SOMA DOS ITENS VENDIDOS DE ACORDO COM O PAÍS/ESTADO--------------------------------------------------------------

SELECT
    Country,
	[State],
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'Germany'
GROUP BY [State], Country
ORDER BY Soma_Itens_Vendidos DESC;

------------SOMA DOS ITENS VENDIDOS DE ACORDO COM O PAÍS/ESTADO--------------------------------------------------------------

SELECT
    Country,
	[State],
    SUM(Quantity) AS Soma_Itens_Vendidos,
	FORMAT(SUM(Revenue), 'C', 'en-US') AS Renda
FROM customer
WHERE Country = 'France'
GROUP BY [State], Country
ORDER BY Soma_Itens_Vendidos DESC;

------------RELAÇÃO DO GENERO COM AS CATEGORIAS DOS ITENS VENDIDOS E AS MÉDIAS DE IDADE RESPECTIVA--------------------------

SELECT
    Product_Category,
    COUNT(CASE WHEN Customer_Gender = 'Masculino' THEN 1 END) AS Masculino,
    ROUND(AVG(CASE WHEN Customer_Gender = 'Masculino' THEN Customer_Age END),0)AS Media_Idade_Masculino,
	COUNT(CASE WHEN Customer_Gender = 'Feminino' THEN 1 END) AS Feminino,   
    ROUND(AVG(CASE WHEN Customer_Gender = 'Feminino' THEN Customer_Age END),0) AS Media_Idade_Feminino
FROM customer
GROUP BY Product_Category;


------------QUANTIDADE DE ITENS VENDIDOS DE ACORDO COM O MÊS PARA CADA PAÍS---------------------------------------------------
SELECT   
	[Year],
	[Month],
	Country,
    Sub_Category,
    SUM(Quantity) AS QuantidadeItensVendidos
FROM customer
WHERE Country = 'United States'
GROUP BY [Year],[Month], Country, Sub_Category
ORDER BY 	
	[Year],
	CASE Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END,
    QuantidadeItensVendidos DESC;

SELECT   
	[Year],
	[Month],
	Country,
    Sub_Category,
    SUM(Quantity) AS QuantidadeItensVendidos
FROM customer
WHERE Country = 'United Kingdom'
GROUP BY [Year],[Month], Country, Sub_Category
ORDER BY 	
	[Year],
	CASE Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END,
    QuantidadeItensVendidos DESC;

SELECT   
	[Year],
	[Month],
	Country,
    Sub_Category,
    SUM(Quantity) AS QuantidadeItensVendidos
FROM customer
WHERE Country = 'Germany'
GROUP BY [Year],[Month], Country, Sub_Category
ORDER BY 	
	[Year],
	CASE Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END,
    QuantidadeItensVendidos DESC;

SELECT   
	[Year],
	[Month],
	Country,
    Sub_Category,
    SUM(Quantity) AS QuantidadeItensVendidos
FROM customer
WHERE Country = 'France'
GROUP BY [Year],[Month], Country, Sub_Category
ORDER BY 	
	[Year],
	CASE Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END,
    QuantidadeItensVendidos DESC;