SELECT  StockItemTransactionID AS stock_item_transaction_id
        , StockItemID AS stock_item_id
        , TransactionTypeID AS transaction_type_id
        , CustomerID AS customer_id
        , InvoiceID AS invoice_id
	, SupplierID AS supplier_id
        , PurchaseOrderID AS purchase_order_id
	, PARSE_DATETIME('%FT%H:%M:%E*SZ', TransactionOccurredWhen) AS transaction_occurred_when
        , Quantity AS quantity
	, LastEditedBy AS last_edited_by
        , PARSE_DATETIME('%FT%H:%M:%E*SZ', LastEditedWhen) AS last_edited_when
FROM     {{ source('wide_world_importers', 'Warehouse_StockItemTransactions') }}
