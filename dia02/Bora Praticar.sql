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
