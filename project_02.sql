CREATE DATABASE fintech_personalization;
USE fintech_personalization;

-- 1. customer_profile
CREATE TABLE customer_profile (
    customer_id INT PRIMARY KEY,
    age INT,
    city VARCHAR(50),
    city_tier VARCHAR(10),
    income_band VARCHAR(10),
    preferred_category VARCHAR(20),
    signup_date DATE
);

-- 2. product_catalog
CREATE TABLE product_catalog (
    product_id INT PRIMARY KEY,
    category VARCHAR(20),
    price DECIMAL(10,2),
    brand VARCHAR(100),
    discount INT,
    rating DECIMAL(2,1)
);

-- 3. customer_transactions
CREATE TABLE customer_transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    txn_date DATETIME,
    amount DECIMAL(10,2),
    category VARCHAR(20),
    payment_mode VARCHAR(20),
    merchant_type VARCHAR(10),
    is_discounted TINYINT,
    
    FOREIGN KEY (customer_id) REFERENCES customer_profile(customer_id),
    FOREIGN KEY (product_id) REFERENCES product_catalog(product_id)
);

-- 4. browsing_behavior
CREATE TABLE browsing_behavior (
    session_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    view_time INT,
    added_to_cart TINYINT,
    device VARCHAR(10),
    time_of_day VARCHAR(20),

    FOREIGN KEY (customer_id) REFERENCES customer_profile(customer_id),
    FOREIGN KEY (product_id) REFERENCES product_catalog(product_id)
);

select COUNT(*) from customer_profile;
SELECT COUNT(*) FROM product_catalog;
select COUNT(*) from customer_transactions;
select COUNT(*) from browsing_behavior;

SELECT * FROM customer_transactions LIMIT 5;

-- PERFORMANCE BOOST

CREATE INDEX idx_customer ON customer_transactions(customer_id);
CREATE INDEX idx_product ON customer_transactions(product_id);
CREATE INDEX idx_session_customer ON browsing_behavior(customer_id);

-- Need to BUILD MASTER FEATURE TABLE

-- 1. RFM (Recency, Frequency, Monetary) FEATURES

  CREATE TABLE customer_features AS
SELECT 
    c.customer_id,

    -- RECENCY (days since last transaction)
    DATEDIFF(CURDATE(), MAX(t.txn_date)) AS recency,

    -- FREQUENCY (number of transactions)
    COUNT(t.txn_id) AS frequency,

    -- MONETARY (total spend)
    SUM(t.amount) AS total_spend,

    -- AOV (average order value)
    AVG(t.amount) AS avg_order_value

FROM customer_profile c
LEFT JOIN customer_transactions t 
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id;

select * from customer_features;
select count(*) from customer_features;

-- 2. DISCOUNT SENSITIVITY
alter table customer_features add discount_ratio float;
SET SQL_SAFE_UPDATES = 0;
update customer_features cf
  join (
      select customer_id,
      avg(is_discounted) as discount_ratio
      from customer_transactions
      group by customer_id
      ) t
      on cf.customer_id = t.customer_id
      set cf.discount_ratio = t.discount_ratio;


select count(*) from customer_features;
select * from customer_features;

-- 3. CATEGORY AFFINITY
 -- here we are observing, What category does customer prefer?
 
 ALTER TABLE customer_features ADD top_category VARCHAR(20);

UPDATE customer_features cf
JOIN (
    SELECT customer_id, category
    FROM (
        SELECT customer_id, category,
               COUNT(*) AS cnt,
               RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) rnk
        FROM customer_transactions
        GROUP BY customer_id, category
    ) ranked
    WHERE rnk = 1
) t
ON cf.customer_id = t.customer_id
SET cf.top_category = t.category;

SELECT * FROM customer_features;

-- 4. BROWSING BEHAVIOR FEATURES
ALTER TABLE customer_features 
ADD total_views INT,
ADD cart_add_ratio FLOAT;

UPDATE customer_features cf
JOIN (
    SELECT 
        customer_id,
        COUNT(*) AS total_views,
        AVG(added_to_cart) AS cart_add_ratio
    FROM browsing_behavior
    GROUP BY customer_id
) b
ON cf.customer_id = b.customer_id
SET 
    cf.total_views = b.total_views,
    cf.cart_add_ratio = b.cart_add_ratio;
    
    select * from customer_features;
    select count(*) from customer_features;
    
    -- 5. CONVERSION PROXY
    
    ALTER TABLE customer_features ADD conversion_rate FLOAT;

UPDATE customer_features cf
SET conversion_rate = 
    CASE 
        WHEN total_views = 0 THEN 0
        ELSE frequency / total_views
    END;
    
 select * from customer_features;   
    
-- now customer_features is ML-ready data

-- EXPORT TO PYTHON
SELECT * FROM customer_features;

ALTER TABLE customer_features ADD segment VARCHAR(50);

ALTER USER 'root'@'localhost' 
IDENTIFIED WITH mysql_native_password 
BY 'Vansh@1012';

FLUSH PRIVILEGES;

SELECT segment, COUNT(*) 
FROM customer_features 
GROUP BY segment;

-- LAYER 1 — CANDIDATE GENERATION
-- 1A. Top Products by Segment
   CREATE VIEW segment_top_products AS
SELECT 
    cf.segment,
    t.product_id,
    COUNT(*) AS purchase_count
FROM customer_features cf
JOIN customer_transactions t 
    ON cf.customer_id = t.customer_id
GROUP BY cf.segment, t.product_id;

-- 1B. High Intent Products
   CREATE VIEW high_intent_products AS
SELECT 
    b.customer_id,
    b.product_id,
    COUNT(*) AS views
FROM browsing_behavior b
LEFT JOIN customer_transactions t
    ON b.customer_id = t.customer_id
    AND b.product_id = t.product_id
WHERE t.product_id IS NULL
GROUP BY b.customer_id, b.product_id;

-- from here we'll load data in Python
DESCRIBE customer_transactions;
DESCRIBE browsing_behavior;