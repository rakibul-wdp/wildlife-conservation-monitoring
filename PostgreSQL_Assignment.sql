CREATE DATABASE conservation_db;

CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  region VARCHAR(150)
);
SELECT * FROM rangers;

CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  common_name VARCHAR(250) NOT NULL,
  scientific_name VARCHAR(250),
  discovery_date DATE,
  conservation_status VARCHAR(70)
);
SELECT * FROM species;

CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INTEGER REFERENCES rangers(ranger_id),
  species_id INTEGER REFERENCES species(species_id),
  sighting_time TIMESTAMP,
  location VARCHAR(250),
  notes TEXT
);
SELECT * FROM sightings;

INSERT INTO rangers (name, region) VALUES 
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (ranger_id, species_id, sighting_time, location, notes) VALUES 
(1, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(2, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen'),
(3, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed'),
(2, 1, '2024-05-18 18:30:00', 'Snowfall Pass', NULL);

-- Problem 1
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4
SELECT r.name, COUNT(s.sighting_id) AS total_sightings 
FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name
ORDER BY r.name ASC;

-- Problem 5
SELECT s.common_name
FROM species s
LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE si.sighting_id IS NULL;