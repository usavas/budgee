SELECT 
	 SUM(transaction_amount) as total
	,strftime('%m', datetime(transaction_date,'unixepoch')) as month_num
	,strftime('%Y', datetime(transaction_date,'unixepoch')) as year_num
 FROM transaction_info
 WHERE 
	month_num = '[%MONTH]' AND
    year_num = '[%YEARNUMBER]' AND
	transaction_type_id IN 
	(SELECT t.id FROM transaction_type t, transaction_cat c 
	WHERE t.transaction_cat_id = c.id AND c.id = '[%TRANSACTION_CAT_ID]')
 GROUP BY month_num, year_num

