-- Databricks notebook source
SELECT 
      date(dtPedido) AS diaPedido,
      count(DISTINCT idPedido) AS qtdePedido

FROM silver.olist.pedido

GROUP BY diaPedido
ORDER BY diaPedido

-- COMMAND ----------

SELECT descCategoria,
      count(idProduto) AS qtdeProduto,
      avg(vlPesoGramas) AS avgPeso,
      avg(vlAlturaCm * vlComprimentoCm * vlLarguraCm) AS avgVolume

FROM silver.olist.produto

GROUP BY descCategoria
HAVING qtdeProduto >= 500

ORDER BY qtdeProduto DESC
