CREATE TABLE teams(
   t_id INT,
   t_name VARCHAR(50) NOT NULL,
   t_points INT NOT NULL,
   PRIMARY KEY(t_id)
);

CREATE TABLE games(
   g_id VARCHAR(50),
   g_date DATETIME NOT NULL,
   g_stadium VARCHAR(50),
   PRIMARY KEY(g_id)
);

CREATE TABLE players(
   p_id INT,
   p_position VARCHAR(50) NOT NULL,
   p_lastname VARCHAR(50) NOT NULL,
   p_firstname VARCHAR(50) NOT NULL,
   p_goals INT NOT NULL,
   p_assists INT NOT NULL,
   t_id INT NOT NULL,
   PRIMARY KEY(p_id),
   FOREIGN KEY(t_id) REFERENCES teams(t_id)
);

CREATE TABLE soccer_match(
   p_id INT,
   t_id INT,
   g_id VARCHAR(50),
   PRIMARY KEY(p_id, t_id, g_id),
   FOREIGN KEY(p_id) REFERENCES players(p_id),
   FOREIGN KEY(t_id) REFERENCES teams(t_id),
   FOREIGN KEY(g_id) REFERENCES games(g_id)
);

DELIMITER $$

/*
déclarer une variable de type INT
recherche l'identifiant de l'équipe dans la table players (p_id=NEW.p_id)
comparer cet identifiant avec l'identiant de l'equipe en cours d'insertion
si c'est différent, je leve une erreur
*/
CREATE trigger inclusion_test 
BEFORE INSERT ON soccer_match
FOR EACH ROW 
BEGIN

	DECLARE C INT DEFAULT 0;
	/* SET C = 0; */

	SELECT t_id INTO C FROM players WHERE p_id=NEW.p_id;
    
	IF C <> NEW.t_id 
	THEN 
	 SIGNAL SQLSTATE '45000' 
	 SET MESSAGE_TEXT = '';
	END IF ;
    
    /*
    SELECT COUNT(*) INTO C 
	FROM players WHERE p_id=NEW.p_id AND t_id=NEW.t_id;
    
    IF C <> 1 
	THEN
	 SIGNAL SQLSTATE '45000' 
	 SET MESSAGE_TEXT = '';
	END IF ;
    */
    
    
END $$

DELIMITER ;