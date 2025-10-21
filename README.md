# Vehicle Rental DB System (DTU 02170 — Spring 2025)

Relational database project for a **Vehicle Rental Management** system built in **MariaDB** as part of the **Database Systems (02170)** course at **DTU** (Bachelor, Cyber Systems), **Spring 2025**.  
The project follows the full database development lifecycle: requirements → ER model → logical design → implementation → realistic seed data → queries → SQL programming (functions, procedure, trigger) → table modifications.  [oai_citation:0‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [What You Can Explore](#what-you-can-explore)
- [Team](#team)
- [Notes & Possible Extensions](#notes--possible-extensions)
- [Course Context](#course-context)
- [License](#license)

---

## Overview
The database models day-to-day vehicle rental operations: **Customers**, **Vehicles** (by **Category**), **Bookings**, **Payments**, **Insurance**, **Maintenance**, and **Reviews**.  
It keeps track of availability, enforces referential integrity, and supports typical operational and analytical queries for a rental business.  [oai_citation:1‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)

Key lifecycle steps implemented:
- **Statement of Requirements** (domain description)  
- **Conceptual Design** (ER diagram + explanation)  
- **Logical Design** (relational schemas + FK specification)  
- **Implementation** (tables, constraints, enums)  
- **Database Instance** (realistic data)  
- **SQL Data Queries** (JOIN, GROUP BY, IN)  
- **SQL Programming** (2 functions, 1 stored procedure, 1 trigger)  
- **Table Modifications** (UPDATE, DELETE)  [oai_citation:2‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)

---

## Features
- **Normalized schema & constraints:** primary/foreign keys, `NOT NULL`, `DEFAULT`, `UNIQUE`, selective `ENUM`s for categories.  [oai_citation:3‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)  
- **Referential integrity:** appropriate `ON DELETE CASCADE` / `ON DELETE SET NULL` for dependent records (e.g., Booking ↔ Payment, Vehicle ↔ Insurance/Maintenance).  [oai_citation:4‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)  
- **Realistic seed data:** multiple customers, vehicles across categories, bookings, payments, and reviews to exercise queries and logic.  [oai_citation:5‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)  
- **Queries:** examples with `JOIN`, `GROUP BY`, and `IN` to answer common analytical questions.  [oai_citation:6‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)  
- **SQL programming:**  
  - Functions: `calculateTotalRentalCost(vehicle_id, start_date, end_date)` and `getBookingDuration(start, end)`;  
  - Stored procedure: `createBookingWithPayment(...)` (creates booking and computes/inserts payment);  
  - Trigger: `updateVehicleStatusAfterBooking` (auto-sets vehicle status to `Rented` after booking).  [oai_citation:7‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)  
- **Table modifications:** illustrative `UPDATE` and `DELETE` with before/after verification.  [oai_citation:8‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)

---

## Repository Structure
vehicle-rental-db-system/
├─ scripts/
│  ├─ 01_schema_and_data.sql                # DDL + seed (create tables, constraints, inserts)
│  └─ 02_queries_and_db_logic.sql           # queries + functions + procedure + trigger + updates/deletes
├─ docs/
│  └─ Vehicle_Rental_Database_Final_Report.pdf
└─ README.md

> The split into two scripts mirrors the course hand-in specification: one for schema+population, one for queries+programming+modifications.  [oai_citation:9‡GroupProjectRequirements2025.pdf](sediment://file_00000000f7c0620eb591833949acde6e)

---

## Getting Started

**Prerequisites:** MariaDB (recommended) or MySQL-compatible environment. In the course, scripts were run under MariaDB; queries were also executed via MySQL Workbench.  [oai_citation:10‡GroupProjectRequirements2025.pdf](sediment://file_00000000f7c0620eb591833949acde6e)  [oai_citation:11‡Vehicle_Rental_Database_Final_Report.pdf](sediment://file_0000000057e461fbaa2a3fa86b7770bf)

1) **Create schema & load sample data**
```sql
SOURCE scripts/01_schema_and_data.sql;
2.	Create queries, functions, procedure, trigger & run modifications
SOURCE scripts/02_queries_and_db_logic.sql;

3.	Explore (examples included in script #2):

	•	Run data queries (JOIN / GROUP BY / IN).
	•	Call functions: calculateTotalRentalCost(...), getBookingDuration(...).
	•	Use the stored procedure: CALL createBookingWithPayment(...);
	•	Verify the trigger by inserting a booking and checking vehicle status.

Scripts are designed to run without runtime errors in MariaDB as required by the assignment.
What You Can Explore
	•	Schema design choices: keys, cardinalities, and cascade rules.  ￼
	•	Business logic in SQL: encapsulation via functions/procedure, and automation via trigger.  ￼
	•	Analytics examples: bookings per vehicle, vehicles with reviews, joined customer-vehicle rentals.  ￼

For deeper discussion, see the full report in docs/Vehicle_Rental_Database_Final_Report.pdf.

Team
	•	Adrian Ursu
	•	Antonijs Bolsakovs
	•	Andrej Kitanovski
	•	Niclas Søe Irsbøl
	•	Viktor Manuel Guijarro

Notes & Possible Extensions
	•	Add indexes based on expected workloads (e.g., frequent lookups on bookings or availability).
	•	Add views for reporting (top booked vehicles, utilization, maintenance schedules).
	•	Extend triggers (e.g., auto-set Available on return; schedule maintenance windows).
	•	Add small transaction demos and mention isolation levels to discuss ACID characteristics

Course Context

This project was developed and handed in under DTU 02170 – Database Systems (Spring 2025).
Hand-in requirements: one PDF report + two SQL scripts (schema+population; queries+programming+modifications) executed on MariaDB.

License

Academic project — no explicit license.
If you plan to reuse/extend this, consider adding MIT or another OS license.
