/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     25/05/2017 13:34:26                          */
/*==============================================================*/


/*==============================================================*/
/* Table: CommonsRef                                            */
/*==============================================================*/
BEGIN TRANSACTION
GO

IF (OBJECT_ID('dbo.CommonsRef') IS NOT NULL)
BEGIN
  DROP TABLE dbo.CommonsRef
  IF @@error <> 0
    AND @@trancount > 0
    ROLLBACK TRANSACTION
END
GO

CREATE TABLE dbo.CommonsRef (
  CommonRefId INT IDENTITY
 ,CommonName VARCHAR(100) NOT NULL
 ,CommonTableName VARCHAR(50) NULL
 ,CONSTRAINT PK_COMMONSREF PRIMARY KEY (CommonRefId)
)
GO

COMMIT TRANSACTION
GO
