CREATE PROCEDURE GetOverdueOrders
AS
BEGIN
    SELECT
        o.OrderID,
        c.FirstName + ' ' + c.LastName AS CustomerName,
        o.RequiredDate AS RequiredDate,
        o.ShippedDate AS ShippedDate,
        DATEDIFF(day, o.RequiredDate, GETDATE()) AS DaysOverdue
    FROM
        [Orders] o
        INNER JOIN Customer c ON o.CustomerID = c.CustomerID
    WHERE
        o.RequiredDate < GETDATE()
        AND o.ShippedDate IS NULL
    ORDER BY
        o.RequiredDate DESC
END