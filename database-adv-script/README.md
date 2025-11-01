# Complex Queries with Joins

## Overview
This task demonstrates three types of SQL joins using the Airbnb database schema.

## Queries Explanation

### 1. INNER JOIN - Bookings with Users
**Purpose:** Find all bookings that have associated users
**Tables Used:** `Booking` and `User`
**Join Condition:** `Booking.user_id = User.user_id`
**Result:** Only shows bookings where we know who made them

### 2. LEFT JOIN - Properties with Reviews  
**Purpose:** Show all properties, including those without any reviews
**Tables Used:** `Property` and `Review`
**Join Condition:** `Property.property_id = Review.property_id`
**Result:** Every property is shown. Properties without reviews have NULL in review columns

### 3. FULL OUTER JOIN - Users and Bookings
**Purpose:** Show all users and all bookings, including unmatched records
**Tables Used:** `User` and `Booking`
**Implementation:** Simulated using UNION of LEFT JOIN and RIGHT JOIN since MySQL doesn't support FULL OUTER JOIN
**Result:** Complete picture of all data relationships and orphans

## Key Learnings
- INNER JOIN filters to only matching records
- LEFT JOIN preserves all records from the left table
- FULL OUTER JOIN shows the complete dataset from both tables
- Understanding join types helps in data analysis and finding data quality issues
