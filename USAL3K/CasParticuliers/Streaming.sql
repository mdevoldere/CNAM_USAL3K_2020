
INSERT INTO lire 
(client_id, film_id, service_id, date_lecture, position_lecture) 
VALUES 
(1, 3, 5, '2020-01-02 14:45:52', 0);


SELECT client_id, service_id FROM abonner  
WHERE client_id=1 AND service_id=5; 

-- compte le nombre de lignes que renvoie la requete 
-- et injecte le résultat dans "maVar"
SELECT COUNT(*) INTO maVar FROM abonner  
WHERE client_id=1 AND service_id=5; 


