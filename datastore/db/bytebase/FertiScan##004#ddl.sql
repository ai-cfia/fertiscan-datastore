SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DEFAULT uuid_generate_v4()

-- Tables

-- Create the user table
CREATE TABLE "FertiScan_0.0.4".user (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  email varchar(255) NOT NULL UNIQUE,
  name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  id_region uuid REFERENCES "FertiScan_0.0.4".region(id),
  registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  permission_id int NOT NULL REFERENCES "FertiScan_0.0.4".permission(id)
);

-- Create the object table
CREATE TABLE "FertiScan_0.0.4".object (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid NOT NULL REFERENCES "FertiScan_0.0.4".user(id),
  upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the fertiliser_object table (many-to-many relationship between fertiliser and object)
CREATE TABLE "FertiScan_0.0.4".fertiliser_object (
  fertiliser_id uuid REFERENCES "FertiScan_0.0.4".fertiliser(id) PRIMARY KEY,
  object_id uuid REFERENCES "FertiScan_0.0.4".object(id) PRIMARY KEY
);

-- Create the group table
CREATE TABLE "FertiScan_0.0.4".group (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name varchar(255) NOT NULL,
  permission_id int NOT NULL REFERENCES "FertiScan_0.0.4".permission(id),
  owner_id uuid REFERENCES "FertiScan_0.0.4".user(id),
  upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the permission table
CREATE TABLE "FertiScan_0.0.4".permission (
  id int PRIMARY KEY DEFAULT uuid_generate_v4(),
  name varchar(255) NOT NULL
);

-- Create the user_group table (many-to-many relationship between user and group)
CREATE TABLE "FertiScan_0.0.4".user_group (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES "FertiScan_0.0.4".user(id),
  group_id uuid REFERENCES "FertiScan_0.0.4".group(id),
  upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the companie table
CREATE TABLE "FertiScan_0.0.4".companie (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name varchar(255) NOT NULL,
  address text,
  website varchar(255),
  phone_number varchar(255)
);

-- Create the manufacturer table
CREATE TABLE "FertiScan_0.0.4".manufacturer (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name varchar(255) NOT NULL,
  address text,
  website varchar(255),
  phone_number varchar(255)
);

-- Create the manufacturer_companie table (many-to-many relationship between manufacturer and companie)
CREATE TABLE "FertiScan_0.0.4".manufacturer_companie (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  companie_id uuid REFERENCES "FertiScan_0.0.4".companie(id),
  manufacturer_id uuid REFERENCES "FertiScan_0.0.4".manufacturer(id)
);

-- Create the fertiliser table
CREATE TABLE "FertiScan_0.0.4".fertiliser (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name varchar(255) NOT NULL,
  registration_number varchar(255),
  upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fertiliser_information_id uuid REFERENCES "FertiScan_0.0.4".information(id),
  manufacturer_companie_id uuid REFERENCES "FertiScan_0.0.4".manufacturer_companie(id)
);

-- Create the region table
CREATE TABLE "FertiScan_0.0.4".region (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  address text,
  city varchar(255) NOT NULL
);

-- Create the information table
CREATE TABLE "FertiScan_0.0.4".information (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  lot_number varchar(255),
  npk text,
  seller_garantie text,
  precautionary_id uuid REFERENCES "FertiScan_0.0.4".precautionary(id),
  guaranteed_analysis_id uuid REFERENCES "FertiScan_0.0.4".guaranteed_analysis(id),
  instruction_id uuid REFERENCES "FertiScan_0.0.4".instruction(id),
  ingredient_id uuid REFERENCES "FertiScan_0.0.4".ingredient(id),
  specification_id uuid REFERENCES "FertiScan_0.0.4".specification(id),
  caution_id uuid REFERENCES "FertiScan_0.0.4".caution(id),
  recommendation_id uuid REFERENCES "FertiScan_0.0.4".recommendation(id),
  first_aid_id uuid REFERENCES "FertiScan_0.0.4".first_aid(id),
  warranty_id uuid REFERENCES "FertiScan_0.0.4".warranty(id),
  danger_id uuid REFERENCES "FertiScan_0.0.4".danger(id),
  information_metrics_id uuid REFERENCES "FertiScan_0.0.4".information_metrics(id)
);

-- Create the precautionary table
CREATE TABLE "FertiScan_0.0.4".precautionary (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  precautionary_fr text,
  precautionary_en text
);

-- Create the instruction table
CREATE TABLE "FertiScan_0.0.4".instruction (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  instruction_fr text,
  instruction_en text
);

-- Create the ingredient table
CREATE TABLE "FertiScan_0.0.4".ingredient (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4()
);

-- Create the specification table
CREATE TABLE "FertiScan_0.0.4".specification (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  specification_fr text,
  specification_en text
);

-- Create the caution table
CREATE TABLE "FertiScan_0.0.4".caution (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  caution_fr text,
  caution_en text
);

-- Create the recommendation table
CREATE TABLE "FertiScan_0.0.4".recommendation (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  recommendation_fr text,
  recommendation_en text
);

-- Create the first_aid table
CREATE TABLE "FertiScan_0.0.4".first_aid (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  first_aid_fr text,
  first_aid_en text
);

-- Create the warranty table
CREATE TABLE "FertiScan_0.0.4".warranty (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  warranty_fr text,
  warranty_en text
);

-- Create the danger table
CREATE TABLE "FertiScan_0.0.4".danger (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  danger_fr text,
  danger_en text
);

-- Create the guaranteed_analysis table
CREATE TABLE "FertiScan_0.0.4".guaranteed_analysis (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  nutrient_id uuid REFERENCES "FertiScan_0.0.4".nutrient(id),
  percentage_id uuid REFERENCES "FertiScan_0.0.4".percentage(id)
);

-- Create the nutrient table
CREATE TABLE "FertiScan_0.0.4".nutrient (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name varchar(255) NOT NULL,
  sign char(1)
);

-- Create the percentage table
CREATE TABLE "FertiScan_0.0.4".percentage (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  percentage decimal(5,2) NOT NULL,
  CONSTRAINT percentage_check CHECK (percentage >= 0 AND percentage <= 100)
);

-- Create the information_metrics table
CREATE TABLE "FertiScan_0.0.4".information_metrics (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  information_id uuid REFERENCES "FertiScan_0.0.4".information(id),
  metrics_id uuid REFERENCES "FertiScan_0.0.4".metrics(id)
);

-- Create the metrics table
CREATE TABLE "FertiScan_0.0.4".metrics (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  metric_type varchar(255) NOT NULL,
  metric_value decimal(10,2) NOT NULL,
  unit char(10)
);

-- Add Foreign Key Constraints

ALTER TABLE "FertiScan_0.0.4".information_metrics
ADD CONSTRAINT information_metrics_metrics_id_fkey FOREIGN KEY (metrics_id) REFERENCES "FertiScan_0.0.4".metrics(id);

ALTER TABLE "FertiScan_0.0.4".fertiliser_object
ADD CONSTRAINT fertiliser_object_fertiliser_id_fkey FOREIGN KEY (fertiliser_id) REFERENCES "FertiScan_0.0.4".fertiliser(id);

ALTER TABLE "FertiScan_0.0.4".fertiliser_object
ADD CONSTRAINT fertiliser_object_object_id_fkey FOREIGN KEY (object_id) REFERENCES "FertiScan_0.0.4".object(id);

ALTER TABLE "FertiScan_0.0.4".user_group
ADD CONSTRAINT user_group_user_id_fkey FOREIGN KEY (user_id) REFERENCES "FertiScan_0.0.4".user(id);

ALTER TABLE "FertiScan_0.0.4".user_group
ADD CONSTRAINT user_group_group_id_fkey FOREIGN KEY (group_id) REFERENCES "FertiScan_0.0.4".group(id);

ALTER TABLE "FertiScan_0.0.4".manufacturer_companie
ADD CONSTRAINT manufacturer_companie_companie_id_fkey FOREIGN KEY (companie_id) REFERENCES "FertiScan_0.0.4".companie(id);

ALTER TABLE "FertiScan_0.0.4".manufacturer_companie
ADD CONSTRAINT manufacturer_companie_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES "FertiScan_0.0.4".manufacturer(id);
