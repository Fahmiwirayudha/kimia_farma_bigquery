# kimia_farma_bigquery
# Kimia Farma BigQuery Project

Repository ini berisi query SQL untuk membangun tabel analisa Kimia Farma pada Google BigQuery.  
Tabel analisa ini dibuat berdasarkan agregasi dari 4 tabel utama: transaksi, produk, cabang, dan inventory.

## Tabel yang digunakan
- kf_final_transact
- kf_product
- kf_kantor_caban
- kf_inventory

## Output
Tabel analisa `kf_analysis` dengan kolom:
- transaction_id, date, branch_id, branch_name, kota, provinsi
- rating_cabang, customer_name
- product_id, product_name
- actual_price, discount_percentage, persentase_gross_laba
- nett_sales, nett_profit
- rating_transaksi

## Tools
- Google BigQuery (SQL)
- Google Cloud Platform (GCP)
