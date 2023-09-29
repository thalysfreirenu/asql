-- Databricks notebook source
-- Qual estado tem mais vendedores?

SELECT 
       descUF,
       count(distinct idVendedor) AS qtdeVendedor
FROM silver.olist.vendedor
WHERE descUF IS NOT NULL
GROUP BY descUF
HAVING qtdeVendedor > 20
ORDER BY qtdeVendedor DESC
LIMIT 1

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido

-- WHERE dtPedido <= '2017-12-01'
-- AND dtPedido >= date('2017-12-01') - INTERVAL 3 MONTH

-- WHERE dtPedido <= NOW()
-- AND dtPedido >= add_months(NOW(), -3)

WHERE dtPedido <= NOW()
AND dtPedido >= dateadd(month,-3, '2017-12-01')
