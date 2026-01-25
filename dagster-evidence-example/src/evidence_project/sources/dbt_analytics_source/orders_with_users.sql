select
    o.id as order_id,
    o.amount,
    o.order_date,
    u.name as user_name,
    u.department
from main.fct_example_orders o
join main.dim_example_users u on o.user_id = u.id
