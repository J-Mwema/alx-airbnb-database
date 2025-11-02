# Table Partitioning Performance Report

## Task Overview
Implement table partitioning on the Booking table based on `start_date` column to optimize query performance for large datasets.

## Partitioning Strategy

### Chosen Partitioning Method: RANGE Partitioning
- **Partition Key**: `YEAR(start_date)`
- **Partitions Created**:
  - `p2023`: Bookings before 2024
  - `p2024`: Bookings in 2024 (current year in dataset)
  - `p2025`: Bookings in 2025
  - `p_future`: Bookings after 2025

### Rationale:
- Most queries filter by date ranges
- Natural data distribution by year
- Easy maintenance and archiving of old data

## Implementation Steps

1. **Created new partitioned table** `Booking_Partitioned` with same structure as original
2. **Copied all data** from original Booking table
3. **Verified data distribution** across partitions
4. **Tested query performance** on both tables

## Performance Comparison

### Test Query 1: Date Range within Single Partition
```sql
SELECT * FROM Booking_Partitioned 
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
