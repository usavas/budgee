        SELECT 
        strftime('%m', datetime(transaction_date,'unixepoch')) as month_num,
        strftime('%Y', datetime(transaction_date,'unixepoch')) as year_num,
        t.transaction_cat_id,
        c.transaction_cat_name,
        i.transaction_type_id,
        t.transaction_type_name,
        SUM(transaction_amount) AS total_amount
      FROM transaction_info i, transaction_type t, transaction_cat c
      WHERE i.transaction_type_id = t.id 
        AND t.transaction_cat_id = c.id
        AND month_num = '[MONTH_NUM]' 
        AND year_num = '[YEAR_NUM]'
        AND c.id = '[CATEGORY_ID]'
      GROUP BY 	transaction_type_id,
        transaction_type_name,
        i.transaction_type_id,
        t.transaction_type_name,
        year_num,
        month_num;