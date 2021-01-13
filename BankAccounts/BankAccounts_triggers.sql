USE usal3k_bank;

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
			SET tr_type = 'debit'; 
            SET tr_amount = OLD.balance - NEW.balance;
		ELSE 
			SET tr_type = 'credit';
            SET tr_amount = NEW.balance - OLD.balance;
        END IF;
        
		INSERT INTO transaction_history
        (t_date, t_amount, t_type, t_account_id)
        VALUES
        (NOW(), tr_amount, tr_type, NEW.id);
    END IF;
END $$

DELIMITER ;

