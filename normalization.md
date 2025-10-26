# Database Normalization Analysis

## Normalization Overview
This document analyzes the Airbnb database design against normalization principles up to the Third Normal Form (3NF). Normalization ensures data integrity, reduces redundancy, and prevents anomalies.

## Normalization Process

### First Normal Form (1NF) - Eliminate Repeating Groups
**Requirements:**
- Each table has a primary key
- All attributes contain atomic values
- No repeating groups or arrays

**Analysis:**
✅ **1NF Compliance Achieved**
- All tables have UUID primary keys
- Each attribute contains single, atomic values
- No multi-valued attributes or repeating groups

### Second Normal Form (2NF) - Eliminate Partial Dependencies  
**Requirements:**
- Meet 1NF requirements
- All non-key attributes fully functionally dependent on the entire primary key

**Analysis:**
✅ **2NF Compliance Achieved**

**Table-by-Table Analysis:**
- **User Table**: All attributes (`first_name`, `email`, `role`, etc.) depend entirely on `user_id`
- **Property Table**: All attributes depend entirely on `property_id`
- **Booking Table**: All attributes depend entirely on `booking_id`
- **Payment Table**: All attributes depend entirely on `payment_id`
- **Review Table**: All attributes depend entirely on `review_id`
- **Message Table**: All attributes depend entirely on `message_id`

No partial dependencies found in any table.

### Third Normal Form (3NF) - Eliminate Transitive Dependencies
**Requirements:**
- Meet 2NF requirements
- No transitive dependencies (non-key attributes depend only on the primary key)

**Analysis:**
✅ **3NF Compliance Achieved**

**Key Findings:**
- All non-key attributes directly depend on their respective primary keys
- No attributes depend on other non-key attributes
- Foreign keys maintain referential integrity without creating transitive dependencies

## Design Decisions and Considerations

### ENUM Types Analysis
**Current Implementation:**
- `User.role`: ENUM('guest', 'host', 'admin')
- `Booking.status`: ENUM('pending', 'confirmed', 'canceled') 
- `Payment.payment_method`: ENUM('credit_card', 'paypal', 'stripe')

**Normalization Consideration:**
While ENUM values could be extracted to separate lookup tables for full normalization, we determined that:
- The values are fixed and unlikely to change frequently
- The sets are small and manageable
- The performance benefit of keeping them inline outweighs the normalization purity
- This is appropriate for the project scale

### Location Data
**Current Implementation:**
- `Property.location`: VARCHAR field

**Potential Enhancement:**
For a production system, we might normalize this into:
```sql
CREATE TABLE cities (city_id PK, city_name, country_id);
CREATE TABLE countries (country_id PK, country_name);
