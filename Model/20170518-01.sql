/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     18/05/2017 15:10:40                          */
/*==============================================================*/

BEGIN TRANSACTION
GO

/*==============================================================*/
/* Drop ForeignKeys                                             */
/*==============================================================*/

IF (OBJECT_ID('dbo.Consumers') IS NOT NULL)
BEGIN
  ALTER TABLE dbo.Consumers
  DROP CONSTRAINT FK_CONSUMER_FK_CONSUM_BANKS
  ALTER TABLE dbo.Consumers
  DROP CONSTRAINT FK_CONSUMER_FK_CONSUM_BUDGETKI
  ALTER TABLE dbo.Consumers
  DROP CONSTRAINT FK_CONSUMER_FK_CONSUM_CONSUMER
  ALTER TABLE dbo.Consumers
  DROP CONSTRAINT FK_CONSUMER_FK_MINIST_MINISTRY
END
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Drop Indexes                                                 */
/*==============================================================*/
DROP INDEX ConsumerKind_Idx ON dbo.Consumers
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
DROP INDEX ConsumerName_Idx ON dbo.Consumers
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: Banks                                                 */
/*==============================================================*/
IF (OBJECT_ID('dbo.Banks') IS NOT NULL)
  DROP TABLE dbo.Banks
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE dbo.Banks (
  BankId INT NOT NULL
 ,BankName VARCHAR(100) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,BankAddress VARCHAR(100) COLLATE Cyrillic_General_CI_AS NULL
 ,CONSTRAINT PK_BANKS PRIMARY KEY (BankId)
) ON "PRIMARY"
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: BudgetKindRef                                         */
/*==============================================================*/
IF (OBJECT_ID('dbo.BudgetKindRef') IS NOT NULL)
  DROP TABLE dbo.BudgetKindRef
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE dbo.BudgetKindRef (
  BudgetKindRefId SMALLINT NOT NULL
 ,BudgetKindName VARCHAR(50) NOT NULL
 ,CONSTRAINT PK_BUDGETKINDREF PRIMARY KEY (BudgetKindRefId)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: Consumers                                             */
/*==============================================================*/
IF (OBJECT_ID('dbo.Consumers') IS NOT NULL)
  DROP TABLE dbo.Consumers
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE dbo.Consumers (
  ConsumerId INT IDENTITY (1, 1) NOT FOR REPLICATION
 ,ConsumerName VARCHAR(100) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,ConsumerAddress VARCHAR(100) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,Account VARCHAR(30) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,UNN VARCHAR(10) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,ConsumerKindId SMALLINT NOT NULL
 ,MinistryId SMALLINT NULL
 ,BudgetKindId SMALLINT NULL
 ,BankId INT NULL
 ,IsDeleted SMALLINT NULL
 ,CONSTRAINT PK_CONSUMERS PRIMARY KEY (ConsumerId)
) ON "PRIMARY"
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Index: ConsumerKind_Idx                                      */
/*==============================================================*/
CREATE INDEX ConsumerKind_Idx ON dbo.Consumers (
ConsumerKindId ASC
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Index: ConsumerName_Idx                                      */
/*==============================================================*/
CREATE INDEX ConsumerName_Idx ON dbo.Consumers (
ConsumerName ASC
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: ConsumersKindRef                                      */
/*==============================================================*/
IF (OBJECT_ID('dbo.ConsumersKindRef') IS NOT NULL)
  DROP TABLE dbo.ConsumersKindRef
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE dbo.ConsumersKindRef (
  ConsumerKindRefId SMALLINT NOT NULL
 ,ConsumerKindName VARCHAR(50) NOT NULL
 ,CONSTRAINT PK_CONSUMERSKINDREF PRIMARY KEY (ConsumerKindRefId)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: MinistryRef                                           */
/*==============================================================*/
IF (OBJECT_ID('dbo.MinistryRef') IS NOT NULL)
  DROP TABLE dbo.MinistryRef
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE dbo.MinistryRef (
  MinistryRefId SMALLINT NOT NULL
 ,MinistryName VARCHAR(100) NOT NULL
 ,CONSTRAINT PK_MINISTRYREF PRIMARY KEY (MinistryRefId)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE dbo.Consumers
ADD CONSTRAINT FK_CONSUMER_FK_CONSUM_BANKS FOREIGN KEY (BankId)
REFERENCES dbo.Banks (BankId)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE dbo.Consumers
ADD CONSTRAINT FK_CONSUMER_FK_CONSUM_BUDGETKI FOREIGN KEY (BudgetKindId)
REFERENCES dbo.BudgetKindRef (BudgetKindRefId)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE dbo.Consumers
ADD CONSTRAINT FK_CONSUMER_FK_CONSUM_CONSUMER FOREIGN KEY (ConsumerKindId)
REFERENCES dbo.ConsumersKindRef (ConsumerKindRefId)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE dbo.Consumers
ADD CONSTRAINT FK_CONSUMER_FK_MINIST_MINISTRY FOREIGN KEY (MinistryId)
REFERENCES dbo.MinistryRef (MinistryRefId)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

COMMIT TRANSACTION
GO

