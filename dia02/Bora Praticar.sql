-- Databricks notebook source
-- Selecione todos os vendedores cariocas e paulistas

SELECT * 
FROM silver.olist.vendedor
WHERE (LOWER(descCidade) = 'rio de janeiro' AND descUF = 'RJ')
OR descUF = 'SP'


-- COMMAND ----------

-- DBTITLE 1,Ex 01 - Where (Téo)
-- Lista de pedidos com mais de um item.

SELECT DISTINCT idPedido
FROM silver.olist.item_pedido
WHERE idPedidoItem > 1

-- COMMAND ----------

-- DBTITLE 1,Ex 01 - Where (Valéria)
SELECT idPedido
FROM silver.olist.item_pedido
WHERE idPedidoItem = 2

-- COMMAND ----------

-- DBTITLE 1,Ex 05 - Where
-- Lista de pedidos que foram entregues com 2 dias de antecedência.
SELECT *,
       date(dtEntregue) AS dataEntrega,
       date(dtEstimativaEntrega) AS dataEstimativa,
       datediff(dtEstimativaEntrega,   dtEntregue) AS diffDatas

FROM silver.olist.pedido

WHERE datediff(dtEstimativaEntrega, dtEntregue) >= 2

-- COMMAND ----------

-- Selecione a tabela silver.olist.produto :
-- Crie uma coluna nova chamada ‘descNovaCategoria’ seguindo:
-- agrupe ‘alimentos’ e ‘alimentos_bebidas’ em ‘alimentos’
-- agrupe ‘artes’ e ‘artes_e_artesanato’ em ‘artes’
-- agrupe todas categorias de construção em uma única categoria chamada ‘construcao’
-- Cria uma coluna nova chamada ‘descPeso’
-- para peso menor que 2kg: ‘leve’
-- para peso entre 2kg e 5kg: ‘médio’
-- para peso entre 5kg e 10kg: ‘pesado’
-- para peso maior que 10kg: ‘muito pesado’

SELECT *,
       CASE
          WHEN descCategoria IN ('alimentos', 'alimentos_bebidas') THEN 'alimentos'
          WHEN descCategoria IN ('artes', 'artes_e_artesanato') THEN 'artes'
          WHEN descCategoria LIKE '%construcao%' THEN 'construcao'
          ELSE descCategoria
       END AS descNovaCategoria,

       CASE
          WHEN vlPesoGramas < 2000 THEN 'leve'
          WHEN vlPesoGramas < 5000 THEN 'medio'
          WHEN vlPesoGramas < 10000 THEN 'pesado'
          ELSE 'muito pesado'
       END AS descPeso

FROM silver.olist.produto

-- COMMAND ----------


