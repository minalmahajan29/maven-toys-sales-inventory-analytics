USE maven_toys;

-- Which Product Categories Drive the Biggest Profits?
SELECT 
    p.Product_Category,
    ROUND(SUM((p.Product_Price - p.Product_Cost) * s.Units), 2) AS Total_Profit,
    ROUND(SUM(p.Product_Price * s.Units), 2) AS Total_Revenue
FROM sales s
JOIN products p ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Total_Profit DESC;

SELECT *
FROM products p
JOIN sales s 
ON p.product_id=s.product_id
LIMIT 50;

-- Is this top category the same across store locations?
SELECT 
    st.Store_Location,
    p.Product_Category,
    ROUND(SUM((p.Product_Price - p.Product_Cost) * s.Units), 2) AS Total_Profit
FROM sales s
JOIN products p ON s.Product_ID = p.Product_ID
JOIN stores st ON s.Store_ID = st.Store_ID
GROUP BY st.Store_Location, p.Product_Category
ORDER BY st.Store_Location, Total_Profit DESC;

-- Can you find any seasonal trends or patterns in the sales data?
SELECT 
    DATE_FORMAT(s.Date, '%Y-%m') AS YearMonth,
    ROUND(SUM((p.Product_Price - p.Product_Cost) * s.Units), 2) AS Total_Profit,
    SUM(s.Units) AS Total_Units_Sold
FROM sales s
JOIN products p ON s.Product_ID = p.Product_ID
GROUP BY YearMonth
ORDER BY Total_profit ASC;

SELECT 
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS Total_Units_Sold,
    SUM(i.Stock_On_Hand) AS Total_Current_Stock
FROM sales s
JOIN products p ON s.Product_ID = p.Product_ID
JOIN inventory i ON s.Store_ID = i.Store_ID AND s.Product_ID = i.Product_ID
GROUP BY p.Product_Name, p.Product_Category
ORDER BY Total_Units_Sold DESC, Total_Current_Stock ASC;

-- Are we losing sales due to out-of-stock products?
SELECT 
    ROUND(SUM(i.Stock_On_Hand * p.Product_Cost), 2) AS Total_Inventory_Value
FROM inventory i
JOIN products p ON i.Product_ID = p.Product_ID;