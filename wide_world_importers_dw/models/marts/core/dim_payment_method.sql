with payment_methods as (
    SELECT *
    FROM {{ ref('stg_payment_methods') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  p.payment_method_id AS wwi_payment_method_id
        , p.payment_method_name AS payment_method
        , p.valid_from AS valid_from
        , p.valid_to AS valid_to
FROM    payment_methods p
