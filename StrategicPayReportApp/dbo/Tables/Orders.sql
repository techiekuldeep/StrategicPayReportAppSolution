CREATE TABLE [dbo].[Orders] (
    [OrderID]      INT             NOT NULL,
    [CustomerID]   INT             NULL,
    [OrderDate]    DATETIME        NULL,
    [ShippedDate]  DATETIME        NULL,
    [RequiredDate] DATETIME        NULL,
    [Freight]      DECIMAL (10, 2) NULL,
    [ShipName]     VARCHAR (50)    NULL,
    [ShipAddress]  VARCHAR (100)   NULL,
    [ShipCity]     VARCHAR (50)    NULL,
    [ShipState]    VARCHAR (50)    NULL,
    [ShipZipCode]  VARCHAR (20)    NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID])
);

