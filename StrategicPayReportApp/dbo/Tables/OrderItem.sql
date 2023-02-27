CREATE TABLE [dbo].[OrderItem] (
    [OrderID]   INT             NOT NULL,
    [ProductID] INT             NOT NULL,
    [Quantity]  INT             NULL,
    [UnitPrice] DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_OrderItem_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID])
);

