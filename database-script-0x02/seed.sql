-- Airbnb Sample Data
-- Seed data for ALX Airbnb Database Project

USE alx_airbnb;

-- Clear existing data
-- DELETE FROM Message;
-- DELETE FROM Review;
-- DELETE FROM Payment;
-- DELETE FROM Booking;
-- DELETE FROM Property;
-- DELETE FROM User;

-- 1. USERS: Create multiple users with different roles
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
-- Admin user
('11111111-1111-1111-1111-111111111111', 'Admin', 'User', 'admin@airbnb.com', 'hash_admin123', '+254700000001', 'admin'),

-- Host users
('22222222-2222-2222-2222-222222222222', 'Sarah', 'Johnson', 'sarah.johnson@email.com', 'hash_sarah123', '+254711111111', 'host'),
('33333333-3333-3333-3333-333333333333', 'Mike', 'Chen', 'mike.chen@email.com', 'hash_mike123', '+254722222222', 'host'),
('44444444-4444-4444-4444-444444444444', 'Emma', 'Williams', 'emma.w@email.com', 'hash_emma123', '+254733333333', 'host'),

-- Guest users
('55555555-5555-5555-5555-555555555555', 'David', 'Kimani', 'david.k@email.com', 'hash_david123', '+254744444444', 'guest'),
('66666666-6666-6666-6666-666666666666', 'Lisa', 'Wang', 'lisa.wang@email.com', 'hash_lisa123', '+254755555555', 'guest'),
('77777777-7777-7777-7777-777777777777', 'James', 'Taylor', 'james.t@email.com', 'hash_james123', '+254766666666', 'guest'),
('88888888-8888-8888-8888-888888888888', 'Maria', 'Garcia', 'maria.g@email.com', 'hash_maria123', '+254777777777', 'guest');

-- 2. PROPERTIES: Create various property listings
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
-- Sarah's properties
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 'Luxury Nairobi Apartment', 'Spacious 2-bedroom apartment with city views, fully furnished and secure.', 'Westlands, Nairobi', 85.00),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 'Cozy Karen Cottage', 'Quiet cottage with garden, perfect for couples or small families.', 'Karen, Nairobi', 65.00),

-- Mike's properties
('cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', 'Beachfront Mombasa Villa', 'Stunning beachfront villa with private pool and direct beach access.', 'Nyali, Mombasa', 120.00),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333', 'Mombasa City Studio', 'Modern studio apartment in the heart of Mombasa, close to attractions.', 'Mombasa CBD', 45.00),

-- Emma's properties
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '44444444-4444-4444-4444-444444444444', 'Mountain View Cabin', 'Rustic cabin with breathtaking mountain views, perfect for nature lovers.', 'Mount Kenya Region', 55.00),
('ffffffff-ffff-ffff-ffff-ffffffffffff', '44444444-4444-4444-4444-444444444444', 'Lakeside Retreat', 'Peaceful retreat by the lake, great for fishing and relaxation.', 'Naivasha', 70.00);

-- 3. BOOKINGS: Create realistic bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
-- David's bookings
('11111111-1111-1111-1111-111111111112', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '55555555-5555-5555-5555-555555555555', '2024-11-15', '2024-11-20', 425.00, 'confirmed'),
('11111111-1111-1111-1111-111111111113', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '55555555-5555-5555-5555-555555555555', '2024-12-10', '2024-12-15', 600.00, 'pending'),

-- Lisa's bookings
('11111111-1111-1111-1111-111111111114', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '66666666-6666-6666-6666-666666666666', '2024-11-25', '2024-11-28', 195.00, 'confirmed'),
('11111111-1111-1111-1111-111111111115', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '66666666-6666-6666-6666-666666666666', '2024-12-20', '2024-12-25', 275.00, 'confirmed'),

-- James's booking
('11111111-1111-1111-1111-111111111116', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '77777777-7777-7777-7777-777777777777', '2024-11-30', '2024-12-02', 90.00, 'confirmed'),

-- Maria's booking
('11111111-1111-1111-1111-111111111117', 'ffffffff-ffff-ffff-ffff-ffffffffffff', '88888888-8888-8888-8888-888888888888', '2024-12-05', '2024-12-08', 210.00, 'canceled');

-- 4. PAYMENTS: Create corresponding payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('22222222-2222-2222-2222-222222222221', '11111111-1111-1111-1111-111111111112', 425.00, 'credit_card'),
('22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111114', 195.00, 'paypal'),
('22222222-2222-2222-2222-222222222223', '11111111-1111-1111-1111-111111111115', 275.00, 'stripe'),
('22222222-2222-2222-2222-222222222224', '11111111-1111-1111-1111-111111111116', 90.00, 'credit_card');

-- 5. REVIEWS: Create reviews for completed stays
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
-- Reviews for Luxury Nairobi Apartment
('33333333-3333-3333-3333-333333333331', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '55555555-5555-5555-5555-555555555555', 5, 'Amazing apartment with stunning views! Sarah was a wonderful host.'),

-- Reviews for Cozy Karen Cottage
('33333333-3333-3333-3333-333333333332', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '66666666-6666-6666-6666-666666666666', 4, 'Very peaceful and cozy. Perfect for a weekend getaway.'),

-- Reviews for Mombasa City Studio
('33333333-3333-3333-3333-333333333333', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '77777777-7777-7777-7777-777777777777', 3, 'Good location but could use some updates. Overall decent stay.'),

-- Reviews for Lakeside Retreat
('33333333-3333-3333-3333-333333333334', 'ffffffff-ffff-ffff-ffff-ffffffffffff', '88888888-8888-8888-8888-888888888888', 5, 'Absolutely beautiful! The lake views were breathtaking.');

-- 6. MESSAGES: Create conversation threads
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
-- Conversation between David and Sarah
('44444444-4444-4444-4444-444444444441', '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Hi Sarah, I''m interested in your Nairobi apartment. Is it available for November 15-20?'),
('44444444-4444-4444-4444-444444444442', '22222222-2222-2222-2222-222222222222', '55555555-5555-5555-5555-555555555555', 'Hello David! Yes, those dates are available. The apartment would be perfect for your stay.'),

-- Conversation between Lisa and Emma
('44444444-4444-4444-4444-444444444443', '66666666-6666-6666-6666-666666666666', '44444444-4444-4444-4444-444444444444', 'Hi Emma, is the mountain cabin pet-friendly?'),
('44444444-4444-4444-4444-444444444444', '44444444-4444-4444-4444-444444444444', '66666666-6666-6666-6666-666666666666', 'Hi Lisa! Yes, we are pet-friendly. There''s plenty of space for dogs to run around.'),

-- Conversation between James and Mike
('44444444-4444-4444-4444-444444444445', '77777777-7777-7777-7777-777777777777', '33333333-3333-3333-3333-333333333333', 'Hello Mike, what''s the check-in time for the Mombasa studio?'),
('44444444-4444-4444-4444-444444444446', '33333333-3333-3333-3333-333333333333', '77777777-7777-7777-7777-777777777777', 'Hi James! Check-in is from 2 PM onwards. Let me know your arrival time.');

-- Verification query to show sample of inserted data
SELECT 'Sample Data Insertion Complete!' as Status;
SELECT COUNT(*) as TotalUsers FROM User;
SELECT COUNT(*) as TotalProperties FROM Property;
SELECT COUNT(*) as TotalBookings FROM Booking;
SELECT COUNT(*) as TotalPayments FROM Payment;
SELECT COUNT(*) as TotalReviews FROM Review;
SELECT COUNT(*) as TotalMessages FROM Message;
