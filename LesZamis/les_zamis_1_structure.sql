
DROP DATABASE IF EXISTS zamis;


CREATE DATABASE IF NOT EXISTS zamis;


USE zamis;

CREATE TABLE parkings 
(
	parking_id INT PRIMARY KEY AUTO_INCREMENT,
	parking_price DECIMAL(6,4) UNSIGNED NULL,
	parking_places MEDIUMINT UNSIGNED NOT NULL
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci; 


-- Création de la table "passages"
CREATE TABLE passages
(
	passage_registration CHAR(11),
	passage_in DATETIME,
	passage_out DATETIME NULL,
	parking_id INT,
	PRIMARY KEY (passage_registration, passage_in)
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;



CREATE TABLE members
(
	member_id INT PRIMARY KEY AUTO_INCREMENT,
	member_lastname VARCHAR(255) NOT NULL,
	member_firstname VARCHAR(255) NOT NULL,
	member_date DATE NOT NULL,
	member_job VARCHAR(255) NULL,
	member_active TINYINT(1) NOT NULL
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;



CREATE TABLE incidents
(
	incident_number INT PRIMARY KEY AUTO_INCREMENT,
	incident_label VARCHAR(100) NOT NULL,
	incident_date DATETIME NOT NULL,
	incident_rescue TINYINT(1) NOT NULL,
	incident_rescue_hour DATETIME NULL,
	incident_details TEXT NOT NULL,
	incident_resolution TEXT NULL,
	fk_member_id INT NOT NULL
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE checkpoints
(
	checkpoint_name VARCHAR(50) PRIMARY KEY
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE rondes
(
	fk_member_id INT NOT NULL,
	fk_checkpoint_name VARCHAR(50),
	checkpoint_passage DATETIME NOT NULL,	
	PRIMARY KEY (fk_member_id, fk_checkpoint_name)
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;




CREATE TABLE types
(
	type_name VARCHAR(100) PRIMARY KEY
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE incidents_types
(
	fk_incident_number INT,
	fk_type_name VARCHAR(100),
	PRIMARY KEY (fk_incident_number, fk_type_name),
	FOREIGN KEY (fk_incident_number) REFERENCES incidents(incident_number),
	FOREIGN KEY (fk_type_name) REFERENCES types(type_name)
) Engine=InnoDb CHARACTER SET utf8 COLLATE utf8_general_ci;



ALTER TABLE passages 
	ADD FOREIGN KEY (parking_id) REFERENCES parkings(parking_id);
	
ALTER TABLE incidents 
	ADD COLUMN fk_checkpoint_name VARCHAR(50) NOT NULL AFTER incident_resolution,
	MODIFY COLUMN incident_label VARCHAR(150) NOT NULL,
	ADD FOREIGN KEY (fk_member_id) REFERENCES members(member_id),
	ADD FOREIGN KEY (fk_checkpoint_name) REFERENCES checkpoints(checkpoint_name),
	ADD INDEX  idx_incident_rescue (incident_rescue);


ALTER TABLE rondes 
	ADD FOREIGN KEY (fk_member_id) REFERENCES members(member_id),
	ADD FOREIGN KEY (fk_checkpoint_name) REFERENCES checkpoints(checkpoint_name);
	



