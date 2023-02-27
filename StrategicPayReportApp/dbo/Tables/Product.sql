CREATE TABLE [dbo].[Product] (
    [ProductID]   INT             NOT NULL,
    [ProductName] VARCHAR (50)    NULL,
    [UnitPrice]   DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

