{{ config (
    materialized="table",
    partition_by={
      "field": "valid_from",
      "data_type": "datetime",
      "granularity": "day"
    }
)}}

SELECT  PersonID AS person_id
        , FullName AS full_name
        , PreferredName AS preferred_name
        , CONCAT(PreferredName,' ',FullName) AS search_name
        , IsPermittedToLogon AS is_permitted_to_logon
        , LogonName AS logon_name
        , IsExternalLogonProvider AS is_external_logon_provider
        -- , HashedPassword AS hashed_password
        , IsSystemUser AS is_system_user
        , IsEmployee AS is_employee
        , IsSalesperson AS is_salesperson
        , UserPreferences AS user_preferences
        , PhoneNumber AS phone_number
        , FaxNumber AS fax_number
        , EmailAddress AS email_address
        -- , Photo AS photo
        , CustomFields AS custom_fields
        -- , OtherLanguages AS other_languages
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_People') }}
UNION ALL
SELECT  PersonID AS person_id
        , FullName AS full_name
        , PreferredName AS preferred_name
        , CONCAT(PreferredName,' ',FullName) AS search_name
        , IsPermittedToLogon AS is_permitted_to_logon
        , LogonName AS logon_name
        , IsExternalLogonProvider AS is_external_logon_provider
        -- , HashedPassword AS hashed_password
        , IsSystemUser AS is_system_user
        , IsEmployee AS is_employee
        , IsSalesperson AS is_salesperson
        , UserPreferences AS user_preferences
        , PhoneNumber AS phone_number
        , FaxNumber AS fax_number
        , EmailAddress AS email_address
        -- , Photo AS photo
        , CustomFields AS custom_fields
        -- , OtherLanguages AS other_languages
        , LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidFrom) AS valid_from
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', ValidTo) AS valid_to
FROM     {{ source('wide_world_importers', 'Application_People_Archive') }}
