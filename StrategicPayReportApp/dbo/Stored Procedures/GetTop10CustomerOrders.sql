CREATE PROCEDURE GetTop10CustomerOrders
AS
BEGIN
    SELECT TOP 10
        c.FirstName + ' ' + c.LastName AS CustomerName,
        o.OrderID,
        o.OrderDate,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderAmount
    FROM
        Customer c
        INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
        INNER JOIN OrderItem oi ON o.OrderID = oi.OrderID
    GROUP BY
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate
    ORDER BY
        OrderAmount DESC
END