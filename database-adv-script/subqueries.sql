-- Non-Correlated Subquery - Properties with average rating > 4.0
SELECT
	p.property_id,
	p.name AS property_name,
	p.location,
	(SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating FROM Property p
	WHERE ( SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) > 4.0;




-- Correlated Subquery - Users with more than 3 Bookings
SELECT
	u.user_id,
	u.first_name,
	u.last_name,
	u.email,
	(SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) AS total_bookings
	FROM User u
	WHERE (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) > 3;
