# Vehicle Rental Database System (MariaDB)

A relational database system built for managing vehicle rentals, developed during the **Database Systems (02170)** course at **DTU** (Spring 2025).

The project covers full database design and implementation — from conceptual modeling to stored procedures and triggers — reflecting a typical backend/database system workflow.

---

## 🚗 What the database supports
- Customers renting vehicles of different categories
- Booking registrations & payment handling
- Vehicle insurance and maintenance tracking
- Customer reviews
- Automatic status update of vehicles when booked

---

## 🛠️ Tech & SQL Features
✅ MariaDB  
✅ Normalized schema with constraints & foreign keys  
✅ Sample dataset for testing  
✅ SQL queries (JOIN, GROUP BY, IN)  
✅ Functions & stored procedure  
✅ Trigger for rental workflow automation  

---

## 📂 Repository Structure
scripts/        – SQL scripts (schema, data, logic)
docs/           – Full report (PDF)
README.md

---

## ▶️ How to run
```sql
-- 1. Create schema & insert data
SOURCE scripts/01_schema_and_data.sql;

-- 2. Load queries, functions, procedure, trigger
SOURCE scripts/02_queries_and_db_logic.sql;

You can then call:
CALL createBookingWithPayment(...);
SELECT calculateTotalRentalCost(...);

---

## 📄 Full Report
For the complete ER model, schema explanations, and documentation, see:
📁 docs/Vehicle_Rental_Database_Final_Report.pdf

---

## 👥 Team
Antonijs Bolsakovs · Adrian Ursu · Andrej Kitanovski · Niclas Søe Irsbøl · Viktor Manuel Guijarro

---

## ✅ Future improvements (if extended)
	•	Add views and indexes
	•	Implement return flow and maintenance scheduler
	•	Add transaction support and ACID discussion
