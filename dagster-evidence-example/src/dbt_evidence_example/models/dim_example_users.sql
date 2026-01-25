-- Sample users dimension table
select * from (
    values
        (1, 'Alice Smith', 'Engineering'),
        (2, 'Bob Johnson', 'Marketing'),
        (3, 'Carol Williams', 'Sales')
) as users(id, name, department)
