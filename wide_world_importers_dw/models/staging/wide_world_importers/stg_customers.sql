{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  CustomerID AS customer_id
	, CustomerName AS customer_name
	, BillToCustomerID AS bill_to_customer_id
	, CustomerCategoryID AS customer_category_id
	, BuyingGroupID AS buying_group_id
	, PrimaryContactPersonID AS primary_contact_person_id 
	, AlternateContactPersonID AS alternate_contact_person_id
	, DeliveryMethodID AS delivery_method_id
	, DeliveryCityID AS delivery_city_id
	, PostalCityID AS postal_city_id
	, CreditLimit AS credit_limit
	, AccountOpenedDate AS account_opened_date
	, StandardDiscountPercentage AS standard_discount_percentage
	, IsStatementSent AS is_statement_sent
	, IsOnCreditHold AS is_on_credit_hold
	, PaymentDays AS payment_days
	, PhoneNumber AS phone_number
	, FaxNumber AS fax_number
	, DeliveryRun AS delivery_run
	, RunPosition AS run_position
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
FROM     {{ source('wide_world_importers', 'Sales_Customers') }}
UNION ALL
SELECT  CustomerID AS customer_id
	, CustomerName AS customer_name
	, BillToCustomerID AS bill_to_customer_id
	, CustomerCategoryID AS customer_category_id
	, BuyingGroupID AS buying_group_id
	, PrimaryContactPersonID AS primary_contact_person_id 
	, AlternateContactPersonID AS alternate_contact_person_id
	, DeliveryMethodID AS delivery_method_id
	, DeliveryCityID AS delivery_city_id
	, PostalCityID AS postal_city_id
	, CreditLimit AS credit_limit
	, AccountOpenedDate AS account_opened_date
	, StandardDiscountPercentage AS standard_discount_percentage
	, IsStatementSent AS is_statement_sent
	, IsOnCreditHold AS is_on_credit_hold
	, PaymentDays AS payment_days
	, PhoneNumber AS phone_number
	, FaxNumber AS fax_number
	, DeliveryRun AS delivery_run
	, RunPosition AS run_position
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
FROM     {{ source('wide_world_importers', 'Sales_Customers_Archive') }}
