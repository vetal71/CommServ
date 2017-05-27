/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     27/05/2017 16:27:35                          */
/*==============================================================*/

BEGIN TRANSACTION
GO

/*==============================================================*/
/* Foreign Keys                                                 */
/*==============================================================*/
IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.Counters')
    AND o.name = 'FK_COUNTERS_FK_COUNTE_CONSUMER')
  ALTER TABLE dbo.Counters
  DROP CONSTRAINT FK_COUNTERS_FK_COUNTE_CONSUMER
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_COUNTERS_FK_COUNTE_CONSUMER'

IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.Counters')
    AND o.name = 'FK_COUNTERS_FK_COUNTE_COUNTERK')
  ALTER TABLE dbo.Counters
  DROP CONSTRAINT FK_COUNTERS_FK_COUNTE_COUNTERK
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_COUNTERS_FK_COUNTE_COUNTERK'

IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.GroupCounters')
    AND o.name = 'FK_GROUPCOU_FK_GC_COU_COUNTERK')
  ALTER TABLE dbo.GroupCounters
  DROP CONSTRAINT FK_GROUPCOU_FK_GC_COU_COUNTERK
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_GROUPCOU_FK_GC_COU_COUNTERK'

IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.PSAttrsVal')
    AND o.name = 'FK_PSATTRSV_FK_ATTRSR_ATTRSREF')
  ALTER TABLE dbo.PSAttrsVal
  DROP CONSTRAINT FK_PSATTRSV_FK_ATTRSR_ATTRSREF
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_PSATTRSV_FK_ATTRSR_ATTRSREF'

IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.PSAttrsVal')
    AND o.name = 'FK_PSATTRSV_FK_PRODUC_PRODUCTS')
  ALTER TABLE dbo.PSAttrsVal
  DROP CONSTRAINT FK_PSATTRSV_FK_PRODUC_PRODUCTS
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_PSATTRSV_FK_PRODUC_PRODUCTS'

IF EXISTS (SELECT
      1
    FROM sysindexes
    WHERE id = OBJECT_ID('dbo.PSAttrsVal')
    AND name = 'UNQ_AttrID_Date'
    AND indid > 0
    AND indid < 255)
  DROP INDEX dbo.PSAttrsVal.UNQ_AttrID_Date
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop Index UNQ_AttrID_Date'

IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.ProductSites')
    AND o.name = 'FK_PRODUCTS_FK_PS_GRC_GROUPCOU')
  ALTER TABLE dbo.ProductSites
  DROP CONSTRAINT FK_PRODUCTS_FK_PS_GRC_GROUPCOU
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_PRODUCTS_FK_PS_GRC_GROUPCOU'

IF EXISTS (SELECT
      1
    FROM sys.sysreferences r
    JOIN sys.sysobjects o
      ON (o.id = r.constid
      AND o.type = 'F')
    WHERE r.fkeyid = OBJECT_ID('dbo.Counters')
    AND o.name = 'FK_COUNTERS_FK_COUNTE_PRODUCTS')
  ALTER TABLE dbo.Counters
  DROP CONSTRAINT FK_COUNTERS_FK_COUNTE_PRODUCTS
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
IF @@error = 0
  PRINT 'Drop FK_COUNTERS_FK_COUNTE_PRODUCTS'

/*==============================================================*/
/* Tables                                                       */
/*==============================================================*/

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.AttrsRef')
    AND type = 'U')
  DROP TABLE dbo.AttrsRef
GO

/*==============================================================*/
/* Table: AttrsRef                                              */
/*==============================================================*/
CREATE TABLE dbo.AttrsRef (
  AttrRefId VARCHAR(20) NOT NULL
 ,AttrFullName VARCHAR(150) NOT NULL
 ,AttrType CHAR(1) NOT NULL
 ,CONSTRAINT PK_ATTRSREF PRIMARY KEY (AttrRefId)
)
GO

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.CounterKindsRef')
    AND type = 'U')
  DROP TABLE dbo.CounterKindsRef
GO

/*==============================================================*/
/* Table: CounterKindsRef                                       */
/*==============================================================*/
CREATE TABLE dbo.CounterKindsRef (
  CounterKindRefId SMALLINT NOT NULL
 ,CounterKindName VARCHAR(100) NULL
 ,CONSTRAINT PK_COUNTERKINDSREF PRIMARY KEY (CounterKindRefId)
)
GO

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.Counters')
    AND type = 'U')
  DROP TABLE dbo.Counters
GO

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.ProductSites')
    AND type = 'U')
  DROP TABLE dbo.ProductSites
GO

/*==============================================================*/
/* Table: ProductSites                                          */
/*==============================================================*/
CREATE TABLE dbo.ProductSites (
  ProductSiteId INT IDENTITY (1, 1) NOT FOR REPLICATION
 ,ProductSiteName VARCHAR(50) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,LocationTypeId SMALLINT NOT NULL
 ,Chief VARCHAR(50) COLLATE Cyrillic_General_CI_AS NULL
 ,GroupCounterId INT NULL
 ,CONSTRAINT PK_PRODUCTSITES PRIMARY KEY (ProductSiteId)
)
GO

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.Counters')
    AND type = 'U')
  DROP TABLE dbo.Counters
GO

/*==============================================================*/
/* Table: Counters                                              */
/*==============================================================*/
CREATE TABLE dbo.Counters (
  CounterId INT IDENTITY (1, 1) NOT FOR REPLICATION
 ,CounterName VARCHAR(50) COLLATE Cyrillic_General_CI_AS NOT NULL
 ,ConsumerId INT NULL
 ,ProductSiteId INT NULL
 ,CounterKindRefId SMALLINT NULL
 ,CONSTRAINT PK_COUNTERS PRIMARY KEY (CounterId)
)
GO

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.GroupCounters')
    AND type = 'U')
  DROP TABLE dbo.GroupCounters
GO

/*==============================================================*/
/* Table: GroupCounters                                         */
/*==============================================================*/
CREATE TABLE dbo.GroupCounters (
  GroupCounterId INT IDENTITY (1, 1) NOT FOR REPLICATION
 ,GroupCounterName VARCHAR(50) NOT NULL
 ,CounterKindRefId SMALLINT NULL
 ,CONSTRAINT PK_GROUPCOUNTERS PRIMARY KEY (GroupCounterId)
)
GO

IF EXISTS (SELECT
      1
    FROM sysobjects
    WHERE id = OBJECT_ID('dbo.PSAttrsVal')
    AND type = 'U')
  DROP TABLE dbo.PSAttrsVal
GO

/*==============================================================*/
/* Table: PSAttrsVal                                            */
/*==============================================================*/
CREATE TABLE dbo.PSAttrsVal (
  ProductSiteAttrID INT NOT NULL
 ,ProductSiteId INT NULL
 ,AttrRefId VARCHAR(20) NOT NULL
 ,ValueDate DATETIME NOT NULL
 ,SValue VARCHAR(100) NULL
 ,NValue NUMERIC
 ,DValue DATETIME NULL
 ,CONSTRAINT PK_PSATTRSVAL PRIMARY KEY (ProductSiteAttrID)
)
GO

/*==============================================================*/
/* Index: UNQ_AttrID_Date                                       */
/*==============================================================*/
CREATE UNIQUE INDEX UNQ_AttrID_Date ON dbo.PSAttrsVal (
AttrRefId ASC,
ValueDate ASC
)
GO

ALTER TABLE dbo.GroupCounters
ADD CONSTRAINT FK_GROUPCOU_FK_GC_COU_COUNTERK FOREIGN KEY (CounterKindRefId)
REFERENCES dbo.CounterKindsRef (CounterKindRefId)
GO

ALTER TABLE dbo.PSAttrsVal
ADD CONSTRAINT FK_PSATTRSV_FK_ATTRSR_ATTRSREF FOREIGN KEY (AttrRefId)
REFERENCES dbo.AttrsRef (AttrRefId)
GO

ALTER TABLE dbo.PSAttrsVal
ADD CONSTRAINT FK_PSATTRSV_FK_PRODUC_PRODUCTS FOREIGN KEY (ProductSiteId)
REFERENCES dbo.ProductSites (ProductSiteId)
GO

ALTER TABLE dbo.ProductSites
ADD CONSTRAINT FK_PRODUCTS_FK_PS_GRC_GROUPCOU FOREIGN KEY (GroupCounterId)
REFERENCES dbo.GroupCounters (GroupCounterId)
GO

ALTER TABLE dbo.Counters
ADD CONSTRAINT FK_COUNTERS_FK_COUNTE_PRODUCTS FOREIGN KEY (ProductSiteId)
REFERENCES dbo.ProductSites (ProductSiteId)
GO


ALTER TABLE dbo.Counters
ADD CONSTRAINT FK_COUNTERS_FK_COUNTE_CONSUMER FOREIGN KEY (ConsumerId)
REFERENCES dbo.Consumers (ConsumerId)
GO

ALTER TABLE dbo.Counters
ADD CONSTRAINT FK_COUNTERS_FK_COUNTE_COUNTERK FOREIGN KEY (CounterKindRefId)
REFERENCES dbo.CounterKindsRef (CounterKindRefId)
GO

COMMIT TRANSACTION
GO
