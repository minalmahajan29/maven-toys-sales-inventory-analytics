USE maven_toys;

-- 1. Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    product_cost DECIMAL(10,2),
    product_price DECIMAL(10,2)
);

-- 2. Stores Table
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(50),
    store_location VARCHAR(50),
    store_open_date DATE
);

-- 3. Calendar Table
CREATE TABLE calendar (
    date DATE PRIMARY KEY,
    day_of_week VARCHAR(20),
    month VARCHAR(20),
    quarter VARCHAR(10),
    year INT
);

-- 4. Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    date DATE,
    store_id INT,
    product_id INT,
    units INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (date) REFERENCES calendar(date)
);

-- 5. Inventory Table
CREATE TABLE inventory (
    store_id INT,
    product_id INT,
    stock_on_hand INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);