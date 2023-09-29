-- Databricks notebook source
SELECT count(*), -- contagem de linhas da tabela
       count(1), -- contagem de linhas da tabela
       count(idProduto), -- contagem de linhas de produto nao nulas
       count(DISTINCT idProduto) -- contagem de linhas de produtos distintos
FROM silver.olist.produto

-- COMMAND ----------

SELECT COUNT(*)
FROM silver.olist.pedido

-- COMMAND ----------

SELECT count(*), -- contagem de linhas da tabela
       count(1), -- contagem de linhas da tabela
       count(idProduto), -- contagem de linhas de produto nao nulas
       count(DISTINCT idProduto), -- contagem de linhas de produtos distintos
       count(DISTINCT idPedido, idPedidoItem)

FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT avg(vlPesoGramas),
       min(vlPesoGramas),
       max(vlPesoGramas),
       std(vlPesoGramas),
       percentile(vlPesoGramas,0.25),
       median(vlPesoGramas),
       percentile(vlPesoGramas,0.75)

FROM silver.olist.produto

-- COMMAND ----------

SELECT descUF,
       COUNT(DISTINCT idVendedor) AS qtdeVendedor

FROM silver.olist.vendedor

GROUP BY descUF
ORDER BY descUF

-- COMMAND ----------

SELECT descCategoria,
       avg(vlPesoGramas) as avgPesoCategoria,
       COUNT(idProduto) AS qtdeProduto

FROM silver.olist.produto

GROUP BY descCategoria
ORDER BY avgPesoCategoria DESC

LIMIT 10
