# Airbnb Database ER Diagram Requirements

## Project Overview
This document outlines the Entity-Relationship (ER) diagram design for the ALX Airbnb-like application database. The ER diagram visually represents the database structure, including entities, attributes, and relationships.

## Entities and Attributes

### 1. User Entity
Represents all users of the system (guests, hosts, and administrators).

**Attributes:**
- `user_id` (Primary Key, UUID) - Unique identifier for each user
- `first_name` (VARCHAR, NOT NULL) - User's first name
- `last_name` (VARCHAR, NOT NULL) - User's last name  
- `email` (VARCHAR, UNIQUE, NOT NULL) - User's email address
- `password_hash` (VARCHAR, NOT NULL) - Hashed password for security
- `phone_number` (VARCHAR, NULL) - User's contact number
- `role` (ENUM: guest, host, admin, NOT NULL) - User's role in the system
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Account creation date

### 2. Property Entity
Represents rental properties listed by hosts.

**Attributes:**
- `property_id` (Primary Key, UUID) - Unique identifier for each property
- `host_id` (Foreign Key, references User.user_id) - Property owner
- `name` (VARCHAR, NOT NULL) - Property title/name
- `description` (TEXT, NOT NULL) - Detailed property description
- `location` (VARCHAR, NOT NULL) - Property address/location
- `pricepernight` (DECIMAL, NOT NULL) - Rental price per night
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Listing creation date
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP) - Last update timestamp

### 3. Booking Entity
Represents reservations made by guests for properties.

**Attributes:**
- `booking_id` (Primary Key, UUID) - Unique identifier for each booking
- `property_id` (Foreign Key, references Property.property_id) - Booked property
- `user_id` (Foreign Key, references User.user_id) - Guest who made booking
- `start_date` (DATE, NOT NULL) - Booking start date
- `end_date` (DATE, NOT NULL) - Booking end date
- `total_price` (DECIMAL, NOT NULL) - Total cost of booking
- `status` (ENUM: pending, confirmed, canceled, NOT NULL) - Booking status
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Booking creation date

### 4. Payment Entity
Represents financial transactions for bookings.

**Attributes:**
- `payment_id` (Primary Key, UUID) - Unique identifier for each payment
- `booking_id` (Foreign Key, references Booking.booking_id) - Associated booking
- `amount` (DECIMAL, NOT NULL) - Payment amount
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - When payment was made
- `payment_method` (ENUM: credit_card, paypal, stripe, NOT NULL) - Payment method used

### 5. Review Entity
Represents user reviews and ratings for properties.

**Attributes:**
- `review_id` (Primary Key, UUID) - Unique identifier for each review
- `property_id` (Foreign Key, references Property.property_id) - Reviewed property
- `user_id` (Foreign Key, references User.user_id) - User who wrote review
- `rating` (INTEGER, CHECK: 1-5, NOT NULL) - Numerical rating (1-5 stars)
- `comment` (TEXT, NOT NULL) - Written review content
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Review creation date

### 6. Message Entity
Represents communication between users.

**Attributes:**
- `message_id` (Primary Key, UUID) - Unique identifier for each message
- `sender_id` (Foreign Key, references User.user_id) - Message sender
- `recipient_id` (Foreign Key, references User.user_id) - Message recipient
- `message_body` (TEXT, NOT NULL) - Message content
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - When message was sent

## Relationships

### 1. User → Property (One-to-Many)
- **Relationship**: A User OWNS many Properties
- **Cardinality**: One-to-Many (1:N)
- **Description**: One host user can own multiple properties, but each property has only one host

### 2. User → Booking (One-to-Many)  
- **Relationship**: A User MAKES many Bookings
- **Cardinality**: One-to-Many (1:N)
- **Description**: One user can make multiple bookings, but each booking belongs to one user

### 3. Property → Booking (One-to-Many)
- **Relationship**: A Property HAS many Bookings
- **Cardinality**: One-to-Many (1:N)
- **Description**: One property can have multiple bookings, but each booking is for one property

### 4. Booking → Payment (One-to-One)
- **Relationship**: A Booking HAS one Payment
- **Cardinality**: One-to-One (1:1)
- **Description**: Each booking has exactly one associated payment

### 5. User → Review (One-to-Many)
- **Relationship**: A User WRITES many Reviews
- **Cardinality**: One-to-Many (1:N)
- **Description**: One user can write multiple reviews for different properties

### 6. Property → Review (One-to-Many)
- **Relationship**: A Property RECEIVES many Reviews
- **Cardinality**: One-to-Many (1:N)
- **Description**: One property can receive multiple reviews from different users

### 7. User → Message (One-to-Many as Sender)
- **Relationship**: A User SENDS many Messages
- **Cardinality**: One-to-Many (1:N)
- **Description**: One user can send multiple messages to different recipients

### 8. User → Message (One-to-Many as Recipient)  
- **Relationship**: A User RECEIVES many Messages
- **Cardinality**: One-to-Many (1:N)
- **Description**: One user can receive multiple messages from different senders

## Design Decisions

### Primary Keys
- All entities use UUID primary keys for better scalability and security
- UUIDs prevent sequential guessing and are globally unique

### Foreign Keys
- All relationships are enforced through foreign key constraints
- Foreign keys maintain referential integrity between tables

### Data Types
- **VARCHAR** for short text fields (names, emails, locations)
- **TEXT** for longer content (descriptions, comments, messages)
- **DECIMAL** for monetary values to avoid floating-point precision issues
- **ENUM** for fixed sets of values (roles, statuses, payment methods)
- **TIMESTAMP** for tracking creation and update times

### Constraints
- **NOT NULL** for required fields
- **UNIQUE** for email to prevent duplicate accounts
- **CHECK** constraints for rating validation (1-5 stars)

## ER Diagram Files
- `airbnb_erd.drawio` - Editable diagram source file
- `airbnb_erd.png` - Exported visual representation

## Tools Used
- **Draw.io** for creating the ER diagram
- **Crow's Foot Notation** for relationship cardinality
