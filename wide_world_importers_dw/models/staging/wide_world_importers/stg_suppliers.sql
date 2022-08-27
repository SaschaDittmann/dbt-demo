{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  SupplierID AS supplier_id
        , SupplierName AS supplier_name
        , SupplierCategoryID AS supplier_category_id
        , PrimaryContactPersonID AS primary_contact_person_id
	, AlternateContactPersonID AS alternate_contact_person_id
        , DeliveryMethodID AS delivery_method_id
        , DeliveryCityID AS delivery_city_id
        , PostalCityID AS postal_city_id
        , SupplierReference AS supplier_reference
        , BankAccountName AS bank_account_name
        , BankAccountBranch AS bank_account_branch
        , BankAccountCode AS bank_account_code
        , BankAccountNumber AS bank_account_number
        , BankInternationalCode AS bank_international_code
        , PaymentDays AS payment_days
        , InternalComments AS internal_comments
        , PhoneNumber AS phone_number
        , FaxNumber AS fax_number
        , WebsiteURL AS website_url
        , DeliveryAddressLine1 AS delivery_address_line_1
        , DeliveryAddressLine2 AS delivery_address_line_2
        , DeliveryPostalCode AS delivery_postal_code
        -- , DeliveryLocation AS delivery_location
	, PostalAddressLine1 AS postal_address_line_1
        , PostalAddressLine2 AS postal_address_line_2
        , PostalPostalCode AS postal_postal_code
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Purchasing_Suppliers') }}
UNION ALL
SELECT  SupplierID AS supplier_id
        , SupplierName AS supplier_name
        , SupplierCategoryID AS supplier_category_id
        , PrimaryContactPersonID AS primary_contact_person_id
	, AlternateContactPersonID AS alternate_contact_person_id
        , DeliveryMethodID AS delivery_method_id
        , DeliveryCityID AS delivery_city_id
        , PostalCityID AS postal_city_id
        , SupplierReference AS supplier_reference
        , BankAccountName AS bank_account_name
        , BankAccountBranch AS bank_account_branch
        , BankAccountCode AS bank_account_code
        , BankAccountNumber AS bank_account_number
        , BankInternationalCode AS bank_international_code
        , PaymentDays AS payment_days
        , InternalComments AS internal_comments
        , PhoneNumber AS phone_number
        , FaxNumber AS fax_number
        , WebsiteURL AS website_url
        , DeliveryAddressLine1 AS delivery_address_line_1
        , DeliveryAddressLine2 AS delivery_address_line_2
        , DeliveryPostalCode AS delivery_postal_code
        -- , DeliveryLocation AS delivery_location
	, PostalAddressLine1 AS postal_address_line_1
        , PostalAddressLine2 AS postal_address_line_2
        , PostalPostalCode AS postal_postal_code
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Purchasing_Suppliers_Archive') }}
