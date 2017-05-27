/* Заполнение таблиц */
DELETE FROM dbo.CounterKindsRef
GO
INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (1, 'Счетчик расхода тепловой энергии на отопление');
INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (2, 'Счетчик расхода тепловой энергии на отопление и ГВС');
INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (3, 'Счетчик расхода холодной воды');

DELETE FROM dbo.AttrsRef
GO
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('ENERGY_RATE', 'Норма расхода электроэнергии', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('HEAT_LOSS_PERCENT', 'Процент тепловых потерь', 'N');
GO

DELETE FROM dbo.GroupCounters
GO
SET IDENTITY_INSERT GroupCounters OFF
INSERT INTO dbo.GroupCounters (GroupCounterId, GroupCounterName, CounterKindRefId)
  SELECT
    p.kod
   ,p.nazp
   ,1
  FROM dbo.pribor p
  WHERE p.kod IN (SELECT
      k.kodpr
    FROM dbo.koteln k);
SET IDENTITY_INSERT GroupCounters ON
GO

DELETE FROM ProductSites
GO
SET IDENTITY_INSERT ProductSites OFF
INSERT INTO dbo.ProductSites (ProductSiteId, ProductSiteName, LocationTypeId, Chief)
  SELECT
    k.kodkot
   ,k.nazk
   ,k.mesto
   ,k.master
  FROM dbo.koteln k;
SET IDENTITY_INSERT ProductSites ON
GO

