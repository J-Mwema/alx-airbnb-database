-- INNER JOIN - Bookings with their Users
SELECT
	b.booking_id,
	b.start_date,
	b.end_date,
	b.total_price,
	u.user_id,
	u.first_name,
	u.last_name,
	u.email
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id;


-- LEFT JOIN - All Properties with their Reviews
SELECT
	p.property_id,
	p.name AS property_name,
	p.location,
	r.review_id,
	r.rating,
	r.comment,
	r.created_at AS review_date
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;


-- FULL OUTER JOIN simulation - All Users and All Bookings
SELECT
	u.user_id,
	u.first_name,
	u.last_name,
	b.booking_id,
	b.start_date,
	b.end_date,
	'User with/without Booking' AS record_type
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id

UNION

-- Show bookings with their users 
SELECT
	u.user_id,
	u.first_name,
	u.last_name,
	b.booking_id,
	b.start_date,
	b.end_date,
	'Booking with/without User' AS record_type
FROM User u
RIGHT JOIN Booking b ON u.user_id = b.user_id;
