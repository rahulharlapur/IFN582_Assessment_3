DROP DATABASE IF EXISTS sharespace;
create database sharespace;
use sharespace;

CREATE TABLE users (

    id INT AUTO_INCREMENT PRIMARY KEY,

    firstname VARCHAR(100) NOT NULL,

    lastname VARCHAR(100) NOT NULL,

    email VARCHAR(255) NOT NULL UNIQUE,

    password VARCHAR(255) NOT NULL,

    phone VARCHAR(20) NOT NULL,

    role ENUM('admin', 'seller', 'buyer') NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE properties (

    id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(255) NOT NULL,

    property_type VARCHAR(50) NOT NULL,

    price DECIMAL(10,2) NOT NULL,

    suburb VARCHAR(100) NOT NULL,

    city VARCHAR(100) NOT NULL,

    postcode VARCHAR(10) NOT NULL,

    bedrooms INT NOT NULL,

    bathrooms INT NOT NULL,

    occupants INT NOT NULL,

    compatibility_score DECIMAL(3,1) DEFAULT 0,

    image VARCHAR(255),

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

INSERT INTO properties
(
    title,
    property_type,
    price,
    suburb,
    city,
    postcode,
    bedrooms,
    bathrooms,
    occupants,
    compatibility_score,
    image,
    description
)

VALUES

(
    'Room in Brisbane CBD',
    'Apartment',
    220,
    'Brisbane CBD',
    'Brisbane',
    '4000',
    2,
    1,
    2,
    4.5,
    'img/pexels-artbovich-7019026.jpg',
    'Modern shared apartment located close to public transport and universities.'
),

(
    'Bright & Airy Shared Apartment',
    'Apartment',
    240,
    'South Brisbane',
    'Brisbane',
    '4101',
    2,
    2,
    2,
    4.7,
    'img/pexels-pixabay-271618.jpg',
    'Spacious apartment with natural lighting and fully furnished rooms.'
),

(
    'City View Apartment',
    'Apartment',
    280,
    'Fortitude Valley',
    'Brisbane',
    '4006',
    3,
    3,
    3,
    4.9,
    'img/pexels-fotoaibe-1571453.jpg',
    'Premium apartment with balcony city views and modern amenities.'
),

(
    'Comfortable Room in Quiet Home',
    'House',
    220,
    'Toowong',
    'Brisbane',
    '4066',
    2,
    1,
    2,
    4.6,
    'img/pexels-john-tekeridis-21837-1428348.jpg',
    'Quiet home environment suitable for students and professionals.'
),

(
    'Affordable City Living Space',
    'Unit',
    200,
    'Woolloongabba',
    'Brisbane',
    '4102',
    2,
    1,
    2,
    4.2,
    'img/pexels-andrew-3201763.jpg',
    'Affordable shared accommodation located near public transport.'
),

(
    'Clean & Quiet Shared Apartment',
    'Apartment',
    230,
    'West End',
    'Brisbane',
    '4101',
    2,
    1,
    2,
    4.8,
    'img/pexels-artbovich-7195864.jpg',
    'Well-maintained apartment with peaceful shared living spaces.'
);


CREATE TABLE preferences (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL UNIQUE

);

INSERT INTO preferences (name)
VALUES
('Clean'),
('Pet Friendly'),
('Non-Smoker'),
('Student'),
('Quiet'),
('Social'),
('Early Riser'),
('Night Owl');


CREATE TABLE property_preferences (

    property_id INT NOT NULL,

    preference_id INT NOT NULL,

    PRIMARY KEY (property_id, preference_id),

    FOREIGN KEY (property_id)
        REFERENCES properties(id)
        ON DELETE CASCADE,

    FOREIGN KEY (preference_id)
        REFERENCES preferences(id)
        ON DELETE CASCADE

);

INSERT INTO property_preferences
(property_id, preference_id)
VALUES
(1, 2),
(1, 4),
(1, 5),
(2, 1),
(2, 3),
(3, 4);


CREATE TABLE user_preferences (

    user_id INT NOT NULL,

    preference_id INT NOT NULL,

    PRIMARY KEY (user_id, preference_id),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (preference_id)
        REFERENCES preferences(id)
        ON DELETE CASCADE

);


INSERT INTO user_preferences
(user_id, preference_id)
VALUES
(1, 3),
(1, 4),
(1, 5);




