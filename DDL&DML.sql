--1. Customer Table

CREATE TABLE Customer ( customerID NUMBER PRIMARY KEY, customer_name VARCHAR2(100), customer_NID VARCHAR2(20), passport VARCHAR2(20), address VARCHAR2(200), phone VARCHAR2(15), email VARCHAR2(100) );

-- Sample Data Insertion 
INSERT INTO Customer VALUES (1, 'Miraz', '1234567890', 'AB1234567', '123 Dhaka', '0123456789', 'miraz@gmail.com'); 
INSERT INTO Customer VALUES (2, 'Smith', '0987654321', 'CD7654321', '456 khulna', '9876543210', 'smith@gmail.com'); 

--2. Booking Table

CREATE TABLE Booking ( bookingID NUMBER PRIMARY KEY, customerID NUMBER, booking_date DATE, customer_name VARCHAR2(100), package_cost NUMBER, add_pay NUMBER, FOREIGN KEY (customerID) REFERENCES Customer(customerID) ); 
 
-- Sample Data Insertion
INSERT INTO Booking VALUES (1, 1, TO_DATE('2024-05-20', 'YYYY-MM-DD'), `Miraz`, 1500, 300);
INSERT INTO Booking VALUES (2, 2, TO_DATE('2024-05-22', 'YYYY-MM-DD'), `Amit`, 1800, 200); 

--3. Package Table

CREATE TABLE Package ( packageID NUMBER PRIMARY KEY, Tourtime VARCHAR2(50), location VARCHAR2(100), start_location VARCHAR2(100), end_location VARCHAR2(100), capacity NUMBER, remain_capacity NUMBER, duration NUMBER, food_type VARCHAR2(50), price NUMBER );

 -- Sample Data Insertion 
INSERT INTO Package VALUES (1, 'Morning', 'Sundarban', 'City A', 'City B', 40, 10, 3, 'Vegetarian', 1500); 
INSERT INTO Package VALUES (2, 'Evening', 'Coxs Bazar', 'City C', 'City D', 30, 5, 2, 'Non-Vegetarian', 1800); 

--4. Hotel Table

CREATE TABLE Hotel ( hotelID NUMBER PRIMARY KEY, packageID NUMBER, hotel_name VARCHAR2(100), hotel_class VARCHAR2(10), address VARCHAR2(200), phone VARCHAR2(15), FOREIGN KEY (packageID) REFERENCES Package(packageID) ); 

-- Sample Data Insertion 
INSERT INTO Hotel VALUES (1, 1, 'Green Resort', '5 Star', '123 Resort St, Sundarban', '0345678901');
INSERT INTO Hotel VALUES (2, 2, 'Blue Hotel', '4 Star', '456 Hotel Rd, Coxs Bazar', '0987654321'); 

--5. Agency Table

CREATE TABLE Agency ( AgencyID NUMBER PRIMARY KEY, packageID NUMBER, agency_name VARCHAR2(100), agency_manager VARCHAR2(100), contact VARCHAR2(15), email VARCHAR2(100), FOREIGN KEY (packageID) REFERENCES Package(packageID) );

 -- Sample Data Insertion
INSERT INTO Agency VALUES (1, 1, 'TravelA', 'Miraz', '0345678902', 'Miraz@travela.com'); 
INSERT INTO Agency VALUES (2, 2, 'TravelB', `Amit`, '0987654322', 'Amit@travelb.com'); 
