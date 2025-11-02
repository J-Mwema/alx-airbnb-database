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


# Subqueries

### 1. Non-Correlated Subquery - High-Rated Properties
**Purpose:** Find properties with average ratings greater than 4.0 stars
**Tables Used:** `Property` and `Review`
**Method:** Uses a subquery in both SELECT and WHERE clauses to calculate and filter by average rating
**Result:** 
- Luxury Nairobi Apartment (5.0 rating)
- Lakeside Retreat (5.0 rating)
- 2 properties found with ratings > 4.0

### 2. Correlated Subquery - Frequent Bookers  
**Purpose:** Find users who have made more than 3 bookings
**Tables Used:** `User` and `Booking`
**Method:** Uses correlated subquery that references the outer query's user_id
**Result:** Empty set (no users have more than 3 bookings in current dataset)
**Analysis:** Query working correctly - properly filters users based on booking count


## Aggregations and Window Functions

### 1. Aggregation - Total Bookings Per User
**Purpose:** Count how many bookings each user has made
**Tables Used:** `User` and `Booking`
**Methods:** 
- `COUNT()` aggregation function
- `GROUP BY` to group results per user
- `LEFT JOIN` to include users with zero bookings
**Result:**
- David Kimani: 2 bookings
- Lisa Wang: 2 bookings  
- James Taylor: 1 booking
- Maria Garcia: 1 booking
- 4 users with 0 bookings

### 2. Window Functions - Property Rankings
**Purpose:** Rank properties by their booking popularity
**Tables Used:** `Property` and `Booking`
**Methods:**
- `COUNT()` for total bookings per property
- `RANK()` window function for ranking with ties
- `ROW_NUMBER()` window function for unique ranking
- `LEFT JOIN` to include properties with zero bookings
**Result:**
- All 6 properties have 1 booking each
- RANK() gives all properties rank 1 (tied)
- ROW_NUMBER() gives unique numbers 1-6
- Demonstrates difference between ranking methods
