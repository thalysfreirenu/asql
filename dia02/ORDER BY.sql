-- Databricks notebook source

SELECT *

FROM silver.olist.produto

WHERE descCategoria = 'bebes'

ORDER BY vlPesoGramas DESC, vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC
