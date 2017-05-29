/* Заполнение таблиц */
DELETE FROM dbo.PSAttrsVal
GO
DELETE FROM ProductSites
GO
DELETE FROM dbo.Counters
GO
DELETE FROM dbo.AttrsRef
GO
DELETE FROM dbo.LocationTypesRef
GO
DELETE FROM dbo.CounterKindsRef
GO

INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (1, 'Счетчик расхода тепловой энергии на отопление');
INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (2, 'Счетчик расхода тепловой энергии на отопление и ГВС');
INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (3, 'Счетчик расхода холодной воды');
GO

INSERT INTO dbo.LocationTypesRef (LocationTypeRefId, LocationTypeName)
  VALUES (1, 'Город');
INSERT INTO dbo.LocationTypesRef (LocationTypeRefId, LocationTypeName)
  VALUES (2, 'Село');
GO

INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('ENERGY_RATE', 'Норма расхода электроэнергии', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('HEAT_LOSS_PERCENT', 'Процент тепловых потерь', 'N');
GO

SET IDENTITY_INSERT ProductSites ON
INSERT INTO dbo.ProductSites (ProductSiteId, ProductSiteName, LocationTypeId, Chief)
  SELECT
    k.kodkot
   ,k.nazk
   ,k.mesto
   ,k.master
  FROM dbo.koteln k;
SET IDENTITY_INSERT ProductSites OFF
GO

DECLARE @VDate DATE
SELECT @VDate=p.start_period FROM dbo.paramorg p;
INSERT INTO dbo.PSAttrsVal (ProductSiteId, AttrRefId, ValueDate, SValue, NValue, DValue)
  SELECT
    k.kodkot
   ,'ENERGY_RATE'
   ,@VDate
   ,NULL
   ,k.nel
   ,NULL
  FROM dbo.koteln k;
INSERT INTO dbo.PSAttrsVal (ProductSiteId, AttrRefId, ValueDate, SValue, NValue, DValue)
  SELECT
    k.kodkot
   ,'HEAT_LOSS_PERCENT'
   ,@VDate
   ,NULL
   ,k.ps
   ,NULL
  FROM dbo.koteln k;
GO

SET IDENTITY_INSERT dbo.Counters ON
GO
INSERT INTO dbo.Counters (CounterId, CounterName, ConsumerId, CounterKindRefId)
  SELECT
    p.kod
   ,p.nazp
   ,p.kodorg
   ,dbo.IIF(p.tgv, 0, 1, 2)
  FROM dbo.pribor p;
GO
SET IDENTITY_INSERT dbo.Counters OFF
GO
PRINT 'ГОТОВО!!!'
