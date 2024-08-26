-- Create schemas
CREATE SCHEMA schema1;
CREATE SCHEMA schema2;
CREATE SCHEMA schema3;

-- Create the same table in each schema
CREATE TABLE schema1.example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    value INT
);

CREATE TABLE schema2.example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    value INT
);

CREATE TABLE schema3.example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    value INT
);

-- Insert initial data into each table
INSERT INTO schema1.example_table (name, value) VALUES
('Alice', 10),
('Bob', 20);

INSERT INTO schema2.example_table (name, value) VALUES
('Charlie', 30),
('David', 40);

INSERT INTO schema3.example_table (name, value) VALUES
('Eve', 50),
('Frank', 60);
