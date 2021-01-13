DELIMITER $$

DROP PROCEDURE IF EXISTS usal3K_bank.bank_transfer;

CREATE PROCEDURE usal3K_bank.bank_transfer()
BEGIN

	UPDATE bank_accounts SET balance=balance-200 WHERE id=1;

	UPDATE bank_accounts SET balance=balance+200 WHERE id=2;


END $$

DELIMITER ;