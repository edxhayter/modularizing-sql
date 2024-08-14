-- I've documented the script so we can focus more on refactoring but consider the readability of the code without the comments.

-- Initial CTE that uses orders and payments to return the number of (successful) payments made in an order and the total value of the order
WITH order_payment_stats AS (
    SELECT
        o.id AS order_id,
        o.user_id AS customer_id,
        COUNT(p.id) AS number_of_payments,
        SUM(p.amount) / 100.0 AS total_order_amount
    FROM til_portfolio_projects.jaffle_shop.orders o
    LEFT JOIN til_portfolio_projects.stripe.payment p
        ON o.id = p.orderid
    WHERE p.status != 'fail'
    GROUP BY o.id, o.user_id
)

-- Main query aggregates the previous CTE data to the customer level (as opposed to order level) and also adds a first_order_date for context.
SELECT
    c.id AS customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    fo.first_order_date,
    SUM(ops.total_order_amount) AS total_spent,
    COUNT(ops.order_id) AS total_orders,
    AVG(ops.total_order_amount) AS avg_spend_per_order
FROM til_portfolio_projects.jaffle_shop.customers c
LEFT JOIN (
    SELECT 
        o.user_id AS customer_id,
        MIN(o.order_date) AS first_order_date
    FROM til_portfolio_projects.jaffle_shop.orders o
    GROUP BY o.user_id
) AS fo
    ON c.id = fo.customer_id
LEFT JOIN order_payment_stats ops
    ON c.id = ops.customer_id
GROUP BY c.id, c.first_name, c.last_name, fo.first_order_date
HAVING total_orders >= 1
ORDER BY total_spent DESC
