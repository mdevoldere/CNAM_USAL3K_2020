-- Gestion utilisateurs

DROP USER `mdevoldere`@`localhost`;

CREATE user `mdevoldere`@`localhost` IDENTIFIED BY 'azer';
GRANT ALL PRIVILEGES ON usal3k_bank.* TO `mdevoldere`@`localhost`;


RENAME user `mdevoldere`@`localhost` TO `mdev`@`127.0.0.1`;
GRANT ALL PRIVILEGES ON zamis.* TO `mdev`@`127.0.0.1`;
REVOKE INSERT ON zamis.* FROM `mdev`@`127.0.0.1`;
REVOKE INSERT, UPDATE ON zamis.* FROM `mdev`@`127.0.0.1`;


CREATE user 'utilisateur1'@'localhost' IDENTIFIED BY 'azer';
CREATE user 'utilisateur2'@'localhost' IDENTIFIED BY 'azer';
CREATE user 'utilisateur3'@'localhost' IDENTIFIED BY 'azer';

GRANT SELECT ON zamis.* TO 'utilisateur1'@'localhost';

GRANT SELECT, UPDATE  ON zamis.members TO 'utilisateur2'@'localhost';
GRANT SELECT  ON zamis.parkings TO 'utilisateur2'@'localhost';
GRANT UPDATE  ON zamis.passages TO 'utilisateur2'@'localhost';
GRANT INSERT, DELETE  ON zamis.checkpoints TO 'utilisateur2'@'localhost';

FLUSH PRIVILEGES;

-- GRANT ALL PRIVILEGES ON *.* TO `mdev`@`127.0.0.1`;



-- GRANT ALL PRIVILEGES ON zamis.members TO `mdev`@`127.0.0.1`;


FLUSH PRIVILEGES;

SELECT * FROM `mysql`.`user`;