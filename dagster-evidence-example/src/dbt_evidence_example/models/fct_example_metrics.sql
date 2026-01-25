-- Sample metrics fact table
select * from (
    values
        ('revenue', 845.50, 'USD'),
        ('orders', 3, 'count'),
        ('avg_order_value', 281.83, 'USD')
) as metrics(name, value, unit)
