# Airbnb Database Sample Data

## Overview
This directory contains sample data for seeding the Airbnb-like application database with realistic test data.

## Files
- `seed.sql` - SQL script containing INSERT statements for all tables

## Sample Data Summary

### Users (8 records)
- **1 Admin**: System administrator
- **3 Hosts**: Property owners with multiple listings
- **4 Guests**: Users who book properties

### Properties (6 records)
- **Locations**: Nairobi, Mombasa, Mount Kenya Region, Naivasha
- **Types**: Apartments, villas, cottages, studios, cabins
- **Price Range**: $45 - $120 per night

### Bookings (7 records)
- **Status Distribution**: 5 confirmed, 1 pending, 1 canceled
- **Date Range**: November - December 2024
- **Realistic Durations**: 2-5 night stays

### Payments (4 records)
- **Payment Methods**: Credit card, PayPal, Stripe
- **Matching**: Each payment linked to a confirmed booking

### Reviews (4 records)
- **Rating Distribution**: 3-5 stars
- **Realistic Comments**: Varied feedback reflecting actual guest experiences

### Messages (6 records)
- **Conversations**: 3 different message threads
- **Realistic Content**: Typical host-guest communications

## Data Relationships

### User-Property Relationships
- Sarah Johnson owns 2 properties in Nairobi
- Mike Chen owns 2 properties in Mombasa  
- Emma Williams owns 2 properties in rural areas

### Booking Patterns
- David Kimani has 2 bookings (one confirmed, one pending)
- Lisa Wang has 2 confirmed bookings
- James Taylor has 1 confirmed booking
- Maria Garcia has 1 canceled booking

### Review Coverage
- Each reviewed property has 1 review
- Ratings reflect varied guest experiences
- Comments provide useful feedback for hosts

## Usage

### Seeding the Database
```bash
mysql -u root -p alx_airbnb < seed.sql
