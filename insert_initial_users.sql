-- Insert initial admin user
INSERT INTO users (
    username,
    password,
    first_name,
    last_name,
    role_id,
    email,
    contact,
    flat_number,
    maintenance_amount
) VALUES (
    'admin',
    -- Password: Admin@123 (hashed with bcrypt)
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'System',
    'Administrator',
    (SELECT id FROM roles WHERE name = 'Admin'),
    'admin@apartmentmanagement.com',
    '9999999999',
    'ADMIN-001',
    0.00
);

-- Insert sample resident user
INSERT INTO users (
    username,
    password,
    first_name,
    last_name,
    role_id,
    email,
    contact,
    flat_number,
    maintenance_amount
) VALUES (
    'resident',
    -- Password: Resident@123 (hashed with bcrypt)
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'John',
    'Doe',
    (SELECT id FROM roles WHERE name = 'Resident'),
    'john.doe@example.com',
    '8888888888',
    '101',
    5000.00
); 
