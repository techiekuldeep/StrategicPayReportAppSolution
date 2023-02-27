CREATE TABLE [dbo].[Customer] (
    [CustomerID] INT           NOT NULL,
    [FirstName]  VARCHAR (50)  NULL,
    [LastName]   VARCHAR (50)  NULL,
    [Email]      VARCHAR (100) NULL,
    [Phone]      VARCHAR (20)  NULL,
    [Address]    VARCHAR (100) NULL,
    [City]       VARCHAR (50)  NULL,
    [State]      VARCHAR (50)  NULL,
    [ZipCode]    VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);

