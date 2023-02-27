# StrategicPayReportAppSolution
 A databse project to create report for user requirements.This is a sample implementation of creating SQL tables and stored procedures for generating a report of the top 10 customer orders based on order amount and all overdue orders.

## Prerequisites

Microsoft SQL Server.

## Creating SQL Tables
The Orders table represents an order made by a customer. It includes the order ID, the customer who made the order, the date the order was made, the date the order was shipped, the required date for the order, the shipping cost, and the shipping details (name, address, city, state, and zip code).
The Customer table includes details about the customers, such as their name, email, phone, address, and location.
The two tables are related by the CustomerID column in the Order table, which references the primary key of the Customer table.

The Product and OrderItem tables are additional tables that can be used to provide more information and detail about the orders in the Order table.

The OrderItem table represents the individual items that are part of an order. It includes the order ID (foreign key referencing the Order table), the product ID (foreign key referencing the Product table), the quantity of the product ordered, and the unit price of the product. By using this table, we can calculate the total cost of each order by multiplying the quantity and unit price for each item.

The Product table includes details about the products that are sold, such as the product name and the unit price. The ProductID column is used as a foreign key in the OrderItem table to associate each order item with the corresponding product.

By using these additional tables, we can generate more detailed reports about the orders and the products that are sold. For example, we can generate a report that shows the top 10 products that are ordered, or the top 10 customers who have ordered a specific product.
- Open SQL Server Management Studio.
- Connect to your SQL Server database.
- Create the Customer table by running the following script:

```bash
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(20)
);
```
- Create the Orders table by running the following script:

```bash
CREATE TABLE Order (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    ShippedDate DATETIME,
    RequiredDate DATETIME,
    Freight DECIMAL(10,2),
    ShipName VARCHAR(50),
    ShipAddress VARCHAR(100),
    ShipCity VARCHAR(50),
    ShipState VARCHAR(50),
    ShipZipCode VARCHAR(20),
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
```
- Create the Product table by running the following script:

```bash
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);
```
- Create the OrderItem table by running the following script:

```bash
CREATE TABLE OrderItem (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    CONSTRAINT PK_OrderItem PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderID) REFERENCES Order(OrderID),
    CONSTRAINT FK_OrderItem_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
```
Note that these scripts assume that the tables will be created in a Microsoft SQL Server database. If you are using a different database system, the syntax for creating tables may be slightly different.

## Creating the Stored Procedure
- Create a new stored procedure that generates the top 10 customer orders based on order amount by running the following script:
```bash
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
        INNER JOIN [Order] o ON c.CustomerID = o.CustomerID
        INNER JOIN OrderItem oi ON o.OrderID = oi.OrderID
    GROUP BY
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate
    ORDER BY
        OrderAmount DESC
END
```
This stored procedure joins the Customer, Order, and OrderItem tables together to calculate the total order amount for each customer. It then selects the top 10 customers based on the order amount and returns their names, order IDs, order dates, and order amounts.

- Create a new stored procedure for all overdue orders by running the following script:
```bash
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
        [Order] o
        INNER JOIN Customer c ON o.CustomerID = c.CustomerID
    WHERE
        o.RequiredDate < GETDATE()
        AND o.ShippedDate IS NULL
    ORDER BY
        o.RequiredDate DESC
END
```
This stored procedure selects all orders that are overdue (i.e., their required date has passed but they have not yet been shipped). It joins the Order and Customer tables together to get the customer name, and calculates the number of days that the order is overdue using the DATEDIFF function. It then orders the results by the required date in descending order.
The stored procedure is now created in your SQL Server database.

## Executing the Stored Procedures
The insert scripts has been provided to add the sample data for each table.
```python
exec GetTop10CustomerOrders
exec GetOverdueOrders
```

## Report Generation
The best way to generate this report depends on your specific needs and requirements. Here are a few options:

- Use a reporting tool: If you need to generate reports frequently or on a regular basis, it may be worth investing in a reporting tool that can connect to your database and generate reports automatically. Popular reporting tools include Crystal Reports, Microsoft Power BI, and Tableau.

- Use a stored procedure: If you need to generate the report programmatically, you can create a stored procedure in your SQL Server database that generates the report data and returns it to your application. Your application can then read the data and generate the report using a library such as iTextSharp or Microsoft Reporting Services.

- Use an ORM: If you are using an Object-Relational Mapping (ORM) framework such as Entity Framework or NHibernate, you can use LINQ or HQL to query the database and generate the report data. Your application can then use a library such as iTextSharp or Microsoft Reporting Services to generate the report.

- Use a simple query: If you only need to generate the report once or a few times, you can use a simple SQL query to generate the report data and export it to a CSV or Excel file. You can then open the file in a spreadsheet program and format it as needed.

Ultimately, the best approach depends on your specific needs and requirements, as well as your available resources and budget.

## Acknowledgements
- This project is inspired by a mixture of resources from Dot Net Tricks & Essential SQL.
- Many thanks to [DotNetTricks](https://www.dotnettricks.com/) [EssnetialSQL](https://www.essentialsql.com/)

## Contact
Created by @kuldeepSingh - feel free to contact me!
