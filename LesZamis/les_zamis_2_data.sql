-- DML 
-- INSERT INTO
-- UPDATE 
-- DELETE
-- TRUNCATE

USE zamis;


INSERT INTO parkings 
VALUES
(NULL, 0, 300);

INSERT INTO parkings
(parking_price, parking_places)
VALUES
(3, 700);

INSERT INTO parkings
(parking_price, parking_places)
VALUES
(4, 800),
(8, 800),
(12.75, 800);


-- SELECT * FROM parkings;

UPDATE parkings SET parking_places=850 WHERE parking_id=3;

-- SELECT * FROM parkings;

UPDATE parkings SET parking_places=parking_places+50 WHERE parking_id=3;

-- SELECT * FROM parkings;


UPDATE parkings SET parking_places=1000, parking_price=parking_price+2 WHERE parking_id=4;

-- SELECT * FROM parkings;


-- DELETE FROM parkings WHERE parking_places < 800 AND parking_price < 10;




-- TRUNCATE TABLE parkings;


INSERT INTO passages
(passage_registration, passage_in, passage_out, parking_id)
VALUES
('AA-123-BB', '2020-09-08 09:47:15', NULL, '1'),
('CC-123-BB', '2020-09-10 13:47:30', NULL, 1),
('DD-123-BB', '2020-09-10 19:47:00', '2020-09-10 21:34:56', 2),
('DD-123-BB', '2020-09-11 09:47:00', NULL, 2), -- sortie 1 heure plus tard
('EE-123-BB', '2020-09-12 13:01:45', NULL, '2'),
('AA-123-BB', '2020-09-12 13:47:15', NULL, 2);


UPDATE passages SET passage_out='2020-09-11 10:47:02' WHERE passage_registration='DD-123-BB' AND passage_out IS NULL;



INSERT INTO members
(member_id, member_lastname, member_firstname, member_date, member_job, member_active)
VALUES 
(NULL,'DEV','Mike','2020-06-01','Gardien',1),
(NULL,'DUPONT','Jean','2018-04-08','Gardien',1),
(NULL,'MARTIN','Léa','2020-09-08',NULL,1);


INSERT INTO checkpoints 
(checkpoint_name)
VALUES
('Salle 1'),
('Salle 2'),
('Parking'),
('Terrain');


INSERT INTO types
(type_name)
VALUES 
('Dégât matériel'), 
('Accident corporel'), 
('Intrusiuon'), 
('Altercation'), 
('Autre');



INSERT INTO incidents
(incident_label, incident_date, incident_rescue, incident_rescue_hour, incident_details, incident_resolution, fk_checkpoint_name, fk_member_id)
VALUES 
('Bagarre', '2020-08-12 14:12:00', 1, '2020-08-12 14:35:00', 'Bagarre entre membres', 'un blessé léger emmené par une ambulance', 'Salle 1', 1),
('Vandalisme', '2020-08-12 14:12:00', 1, '2020-08-12 14:35:00', 'le carreau du bureau de la salle 1 a été cassé', 'appel d\'un professionnel', 'Salle 1', 1),
('Bagarre', '2020-08-12 14:12:00', 0, NULL, 'Bagarre entre membres', NULL, 'Parking', 1);


INSERT INTO incidents_types
(fk_incident_number, fk_type_name)
VALUES 
(1, 'Accident corporel'), 
(1, 'Altercation'), 
(2, 'Dégât matériel'), 
(3, 'Altercation');



SELECT * FROM parkings;
SELECT * FROM passages;
SELECT * FROM members;
SELECT * FROM checkpoints;
SELECT * FROM types;
SELECT * FROM incidents;
SELECT * FROM incidents_types;