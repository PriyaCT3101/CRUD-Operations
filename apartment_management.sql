-- Create database
CREATE DATABASE IF NOT EXISTS apartment_management;
USE apartment_management;

-- Create roles table
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    details TEXT,
    access JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    authentication_id VARCHAR(100) UNIQUE,
    role_id INT,
    email VARCHAR(100) NOT NULL UNIQUE,
    contact VARCHAR(20),
    flat_number VARCHAR(20),
    maintenance_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Create apartments table
CREATE TABLE apartments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    number_of_flats INT NOT NULL,
    address_1 VARCHAR(255) NOT NULL,
    address_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    phone VARCHAR(20),
    state VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create income table
CREATE TABLE income (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    apartment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_ref VARCHAR(100),
    paid_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (apartment_id) REFERENCES apartments(id)
);

-- Create expense table
CREATE TABLE expense (
    id INT PRIMARY KEY AUTO_INCREMENT,
    apartment_id INT NOT NULL,
    user_id INT NOT NULL,
    expense_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    details TEXT,
    paid_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (apartment_id) REFERENCES apartments(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create files table
CREATE TABLE files (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expense_id INT NOT NULL,
    blob_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (expense_id) REFERENCES expense(id)
);

-- Insert default roles
INSERT INTO roles (name, details, access) VALUES
('Admin', 'Full system access', '{"all": true}'),
('Manager', 'Apartment management access', '{"apartment": true, "users": true, "reports": true}'),
('Resident', 'Basic resident access', '{"profile": true, "payments": true}');

-- Create indexes for better performance
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_apartments_name ON apartments(name);
CREATE INDEX idx_income_user_id ON income(user_id);
CREATE INDEX idx_income_apartment_id ON income(apartment_id);
CREATE INDEX idx_expense_apartment_id ON expense(apartment_id);
CREATE INDEX idx_expense_user_id ON expense(user_id);
CREATE INDEX idx_files_expense_id ON files(expense_id); 
