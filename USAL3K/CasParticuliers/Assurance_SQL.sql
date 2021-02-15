CREATE TABLE compagnies(
   compagnie_id INT,
   compagnie_name VARCHAR(50) NOT NULL,
   PRIMARY KEY(compagnie_id)
);

CREATE TABLE Foyers(
   particulier_id INT,
   PRIMARY KEY(particulier_id)
);

CREATE TABLE entreprises(
   ets_id INT,
   PRIMARY KEY(ets_id)
);

CREATE TABLE clients(
   client_id INT,
   client_name VARCHAR(50) NOT NULL,
   ets_id INT,
   particulier_id INT,
   compagnie_id INT NOT NULL,
   PRIMARY KEY(client_id),
   FOREIGN KEY(ets_id) REFERENCES entreprises(ets_id),
   FOREIGN KEY(particulier_id) REFERENCES Foyers(particulier_id),
   FOREIGN KEY(compagnie_id) REFERENCES compagnies(compagnie_id)
);

DELIMITER $$

CREATE trigger before_insert_clients 
BEFORE INSERT ON clients 
FOR EACH ROW  
BEGIN 

    IF NEW.ets_id IS NOT NULL AND NEW.particulier_id IS NOT NULL 
    THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Un client ne pas pas etre rattaché à un foyer et à une entreprise en même temps';
    ELSE IF NEW.ets_id IS NULL AND NEW.particulier_id IS NULL
    THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Un client doit être rattaché à un foyer ou à une entreprise';
    END IF;  

END $$


DELIMITER ;
