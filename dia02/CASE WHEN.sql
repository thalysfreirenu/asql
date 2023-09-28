-- Databricks notebook source
SELECT *,
       CASE
          WHEN descUF = 'SP' THEN 'Paulista'
          WHEN descUF = 'PR'THEN 'Paranaense'
          WHEN descUF = 'RJ'THEN 'Fluminense'
       ELSE 'Desconhecido'
       END AS naturalidade,

       CASE
          WHEN descUF IN ('SP','RJ') THEN 'Sudeste'
          WHEN descUF IN ('SC', 'PR') THEN 'Sul'
       ELSE 'Desconhecido'
       END AS regiao

FROM silver.olist.cliente
