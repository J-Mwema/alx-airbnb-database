-- Complex Query Optimization

-- INITIAL QUERY

-- Query: Retrieve all bookings with user, property and payment details
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    b.booking_id,
    b.start_date,  -- FIXED: was start_dat
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created,
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created,
    py.payment_id,
    py.amount AS payment_amount,  -- FIXED: was property_created
    py.payment_method,
    py.payment_date,
    -- Subquery for average rating
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating,
    -- Subquery for review count (ONLY ONCE)
    (SELECT COUNT(*) FROM Review r WHERE r.property_id = p.property_id) AS total_reviews
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment py ON b.booking_id = py.booking_id
ORDER BY b.start_date DESC;



-- Analyze the initial query performance
EXPLAIN FORMAT=JSON
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    p.property_id,
    p.name AS property_name,
    p.location,
    py.payment_id,
    py.amount AS payment_amount,
    py.payment_method,
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating,
    (SELECT COUNT(*) FROM Review r WHERE r.property_id = p.property_id) AS total_reviews
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment py ON b.booking_id = py.booking_id
ORDER BY b.start_date DESC;


-- Optimized: Remove correlated subqueries, use pre-aggregation, leverage indexes
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    p.property_id,
    p.name AS property_name,
    p.location,
    py.payment_id,
    py.amount AS payment_amount,
    py.payment_method,
    COALESCE(rev.avg_rating, 0) AS average_rating,
    COALESCE(rev.review_count, 0) AS total_reviews
FROM Booking b
-- Force index usage for sorting
FORCE INDEX (idx_booking_dates)
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment py ON b.booking_id = py.booking_id
-- Pre-aggregate review data to avoid correlated subqueries
LEFT JOIN (
    SELECT
        property_id,
        AVG(rating) AS avg_rating,
        COUNT(*) AS review_count
    FROM Review
    GROUP BY property_id
) rev ON p.property_id = rev.property_id
ORDER BY b.start_date DESC;

-- Analyze optimized query performance
EXPLAIN FORMAT=JSON
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    p.property_id,
    p.name AS property_name,
    p.location,
    py.payment_id,
    py.amount AS payment_amount,
    py.payment_method,
    COALESCE(rev.avg_rating, 0) AS average_rating,
    COALESCE(rev.review_count, 0) AS total_reviews
FROM Booking b
FORCE INDEX (idx_booking_dates)
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment py ON b.booking_id = py.booking_id
LEFT JOIN (
    SELECT
        property_id,
        AVG(rating) AS avg_rating,
        COUNT(*) AS review_count
    FROM Review
    GROUP BY property_id
) rev ON p.property_id = rev.property_id
ORDER BY b.start_date DESC;
