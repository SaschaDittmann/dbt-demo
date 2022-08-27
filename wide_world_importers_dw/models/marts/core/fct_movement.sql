{{ config (
    materialized="table",
    partition_by={
      "field": "date_key",
      "data_type": "date",
      "granularity": "day"
    },
    cluster_by="wwi_stock_item_transaction_id"
)}}

SELECT CAST(sit.transaction_occurred_when AS date) AS date_key,
           sit.stock_item_transaction_id AS wwi_stock_item_transaction_id,
           sit.invoice_id AS wwi_invoice_id,
           sit.purchase_order_id AS wwi_purchase_order_id,
           CAST(sit.quantity AS integer) AS quantity,
           sit.stock_item_id AS wwi_stock_item_id,
           sit.customer_id AS wwi_customer_id,
           sit.supplier_id AS wwi_supplier_id,
           sit.transaction_type_id AS wwi_transaction_type_id,
           sit.transaction_occurred_when AS transaction_occurred_when
FROM    {{ ref('stg_stock_item_transactions') }} AS sit
