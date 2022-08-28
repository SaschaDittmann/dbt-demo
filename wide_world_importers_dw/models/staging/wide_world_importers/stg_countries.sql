{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  CountryID AS country_id
        , CountryName AS country_name
        , FormalName AS formal_name
		, IsoAlpha3Code AS iso_alpha3_code
		, IsoNumericCode AS iso_numeric_code
		, CountryType AS country_type
		, LatestRecordedPopulation AS latest_recorded_population
		, Continent AS continent
		, Region AS region
		, Subregion AS subregion
		, LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_Countries') }}
UNION ALL
SELECT  CountryID AS country_id
        , CountryName AS country_name
        , FormalName AS formal_name
		, IsoAlpha3Code AS iso_alpha3_code
		, IsoNumericCode AS iso_numeric_code
		, CountryType AS country_type
		, LatestRecordedPopulation AS latest_recorded_population
		, Continent AS continent
		, Region AS region
		, Subregion AS subregion
		, LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_Countries_Archive') }}
