-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC ## Bora praticar?
-- MAGIC
-- MAGIC 1. Selecione todos os clientes paulistanos
-- MAGIC 2. Selecione todos os clientes paulistas
-- MAGIC 3. Selecione todos os vendedores cariocas e paulistas
-- MAGIC 4. Selecione produtos de perfumaria e bebes com altura maior que 5cm

-- COMMAND ----------

-- DBTITLE 1,Selecione todos os clientes paulistanos
SELECT *
FROM silver.olist.cliente
WHERE descCidade = 'sao paulo'

-- COMMAND ----------

-- DBTITLE 1,Selecione todos os clientes paulistas
SELECT *
FROM silver.olist.cliente
WHERE descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,Selecione todos os vendedores cariocas e paulistas
SELECT *
FROM silver.olist.cliente
WHERE descUF = 'SP'
OR (descUF = 'RJ' AND descCidade = 'rio de janeiro')

-- COMMAND ----------

-- DBTITLE 1,Selecione produtos de perfumaria e bebes com altura maior que 5cm
SELECT *
FROM silver.olist.produto
WHERE descCategoria IN ('perfumaria', 'bebes')
AND vlAlturaCm >= 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC A gora temos os exercícios
-- MAGIC
-- MAGIC 1. Lista de pedidos com mais de um item.
-- MAGIC 2. Lista de pedidos que o frete é mais caro que o item.
-- MAGIC 3. Lista de pedidos que ainda não foram enviados.
-- MAGIC 4. Lista de pedidos que foram entregues com atraso.
-- MAGIC 5. Lista de pedidos que foram entregues com 2 dias de antecedência.
-- MAGIC 6. Lista de pedidos feitos em dezembro de 2017 e entregues com atraso
-- MAGIC 7. Lista de pedidos com avaliação maior ou igual que 4
-- MAGIC 8. Lista de pedidos com 2 ou mais parcelas menores que R$20,00
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,1. Lista de pedidos com mais de um item.
SELECT *
FROM silver.olist.item_pedido
WHERE idPedidoItem = 2

-- COMMAND ----------

-- DBTITLE 1,2. Lista de pedidos que o frete é mais caro que o item.
SELECT *
FROM silver.olist.item_pedido
WHERE vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,3. Lista de pedidos que ainda não foram enviados.
SELECT *
FROM silver.olist.pedido
WHERE dtEnvio IS NULL

-- COMMAND ----------

-- DBTITLE 1,4. Lista de pedidos que foram entregues com atraso.
SELECT *
FROM silver.olist.pedido
WHERE date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,5. Lista de pedidos que foram entregues com 2 dias de antecedência.
SELECT *
FROM silver.olist.pedido
WHERE date_diff(date(dtEstimativaEntrega), date(dtEntregue)) >= 2

-- COMMAND ----------

-- DBTITLE 1,6. Lista de pedidos feitos em dezembro de 2017 e entregues com atraso
SELECT *
FROM silver.olist.pedido
WHERE YEAR(dtPedido) = 2017 AND MONTH(dtPedido) = 12
AND date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,7. Lista de pedidos com avaliação maior ou igual que 4
SELECT *
FROM silver.olist.avaliacao_pedido
WHERE vlNota >= 4

-- COMMAND ----------

-- DBTITLE 1,8. Lista de pedidos com 2 ou mais parcelas menores que R$20,00
SELECT *,
       vlPagamento / nrParcelas AS vlParcela

FROM silver.olist.pagamento_pedido
WHERE vlPagamento / nrParcelas < 20
AND nrParcelas >= 2

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Tempo de foco (case)
-- MAGIC
-- MAGIC 1. Selecione todos os pedidos e marque se houve atraso ou não
-- MAGIC
-- MAGIC 2. Selecione os pedidos/itens e defina os grupos em uma nova coluna:
-- MAGIC     - para frete inferior à 10%: ‘10%’
-- MAGIC     - para frete entre 10% e 25%: ‘10% a 25%’
-- MAGIC     - para frete entre 25% e 50%: ‘25% a 50%’
-- MAGIC     - para frete maior que 50%: ‘+50%’
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,1. Selecione todos os pedidos e marque se houve atraso ou não
SELECT *,
       CASE
          WHEN date(dtEntregue) > date(dtEstimativaEntrega) THEN TRUE
          ELSE FALSE
       END AS flAtraso

FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,2. Selecione os pedidos/itens e defina os grupos em uma nova coluna
-- para frete inferior à 10%: ‘10%’
-- para frete entre 10% e 25%: ‘10% a 25%’
-- para frete entre 25% e 50%: ‘25% a 50%’
-- para frete maior que 50%: ‘+50%’

SELECT *,
       CASE
          WHEN vlFrete / (vlPreco + vlFrete) < 0.1 THEN '10%'
          WHEN vlFrete / (vlPreco + vlFrete) < 0.25 THEN '25%'
          WHEN vlFrete / (vlPreco + vlFrete) < 0.5 THEN '50%'
          ELSE '+50%'
       END AS descGrupoDesconto

FROM silver.olist.item_pedido

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Desafio
-- MAGIC
-- MAGIC Selecione a tabela silver.olist.produto :
-- MAGIC
-- MAGIC 1. Crie uma coluna nova chamada ‘descNovaCategoria’ seguindo:
-- MAGIC     - agrupe ‘alimentos’ e ‘alimentos_bebidas’ em ‘alimentos’;
-- MAGIC     - agrupe ‘artes’ e ‘artes_e_artesanato’ em ‘artes’;
-- MAGIC     - agrupe todas categorias de construção em uma única categoria chamada ‘construção’;
-- MAGIC
-- MAGIC 2. Crie uma coluna nova chamada ‘descPeso’
-- MAGIC     - para peso menor que 2kg: ‘leve’;
-- MAGIC     - para peso entre 2kg e 5kg: ‘médio’;
-- MAGIC     - para peso entre 5kg e 10kg: ‘pesado’;
-- MAGIC     - para peso maior que 10kg: ‘muito pesado’;

-- COMMAND ----------

SELECT *,
       
       CASE
          WHEN descCategoria IN ('alimentos', 'alimentos_bebidas') THEN 'alimentos'
          WHEN descCategoria IN ('artes', 'artes_e_artesanato') THEN 'artes'
          WHEN descCategoria LIKE '%construcao%' THEN 'construcao'
          ELSE descCategoria
       END AS descNovaCategoria,

       CASE
          WHEN vlPesoGramas < 2000 THEN 'leve'
          WHEN vlPesoGramas < 5000 THEN 'medio'
          WHEN vlPesoGramas < 10000 THEN 'pesado'
          ELSE 'muito pesado'
       END AS descPeso

FROM silver.olist.produto

