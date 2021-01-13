DROP DATABASE IF EXISTS usal3K_bank;
CREATE DATABASE usal3k_bank;
USE usal3k_bank;


-- CREATE user `mdevoldere`@`localhost` IDENTIFIED BY 'azer';
-- GRANT ALL PRIVILEGES ON usal3k_bank.* TO `mdevoldere`@`localhost`;

CREATE TABLE bank_accounts 
(
   `id` INT PRIMARY KEY,
   `name` VARCHAR(50),
   `balance` INT NOT NULL DEFAULT '0',
   `overdraft_limit` INT NOT NULL DEFAULT '0'
) Engine=InnoDb;

CREATE TABLE transaction_history 
(
	t_id INT PRIMARY KEY AUTO_INCREMENT,
    t_date DATETIME NOT NULL,
    t_amount DECIMAL(10,2),
    t_type CHAR(6),
    t_account_id INT NOT NULL,
    FOREIGN KEY (t_account_id) REFERENCES bank_accounts(id) 
);


/*
TODO : 
- Table transaction_history (conserver l'historique des débits/crédits)
	~ transaction_history(transaction_id, transaction_type, transaction_amount, transaction_account)
- Déclencheurs :
	~ Sauvegarder chaque débit/crédit dans l'historique
*/



INSERT INTO bank_accounts
(`id`, `name`, `balance`, `overdraft_limit`)
VALUES
(1, 'Mike', 1000, -100),
(2, 'Jean', 2500, -100),
(3, 'Pauline', 17800, -500),
(4, 'Martin', -50, -100),
(5, 'Cindy', 1900, -100);


DELIMITER $$ 

CREATE PROCEDURE bank_transfer
(
	IN amount INT UNSIGNED, 
	IN account_from INT UNSIGNED, 
	IN account_to INT UNSIGNED
)
BEGIN

	DECLARE new_balance INT;
    DECLARE new_overdraft INT;
	DECLARE account_exists INT;
    
    /* SELECT COUNT(*) INTO account_exists FROM bank_accounts 
    WHERE id=account_from OR id=account_to; */

	START TRANSACTION;
        
    SELECT COUNT(*) INTO account_exists FROM bank_accounts 
    WHERE id IN(account_from, account_to); 
	
    IF account_exists <> 2  
    THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Un des 2 comptes n\'existe pas !';
    END IF;

	UPDATE bank_accounts SET balance=balance-amount WHERE id=account_from; 
    
    SELECT 
    balance, overdraft_limit INTO new_balance, new_overdraft 
    FROM bank_accounts WHERE id=account_from;
    
    IF new_balance < new_overdraft 
    THEN 
		ROLLBACK;
	ELSE 
		UPDATE bank_accounts SET balance=balance+amount WHERE id=account_to;
        COMMIT;
    END IF;

END $$

DELIMITER ;



SELECT * FROM bank_accounts;

/* call bank_transfer(1, 2, 500); */