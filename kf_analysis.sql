CREATE OR REPLACE TABLE `rakamin-kf-analytics-472705.kimia_farma.kf_analysis` AS
WITH tx AS (
  SELECT
    transaction_id,
    SAFE_CAST(date AS DATE) AS date,
    branch_id,
    customer_name,
    product_id,
    SAFE_CAST(price AS FLOAT64) AS price,
    SAFE_CAST(REPLACE(CAST(discount_percentage AS STRING), '%', '') AS FLOAT64) AS discount_pct,
    rating AS rating_transaksi
  FROM `rakamin-kf-analytics-472705.kimia_farma.kf_final_transaction`
),
prod AS (
  SELECT product_id, product_name
  FROM `rakamin-kf-analytics-472705.kimia_farma.kf_product`
),
branch AS (
  SELECT branch_id, branch_name, kota, provinsi, rating AS rating_cabang
  FROM `rakamin-kf-analytics-472705.kimia_farma.kf_kantor_cabang`
)
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  b.branch_name,
  b.kota,
  b.provinsi,
  b.rating_cabang,
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price AS actual_price,
  t.discount_pct AS discount_percentage,
  CASE
    WHEN t.price <= 50000 THEN 10
    WHEN t.price <= 100000 THEN 15
    WHEN t.price <= 300000 THEN 20
    WHEN t.price <= 500000 THEN 25
    ELSE 30
  END AS persentase_gross_laba,
  ROUND(t.price * (1 - t.discount_pct/100), 2) AS nett_sales,
  ROUND(
    (t.price * (1 - t.discount_pct/100)) *
    (CASE
      WHEN t.price <= 50000 THEN 10
      WHEN t.price <= 100000 THEN 15
      WHEN t.price <= 300000 THEN 20
      WHEN t.price <= 500000 THEN 25
      ELSE 30
    END) / 100
  , 2) AS nett_profit,
  t.rating_transaksi
FROM tx t
LEFT JOIN prod p USING (product_id)
LEFT JOIN branch b USING (branch_id);
