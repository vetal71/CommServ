/* Заполнение таблиц */
IF EXISTS (SELECT
      *
    FROM sys.all_objects ao
    WHERE ao.name = 'tmp_org'
    AND ao.type = 'U')
  DROP TABLE tmp_org
GO
PRINT 'Удалили tmp_org'

DELETE FROM dbo.Banks
GO
INSERT INTO Banks (BankId, BankName, BankAddress)
  SELECT
    b.kod_bank
   ,b.nazv_bank
   ,b.adres_bank
  FROM bank b;
GO
PRINT 'Добавили банки'

SELECT
  kodorg
 ,nazv
 ,adres
 ,bank
 ,rschet
 ,unn
 ,tiporg
 ,datadog
 ,ndog
 ,_min
 ,tipbud
 ,kodbank
 ,data_per INTO dbo.tmp_org
FROM dbo.org
GO
PRINT 'Создали tmp_org'

UPDATE dbo.tmp_org
SET tiporg = 4
WHERE tiporg = 3
UPDATE dbo.tmp_org
SET tiporg = 3
WHERE tiporg = 2
UPDATE dbo.tmp_org
SET tiporg = 2
WHERE tiporg = 1
UPDATE dbo.tmp_org
SET tiporg = 1
WHERE tiporg = 0

UPDATE dbo.tmp_org
SET tipbud = 4
WHERE tipbud = 3
UPDATE dbo.tmp_org
SET tipbud = 3
WHERE tipbud = 2
UPDATE dbo.tmp_org
SET tipbud = 2
WHERE tipbud = 1
UPDATE dbo.tmp_org
SET tipbud = 1
WHERE tipbud = 0

UPDATE dbo.tmp_org
SET kodbank = NULL
WHERE kodbank = 0
GO
PRINT 'Обновили tmp_org'

DELETE FROM dbo.MinistryRef
GO
SELECT DISTINCT
  IDENTITY(INT, 1, 1) AS Id
 ,'Министерство ' + o._min AS Name INTO tmp_Ministry
FROM dbo.tmp_org o
WHERE o._min IS NOT NULL
GO
INSERT INTO dbo.MinistryRef (MinistryRefId, MinistryName)
  SELECT
    *
  FROM dbo.tmp_Ministry tm
GO
DROP TABLE tmp_Ministry
GO

DELETE FROM dbo.ClientsKindRef
GO
INSERT INTO dbo.ClientsKindRef (ClientKindRefId, ClientKindName)
  VALUES (1, N'Бюджетные организации');
INSERT INTO dbo.ClientsKindRef (ClientKindRefId, ClientKindName)
  VALUES (2, N'Хозрасчетные организации');
INSERT INTO dbo.ClientsKindRef (ClientKindRefId, ClientKindName)
  VALUES (3, N'ЖСК');
INSERT INTO dbo.ClientsKindRef (ClientKindRefId, ClientKindName)
  VALUES (4, N'ЖСК (БГСХА)');
GO

DELETE FROM dbo.BudgetKindRef
GO
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (1, N'Местный бюджет');
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (2, N'Областной бюджет');
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (3, N'Республиканский бюджет');
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (4, N'Прочее финансирование');
GO
PRINT 'Заполнили вспомагательные таблицы'

DELETE FROM dbo.Clients
GO
SET IDENTITY_INSERT dbo.Clients ON
GO
INSERT INTO dbo.Clients (ClientName, ClientAddress, Account, unn, ClientKindRefId, MinistryRefId, BudgetKindRefId, BankId, IsDeleted)
  SELECT
    kodorg
   ,nazv
   ,adres
   ,rschet
   ,unn
   ,tiporg
   ,(SELECT
        mr.MinistryRefId
      FROM dbo.MinistryRef mr
      WHERE mr.MinistryName = 'Министерство ' + _min)
   ,tipbud
   ,kodbank
   ,0
  FROM dbo.tmp_org
GO
SET IDENTITY_INSERT dbo.Clients OFF
GO
PRINT 'Добавили клиентов.'
GO

DELETE FROM dbo.TariffServsVal
GO
DELETE FROM dbo.TariffServs
GO
DELETE FROM dbo.ServiceKindRef
GO
INSERT INTO dbo.ServiceKindRef (ServiceKindRefId, ServiceKindName)
  VALUES (1, N'Отпуск тепловой энергии')
INSERT INTO dbo.ServiceKindRef (ServiceKindRefId, ServiceKindName)
  VALUES (2, N'Отпуск холодной воды')
INSERT INTO dbo.ServiceKindRef (ServiceKindRefId, ServiceKindName)
  VALUES (3, N'Пропуск сточных вод')
INSERT INTO dbo.ServiceKindRef (ServiceKindRefId, ServiceKindName)
  VALUES (4, N'Вывоз мусора')
GO

DELETE FROM dbo.VatsRef
GO
INSERT INTO dbo.VatsRef (VatID, VatName, VatValue)
  VALUES (1, N'Без НДС', 0.00)
INSERT INTO dbo.VatsRef (VatID, VatName, VatValue)
  VALUES (2, N'НДС 20%', 20.00)
INSERT INTO dbo.VatsRef (VatID, VatName, VatValue)
  VALUES (3, N'НДС 20% в цене', 16.67)
GO
PRINT 'Заполнили вспомагательные таблицы'

DELETE FROM dbo.TariffServs
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT
    kodtt
   ,nazt
   ,1
   ,2
  FROM dbo.tarift
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT
    kodtv + 100
   ,nazt
   ,2
   ,2
  FROM dbo.tarifv
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT
    kodtv + 200
   ,nazt
   ,3
   ,2
  FROM dbo.tarifv
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT
    kodtg + 300
   ,nazt
   ,4
   ,2
  FROM dbo.tarifg
GO
PRINT 'Заполнили виды тарифов'

DELETE FROM dbo.TariffServsVal
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT
    ts.ServId
   ,dd.DATAN
   ,dd.CENA
  FROM dbo.TariffServs ts
      ,(SELECT DISTINCT
           dt.kodtt
          ,dt.CENA
          ,(SELECT
               MAX(d.DATAN)
             FROM dbo.datatarif d
             WHERE dt.kodtt = d.kodtt
             AND dt.CENA = d.CENA)
           AS DATAN
         FROM dbo.datatarif dt) dd
  WHERE dd.kodtt = ts.ServId
  AND dd.DATAN > '30-09-2005'
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT
    ts.ServId
   ,dd.DATAN
   ,dd.CENAV
  FROM dbo.TariffServs ts
      ,(SELECT DISTINCT
           dt.kodtv
          ,dt.CENAV
          ,(SELECT
               MAX(d.DATAN)
             FROM dbo.datatarifv d
             WHERE dt.kodtv = d.kodtv
             AND dt.CENAV = d.CENAV)
           AS DATAN
         FROM dbo.datatarifv dt) dd
  WHERE dd.kodtv + 100 = ts.ServId
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT
    ts.ServId
   ,dd.DATAN
   ,dd.CENAK
  FROM dbo.TariffServs ts
      ,(SELECT DISTINCT
           dt.kodtv
          ,dt.CENAK
          ,(SELECT
               MAX(d.DATAN)
             FROM dbo.datatarifv d
             WHERE dt.kodtv = d.kodtv
             AND dt.CENAK = d.CENAK)
           AS DATAN
         FROM dbo.datatarifv dt) dd
  WHERE dd.kodtv + 200 = ts.ServId
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT
    ts.ServId
   ,dd.DATAN
   ,dd.CENAG
  FROM dbo.TariffServs ts
      ,(SELECT DISTINCT
           dt.kodtg
          ,dt.CENAG
          ,(SELECT
               MAX(d.DATAN)
             FROM dbo.datatarifg d
             WHERE dt.kodtg = d.kodtg
             AND dt.CENAG = d.CENAG)
           AS DATAN
         FROM dbo.datatarifg dt) dd
  WHERE dd.kodtg + 300 = ts.ServId
GO
PRINT 'Заполнили значения тарифов'

DELETE FROM dbo.CommonsRef
GO
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Виды организаций', N'ClientsKindRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Типы финансирования', N'BudgetKindRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Министерства', N'MinistryRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Виды расчетов НДС', N'VatsRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Улицы', N'StreetRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Типы местоположения', N'LocationTypesRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Населенные пункты', N'LocalitiesRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Виды топлива', N'FuelRef')
INSERT INTO dbo.CommonsRef (CommonName, CommonTableName)
  VALUES (N'Виды счетчиков', N'CounterKindsRef')
GO
PRINT 'Заполнили классификатор'

DELETE FROM dbo.ProdSiteAttrs
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
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('NORMA_HOT_WATER', 'Норма расхода горячей воды', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('ECOLOGY_TAX', 'Взымается налог на экологию', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('Q_OT', 'Нагрузка на отопление', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('Q_V', 'Номинальный расход воды', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('Q_K', 'Номинальный расход сточных вод', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('INT_TEMP', 'Внутренняя температура', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('VOLUME', 'Объем здания', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('COUNT_RESIDENTS', 'Количество жильцов', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('COUNT_PREVILEGES', 'Количество льготников', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('TOTAL_AREA', 'Общая площадь', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('PREVILEG_AREA', 'Льготная площадь', 'N');
GO

SET IDENTITY_INSERT ProductSites ON
INSERT INTO dbo.ProductSites (ProductSiteId, ProductSiteName, LocationTypeId, Chief)
  SELECT
    k.Kodkot
   ,k.nazk
   ,k.mesto
   ,k.master
  FROM dbo.koteln k;
SET IDENTITY_INSERT ProductSites OFF
GO

DECLARE @ProdSiteId_ INT
DECLARE cur CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
SELECT
  ps.ProductSiteId
FROM dbo.ProductSites ps

OPEN cur
FETCH NEXT FROM cur INTO @ProdSiteId_
WHILE @@fetch_status = 0
BEGIN
  INSERT INTO dbo.ProdSiteAttrs (ProductSiteId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ProdSiteId_
     ,'ENERGY_RATE'
     ,d.dataiz
     ,NULL
     ,d.nel
     ,NULL
    FROM dbo.dankot d;
  INSERT INTO dbo.ProdSiteAttrs (ProductSiteId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ProdSiteId_
     ,'HEAT_LOSS_PERCENT'
     ,d.dataiz
     ,NULL
     ,d.ps
     ,NULL
    FROM dbo.dankot d;
  FETCH NEXT FROM cur INTO @ProdSiteId_
END
CLOSE cur
DEALLOCATE cur
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
  AND k.Kodkot = ProductSiteId);
GO
PRINT 'Заполнили приборы.'

DELETE FROM dbo.LocalitiesRef
GO
DELETE FROM dbo.Consumers
GO
DELETE FROM dbo.ConsumerServs
GO
DELETE FROM dbo.ConsumerAttrs
GO

SET IDENTITY_INSERT LocalitiesRef ON
INSERT INTO dbo.LocalitiesRef (LocalityRefID, LocalityName, LocalityCouncil)
  SELECT
    l.LocalityID
   ,l.LocalityName
   ,l.LocalityCouncil
  FROM dbo.localities l
SET IDENTITY_INSERT LocalitiesRef OFF
GO

SET IDENTITY_INSERT Consumers ON
INSERT INTO dbo.Consumers (ConsumerId, ClientId, ConsumerName, IsHousingStock, LocalityId)
  SELECT o.kodobk, o.kodorg, o.nazv, o.prin, o.LocalityId FROM dbo.obekt o;

PRINT 'ГОТОВО!!!'