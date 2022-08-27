{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  CityID AS city_id
        , CityName AS city_name
        , StateProvinceID AS state_province_id
        , LatestRecordedPopulation AS latest_recorded_population
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_Cities') }}
UNION ALL
SELECT  CityID AS city_id
        , CityName AS city_name
        , StateProvinceID AS state_province_id
        , LatestRecordedPopulation AS latest_recorded_population
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_Cities_Archive') }}
