{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  ColorID AS color_id
        , ColorName AS color_name
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Warehouse_Colors') }}
UNION ALL
SELECT  ColorID AS color_id
        , ColorName AS color_name
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Warehouse_Colors_Archive') }}
