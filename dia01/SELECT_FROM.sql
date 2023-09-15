-- Databricks notebook source
SELECT *
FROM silver.olist.pedido

-- SELECIONE TODAS AS COLUNAS DA TABELA silver.olist.pedido

-- COMMAND ----------

SELECT 
      idPedido,
      dtEntregue,
      idCliente

FROM silver.olist.pedido

-- COMMAND ----------

SELECT idPedido,
       idCliente,
       dtEntregue > dtEstimativaEntrega AS flAtraso

FROM silver.olist.pedido

-- COMMAND ----------

SELECT idPedido,
       idCliente,
       dtEntregue,
       dtEstimativaEntrega,
       date(dtEntregue) AS dataEntrega,
       date(dtEstimativaEntrega) AS dataEstimativa,
       dtEntregue > dtEstimativaEntrega AS flAtraso,
       date(dtEntregue) > date(dtEstimativaEntrega) AS flDataAtraso,
       date_diff(dtEntregue, dtEstimativaEntrega) AS nrDiasEntrega

FROM silver.olist.pedido

-- COMMAND ----------

SELECT 
       idProduto,
       vlComprimentoCm * vlAlturaCm * vlLarguraCm AS volCm3

FROM silver.olist.produto
