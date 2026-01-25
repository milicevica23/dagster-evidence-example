-- Sample orders fact table
select * from (
    values
        (101, 1, 250.00, '2024-01-15'),
        (102, 2, 175.50, '2024-01-16'),
        (103, 3, 420.00, '2024-01-17')
) as orders(id, user_id, amount, order_date)
