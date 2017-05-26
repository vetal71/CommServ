/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     19/05/2017 16:03:44                          */
/*==============================================================*/

BEGIN TRANSACTION
GO

/*==============================================================*/
/* Drop ForeignKeys                                             */
/*==============================================================*/

IF (OBJECT_ID(N'TariffServs') IS NOT NULL)
BEGIN
  ALTER TABLE TariffServs
  DROP CONSTRAINT FK_TARIFFSE_SERVKIND_SERVICEK
  ALTER TABLE TariffServs
  DROP CONSTRAINT FK_TARIFFSE_VAT_VATSREF
END  
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

IF (OBJECT_ID(N'TariffServsVal') IS NOT NULL)
  ALTER TABLE TariffServsVal
  DROP CONSTRAINT FK_TARIFFSE_SERVID_TARIFFSE
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO


/*==============================================================*/
/* Table: ServiceKindRef                                        */
/*==============================================================*/

IF (OBJECT_ID(N'ServiceKindRef') IS NOT NULL)
  DROP TABLE ServiceKindRef
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE ServiceKindRef (
  ServiceKindRefId SMALLINT NOT NULL
 ,ServiceKindName VARCHAR(100) NOT NULL
 ,CONSTRAINT PK_SERVICEKINDREF PRIMARY KEY (ServiceKindRefId)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: TariffServs                                           */
/*==============================================================*/
IF (OBJECT_ID(N'TariffServs') IS NOT NULL)
  DROP TABLE TariffServs
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE TariffServs (
  ServId INT NOT NULL
 ,ServTitle VARCHAR(50) NOT NULL
 ,ServiceKindId SMALLINT NOT NULL
 ,VatID SMALLINT NOT NULL
 ,CONSTRAINT PK_TARIFFSERVS PRIMARY KEY (ServId)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: TariffServsVal                                        */
/*==============================================================*/
IF (OBJECT_ID(N'TariffServsVal') IS NOT NULL)
  DROP TABLE TariffServsVal
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE TariffServsVal (
  ServId INT NOT NULL
 ,DateFrom DATETIME NOT NULL
 ,Value DECIMAL(15, 4) NOT NULL
 ,CONSTRAINT PK_TARIFFSERVSVAL PRIMARY KEY (ServId, DateFrom)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

/*==============================================================*/
/* Table: VatsRef                                               */
/*==============================================================*/
IF (OBJECT_ID(N'VatsRef') IS NOT NULL)
  DROP TABLE VatsRef
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO
CREATE TABLE VatsRef (
  VatID SMALLINT NOT NULL
 ,VatName VARCHAR(50) NOT NULL
 ,VatValue DECIMAL(5, 2) NULL
 ,CONSTRAINT PK_VATSREF PRIMARY KEY (VatID)
)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE TariffServs
ADD CONSTRAINT FK_TARIFFSE_SERVKIND_SERVICEK FOREIGN KEY (ServiceKindId)
REFERENCES ServiceKindRef (ServiceKindRefId)
ON UPDATE CASCADE ON DELETE CASCADE
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE TariffServs
ADD CONSTRAINT FK_TARIFFSE_VAT_VATSREF FOREIGN KEY (VatID)
REFERENCES VatsRef (VatID)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

ALTER TABLE TariffServsVal
ADD CONSTRAINT FK_TARIFFSE_SERVID_TARIFFSE FOREIGN KEY (ServId)
REFERENCES TariffServs (ServId)
GO
IF @@error <> 0
  AND @@trancount > 0
  ROLLBACK TRANSACTION
GO

COMMIT TRANSACTION
GO
