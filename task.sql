USE ShopDB;

START TRANSACTION;

INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

SET @order_id = LAST_INSERT_ID();

INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@order_id, 1, 1);

UPDATE Products
SET WarehouseAmount = WarehouseAmount - (
    SELECT Count
    FROM OrderItems
    WHERE OrderID = @order_id AND ProductID = 1
)
WHERE ID = 1;

COMMIT;