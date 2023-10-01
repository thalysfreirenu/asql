-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC ## Bora praticar?
-- MAGIC
-- MAGIC 1. Qual pedido com maior valor de frete?
-- MAGIC     - E o menor?
-- MAGIC
-- MAGIC 2. Qual cliente tem mais pedidos?
-- MAGIC
-- MAGIC 3. Qual vendedor tem mais itens vendidos?
-- MAGIC     - E o com menos?
-- MAGIC
-- MAGIC 4. Qual dia tivemos mais pedidos?
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Qual pedido com maior valor de frete?
SELECT idPedido,
       sum(vlFrete) AS vlTotalFrete

FROM silver.olist.item_pedido

GROUP BY idPedido
ORDER BY vlTotalFrete DESC

-- COMMAND ----------

-- DBTITLE 1,E o menor?
SELECT idPedido,
       sum(vlFrete) AS vlTotalFrete

FROM silver.olist.item_pedido

GROUP BY idPedido
ORDER BY vlTotalFrete

-- COMMAND ----------

-- DBTITLE 1,Qual cliente tem mais pedidos?
SELECT idCliente,
       count(*) AS qtPedido

FROM silver.olist.pedido
GROUP BY idCliente
ORDER BY qtPedido DESC

-- COMMAND ----------

-- DBTITLE 1,Qual vendedor tem mais itens vendidos?
SELECT idVendedor,
       count(*) AS qtdItensVendidos

FROM silver.olist.item_pedido

GROUP BY idVendedor
ORDER BY qtdItensVendidos DESC

-- COMMAND ----------

-- DBTITLE 1,E com menos?
SELECT idVendedor,
       count(*) AS qtdItensVendidos

FROM silver.olist.item_pedido

GROUP BY idVendedor
ORDER BY qtdItensVendidos

-- COMMAND ----------

-- DBTITLE 1,Qual dia tivemos mais pedidos?
SELECT DATE(dtPedido) as dataPedido,
       COUNT(DISTINCT idPedido) AS qtdPedido

FROM silver.olist.pedido

GROUP BY dataPedido
ORDER BY qtdPedido DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Tempo de foco (agregacões)
-- MAGIC
-- MAGIC 1. Quantos vendedores são do estado de São Paulo?
-- MAGIC 2. Quantos vendedores são de Presidente Prudente?
-- MAGIC 3. Quantos clientes são do estado do Rio de Janeiro?
-- MAGIC 4. Quantos produtos são de construção?
-- MAGIC 5. Qual o valor médio de um pedido? E do frete?
-- MAGIC 6. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?
-- MAGIC 7. Quanto tempo em média demora para um pedido chegar depois de aprovado?
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Quantos vendedores são do estado de São Paulo?
SELECT count(DISTINCT idVendedor) AS qtdeVendedor
FROM silver.olist.vendedor
WHERE descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,Quantos vendedores são de Presidente Prudente?
SELECT COUNT(DISTINCT idVendedor) AS qtdeVendedor
FROM silver.olist.vendedor
WHERE descCidade = 'presidente prudente'

-- COMMAND ----------

-- DBTITLE 1,Quantos clientes são do estado do Rio de Janeiro?
SELECT COUNT(*)
FROM silver.olist.cliente
WHERE descUF = 'RJ'

-- COMMAND ----------

-- DBTITLE 1,Quantos produtos são de construção?
SELECT COUNT(DISTINCT idProduto) AS qtdeProduto
FROM silver.olist.produto
WHERE descCategoria LIKE '%construcao%'

-- COMMAND ----------

-- DBTITLE 1,Qual o valor médio de um pedido? E do frete?
SELECT
      sum(vlPreco) / count(DISTINCT idPedido) AS avgValorPedido,
      sum(vlFrete) / count(DISTINCT idPedido) AS avgValorFrete

FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?
SELECT SUM(nrParcelas) / COUNT(DISTINCT idPedido) AS avgQtdeParcelas,
       SUM(vlPagamento) / SUM(nrParcelas) AS avgValorParcela

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'

-- COMMAND ----------

-- DBTITLE 1,Quanto tempo em média demora para um pedido chegar depois de aprovado?
SELECT avg(date_diff(dtEntregue,dtAprovado)) AS avgDiasEntrega

FROM silver.olist.pedido
WHERE dtAprovado IS NOT NULL
AND dtEntregue IS NOT NULL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ### Tempo de Foco (GROUP BY)
-- MAGIC
-- MAGIC 1. Qual estado tem mais vendedores?
-- MAGIC 2. Qual cidade tem mais clientes?
-- MAGIC 3. Qual categoria tem mais itens?
-- MAGIC 4. Qual categoria tem maior peso médio de produto?
-- MAGIC 5. Qual a série histórica de pedidos por dia? E receita? E por mês?
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Qual estado tem mais vendedores?
SELECT descUF,
       COUNT(DISTINCT idVendedor) as qtdeVendedor
FROM silver.olist.vendedor

GROUP BY descUF
ORDER BY qtdeVendedor DESC
LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Qual cidade tem mais clientes?
SELECT descCidade,
       COUNT(DISTINCT idClienteUnico) AS qtdeCliente
FROM silver.olist.cliente
GROUP BY descCidade
ORDER BY qtdeCliente DESC
LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Qual categoria tem mais itens?
SELECT descCategoria,
       COUNT(DISTINCT idProduto) AS qtdeProduto
FROM silver.olist.produto

GROUP BY descCategoria
ORDER BY qtdeProduto DESC
LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Qual categoria tem maior peso médio de produto?
SELECT descCategoria,
       avg(vlPesoGramas) As avgPeso
FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY avgPeso DESC
LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Qual a série histórica de pedidos por dia? E receita?
SELECT date(dtPedido) AS dataPedido,
       count(DISTINCT idPedido) AS qtdPedido

FROM silver.olist.pedido

GROUP BY dataPedido
ORDER BY dataPedido

-- COMMAND ----------

-- DBTITLE 1,E por mês?
SELECT 
       date(date_trunc('MONTH', dtPedido)) AS dataPedido,
       count(DISTINCT idPedido) AS qtdePedido
FROM silver.olist.pedido
GROUP BY dataPedido
ORDER BY dataPedido
