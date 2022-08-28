with suppliers as (
    SELECT *
    FROM {{ ref('stg_suppliers') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

supplier_categories as (
    SELECT *
    FROM {{ ref('stg_supplier_categories') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

people as (
    SELECT *
    FROM {{ ref('stg_people') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  s.supplier_id AS wwi_supplier_id
        , s.supplier_name AS supplier_name
        , sc.supplier_category_name AS category
        , p.full_name AS primary_contact
        , s.supplier_reference AS supplier_reference
        , s.payment_days AS payment_days
        , s.delivery_postal_code AS postal_code
        , s.valid_from AS valid_from
        , s.valid_to AS valid_to
FROM    suppliers s
JOIN    supplier_categories sc
        ON s.supplier_category_id = sc.supplier_category_id
JOIN    people p
        ON s.primary_contact_person_id = p.person_id
