{{ config (
    materialized="table",
    partition_by={
      "field": "date",
      "data_type": "datetime",
      "granularity": "month"
    },
    cluster_by="date"
)}}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="CAST('2013-01-01' AS DATE)",
        end_date="DATE(EXTRACT(YEAR FROM CURRENT_DATE())+1,1,1)"
    )
    }}
),

month_lookup as (
    SELECT 1 AS month, 'January' AS month_name
    UNION ALL
    SELECT 2 AS month, 'February' AS month_name
    UNION ALL
    SELECT 3 AS month, 'March' AS month_name
    UNION ALL
    SELECT 4 AS month, 'April' AS month_name
    UNION ALL
    SELECT 5 AS month, 'May' AS month_name
    UNION ALL
    SELECT 6 AS month, 'June' AS month_name
    UNION ALL
    SELECT 7 AS month, 'July' AS month_name
    UNION ALL
    SELECT 8 AS month, 'August' AS month_name
    UNION ALL
    SELECT 9 AS month, 'September' AS month_name
    UNION ALL
    SELECT 10 AS month, 'October' AS month_name
    UNION ALL
    SELECT 11 AS month, 'November' AS month_name
    UNION ALL
    SELECT 12 AS month, 'December' AS month_name
)

SELECT  date_spine.date_day AS `date`
        , EXTRACT(DAY FROM date_spine.date_day) AS day
        , month_lookup.month_name AS month
        , LEFT(month_lookup.month_name, 3) AS short_month
        , EXTRACT(MONTH FROM date_spine.date_day) AS calendar_month_number
        , CONCAT('CY', CAST(EXTRACT(YEAR FROM date_spine.date_day) AS STRING), '-', LEFT(month_lookup.month_name, 3)) AS calendar_month_label
        , EXTRACT(YEAR FROM date_spine.date_day) AS calendar_year
        , CONCAT('CY', CAST(EXTRACT(YEAR FROM date_spine.date_day) AS STRING)) AS calendar_year_label
        , CASE 
            WHEN EXTRACT(MONTH FROM date_spine.date_day) IN (11, 12)
            THEN EXTRACT(MONTH FROM date_spine.date_day) - 10
            ELSE EXTRACT(MONTH FROM date_spine.date_day) + 2
          END AS fiscal_month_number
        , CONCAT('FY', CAST(CASE 
            WHEN EXTRACT(MONTH FROM date_spine.date_day) IN (11, 12)
            THEN EXTRACT(YEAR FROM date_spine.date_day) + 1
            ELSE EXTRACT(YEAR FROM date_spine.date_day)
          END AS STRING), '-', LEFT(month_lookup.month_name, 3)) AS fiscal_month_label
        , CASE 
            WHEN EXTRACT(MONTH FROM date_spine.date_day) IN (11, 12)
            THEN EXTRACT(YEAR FROM date_spine.date_day) + 1
            ELSE EXTRACT(YEAR FROM date_spine.date_day)
          END AS fiscal_year
        , CONCAT('CY', CAST(CASE 
            WHEN EXTRACT(MONTH FROM date_spine.date_day) IN (11, 12)
            THEN EXTRACT(YEAR FROM date_spine.date_day) + 1
            ELSE EXTRACT(YEAR FROM date_spine.date_day)
          END AS STRING)) AS fiscal_year_label
        , EXTRACT(ISOWEEK FROM date_spine.date_day) AS iso_week_number

FROM    date_spine
JOIN    month_lookup
        ON EXTRACT(MONTH FROM date_spine.date_day) = month_lookup.month
