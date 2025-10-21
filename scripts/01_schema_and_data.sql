CREATE DATABASE VehicleRentalDB;
USE VehicleRentalDB;
-- Customers Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    address TEXT NOT NULL,
    created_at DATE NOT NULL
);

-- Categories Table
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name ENUM('Economy', 'Premium', 'SUV', 'Electric', 'Convertible') NOT NULL,
    description TEXT
);

-- Vehicles Table
CREATE TABLE vehicle (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    status ENUM('Available', 'Rented', 'Maintenance') DEFAULT 'Available',
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE SET NULL
);

-- Bookings Table
CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled', 'Completed') DEFAULT 'Pending',
	created_at DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);

-- Payments Table
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
	payment_date DATE NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

-- Insurance Table
CREATE TABLE insurance (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    policy_number VARCHAR(50) UNIQUE NOT NULL,
    provider VARCHAR(100) NOT NULL,
    coverage_details TEXT,
	start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);

-- Maintenance Table
CREATE TABLE maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    service_date DATE NOT NULL,
    details TEXT NOT NULL,
    cost DECIMAL(10,2),
    status ENUM('Scheduled', 'Completed', 'In Progress') DEFAULT 'Scheduled',
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);

-- Reviews Table
CREATE TABLE review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);

-- Insert data into the Customers table
INSERT INTO customer (first_name, last_name, email, phone, address, created_at)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street, SomeCity', CURDATE()),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak Road, OtherCity', CURDATE()),
('Alice', 'Johnson', 'alice.johnson@example.com', '1112223333', '789 Pine Ave, Smalltown', CURDATE()),
('Bob', 'Williams', 'bob.williams@example.com', '4445556666', '321 Maple Street, Bigcity', CURDATE()),
('Carol', 'Brown', 'carol.brown@example.com', '7778889999', '654 Cedar Blvd, Lakeview', CURDATE()),
('David', 'Jones', 'david.jones@example.com', '2223334444', '987 Spruce Way, Hilltown', CURDATE()),
('Eve', 'Davis', 'eve.davis@example.com', '5556667777', '159 Birch Lane, Riverdale', CURDATE()),
('Frank', 'Miller', 'frank.miller@example.com', '8889990000', '753 Willow Street, Coastville', CURDATE()),
('Grace', 'Wilson', 'grace.wilson@example.com', '6667778888', '852 Aspen Rd, Forestburg', CURDATE()),
('Henry', 'Moore', 'henry.moore@example.com', '9990001111', '951 Redwood Dr, Greenfield', CURDATE()),
('Ivy', 'Taylor', 'ivy.taylor@example.com', '3334445555', '357 Chestnut Ct, Sunnytown', CURDATE());

-- Insert data into the Categories table
INSERT INTO category (name, description)
VALUES 
('Economy', 'Economy class vehicles with basic features.'),
('Premium', 'High-end vehicles with premium features.'),
('SUV', 'Sport Utility Vehicles suitable for all terrains and family trips.'),
('Electric', 'Environmentally friendly electric vehicles.'),
('Convertible', 'Stylish cars with retractable roofs for an open-air experience.');

-- Insert data into the Vehicles table
INSERT INTO vehicle (make, model, year, registration_number, price_per_day, category_id)
VALUES 
('Toyota', 'Corolla', 2020, 'XYZ123', 29.99, (SELECT category_id FROM category WHERE name = 'Economy')),
('BMW', '5 Series', 2022, 'ABC987', 89.99, (SELECT category_id FROM category WHERE name = 'Premium')),
('Honda', 'Civic', 2019, 'DEF456', 27.99, (SELECT category_id FROM category WHERE name = 'Economy')),
('Audi', 'A6', 2021, 'GHI789', 79.99, (SELECT category_id FROM category WHERE name = 'Premium')),
('Ford', 'Explorer', 2020, 'JKL012', 49.99, (SELECT category_id FROM category WHERE name = 'SUV')),
('Tesla', 'Model 3', 2022, 'MNO345', 59.99, (SELECT category_id FROM category WHERE name = 'Electric')),
('Chevrolet', 'Camaro', 2021, 'PQR678', 69.99, (SELECT category_id FROM category WHERE name = 'Convertible')),
('Nissan', 'Sentra', 2018, 'STU901', 25.99, (SELECT category_id FROM category WHERE name = 'Economy')),
('Mercedes-Benz', 'C-Class', 2022, 'VWX234', 84.99, (SELECT category_id FROM category WHERE name = 'Premium')),
('Jeep', 'Wrangler', 2021, 'YZA567', 54.99, (SELECT category_id FROM category WHERE name = 'SUV')),
('Ford', 'Mustang', 2020, 'BCD890', 64.99, (SELECT category_id FROM category WHERE name = 'Convertible'));

-- Insert data into the Bookings table
INSERT INTO booking (customer_id, vehicle_id, start_date, end_date, created_at)
VALUES 
((SELECT customer_id FROM customer WHERE email='john.doe@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='jane.smith@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='ABC987'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='alice.johnson@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='DEF456'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 4 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='bob.williams@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='GHI789'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='carol.brown@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='JKL012'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='david.jones@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='MNO345'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='eve.davis@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='PQR678'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='frank.miller@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='YZA567'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 4 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='grace.wilson@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='BCD890'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='henry.moore@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='VWX234'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='ivy.taylor@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='STU901'), 
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY), CURDATE()),
 
((SELECT customer_id FROM customer WHERE email='jane.smith@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), 
 DATE_ADD(CURDATE(), INTERVAL 10 DAY), DATE_ADD(CURDATE(), INTERVAL 13 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='alice.johnson@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), 
 DATE_ADD(CURDATE(), INTERVAL 15 DAY), DATE_ADD(CURDATE(), INTERVAL 18 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='bob.williams@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), 
 DATE_ADD(CURDATE(), INTERVAL 20 DAY), DATE_ADD(CURDATE(), INTERVAL 22 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='carol.brown@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='ABC987'), 
 DATE_ADD(CURDATE(), INTERVAL 10 DAY), DATE_ADD(CURDATE(), INTERVAL 13 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='david.jones@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='ABC987'), 
 DATE_ADD(CURDATE(), INTERVAL 16 DAY), DATE_ADD(CURDATE(), INTERVAL 18 DAY), CURDATE()),

((SELECT customer_id FROM customer WHERE email='eve.davis@example.com'), 
 (SELECT vehicle_id FROM vehicle WHERE registration_number='DEF456'), 
 DATE_ADD(CURDATE(), INTERVAL 12 DAY), DATE_ADD(CURDATE(), INTERVAL 14 DAY), CURDATE());

-- Insert data into the Payments table
-- First INSERT block
INSERT INTO payment (booking_id, amount, payment_method, payment_date)
VALUES 
((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='john.doe@example.com') LIMIT 1), 
29.99 * 7, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='jane.smith@example.com') LIMIT 1), 
89.99 * 6, 'PayPal', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='alice.johnson@example.com') LIMIT 1), 
27.99 * 4, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='bob.williams@example.com') LIMIT 1), 
79.99 * 5, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='carol.brown@example.com') LIMIT 1), 
49.99 * 6, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='david.jones@example.com') LIMIT 1), 
59.99 * 7, 'PayPal', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='eve.davis@example.com') LIMIT 1), 
69.99 * 5, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='frank.miller@example.com') LIMIT 1), 
54.99 * 4, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='grace.wilson@example.com') LIMIT 1), 
64.99 * 7, 'PayPal', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='henry.moore@example.com') LIMIT 1), 
84.99 * 6, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking WHERE customer_id=(SELECT customer_id FROM customer WHERE email='ivy.taylor@example.com') LIMIT 1), 
25.99 * 5, 'Credit Card', CURDATE());

-- Second INSERT block for the additional bookings
INSERT INTO payment (booking_id, amount, payment_method, payment_date)
VALUES 

((SELECT booking_id FROM booking 
  WHERE customer_id = (SELECT customer_id FROM customer WHERE email = 'jane.smith@example.com') 
    AND vehicle_id = (SELECT vehicle_id FROM vehicle WHERE registration_number = 'XYZ123')
  ORDER BY booking_id DESC LIMIT 1),
29.99 * 3, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking 
  WHERE customer_id = (SELECT customer_id FROM customer WHERE email = 'alice.johnson@example.com') 
    AND vehicle_id = (SELECT vehicle_id FROM vehicle WHERE registration_number = 'XYZ123')
  ORDER BY booking_id DESC LIMIT 1),
29.99 * 3, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking 
  WHERE customer_id = (SELECT customer_id FROM customer WHERE email = 'bob.williams@example.com') 
    AND vehicle_id = (SELECT vehicle_id FROM vehicle WHERE registration_number = 'XYZ123')
  ORDER BY booking_id DESC LIMIT 1),
29.99 * 2, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking 
  WHERE customer_id = (SELECT customer_id FROM customer WHERE email = 'carol.brown@example.com') 
    AND vehicle_id = (SELECT vehicle_id FROM vehicle WHERE registration_number = 'ABC987')
  ORDER BY booking_id DESC LIMIT 1),
89.99 * 3, 'Credit Card', CURDATE()),

((SELECT booking_id FROM booking 
  WHERE customer_id = (SELECT customer_id FROM customer WHERE email = 'david.jones@example.com') 
    AND vehicle_id = (SELECT vehicle_id FROM vehicle WHERE registration_number = 'ABC987')
  ORDER BY booking_id DESC LIMIT 1),
89.99 * 2, 'PayPal', CURDATE()),

((SELECT booking_id FROM booking 
  WHERE customer_id = (SELECT customer_id FROM customer WHERE email = 'eve.davis@example.com') 
    AND vehicle_id = (SELECT vehicle_id FROM vehicle WHERE registration_number = 'DEF456')
  ORDER BY booking_id DESC LIMIT 1),
27.99 * 2, 'Credit Card', CURDATE());


-- Insert data into the Insurance table
INSERT INTO insurance (vehicle_id, policy_number, provider, coverage_details, start_date, end_date)
VALUES 
((SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), 'INS1234567', 'GoodInsure', 'Comprehensive coverage', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='ABC987'), 'INS1234568', 'SafeDrive', 'Premium coverage with roadside assistance', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='DEF456'), 'INS1234569', 'AutoSecure', 'Basic liability coverage', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='GHI789'), 'INS1234570', 'EliteCover', 'Full coverage including theft protection', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='JKL012'), 'INS1234571', 'DriveSure', 'Collision and comprehensive coverage', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='MNO345'), 'INS1234572', 'GreenShield', 'Electric vehicle premium coverage', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='PQR678'), 'INS1234573', 'EcoAuto', 'Standard coverage for EVs', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='YZA567'), 'INS1234574', 'TrailSafe', 'Off-road and rugged terrain coverage', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='BCD890'), 'INS1234575', 'SunnyRide', 'Comprehensive convertible protection', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='VWX234'), 'INS1234576', 'PrestigeProtect', 'High-end luxury coverage', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)),
((SELECT vehicle_id FROM vehicle WHERE registration_number='STU901'), 'INS1234577', 'UrbanCover', 'City driving and convertible cover', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR));

-- Insert data into the Maintenance table
INSERT INTO maintenance (vehicle_id, service_date, details, cost)
VALUES 
((SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), DATE_ADD(CURDATE(), INTERVAL 6 MONTH), 'Regular service', 120.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='ABC987'), DATE_ADD(CURDATE(), INTERVAL 4 MONTH), 'Engine check and oil change', 250.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='DEF456'), DATE_ADD(CURDATE(), INTERVAL 5 MONTH), 'Brake pad replacement', 180.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='GHI789'), DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 'Full diagnostic and tire rotation', 320.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='JKL012'), DATE_ADD(CURDATE(), INTERVAL 7 MONTH), 'Transmission fluid change', 210.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='MNO345'), DATE_ADD(CURDATE(), INTERVAL 2 MONTH), 'Battery health check (EV)', 100.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='PQR678'), DATE_ADD(CURDATE(), INTERVAL 5 MONTH), 'Software update and tire inspection', 90.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='YZA567'), DATE_ADD(CURDATE(), INTERVAL 6 MONTH), 'Suspension and off-road readiness check', 275.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='BCD890'), DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 'Convertible roof system check', 160.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='VWX234'), DATE_ADD(CURDATE(), INTERVAL 4 MONTH), 'Luxury vehicle detailing and inspection', 400.00),
((SELECT vehicle_id FROM vehicle WHERE registration_number='STU901'), DATE_ADD(CURDATE(), INTERVAL 2 MONTH), 'Air conditioning and filter replacement', 145.00);

-- Insert data into the Reviews table
INSERT INTO review (customer_id, vehicle_id, rating, comment, review_date)
VALUES 
((SELECT customer_id FROM customer WHERE email='john.doe@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='XYZ123'), 5, 'Excellent vehicle, smooth ride.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='jane.smith@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='ABC987'), 4, 'Luxury experience, but a bit pricey.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='alice.johnson@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='DEF456'), 5, 'Very fuel-efficient and clean.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='bob.williams@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='GHI789'), 3, 'Nice interior, but engine was a bit noisy.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='carol.brown@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='JKL012'), 4, 'Great for long trips and plenty of space.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='david.jones@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='MNO345'), 5, 'Loved the EV experience, super quiet and techy.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='eve.davis@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='PQR678'), 4, 'Smooth drive, charging was convenient.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='frank.miller@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='YZA567'), 5, 'Perfect for off-road trails!', CURDATE()),
((SELECT customer_id FROM customer WHERE email='grace.wilson@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='BCD890'), 4, 'Fun to drive, especially with the top down.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='henry.moore@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='VWX234'), 5, 'Luxury comfort at its best.', CURDATE()),
((SELECT customer_id FROM customer WHERE email='ivy.taylor@example.com'), (SELECT vehicle_id FROM vehicle WHERE registration_number='STU901'), 3, 'Cute car, but the AC wasn’t strong enough.', CURDATE());


-- List all instances from each table
SELECT * FROM customer;
SELECT * FROM category;
SELECT * FROM vehicle;
SELECT * FROM booking;
SELECT * FROM payment;
SELECT * FROM insurance;
SELECT * FROM maintenance;
SELECT * FROM review;
