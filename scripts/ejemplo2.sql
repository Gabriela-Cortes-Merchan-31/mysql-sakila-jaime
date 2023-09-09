use sakila;

## Ventas por empleado y por cliente
with ventas_empleado_cliente as (
    SELECT
        CONCAT(city, ',', country) AS store,
        CONCAT(staff.first_name,' ', staff.last_name) AS manager,
        CONCAT(customer.first_name,' ', customer.last_name) AS customer,
        payment_date,
        MONTH(payment_date) as month,
        YEAR(payment_date) as year,
        amount
    FROM country
        INNER JOIN city USING(country_id)
        INNER JOIN address USING(city_id)
        INNER JOIN store USING(address_id)
        INNER JOIN staff USING(store_id)
        INNER JOIN payment USING(staff_id)
        INNER JOIN customer USING(customer_id)
),
ventas_empleado_cliente_por_mes as (
    SELECT 
        store, 
        manager,
        customer,
        sum(case when year=2005 and month = 5 then amount else 0 end) as may2005,
        sum(case when year=2005 and month = 6 then amount else 0 end) as jun2005,
        sum(case when year=2005 and month = 7 then amount else 0 end) as jul2005
    FROM ventas_empleado_cliente
    GROUP BY store, manager, customer
),
ventas_comparativo as (
    SELECT 
        store,
        manager,
        customer, 
        may2005,
        jun2005,
        (jun2005-may2005) as diff,
        case when may2005 <> 0 then ((jun2005-may2005)/may2005) else 0 end as perc,
        jul2005,
        (jul2005-jun2005) as diff2,
        case when jun2005 <> 0 then ((jul2005-jun2005)/jun2005) else 0 end as perc2
    from ventas_empleado_cliente_por_mes
)
SELECT *
FROM ventas_comparativo
LIMIT 10
;    