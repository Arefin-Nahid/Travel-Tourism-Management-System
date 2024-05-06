--How do you declare a variable for customer name and print its value

DECLARE
  v_customer_name VARCHAR2(100) := 'John Doe';
BEGIN
  DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_customer_name);
END;
-- How do you insert a row with a default value for the email column if it is not provided? 
DECLARE
  v_default_email VARCHAR2(100) := 'noemail@gmail.com';
BEGIN
  INSERT INTO Customer (customerID, customer_name, email) VALUES (3, 'Alice', v_default_email);
END;


-- How do you use a row type to fetch a customer record and display it?

DECLARE
  CURSOR c1 IS SELECT * FROM Customer WHERE customerID = 1;
  v_customer_rec c1%ROWTYPE;
BEGIN
  OPEN c1;
  FETCH c1 INTO v_customer_rec;
  DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_customer_rec.customer_name);
  CLOSE c1;
END;


--How do you create a procedure to update the email address of a customer? 

CREATE OR REPLACE PROCEDURE UpdateEmail (p_customer_id NUMBER, p_email VARCHAR2) AS
BEGIN
  UPDATE Customer SET email = p_email WHERE customerID = p_customer_id;
  COMMIT;
END;


-- How do you create a function to get the email of a customer by their ID?

CREATE OR REPLACE FUNCTION GetCustomerEmail (p_customer_id NUMBER) RETURN VARCHAR2 AS
  v_email VARCHAR2(100);
BEGIN
  SELECT email INTO v_email FROM Customer WHERE customerID = p_customer_id;
  RETURN v_email;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No Email Found';
END;


-- How do you create a trigger to log any updates to customer data?

CREATE OR REPLACE TRIGGER trg_customer_audit
AFTER UPDATE ON Customer
FOR EACH ROW
BEGIN
  INSERT INTO CustomerAudit (customerID, change_date, old_email, new_email)
  VALUES (:OLD.customerID, SYSDATE, :OLD.email, :NEW.email);
END;


-- How do you enforce email format checks before inserting or updating an email in the Customer table?

CREATE OR REPLACE TRIGGER trg_validate_email
BEFORE INSERT OR UPDATE ON Customer
FOR EACH ROW
BEGIN
  IF NOT REGEXP_LIKE(:NEW.email, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid email format');
  END IF;
END;


-- How do you automatically update the remaining capacity in the Package table when a new booking is made? 

CREATE OR REPLACE TRIGGER trg_update_capacity
AFTER INSERT ON Booking
FOR EACH ROW
DECLARE
  v_capacity NUMBER;
BEGIN
  SELECT remain_capacity INTO v_capacity FROM Package WHERE packageID = :NEW.packageID;
  IF v_capacity > 0 THEN
    UPDATE Package SET remain_capacity = remain_capacity - 1 WHERE packageID = :NEW.packageID;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, 'No available capacity');
  END IF;
END;


-- How do you prevent deletion from the Booking table if the booking date is less than 3 days away?

CREATE OR REPLACE TRIGGER trg_prevent_booking_deletion
BEFORE DELETE ON Booking
FOR EACH ROW
BEGIN
  IF :OLD.date - SYSDATE <= 3 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Cannot delete booking within 3 days of the event');
  END IF;
END;
