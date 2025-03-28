-- Create user and grant privileges
CREATE USER IF NOT EXISTS 'ams_user'@'localhost' IDENTIFIED BY 'ams_password';
GRANT ALL PRIVILEGES ON apartment_management.* TO 'ams_user'@'localhost';
FLUSH PRIVILEGES;

-- Switch to the apartment_management database
USE apartment_management; 
