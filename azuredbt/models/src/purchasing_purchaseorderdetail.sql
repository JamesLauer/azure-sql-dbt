WITH cte AS (
    SELECT * FROM raw_purchasing.purchaseorderdetail
)
SELECT CAST(PurchaseOrderID AS int) AS PurchaseOrderID
      , CAST(PurchaseOrderDetailID AS int) AS PurchaseOrderDetailID
      , CAST(DueDate AS datetime) AS DueDate
      , CAST(OrderQty AS smallint) AS OrderQty
      , CAST(ProductID AS int) AS ProductID
      , CAST(UnitPrice AS money) AS UnitPrice
      , CAST(LineTotal AS money) AS LineTotal
      , CAST(ReceivedQty AS decimal) AS ReceivedQty
      , CAST(RejectedQty AS decimal) AS RejectedQty
      , CAST(StockedQty AS decimal) AS StockedQty
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
