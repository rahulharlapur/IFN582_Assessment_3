DROP DATABASE IF EXISTS sharespace;

CREATE DATABASE sharespace;

USE sharespace;


CREATE TABLE users (

    id INT AUTO_INCREMENT PRIMARY KEY,

    firstname VARCHAR(100) NOT NULL,

    lastname VARCHAR(100) NOT NULL,

    email VARCHAR(255) NOT NULL UNIQUE CHECK (LENGTH(email) > 0 AND email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'),

    password VARCHAR(255) NOT NULL CHECK (LENGTH(password) >= 8),

    phone VARCHAR(20) NOT NULL CHECK (LENGTH(phone) = 10 AND phone REGEXP '^04[0-9]{8}$'),

    role ENUM('admin', 'seller', 'buyer') NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE TABLE properties (

    id INT AUTO_INCREMENT PRIMARY KEY,

    seller_id INT NOT NULL,

    title VARCHAR(255) NOT NULL,

    property_type VARCHAR(50) NOT NULL,

    suburb VARCHAR(100) NOT NULL,

    city VARCHAR(100) NOT NULL,

    postcode VARCHAR(10) NOT NULL CHECK (LENGTH(postcode) = 4 AND postcode REGEXP '^[0-9]{4}$'),

    latitude DECIMAL(10,8) NOT NULL,

    longitude DECIMAL(11,8) NOT NULL,

    bedrooms INT NOT NULL,

    bathrooms INT NOT NULL,

    occupants INT NOT NULL,


    status ENUM('available', 'unavailable') DEFAULT 'available',

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    price DECIMAL(10,2) NOT NULL CHECK (price > 0),

    FOREIGN KEY (seller_id)
        REFERENCES users(id)
        ON DELETE CASCADE

);


CREATE TABLE preferences (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL UNIQUE

);


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


CREATE TABLE enquiries (

    enquiry_id INT AUTO_INCREMENT PRIMARY KEY,

    buyer_id INT NOT NULL,

    property_id INT NOT NULL,

    subject VARCHAR(255) NOT NULL,

    message TEXT NOT NULL,

    status ENUM('new', 'responded', 'closed') DEFAULT 'new',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (buyer_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (property_id)
        REFERENCES properties(id)
        ON DELETE CASCADE

);


CREATE TABLE offers (

    id INT AUTO_INCREMENT PRIMARY KEY,

    buyer_id INT NOT NULL,

    property_id INT NOT NULL,

    offered_price DECIMAL(10,2) NOT NULL,

    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (buyer_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (property_id)
        REFERENCES properties(id)
        ON DELETE CASCADE

);


CREATE TABLE bookmarks (

    id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    property_id INT NOT NULL,

    note TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (property_id)
        REFERENCES properties(id)
        ON DELETE CASCADE,

    UNIQUE KEY user_property_unique (user_id, property_id)

);



INSERT INTO users
(firstname, lastname, email, password, phone, role)

VALUES

('Ava', 'Patel', 'admin1@sharespace.com', '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', '0400000001', 'admin'),

('Marcus', 'Nguyen', 'admin2@sharespace.com', '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', '0400000002', 'admin'),

('Sarah', 'Mitchell', 'sarah@sharespace.com', '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', '0412003003', 'seller'),

('Daniel', 'Roberts', 'daniel@sharespace.com', '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', '0412003004', 'seller'),

('Rahul', 'Harlapur', 'rahul@sharespace.com', '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', '0421004005', 'buyer'),

('Emily', 'Chen', 'emily@sharespace.com', '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', '0421004006', 'buyer');



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



INSERT INTO properties
(
    seller_id,
    title,
    property_type,
    price,
    suburb,
    city,
    postcode,
    latitude,
    longitude,
    bedrooms,
    bathrooms,
    occupants,

    status,
    description
)

VALUES

(
    3,
    'Furnished Shared Apartment Near Queen Street',
    'Shared Apartment',
    295,
    'Brisbane CBD',
    'Brisbane',
    '4000',
    -27.47050000,
    153.02600000,
    3,
    1,
    3,

    'available',
    'Furnished room in a tidy shared apartment within walking distance of Queen Street Mall, Central Station, QUT Gardens Point and river bike paths. Rent includes internet and shared cleaning supplies.'
),

(
    3,
    'Sunny South Brisbane Share Apartment',
    'Shared Apartment',
    320,
    'South Brisbane',
    'Brisbane',
    '4101',
    -27.47860000,
    153.02030000,
    2,
    2,
    2,

    'available',
    'Light-filled apartment close to South Bank, TAFE Queensland and busway services. The room is furnished, bills are split monthly, and current housemates prefer a clean weekday routine.'
),

(
    3,
    'Riverfront Entire Apartment in New Farm',
    'Entire Apartment',
    620,
    'New Farm',
    'Brisbane',
    '4005',
    -27.46790000,
    153.04690000,
    2,
    2,
    2,

    'available',
    'Private two-bedroom apartment near New Farm Park with secure parking, air conditioning and a balcony facing the river. Suitable for a couple or two professionals wanting a full-place lease.'
),

(
    4,
    'Quiet Toowong Shared House with Study Space',
    'Shared House',
    245,
    'Toowong',
    'Brisbane',
    '4066',
    -27.48540000,
    152.99200000,
    4,
    2,
    4,

    'available',
    'Calm four-bedroom house near Toowong Village, bus stops and the train station. The available room suits a student or professional who wants a quiet house with shared study space and a backyard.'
),

(
    4,
    'Private Room Near PA Hospital',
    'Private Room',
    225,
    'Woolloongabba',
    'Brisbane',
    '4102',
    -27.49580000,
    153.03660000,
    1,
    1,
    1,

    'available',
    'Lockable furnished room in a well-kept Woolloongabba townhouse close to the PA Hospital, Gabba busway and local cafes. Electricity and water are included in the weekly rent.'
),

(
    4,
    'West End Apartment With Courtyard',
    'Shared Apartment',
    310,
    'West End',
    'Brisbane',
    '4101',
    -27.48150000,
    153.01210000,
    2,
    1,
    2,

    'available',
    'Clean two-bedroom apartment in West End with a small courtyard, furnished lounge and easy access to Boundary Street dining. Best suited to a non-smoker who values tidy shared spaces.'
),

(
    3,
    'St Lucia Student Share Apartment',
    'Shared Apartment',
    285,
    'St Lucia',
    'Brisbane',
    '4067',
    -27.49750000,
    153.01370000,
    3,
    2,
    3,

    'available',
    'Three-bedroom student share apartment close to UQ, Guyatt Park ferry terminal and local buses. The room includes a desk, built-in robe and access to a shared balcony.'
),

(
    3,
    'Indooroopilly Shared House With Study',
    'Shared House',
    275,
    'Indooroopilly',
    'Brisbane',
    '4068',
    -27.49960000,
    152.97380000,
    4,
    2,
    4,

    'available',
    'Large shared house near Indooroopilly Shopping Centre with a dedicated study nook, covered outdoor area and off-street parking. Suitable for tenants wanting a spacious shared home with study-friendly areas.'
),

(
    3,
    'South Bank Studio With Pool Access',
    'Studio',
    410,
    'South Bank',
    'Brisbane',
    '4101',
    -27.47650000,
    153.02190000,
    1,
    1,
    1,

    'available',
    'Self-contained studio near South Bank Parklands with lift access, gym, pool and secure entry. Ideal for someone wanting a private rental close to city campuses and public transport.'
),

(
    4,
    'Annerley Private Room Near Busway',
    'Private Room',
    195,
    'Annerley',
    'Brisbane',
    '4103',
    -27.51210000,
    153.03220000,
    1,
    1,
    1,

    'available',
    'Affordable private room in a quiet Annerley house with a shared kitchen, laundry and covered deck. Frequent buses run to the CBD, UQ and Griffith Nathan.'
),

(
    4,
    'Kelvin Grove Social Student Apartment',
    'Shared Apartment',
    300,
    'Kelvin Grove',
    'Brisbane',
    '4059',
    -27.45330000,
    153.01460000,
    3,
    2,
    3,

    'available',
    'Three-bedroom apartment within walking distance of QUT Kelvin Grove, supermarkets and Victoria Park. Current tenants are social but respectful during study weeks.'
),

(
    4,
    'Highgate Hill Private Room With City Views',
    'Private Room',
    280,
    'Highgate Hill',
    'Brisbane',
    '4101',
    -27.48850000,
    153.01880000,
    1,
    1,
    1,

    'available',
    'Furnished private room in Highgate Hill with city views, shared balcony and fast access to South Bank and West End. Rent includes internet and basic household items.'
),

(
    3,
    'Fortitude Valley Premium Studio with Parking',
    'Studio',
    455,
    'Fortitude Valley',
    'Brisbane',
    '4006',
    -27.45800000,
    153.03460000,
    1,
    1,
    1,

    'available',
    'Premium furnished studio close to James Street, Fortitude Valley station and nightlife. Suitable for a tenant wanting a private inner-city base with easy access to dining and transport.'
),

(
    4,
    'Chermside Shared House With Parking',
    'Shared House',
    265,
    'Chermside',
    'Brisbane',
    '4032',
    -27.38590000,
    153.03210000,
    4,
    2,
    4,

    'available',
    'Spacious shared house near Westfield Chermside with parking, a large kitchen and outdoor entertaining area. Existing tenants are friendly professionals with mixed work schedules.'
),

(
    3,
    'Fortitude Valley Apartment for Night Owl',
    'Shared Apartment',
    335,
    'Fortitude Valley',
    'Brisbane',
    '4006',
    -27.45800000,
    153.03460000,
    2,
    1,
    2,

    'available',
    'Shared apartment close to Fortitude Valley station, live music venues and late-night dining. Best suited to a tenant who is comfortable with an active inner-city lifestyle.'
);

INSERT INTO property_preferences
(property_id, preference_id)

VALUES

(1,2),
(1,4),
(1,5),

(2,1),
(2,3),

(3,4),

(4,1),
(4,5),

(5,4),

(6,1),
(6,3),

(7,4),
(7,5),

(8,1),
(8,5),

(9,1),
(9,3),

(10,4),

(11,6),
(11,4),

(12,3),
(12,5),

(13,1),
(13,7),

(14,2),
(14,6),

(15,8),
(15,6);



INSERT INTO user_preferences
(user_id, preference_id)

VALUES

(5,1),
(5,3),
(5,5),

(6,2),
(6,6),
(6,8);


INSERT INTO offers
(buyer_id, property_id, offered_price, status)

VALUES

(5, 7, 280, 'accepted'),

(6, 3, 590, 'rejected'),

(6, 9, 405, 'pending');


INSERT INTO bookmarks
(user_id, property_id, note)

VALUES

(5, 2, 'Close to South Bank and has the clean shared-space routine I want.'),

(5, 7, 'Best match for UQ access and already includes a desk.'),

(5, 9, 'Good private studio option if I decide not to share.'),

(6, 3, 'Entire apartment with secure parking for a longer lease.'),

(6, 11, 'Social student apartment near QUT Kelvin Grove.'),

(6, 15, 'Inner-city option that matches my night owl schedule.');


CREATE TABLE property_images (

    id INT AUTO_INCREMENT PRIMARY KEY,

    property_id INT NOT NULL,

    image VARCHAR(255) NOT NULL,

    display_order INT NOT NULL,

    FOREIGN KEY (property_id)
        REFERENCES properties(id)
        ON DELETE CASCADE

);


CREATE TABLE property_documents (

    id INT AUTO_INCREMENT PRIMARY KEY,

    property_id INT NOT NULL,

    file_path VARCHAR(255) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (property_id)
        REFERENCES properties(id)
        ON DELETE CASCADE

);


INSERT INTO property_images
(property_id, image, display_order)
VALUES
(1, 'img/property/rental-cover-01.jpg', 1),
(1, 'img/property/rental-kitchen-01.jpg', 2),
(1, 'img/property/rental-bedroom-01.jpg', 3),
(1, 'img/property/rental-bathroom-01.jpg', 4),

(2, 'img/property/rental-cover-02.jpg', 1),
(2, 'img/property/rental-kitchen-02.jpg', 2),
(2, 'img/property/rental-bedroom-02.jpg', 3),
(2, 'img/property/rental-bathroom-02.jpg', 4),

(3, 'img/property/rental-cover-03.jpg', 1),
(3, 'img/property/rental-kitchen-03.jpg', 2),
(3, 'img/property/rental-bedroom-03.jpg', 3),
(3, 'img/property/rental-bathroom-03.jpg', 4),

(4, 'img/property/rental-cover-04.jpg', 1),
(4, 'img/property/rental-kitchen-04.jpg', 2),
(4, 'img/property/rental-bedroom-04.jpg', 3),
(4, 'img/property/rental-bathroom-04.jpg', 4),

(5, 'img/property/rental-cover-05.jpg', 1),
(5, 'img/property/rental-kitchen-05.jpg', 2),
(5, 'img/property/rental-bedroom-05.jpg', 3),
(5, 'img/property/rental-bathroom-05.jpg', 4),

(6, 'img/property/rental-cover-06.jpg', 1),
(6, 'img/property/rental-kitchen-06.jpg', 2),
(6, 'img/property/rental-bedroom-06.jpg', 3),
(6, 'img/property/rental-bathroom-06.jpg', 4),

(7, 'img/property/rental-cover-07.jpg', 1),
(7, 'img/property/rental-kitchen-01.jpg', 2),
(7, 'img/property/rental-bedroom-02.jpg', 3),
(7, 'img/property/rental-bathroom-03.jpg', 4),

(8, 'img/property/rental-cover-08.jpg', 1),
(8, 'img/property/rental-kitchen-02.jpg', 2),
(8, 'img/property/rental-bedroom-03.jpg', 3),
(8, 'img/property/rental-bathroom-04.jpg', 4),

(9, 'img/property/rental-cover-09.jpg', 1),
(9, 'img/property/rental-kitchen-03.jpg', 2),
(9, 'img/property/rental-bedroom-04.jpg', 3),
(9, 'img/property/rental-bathroom-05.jpg', 4),

(10, 'img/property/rental-cover-10.jpg', 1),
(10, 'img/property/rental-kitchen-04.jpg', 2),
(10, 'img/property/rental-bedroom-05.jpg', 3),
(10, 'img/property/rental-bathroom-06.jpg', 4),

(11, 'img/property/rental-cover-11.jpg', 1),
(11, 'img/property/rental-kitchen-05.jpg', 2),
(11, 'img/property/rental-bedroom-06.jpg', 3),
(11, 'img/property/rental-bathroom-01.jpg', 4),

(12, 'img/property/rental-cover-12.jpg', 1),
(12, 'img/property/rental-kitchen-06.jpg', 2),
(12, 'img/property/rental-bedroom-01.jpg', 3),
(12, 'img/property/rental-bathroom-02.jpg', 4),

(13, 'img/property/rental-cover-13.jpg', 1),
(13, 'img/property/rental-kitchen-01.jpg', 2),
(13, 'img/property/rental-bedroom-03.jpg', 3),
(13, 'img/property/rental-bathroom-05.jpg', 4),

(14, 'img/property/rental-cover-14.jpg', 1),
(14, 'img/property/rental-kitchen-02.jpg', 2),
(14, 'img/property/rental-bedroom-04.jpg', 3),
(14, 'img/property/rental-bathroom-06.jpg', 4),

(15, 'img/property/rental-cover-15.jpg', 1),
(15, 'img/property/rental-kitchen-03.jpg', 2),
(15, 'img/property/rental-bedroom-05.jpg', 3),
(15, 'img/property/rental-bathroom-01.jpg', 4);


INSERT INTO property_documents
(property_id, file_path)
VALUES
(1, 'documents/Condition Report.pdf'),
(1, 'documents/House Agreement.pdf'),
(1, 'documents/Offer and Enquiry Guide.pdf'),

(2, 'documents/Condition Report.pdf'),
(2, 'documents/House Agreement.pdf'),
(2, 'documents/Offer and Enquiry Guide.pdf'),

(3, 'documents/Condition Report.pdf'),
(3, 'documents/House Agreement.pdf'),
(3, 'documents/Offer and Enquiry Guide.pdf'),

(4, 'documents/Condition Report.pdf'),
(4, 'documents/House Agreement.pdf'),
(4, 'documents/Offer and Enquiry Guide.pdf'),

(5, 'documents/Condition Report.pdf'),
(5, 'documents/House Agreement.pdf'),
(5, 'documents/Offer and Enquiry Guide.pdf'),

(6, 'documents/Condition Report.pdf'),
(6, 'documents/House Agreement.pdf'),
(6, 'documents/Offer and Enquiry Guide.pdf'),

(7, 'documents/Condition Report.pdf'),
(7, 'documents/House Agreement.pdf'),
(7, 'documents/Offer and Enquiry Guide.pdf'),

(8, 'documents/Condition Report.pdf'),
(8, 'documents/House Agreement.pdf'),
(8, 'documents/Offer and Enquiry Guide.pdf'),

(9, 'documents/Condition Report.pdf'),
(9, 'documents/House Agreement.pdf'),
(9, 'documents/Offer and Enquiry Guide.pdf'),

(10, 'documents/Condition Report.pdf'),
(10, 'documents/House Agreement.pdf'),
(10, 'documents/Offer and Enquiry Guide.pdf'),

(11, 'documents/Condition Report.pdf'),
(11, 'documents/House Agreement.pdf'),
(11, 'documents/Offer and Enquiry Guide.pdf'),

(12, 'documents/Condition Report.pdf'),
(12, 'documents/House Agreement.pdf'),
(12, 'documents/Offer and Enquiry Guide.pdf'),

(13, 'documents/Condition Report.pdf'),
(13, 'documents/House Agreement.pdf'),
(13, 'documents/Offer and Enquiry Guide.pdf'),

(14, 'documents/Condition Report.pdf'),
(14, 'documents/House Agreement.pdf'),
(14, 'documents/Offer and Enquiry Guide.pdf'),

(15, 'documents/Condition Report.pdf'),
(15, 'documents/House Agreement.pdf'),
(15, 'documents/Offer and Enquiry Guide.pdf');


INSERT INTO enquiries
(buyer_id, property_id, subject, message, status)

VALUES

(5, 1, 'Move-in date and bills', 'Hi Sarah, is the room available from the first week of July, and does the weekly rent include internet and water?', 'new'),

(5, 7, 'Inspection request near UQ', 'Could I inspect the St Lucia apartment this Saturday morning? I am looking for a furnished room close to campus.', 'responded'),

(6, 3, 'Lease length for entire apartment', 'I am interested in the New Farm apartment. Would the owner consider a six-month lease with an option to extend?', 'closed'),

(6, 11, 'Parking near Kelvin Grove', 'Is there visitor parking or street parking available nearby? I drive to placement twice a week.', 'new'),

(5, 5, 'Furniture and inspection time', 'Can you confirm whether the private room includes a bed and desk, and whether inspections are available after 5 pm?', 'responded'),

(6, 15, 'Noise and housemate routine', 'The location suits my schedule. Are the current housemates comfortable with someone who works some late shifts?', 'new');
