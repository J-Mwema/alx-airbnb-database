--  Table Partitionin

-- Check current booking data distribution by year
SELECT 
    YEAR(start_date) as booking_year,
    COUNT(*) as booking_count
FROM Booking
GROUP BY YEAR(start_date)
ORDER BY booking_year;

-- Create partitioned table (simpler approach without composite primary key)
CREATE TABLE Booking_Partitioned (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id),
    INDEX idx_booking_user (user_id),
    INDEX idx_booking_dates (start_date, end_date),
    INDEX idx_booking_status (status),
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
) PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Copy data
INSERT INTO Booking_Partitioned 
SELECT * FROM Booking;

-- Verify partition distribution
SELECT 
    PARTITION_NAME,
    TABLE_ROWS,
    'Partitioned Table' as source
FROM information_schema.PARTITIONS 
WHERE TABLE_SCHEMA = 'alx_airbnb' AND TABLE_NAME = 'Booking_Partitioned'
UNION ALL
SELECT 
    'Original Table' as PARTITION_NAME,
    COUNT(*) as TABLE_ROWS,
    'Original Table' as source
FROM Booking;

-- Performance comparison queries
-- Query recent bookings (should hit one partition)
EXPLAIN 
SELECT COUNT(*) 
FROM Booking_Partitioned 
WHERE start_date >= '2024-11-01' 
  AND start_date <= '2024-12-31'
  AND status = 'confirmed';

EXPLAIN 
SELECT COUNT(*) 
FROM Booking 
WHERE start_date >= '2024-11-01' 
  AND start_date <= '2024-12-31'
  AND status = 'confirmed';

-- Query spanning multiple partitions
EXPLAIN 
SELECT YEAR(start_date), COUNT(*)
FROM Booking_Partitioned 
WHERE start_date BETWEEN '2023-01-01' AND '2025-12-31'
GROUP BY YEAR(start_date);
