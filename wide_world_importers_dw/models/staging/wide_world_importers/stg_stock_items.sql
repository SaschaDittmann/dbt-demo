{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  StockItemID AS stock_item_id
        , StockItemName AS stock_item_name
        , SupplierID AS supplier_id
        , ColorID AS color_id
        , UnitPackageID AS unit_package_id
        , OuterPackageID AS outer_package_id
        , Brand AS brand
        , Size AS size
        , LeadTimeDays AS lead_time_days
        , QuantityPerOuter AS quantity_per_outer
        , IsChillerStock AS is_chiller_stock
        , Barcode AS barcode
        , TaxRate AS tax_rate
        , UnitPrice AS unit_price
        , RecommendedRetailPrice AS recommended_retail_price
        , TypicalWeightPerUnit AS typical_weight_per_unit
        , MarketingComments AS marketing_comments
        , InternalComments AS internal_comments
        -- , Photo AS photo
        , CustomFields AS custom_fields
        -- , json_query([CustomFields],N'$.Tags') AS tags
        , concat(StockItemName, ' ', MarketingComments) AS search_details
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Warehouse_StockItems') }}
UNION ALL
SELECT  StockItemID AS stock_item_id
        , StockItemName AS stock_item_name
        , SupplierID AS supplier_id
        , ColorID AS color_id
        , UnitPackageID AS unit_package_id
        , OuterPackageID AS outer_package_id
        , Brand AS brand
        , Size AS size
        , LeadTimeDays AS lead_time_days
        , QuantityPerOuter AS quantity_per_outer
        , IsChillerStock AS is_chiller_stock
        , Barcode AS barcode
        , TaxRate AS tax_rate
        , UnitPrice AS unit_price
        , RecommendedRetailPrice AS recommended_retail_price
        , TypicalWeightPerUnit AS typical_weight_per_unit
        , MarketingComments AS marketing_comments
        , InternalComments AS internal_comments
        -- , Photo AS photo
        , CustomFields AS custom_fields
        -- , json_query([CustomFields],N'$.Tags') AS tags
        , concat(StockItemName, ' ', MarketingComments) AS search_details
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Warehouse_StockItems_Archive') }}
