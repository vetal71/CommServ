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
  VALUES (3, 'Счетчик расхода тепловой энергии на ГВС');
INSERT INTO dbo.CounterKindsRef (CounterKindRefId, CounterKindName)
  VALUES (4, 'Счетчик расхода холодной воды');
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
SELECT
  @VDate = p.start_period
FROM dbo.paramorg p;
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
   ,CounterType =
                 CASE
                   WHEN (p.tep = 0 AND
                     p.tgv = 0) THEN 2
                   WHEN (p.tep = 0 AND
                     p.tgv = 1) THEN 1
                   WHEN (p.tep = 1 AND
                     p.tgv = 0) THEN 3
                   ELSE NULL
                 END
  FROM dbo.pribor p
  WHERE p.kod > 1;
GO
SET IDENTITY_INSERT dbo.Counters OFF
GO

/* Обновление поля IsGroup (групповой учет) */
DECLARE @CounterId_ INT
       ,@CountObj INT
       ,@CountDom INT
DECLARE cur CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
SELECT
  c.CounterId
FROM dbo.Counters c

OPEN cur
FETCH NEXT FROM cur INTO @CounterId_
WHILE @@fetch_status = 0
BEGIN
  /* Количество объектов подключеных к прибору */
  SELECT
    @CountObj = COUNT(*)
  FROM dbo.obekt o
  WHERE o.kodpr = @CounterId_;

  /* Количество домов подключеных к прибору */
  SELECT
    @CountDom = COUNT(*)
  FROM dbo.doma d
  WHERE d.kodpr = @CounterId_;

  UPDATE Counters
  SET IsGroup =
               CASE
                 WHEN (@CountDom + @CountObj) > 1 THEN 1
                 ELSE 0
               END
  WHERE CounterId = @CounterId_;

  FETCH NEXT FROM cur INTO @CounterId_
END
CLOSE cur
DEALLOCATE cur
GO

UPDATE ProductSites
SET CounterId = (SELECT
    k.kodpr
  FROM dbo.koteln k
  WHERE k.kodpr > 1
  AND k.kodkot = ProductSiteId);
GO

PRINT 'ГОТОВО!!!'
