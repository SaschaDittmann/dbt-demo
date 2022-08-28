with cities as (
    SELECT *
    FROM {{ ref('stg_cities') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

state_provinces as (
    SELECT *
    FROM {{ ref('stg_state_provinces') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
),

countries as (
    SELECT *
    FROM {{ ref('stg_countries') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  c.city_id AS wwi_city_id
        , c.city_name AS city
        , sp.state_province_name AS state_province
        , co.country_name AS country
        , co.continent AS continent
        , sp.sales_territory AS sales_territory
        , co.region AS region
        , co.subregion AS subregion
        --, c.[Location]
        , COALESCE(c.latest_recorded_population, 0) AS latest_recorded_population
        , c.valid_from AS valid_from
        , CAST(NULL AS datetime) AS valid_to
FROM    cities c
JOIN    state_provinces sp
        ON c.state_province_id = sp.state_province_id
JOIN    countries co
        ON sp.country_id = co.country_id
