with customers as (
    SELECT *
    FROM {{ ref('stg_customers') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

buying_groups as (
    SELECT *
    FROM {{ ref('stg_buying_groups') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

customer_categories as (
    SELECT *
    FROM {{ ref('stg_customer_categories') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

people as (
    SELECT *
    FROM {{ ref('stg_people') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  c.customer_id AS wwi_customer_id
        , c.customer_name AS customer
        , bt.customer_name AS bill_to_customer
        , cc.customer_category_name AS category
        , bg.buying_group_name AS buying_group
        , p.full_name AS primary_contact
        , c.delivery_postal_code AS postal_code
        , c.valid_from AS valid_from
        , c.valid_to AS valid_to
FROM    customers c
JOIN    buying_groups bg
        ON c.buying_group_id = bg.buying_group_id
JOIN    customer_categories cc
        ON c.customer_category_id = cc.customer_category_id
JOIN    customers bt
        ON c.bill_to_customer_id = bt.bill_to_customer_id
JOIN    people p
        ON c.primary_contact_person_id = p.person_id
