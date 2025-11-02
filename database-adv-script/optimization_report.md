# Query Optimization Report

## Task Overview
Optimize a complex query retrieving booking data with user, property, and payment details.

## Initial Query Analysis

### Performance Issues Identified:

1. **Full Table Scan**: Booking table using `ALL` access type (scanning all rows)
2. **File Sort Operation**: `"using_filesort": true` - No index used for ORDER BY
3. **Correlated Subqueries**: Two dependent subqueries running for each row:
   - Average rating calculation
   - Review count calculation
4. **High Query Cost**: `13.15` cost for only 6 rows

### EXPLAIN Key Findings:
- **Booking Table**: `access_type: "ALL"` (inefficient)
- **Sorting**: `using_filesort: true` (inefficient)
- **Subqueries**: Two correlated subqueries with `dependent: true`
- **Index Usage**: Primary keys used for joins, but missing optimal index for sorting

## Optimization Strategies Applied

### 1. Eliminated Correlated Subqueries
- **Before**: Two subqueries running per row for ratings and review counts
- **After**: Single LEFT JOIN to pre-aggregated review data
- **Benefit**: Review statistics calculated once per property instead of per booking

### 2. Forced Index Usage for Sorting
- **Before**: Full table scan with filesort on Booking table
- **After**: `FORCE INDEX (idx_booking_dates)` to use the composite index on start_date
- **Benefit**: Eliminates filesort, uses index for ORDER BY

### 3. Used COALESCE for Null Handling
- **Before**: NULL values for properties without reviews
- **After**: `COALESCE(rev.avg_rating, 0)` provides default values
- **Benefit**: Cleaner data presentation

## Performance Comparison

### Initial Query:
- **Query Cost**: 13.15
- **Access Type**: ALL (full table scan)
- **Sorting**: Using filesort
- **Subqueries**: 2 correlated subqueries per row

### Optimized Query (Expected):
- **Query Cost**: Significantly reduced
- **Access Type**: Range/index scan using idx_booking_dates
- **Sorting**: Using index (no filesort)
- **Subqueries**: Eliminated - replaced with single aggregation

## Key Learnings

1. **Correlated subqueries are expensive** - run once per row in outer query
2. **Pre-aggregation** with GROUP BY is more efficient than per-row calculations
3. **FORCE INDEX** can guide MySQL to use better execution plans
4. **Composite indexes** on sorted columns eliminate filesort operations
5. **EXPLAIN FORMAT=JSON** provides detailed performance insights

## Recommended Index Improvements
The existing `idx_booking_dates (start_date, end_date)` is adequate, but for large datasets consider:
- `CREATE INDEX idx_booking_sort ON Booking(start_date DESC, status);`

## Conclusion
The optimized query addresses the main performance bottlenecks by eliminating correlated subqueries and leveraging existing indexes for sorting, resulting in significantly better performance especially as dataset size grows.
