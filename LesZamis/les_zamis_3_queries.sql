-- DQL
-- SELECT

USE zamis;

SELECT * FROM parkings;
-- afficher les plaques de toutes les voitures dans un parking

SELECT * FROM passages;

SELECT passage_registration FROM passages WHERE passage_out IS NULL;

-- afficher les plaques + date d'entrée de toutes les voitures dans un parking
SELECT passage_registration, passage_in FROM passages WHERE passage_out IS NULL;

SELECT passage_registration AS toto, passage_in AS tata FROM passages WHERE passage_out IS NULL;


-- afficher les plaques + date d'entrée + prix du parking de toutes les voitures dans un parking
SELECT passage_registration, passage_in, parking_price, P.parking_id
FROM passages 
JOIN parkings AS P ON P.parking_id = passages.parking_id 
WHERE passage_out IS NULL;




-- afficher les plaques + date d'entrée + prix du parking 
-- de toutes les voitures dans un parking dont le prix du parking est supérieur à 1€
SELECT passage_registration, passage_in, P.parking_price, P.parking_id
FROM passages 
JOIN parkings AS P ON P.parking_id = passages.parking_id 
WHERE passage_out IS NULL AND P.parking_price > 1;



-- afficher les plaques + date d'entrée + prix du parking 
-- de toutes les voitures dans un parking dont le prix du parking est supérieur à 1€
SELECT passage_registration, passage_in, P.parking_price, parking_id
FROM passages 
JOIN parkings AS P ON P.parking_id = passages.parking_id AND P.parking_price > 1
WHERE passage_out IS NULL;


-- Référencer toutes les plaques d'immatriculatiuon des véhicules (sans doublon)
SELECT DISTINCT passage_registration, passage_out FROM passages;


-- Afficher la plaque d'immatriculation et le prix total payé par chaque véhicule
SELECT passage_registration, SUM(parking_price), MIN(parking_price) FROM passages 
JOIN parkings ON parkings.parking_id = passages.parking_id
GROUP BY passage_registration;


-- Afficher tous les libellés des incidents de type "Altercation"
SELECT incident_number, incident_label FROM incidents 
JOIN incidents_types ON fk_incident_number = incident_number
JOIN types ON fk_type_name = 'Altercation'
GROUP BY incident_number;


SELECT incident_number, incident_label 
FROM incidents 
JOIN incidents_types ON fk_incident_number = incident_number AND fk_type_name = 'Altercation';


SELECT incident_number, incident_label 
FROM incidents 
JOIN incidents_types ON fk_incident_number = incident_number
WHERE fk_type_name = 'Altercation';


-- Afficher les incidents du membre 1 qui sont du type Altercation
SELECT member_id, incident_number, incident_label, fk_type_name
 FROM members 
 JOIN incidents ON member_id = fk_member_id 
 JOIN incidents_types ON incident_number = fk_incident_number 
 WHERE fk_type_name = 'Altercation';


-- Afficher les incidents du membre 1 qui sont du type Altercation et dont les secours ont du être appelé 
SELECT member_id, incident_number, incident_label, fk_type_name, incident_rescue
 FROM members 
 INNER JOIN incidents ON member_id = fk_member_id 
 INNER JOIN incidents_types ON incident_number = fk_incident_number ;
 
 SELECT member_id, incident_number, incident_label, fk_type_name, incident_rescue
 FROM members 
 LEFT JOIN incidents ON fk_member_id  = member_id
 LEFT JOIN incidents_types ON incident_number = fk_incident_number;
 
 -- Afficher les incidents du membre 1 qui sont du type Altercation et dont les secours ont du être appelé 
SELECT member_id, incident_number, incident_label, fk_type_name, incident_rescue
 FROM members 
 RIGHT JOIN incidents ON fk_member_id  = member_id
 RIGHT JOIN incidents_types ON incident_number = fk_incident_number;
 -- WHERE fk_type_name = 'Altercation';


 -- Afficher les incidents dans la Salle 1 du membre 1 qui sont du type Altercation et dont les secours ont du être appelé 
SELECT member_id, incident_number, incident_label, fk_type_name, incident_rescue, checkpoint_name
 FROM members 
 INNER JOIN incidents ON member_id = fk_member_id 
 INNER JOIN checkpoints ON checkpoint_name = fk_checkpoint_name
 INNER JOIN incidents_types ON incident_number = fk_incident_number 
 WHERE checkpoint_name = 'Salle 1' 
 AND member_id = 1 
 AND incident_rescue = 1
 ;

SELECT member_id, incident_number, incident_label, fk_type_name, incident_rescue, checkpoint_name
 FROM members 
 INNER JOIN incidents ON member_id = fk_member_id  AND member_id = 1 AND incident_rescue = 1
 INNER JOIN checkpoints ON checkpoint_name = fk_checkpoint_name AND  checkpoint_name = 'Salle 1' 
 INNER JOIN incidents_types ON incident_number = fk_incident_number ;

