with payment_methods as (
    SELECT *
    FROM {{ ref('stg_transaction_types') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  p.transaction_type_id AS wwi_payment_method_id
        , p.transaction_type_name AS transaction_type
        , p.valid_from AS valid_from
        , p.valid_to AS valid_to
FROM    payment_methods p
