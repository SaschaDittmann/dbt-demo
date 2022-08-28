{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  StateProvinceID AS state_province_id
		, StateProvinceCode AS state_province_code
		, StateProvinceName AS state_province_name
		, CountryID AS country_id
		, SalesTerritory AS sales_territory
		, LatestRecordedPopulation AS latest_recorded_population
		, LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_StateProvinces') }}
UNION ALL
SELECT  StateProvinceID AS state_province_id
		, StateProvinceCode AS state_province_code
		, StateProvinceName AS state_province_name
		, CountryID AS country_id
		, SalesTerritory AS sales_territory
		, LatestRecordedPopulation AS latest_recorded_population
		, LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_StateProvinces_Archive') }}
