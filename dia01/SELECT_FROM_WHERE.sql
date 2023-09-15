-- Databricks notebook source
SELECT *
FROM silver.olist.pedido
-- WHERE NOT date(dtEstimativaEntrega) < date(dtEntregue)
WHERE date(dtEstimativaEntrega) >= date(dtEntregue)

-- COMMAND ----------

SELECT *

FROM silver.olist.produto

WHERE (descCategoria = 'bebes'
OR descCategoria = 'perfurmaria'
OR descCategoria = 'artes'
)
AND vlComprimentoCm * vlAlturaCm * vlLarguraCm > 1000


-- COMMAND ----------

SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('bebes','perfurmaria','artes')
AND vlComprimentoCm * vlAlturaCm * vlLarguraCm > 1000

-- COMMAND ----------

(1 + 1) * 0 = 0

-- COMMAND ----------

1 + 1 = ligado
0 + 1 = ligado
0 + 0 = desligado
1 + 0 = ligado

1 * 1 = ligado
0 * 1 = desligado
0 * 0 = desligado
1 * 0 = desligado

-- COMMAND ----------

SELECT *
FROM silver.olist.produto
WHERE descCategoria LIKE '%ferramentas%'
