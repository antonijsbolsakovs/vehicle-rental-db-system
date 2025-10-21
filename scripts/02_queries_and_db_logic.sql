-- Queries
-- Query 1: JOIN 
-- This query joins the booking, customer, and vehicle tables to show which customer booked which vehicle and for what dates.
SELECT 
  c.first_name, 
  c.last_name, 
  v.make, 
  v.model, 
  b.start_date, 
  b.end_date
FROM booking b
JOIN customer c ON b.customer_id = c.customer_id
JOIN vehicle v ON b.vehicle_id = v.vehicle_id;

-- Query 2: GROUP BY
-- This groups the bookings by vehicle and counts how many times each vehicle has been booked.
SELECT 
  v.make, 
  v.model, 
  COUNT(b.booking_id) AS total_bookings
FROM vehicle v
JOIN booking b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id;

-- Query 3: IN
-- This selects only those vehicles that have received at least one review from a customer.
SELECT make, model
FROM vehicle
WHERE vehicle_id IN (
    SELECT vehicle_id FROM review
);

-- Functions, Procedures and triggers
-- Function 1

DELIMITER //
CREATE FUNCTION calculateTotalRentalCost(
    p_vehicle_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE rental_days INT;
    DECLARE daily_rate DECIMAL(10,2);
    DECLARE total_cost DECIMAL(10,2);

    SET rental_days = DATEDIFF(p_end_date, p_start_date);

    SELECT price_per_day INTO daily_rate
    FROM vehicle
    WHERE vehicle_id = p_vehicle_id;

    SET total_cost = rental_days * daily_rate;

    RETURN total_cost;
END //

DELIMITER ;

-- Usage Example
SELECT 
    vehicle_id,
    make,
    model,
    year,
    price_per_day,
    calculateTotalRentalCost(vehicle_id, '2025-04-01', '2025-04-05') AS total_rent_cost
FROM vehicle
ORDER BY price_per_day;

-- Function 2
DELIMITER //
CREATE FUNCTION getBookingDuration(startDate DATE, endDate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(endDate, startDate);
END //

DELIMITER ;
-- Usage Example
SELECT 
  booking_id,
  start_date,
  end_date,
  getBookingDuration(start_date, end_date) AS duration_days
FROM booking;

-- Procedures
Delimiter //

CREATE PROCEDURE createBookingWithPayment(
    IN cust_id INT,
    IN veh_id INT,
    IN start_date DATE,
    IN end_date DATE,
    IN payment_method VARCHAR(20)
)
BEGIN
    DECLARE booking_days INT;
    DECLARE price DECIMAL(10,2);
    DECLARE booking_id INT;

    SET booking_days = DATEDIFF(end_date, start_date);
    SELECT price_per_day INTO price FROM vehicle WHERE vehicle_id = veh_id;

    INSERT INTO booking (customer_id, vehicle_id, start_date, end_date, created_at)
    VALUES (cust_id, veh_id, start_date, end_date, CURDATE());

    SET booking_id = LAST_INSERT_ID();

    INSERT INTO payment (booking_id, amount, payment_method, status, payment_date)
    VALUES (booking_id, price * booking_days, payment_method, 'Completed', CURDATE());
END //
Delimiter ;

-- Usage Example
CALL createBookingWithPayment(2, 5, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Credit Card');

-- Query of the created data
SELECT * FROM booking WHERE customer_id = 2 ORDER BY booking_id DESC LIMIT 1;
SELECT * FROM payment ORDER BY payment_id DESC LIMIT 1;

-- Triggers
Delimiter //

CREATE TRIGGER updateVehicleStatusAfterBooking
AFTER INSERT ON booking
FOR EACH ROW
BEGIN
    UPDATE vehicle
    SET status = 'Rented'
    WHERE vehicle_id = NEW.vehicle_id;
END //
Delimiter ;

-- Usage example
INSERT INTO booking (customer_id, vehicle_id, start_date, end_date, created_at)
VALUES (3, 6, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY), CURDATE());

SELECT vehicle_id, make, model, status
FROM vehicle
WHERE vehicle_id = 6;

-- DELETE and UPDATE
-- DELETE
DELETE FROM customer 
WHERE first_name IN ('John', 'Bob');

-- UPDATE
UPDATE customer 
SET email = 
    CASE 
        WHEN first_name = 'John' THEN 'john.doe123@example.com'
        WHEN first_name = 'Bob' THEN 'bob.williams123@example.com'
    END
WHERE first_name IN ('John', 'Bob');

