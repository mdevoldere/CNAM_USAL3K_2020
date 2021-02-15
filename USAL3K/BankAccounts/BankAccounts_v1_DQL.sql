USE usal3K_bank;

SELECT * FROM bank_accounts;
SELECT * FROM transaction_history;


SELECT t_account_id, SUM(t_amount) FROM transaction_history
WHERE t_type='C'
GROUP BY t_account_id;


SELECT t_type, SUM(t_amount) FROM transaction_history
GROUP BY t_type;

SELECT SUM(t_amount) FROM transaction_history;


SELECT 
t_account_id, 
t_type, 
`name`,
balance,
COUNT(*) as transaction_nb,
MIN(t_amount) as transaction_min, 
MAX(t_amount) as transaction_max, 
SUM(t_amount) as transaction_total, 
AVG(t_amount) as transaction_avg
FROM transaction_history
JOIN bank_accounts ON bank_accounts.id = transaction_history.t_account_id
WHERE t_account_id > 0 
GROUP BY t_account_id, t_type
ORDER BY t_account_id DESC;


