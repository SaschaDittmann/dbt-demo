with people as (
    SELECT *
    FROM {{ ref('stg_people') }}
    WHERE CURRENT_DATETIME() BETWEEN valid_from AND valid_to
)

SELECT  p.person_id AS wwi_employee_id
        , p.full_name AS employee
        , p.preferred_name AS preferred_name
        , p.is_salesperson AS is_salesperson
        -- , p.Photo AS photo
        , p.valid_from AS valid_from
        , p.valid_to AS valid_to
FROM    people p
