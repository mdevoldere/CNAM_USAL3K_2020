DROP DATABASE IF EXISTS usal3K_bank;
CREATE DATABASE usal3k_bank DEFAULT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
USE usal3k_bank;

-- CREATE user `usal3k_bank`@`localhost` IDENTIFIED BY 'azer';
-- GRANT ALL PRIVILEGES ON usal3k_bank.* TO `usal3k_bank`@`localhost`;


/*
	CREATION DES TABLES
*/


CREATE TABLE banks 
(
   `bank_id` INT PRIMARY KEY,
   `bank_name` VARCHAR(20),
   `bank_balance` INT NOT NULL DEFAULT '100000000'
) Engine=InnoDb;

CREATE TABLE bank_accounts 
(
   `id` INT PRIMARY KEY,
   `name` VARCHAR(20),
   `balance` INT NOT NULL DEFAULT '10000',
   `bank_id` INT NOT NULL DEFAULT '1',
   FOREIGN KEY (bank_id) REFERENCES banks(bank_id) 
) Engine=InnoDb;

CREATE TABLE transaction_history 
(
	`t_id` INT PRIMARY KEY AUTO_INCREMENT,
    `t_date` DATETIME NOT NULL,
    `t_amount` DECIMAL(10,2),
    `t_type` CHAR(1),
    `t_account_id` INT NOT NULL,
    FOREIGN KEY (t_account_id) REFERENCES bank_accounts(id) 
) Engine=InnoDb;


/*
	PROCEDURE STOCKEE : Transférer un montant vers d'un compte existant vers un autre compte existant
*/

DELIMITER $$ 

CREATE PROCEDURE bank_transfer
(
	IN amount INT UNSIGNED, 
	IN account_from INT UNSIGNED, 
	IN account_to INT UNSIGNED
)
BEGIN
	DECLARE new_balance INT;
	DECLARE account_exists INT;
    
    
	START TRANSACTION;
    
    IF account_from = account_to /* si les 2 identifiants de comptes sont identiques, c'est un simple crédit. */
    THEN
		SELECT COUNT(*) INTO account_exists FROM bank_accounts WHERE id = account_from;
        
        IF account_exists <> 1 /* si le compte n'existe pas */ 
        THEN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'La transaction est impossible !';
        ELSE
			UPDATE bank_accounts SET balance=balance+amount WHERE id = account_from;
			COMMIT;
        END IF;
    ELSE
		SELECT COUNT(*) INTO account_exists FROM bank_accounts WHERE id IN(account_from, account_to); 
		
		IF account_exists <> 2 /* si au moins 1 des 2 comptes n'existe pas, on lève une exception */
		THEN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'La transaction est impossible !';
		END IF;

		UPDATE bank_accounts SET balance=balance-amount WHERE id=account_from; 
		SELECT balance INTO new_balance FROM bank_accounts WHERE id=account_from;
		
		IF new_balance < 0 /* si le virement amène le solde du compte débiteur sous 0, on annule la transaction sans générer d'erreur */
		THEN 
			ROLLBACK;
		ELSE /* sinon, on poursuit et on crédite le compte destinataire */
			UPDATE bank_accounts SET balance=balance+amount WHERE id=account_to;
			COMMIT;
		END IF;
    END IF;
    
        
    

END $$

DELIMITER ;


/*
	DECLENCHEUR : Sauvegarder chaque débit/crédit dans l'historique
*/


DELIMITER $$ 

CREATE trigger log_transactions 
AFTER UPDATE 
ON bank_accounts 
FOR EACH ROW 
BEGIN
	DECLARE tr_type CHAR(6);
    DECLARE tr_amount DECIMAL(10,2);
   
    IF OLD.balance <> NEW.balance
    THEN 
		IF OLD.balance > NEW.balance
        THEN 
			SET tr_type = 'D'; 
            SET tr_amount = OLD.balance - NEW.balance;
		ELSE 
			SET tr_type = 'C';
            SET tr_amount = NEW.balance - OLD.balance;
        END IF;
        
		INSERT INTO transaction_history
        (t_date, t_amount, t_type, t_account_id)
        VALUES
        (NOW(), tr_amount, tr_type, NEW.id);
    END IF;
END $$



/*
	INSERTION DES DONNEES DANS LES TABLES
*/

INSERT INTO banks 
(`bank_id`, `bank_name`) 
VALUES 
(1, 'Master Bank'),
(2, 'Banque Populaire'),
(3, 'Crédit Mutuel'),
(4, 'Caisse d\'épargne'),
(5, 'Crédit Agricole');


INSERT INTO bank_accounts
(`id`, `name`, `bank_id`)
VALUES
(1, 'Mike', 2),
(2, 'Jean', 3),
(3, 'Pauline', 4),
(4, 'Martin', 5),
(5, 'Cindy', 5),
(6, 'Réda', 4),
(7, 'Steeve', 3),
(8, 'Léa', 2),
(9, 'Justine', 3);


/*
	AJOUT DE QUELQUES TRANSACTIONS 
*/

CALL bank_transfer(1000, 1, 2);
CALL bank_transfer(2000, 1, 3);
CALL bank_transfer(3000, 1, 4);
CALL bank_transfer(4000, 2, 5);
CALL bank_transfer(5000, 2, 6);
CALL bank_transfer(500, 2, 7);
CALL bank_transfer(1000, 3, 8);
CALL bank_transfer(1500, 3, 9);
CALL bank_transfer(2000, 3, 1);
CALL bank_transfer(1000, 4, 2);
CALL bank_transfer(50, 4, 3);
CALL bank_transfer(150, 4, 1);
CALL bank_transfer(250, 5, 9);
CALL bank_transfer(350, 5, 6);
CALL bank_transfer(450, 5, 7);
CALL bank_transfer(800, 6, 8);
CALL bank_transfer(700, 6, 9);
CALL bank_transfer(600, 6, 1);
CALL bank_transfer(500, 7, 2);
CALL bank_transfer(100, 7, 3);
CALL bank_transfer(150, 8, 4);
CALL bank_transfer(150, 8, 5);
CALL bank_transfer(100, 9, 6);
CALL bank_transfer(50, 9, 7);


/*
	AFFICHAGE DES DONNES DES TABLES 
*/


SELECT * FROM transaction_history;
SELECT * FROM banks;
SELECT * FROM bank_accounts;
