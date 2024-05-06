-- Retrieve all information about customers.
SELECT * FROM Customer; 

-- Get the list of bookings where additional payment (add_pay) was more than 250.
SELECT * FROM Booking WHERE add_pay > 250; 

-- Find packages that have a duration of more than 2 days.
SELECT * FROM Package WHERE duration > 2; 

-- List all hotels classified as '5 Star'
SELECT * FROM Hotel WHERE hotel_class = '5 Star'; 

-- Get details of all packages that include vegetarian food options.
SELECT * FROM Package WHERE food_type = 'Vegetarian'; 

-- List all bookings scheduled after May 1, 2024.
SELECT * FROM Booking WHERE date > TO_DATE('2024-05-01', 'YYYY-MM-DD'); 

-- Find all hotels in 'Sundarban'.
SELECT hotel_name, address, phone FROM Hotel WHERE address LIKE '%Sundarban%'; 

-- How would you drop the Agency table from your database?
DROP TABLE Agency; 

-- How do you add a new column 'rating' of type VARCHAR2 to the Hotel table? 
ALTER TABLE Hotel ADD (rating VARCHAR2(10)); 

-- How can you rename the column 'hotel_class' to 'class' in the Hotel table?
ALTER TABLE Hotel RENAME COLUMN hotel_class TO class; 

-- How would you modify the data type of the 'phone' column in the Customer table from VARCHAR2(15) to VARCHAR2(20)?
ALTER TABLE Customer MODIFY (phone VARCHAR2(20)); 

-- How can you drop the 'passport' column from the Customer table?
ALTER TABLE Customer DROP COLUMN passport; 

-- How would you update the email of the customer with customerID 1 to 'new.email@gmail.com'?
UPDATE Customer SET email = 'new.email@gmail.com' WHERE customerID = 1; 

-- How can you delete the row from the Booking table where bookingID is 2?
DELETE FROM Booking WHERE bookingID = 2; 

-- How to find the names of customers who are both in the Customer table and have bookings listed in the Booking table, without using JOIN?
SELECT customer_name FROM Customer INTERSECT SELECT customer_name FROM Booking; 
-- How can you use the WITH clause to create a temporary view of customers from 'City A' and select their names and phone numbers?
WITH CityACustomers AS (SELECT customer_name, phone FROM Customer WHERE address LIKE '%City A%') SELECT customer_name, phone FROM CityACustomers;

-- How many customers are registered in the database?
SELECT COUNT(*) AS Total_Customers FROM Customer; 

--What is the maximum and minimum package cost from the Booking table?
SELECT MAX(package_cost) AS Maximum_Cost, MIN(package_cost) AS Minimum_Cost FROM Booking; 

-- What is the average duration of all packages offered?
SELECT AVG(duration) AS Average_Duration FROM Package; 

-- How many bookings have been made for each customer? List the number of bookings per customer. 
SELECT customerID, COUNT(bookingID) AS Number_of_Bookings FROM Booking GROUP BY customerID; 

-- Find the total revenue generated from additional payments across all bookings. 
SELECT SUM(add_pay) AS Total_Additional_Payment FROM Booking;

--What is the highest price of any package currently offered? 
SELECT MAX(price) AS Highest_Package_Price FROM Package; 

-- What is the average price of the packages that include 'Vegetarian' food options?
SELECT AVG(price) AS Average_Price_Vegetarian FROM Package WHERE food_type = 'Vegetarian';
 
-- What is the total number of days for all bookings made so far? 
SELECT SUM(duration) AS Total_Duration FROM Package;

-- Which packages have a remaining capacity that is less than the average remaining capacity of all packages? 
SELECT packageID FROM Package WHERE remain_capacity < (SELECT AVG(remain_capacity) FROM Package); 

-- List the packageIDs and the number of times each packageID appears in the Booking table, but only for those appearing more than once.
SELECT packageID, COUNT(packageID) AS Frequency FROM Booking GROUP BY packageID HAVING COUNT(packageID) > 1; 

--Identify packages where the tour time is either in the 'Morning' or 'Evening' but not both.
SELECT packageID FROM Package WHERE Tourtime = 'Morning' OR Tourtime = 'Evening' AND NOT (Tourtime = 'Morning' AND Tourtime = 'Evening'); 

-- Find customers who have provided either a phone number or an email but not both. 
SELECT customerID FROM Customer WHERE (phone IS NOT NULL OR email IS NOT NULL) AND NOT (phone IS NOT NULL AND email IS NOT NULL); 

-- Which packages have a price that is higher than any package available in 'Sundarban'? 
SELECT packageID FROM Package WHERE price > ALL (SELECT price FROM Package WHERE location = 'Sundarban'); 

-- List the hotels where the phone number is either missing or incorrect (not a 10-digit number).
SELECT hotelID FROM Hotel WHERE phone IS NULL OR LENGTH(phone) != 10;
