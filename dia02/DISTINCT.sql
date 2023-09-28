-- Databricks notebook source
SELECT DISTINCT descUF
FROM silver.olist.cliente
ORDER BY descUF

-- COMMAND ----------

SELECT DISTINCT descUF, descCidade
FROM silver.olist.cliente
ORDER BY descUF asc, descCidade desc
