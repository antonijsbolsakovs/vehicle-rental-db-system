# Vehicle Rental Database System (MariaDB)

A relational database system built for managing vehicle rentals, developed during the **Database Systems (02170)** course at **Technical University of Denmark (DTU)**, Spring 2025.

The project demonstrates a complete database development pipeline: from conceptual modeling to implementation of business logic using stored procedures, functions, and triggers — reflecting practical backend/data engineering workflows.

---

## 🚗 Core Functionality
- Manage customers, vehicles, and categories
- Register bookings and calculate rental cost
- Handle payments linked to bookings
- Track insurance policies and maintenance history
- Allow customer reviews of vehicles
- Automatically update vehicle status after booking (via trigger)

---

## 🛠️ SQL & DBMS Features Used
✔ MariaDB  
✔ Normalized relational schema with keys & constraints  
✔ Realistic seeded dataset  
✔ SQL queries (JOIN, GROUP BY, IN)  
✔ User-defined functions  
✔ Stored procedure for automated booking + payment insertion  
✔ Trigger for updating vehicle availability  

---

## 📂 Project Structure
```
vehicle-rental-db-system/
├─ scripts/
│  ├─ 01_schema_and_data.sql          # Creates tables + inserts data
│  └─ 02_queries_and_db_logic.sql     # Queries, functions, procedure, trigger
├─ docs/
│  └─ Vehicle_Rental_Database_Final_Report.pdf
└─ README.md
```

---

## ▶️ How to Run
Run in MariaDB (or MySQL-compatible environment):

```sql
-- 1. Create schema & load data
SOURCE scripts/01_schema_and_data.sql;

-- 2. Load queries, functions, procedure, trigger
SOURCE scripts/02_queries_and_db_logic.sql;

Examples (after running Script #2):
SELECT calculateTotalRentalCost(vehicle_id, '2025-04-01', '2025-04-05');
CALL createBookingWithPayment(2, 5, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Credit Card');
```

---

## 📄 Documentation

For ER diagram, schema explanation, and implementation report, see:
📁 docs/Vehicle_Rental_Database_Final_Report.pdf

---

## 👥 Team

Adrian Ursu · Antonijs Bolsakovs · Andrej Kitanovski · Niclas Søe Irsbøl · Viktor Manuel Guijarro

---

## 🚀 Optional Future Enhancements
	•	Add views & indexes for analytics
	•	Introduce return flow & maintenance scheduling
	•	Implement transactional logic & ACID-level operations
	•	Extend backend integration (e.g., REST API layer)
