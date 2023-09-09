use sakila;

select 
    st.store_id,
    concat(city, ', ', country) as store_name,
    ad.address,
    ad.district,
    ct.city_id,
    ct.city,
    co.country
from store as st
    inner join address as ad 
        on st.address_id = ad.address_id
    inner join city as ct 
        on ad.city_id = ct.city_id
    inner join country as co 
        on ct.country_id = co.country_id
limit 10
;

select 
    cu.customer_id,
    concat(cu.first_name, ', ', cu.last_name) as customer_name,
    cu.email,
    concat(ct.city, ', ', co.country) as store_id,
    ad.address,
    concat(cct.city, ', ', cco.country) as customer_city,
    cad.address
from customer as cu
    inner join store as st
        on cu.store_id = st.store_id
    inner join address as ad 
        on st.address_id = ad.address_id
    inner join city as ct 
        on ad.city_id = ct.city_id
    inner join country as co 
        on ct.country_id = co.country_id
    inner join address as cad
        on cu.address_id = cad.address_id
    inner join city as cct 
        on cad.city_id = cct.city_id 
    inner join country as cco 
        on cct.country_id = cco.country_id
limit 10
;