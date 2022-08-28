with stock_items as (
    SELECT *
    FROM {{ ref('stg_stock_items') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

package_types as (
    SELECT *
    FROM {{ ref('stg_package_types') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

colors as (
    SELECT *
    FROM {{ ref('stg_colors') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  si.stock_item_id AS wwi_stock_item_id
        , si.stock_item_name AS stock_item
        , c.color_name AS color
        , spt.package_type_name AS selling_package
        , bpt.package_type_name AS buying_package
        , si.brand AS brand
        , si.size AS size
        , si.lead_time_days AS lead_time_days
        , si.quantity_per_outer AS quantity_per_outer
        , si.is_chiller_stock AS is_chiller_stock
        , si.barcode AS barcode
        , si.tax_rate AS tax_rate
        , si.unit_price AS unit_price
        , si.recommended_retail_price AS recommended_retail_price
        , si.typical_weight_per_unit AS typical_weight_per_unit
        -- , si.photo AS photo
        , si.valid_from AS valid_from
        , si.valid_to AS valid_to
FROM    stock_items si
JOIN    package_types spt
        ON si.unit_package_id = spt.package_type_id
JOIN    package_types bpt
        ON si.outer_package_id = bpt.package_type_id
LEFT 
JOIN    colors c
        ON si.color_id = c.color_id
