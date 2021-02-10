
CALL bank_transfer(1000, 1, 2);
CALL bank_transfer(500, 1, 1);

SELECT * FROM bank_accounts;
SELECT * from transaction_history;

/*SELECT * FROM transaction_history WHERE t_id <> 48 ORDER BY t_id DESC LIMIT 1;*/

SELECT * FROM transaction_history ORDER BY t_id DESC LIMIT 2;
