CREATE TABLE portofolio.retail_sales (
    transaction_id INT PRIMARY KEY,
    date DATE,
    customer_id VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    product_category VARCHAR(100),
    quantity INT,
    price_per_unit NUMERIC,
    total_amount NUMERIC
);

SELECT * FROM portofolio.retail_sales;

-- Menampilkan semua transaksi yang terjadi pada tahun 2023
-- Dan diurutkan dari transaksi terbaru hingga transaksi terlama.
SELECT * FROM portofolio.retail_sales
WHERE EXTRACT(YEAR FROM date) = 2023
ORDER BY date DESC;

-- Berapa total transaksi dan total revenue keseluruhan?
SELECT COUNT(transaction_id)AS total_transaksi,
		SUM(total_amount) AS total_revenue
FROM portofolio.retail_sales;

-- Tampilkan daftar transaksi khusus pelanggan perempuan yang membeli Electronics.
SELECT * FROM portofolio.retail_sales
WHERE gender = 'Female' AND product_category = 'Electronics';

-- Menampilkan berapa total revenue dan rata-rata transaksi per kategori produk
-- dan di urutkan dari yang tertinggi ke terendah.
SELECT product_category,
	SUM(total_amount) AS total_revenue,
	ROUND(AVG(total_amount),2) AS average_transaction
FROM portofolio.retail_sales
GROUP BY product_category
ORDER BY 2 DESC;

-- Menampilkan total revenue per bulan selama tahun 2023. 
-- Serta menampilkan juga ulan mana yang paling tinggtotal revenuenya
SELECT 
  EXTRACT(MONTH FROM date) AS month,
  SUM(total_amount) AS total_revenue
FROM portofolio.retail_sales
WHERE EXTRACT(YEAR FROM date) = 2023
GROUP BY EXTRACT(MONTH FROM date)
ORDER BY month;

-- menampilkan siapa 10 pelanggan dengan total belanja tertinggi
SELECT customer_id,
		SUM(total_amount) AS total_belanja
FROM portofolio.retail_sales
GROUP BY customer_id
ORDER BY total_belanja DESC
LIMIT 10;

-- Memandingkan total revenue antara pelanggan laki-laki dan perempuan
-- dengan di kategorikan berdasarkan produk.
SELECT gender, product_category,
		SUM(total_amount) AS total_revenue
FROM portofolio.retail_sales
GROUP BY gender, product_category
ORDER BY total_revenue DESC;

-- mengelompokkan pelanggan berdasarkan kelompok usia: Muda (18–29), Dewasa (30–45), Senior (46–64). 
-- Serta menampilkan kelompok mana yang paling banyak bertransaksi
SELECT CASE
		WHEN age BETWEEN 18 AND 29 THEN 'Muda'
		WHEN age BETWEEN 30 AND 45 THEN 'Dewasa'
		WHEN age BETWEEN 46 AND 64 THEN 'Senior'
		END AS kelompok_usia,
		COUNT(*) AS jumlah_transaksi,
		SUM(total_amount) AS total_revenue
FROM portofolio.retail_sales
GROUP BY kelompok_usia
ORDER BY 2 DESC;

--  Menampilkan transaksi dengan nilai Total Amount tertinggi dari setiap kategori produk.
SELECT *
FROM portofolio.retail_sales
WHERE (product_category, total_amount) IN (
  SELECT product_category, MAX(total_amount)
  FROM portofolio.retail_sales
  GROUP BY product_category
);