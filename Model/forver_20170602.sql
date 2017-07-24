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
PRINT 'Заполнили справочник "Банки"'

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
PRINT 'Создали копию таблицы org в tmp_org'

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
PRINT 'Заполнили справочник "Министерства"'

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
PRINT 'Заполнили справочник "Виды клиентов"'

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
PRINT 'Заполнили справочник "Виды финансирования"'

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
PRINT 'Заполнили таблицу клиентов'
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
PRINT 'Заполнили справочник "Виды услуг"'

DELETE FROM dbo.VatsRef
GO
INSERT INTO dbo.VatsRef (VatID, VatName, VatValue)
  VALUES (1, N'Без НДС', 0.00)
INSERT INTO dbo.VatsRef (VatID, VatName, VatValue)
  VALUES (2, N'НДС 20%', 20.00)
INSERT INTO dbo.VatsRef (VatID, VatName, VatValue)
  VALUES (3, N'НДС 20% в цене', 16.67)
GO
PRINT 'Заполнили справочник "Виды расчета НДС"'

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
PRINT 'Заполнили справочник "Виды тарифов"'

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
PRINT 'Заполнили таблицу значений тарифов'

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
PRINT 'Заполнили справочник "Виды приборов учета"'

INSERT INTO dbo.LocationTypesRef (LocationTypeRefId, LocationTypeName)
  VALUES (1, 'Город');
INSERT INTO dbo.LocationTypesRef (LocationTypeRefId, LocationTypeName)
  VALUES (2, 'Село');
GO
PRINT 'Заполнили справочник "Типы местоположений"'

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
  VALUES ('Q_HW', 'Нагрузка на ГВС', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('Q_V', 'Номинальный расход воды', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('Q_K', 'Номинальный расход сточных вод', 'N');
INSERT INTO AttrsRef (AttrRefId, AttrFullName, AttrType)
  VALUES ('Q_G', 'Номинальный объем мусора', 'N');
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
PRINT 'Добавили новые атрибуты'

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
PRINT 'Заполнили справочник "Производственные участки"'

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
    FROM dbo.dankot d
    WHERE d.kodkot = @ProdSiteId_;
  INSERT INTO dbo.ProdSiteAttrs (ProductSiteId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ProdSiteId_
     ,'HEAT_LOSS_PERCENT'
     ,d.dataiz
     ,NULL
     ,d.ps
     ,NULL
    FROM dbo.dankot d
    WHERE d.kodkot = @ProdSiteId_;
  FETCH NEXT FROM cur INTO @ProdSiteId_
END
CLOSE cur
DEALLOCATE cur
GO
PRINT 'Заполнили атрибуты для производственных участков'

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
PRINT 'Заполнили таблицу "Приборы учета"'

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
    l.LocalityId
   ,l.LocalityName
   ,l.LocalityCouncil
  FROM dbo.localities l
SET IDENTITY_INSERT LocalitiesRef OFF
GO
PRINT 'Заполнили справочник "Населенные пункты"'

SET IDENTITY_INSERT Consumers ON
INSERT INTO dbo.Consumers (ConsumerId, ClientId, ConsumerName, IsHousingStock, LocalityId)
  SELECT
    o.kodobk
   ,o.kodorg
   ,o.nazv
   ,o.prin
   ,o.LocalityId
  FROM dbo.obekt o;
SET IDENTITY_INSERT Consumers OFF
GO
PRINT 'Заполнили картотеку потребителей'

DECLARE @ConsumerId_ INT
DECLARE cur CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
SELECT
  c.ConsumerId
FROM dbo.Consumers c

OPEN cur
FETCH NEXT FROM cur INTO @ConsumerId_
WHILE @@fetch_status = 0
BEGIN
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'COUNT_RESIDENTS'
     ,d.dataiz
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.danobk d
    WHERE d.prj > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'COUNT_RESIDENTS'
     ,SYSDATETIME()
     ,NULL
     ,o.prj
     ,NULL
    FROM dbo.obekt o
    WHERE o.prj > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'COUNT_PREVILEGES'
     ,d.dataiz
     ,NULL
     ,d.prjl
     ,NULL
    FROM dbo.danobk d
    WHERE d.prjl > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'COUNT_PREVILEGES'
     ,SYSDATETIME()
     ,NULL
     ,o.prjl
     ,NULL
    FROM dbo.obekt o
    WHERE o.prjl > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'TOTAL_AREA'
     ,d.dataiz
     ,NULL
     ,d.spl
     ,NULL
    FROM dbo.danobk d
    WHERE d.spl > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'TOTAL_AREA'
     ,SYSDATETIME()
     ,NULL
     ,o.spl
     ,NULL
    FROM dbo.obekt o
    WHERE o.spl > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'PREVILEG_AREA'
     ,d.dataiz
     ,NULL
     ,d.spll
     ,NULL
    FROM dbo.danobk d
    WHERE d.spll > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'PREVILEG_AREA'
     ,SYSDATETIME()
     ,NULL
     ,o.spll
     ,NULL
    FROM dbo.obekt o
    WHERE o.spll > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'INT_TEMP'
     ,SYSDATETIME()
     ,NULL
     ,o.t
     ,NULL
    FROM dbo.obekt o
    WHERE o.t > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'NORMA_HOT_WATER'
     ,SYSDATETIME()
     ,NULL
     ,o.ngvs
     ,NULL
    FROM dbo.obekt o
    WHERE o.ngvs > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_OT'
     ,d.dataiz
     ,NULL
     ,d.q
     ,NULL
    FROM dbo.danobk d
    WHERE d.q > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'Q_OT'
     ,SYSDATETIME()
     ,NULL
     ,o.q
     ,NULL
    FROM dbo.obekt o
    WHERE o.q > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'VOLUME'
     ,d.dataiz
     ,NULL
     ,d.v
     ,NULL
    FROM dbo.danobk d
    WHERE d.v > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'VOLUME'
     ,SYSDATETIME()
     ,NULL
     ,o.v
     ,NULL
    FROM dbo.obekt o
    WHERE o.v > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_V'
     ,SYSDATETIME()
     ,NULL
     ,o.qv
     ,NULL
    FROM dbo.obekt o
    WHERE o.qv > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_K'
     ,SYSDATETIME()
     ,NULL
     ,o.qk
     ,NULL
    FROM dbo.obekt o
    WHERE o.qk > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_G'
     ,SYSDATETIME()
     ,NULL
     ,o.qg
     ,NULL
    FROM dbo.obekt o
    WHERE o.qg > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'ECOLOGY_TAX'
     ,SYSDATETIME()
     ,NULL
     ,o.ecnal
     ,NULL
    FROM dbo.obekt o
    WHERE o.ecnal > 0
    AND o.kodobk = @ConsumerId_;
  FETCH NEXT FROM cur INTO @ConsumerId_
END
CLOSE cur
DEALLOCATE cur
GO
PRINT 'Заполнили атрибуты по потребителям'

DELETE FROM dbo.ConsumerServs
GO
INSERT INTO dbo.ConsumerServs (ConsumerId, ServId, ProductSiteId, CounterId, IsActive)
  SELECT
    o.kodobk
   ,1 /* отопление и ГВС */
   ,o.kodkot
   ,CASE
      WHEN o.kodpr > 1 THEN o.kodpr
      ELSE NULL
    END
   ,1
  FROM dbo.obekt o
  WHERE o.podkl = 0
  OR o.podklgv = 0
  UNION ALL
  SELECT
    o.kodobk
   ,2 /* вода */
   ,o.kodkot
   ,NULL
   ,1
  FROM dbo.obekt o
  WHERE o.podklv = 0
  UNION ALL
  SELECT
    o.kodobk
   ,3 /* стоки */
   ,o.kodkot
   ,NULL
   ,1
  FROM dbo.obekt o
  WHERE o.podklv = 0
  UNION ALL
  SELECT
    o.kodobk
   ,4 /* мусор */
   ,o.kodkot
   ,NULL
   ,1
  FROM dbo.obekt o
  WHERE o.podklg = 0;
GO
PRINT 'Заполнили подключенные услуги по потребителям'

DELETE FROM dbo.StreetRef
GO

SET IDENTITY_INSERT StreetRef ON
INSERT INTO dbo.StreetRef (StreetRefId, StreetName)
  SELECT
    u.kodul
   ,u.nazvul
  FROM dbo.ulica u;
SET IDENTITY_INSERT StreetRef OFF
GO
PRINT 'Заполнили справочник улиц'

DELETE FROM dbo.Houses
GO

SET IDENTITY_INSERT Houses ON
INSERT INTO dbo.Houses (HouseId, ProductSiteId, LocalityId, StreetId, HouseNum, HCounterId, IsHeat, IsHotWater)
  SELECT d.koddom, d.kodkot, NULL, d.kodul, d.ndom, D.kodpr, CASE WHEN d.podkl = 0 THEN 1 ELSE 0 END, CASE WHEN d.podklgv = 0 THEN 1 ELSE 0 END FROM dbo.doma d;
SET IDENTITY_INSERT Houses OFF
GO
PRINT 'Заполнили таблицу "Дома"'

DECLARE @HouseId_ INT
DECLARE cur CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
SELECT
  h.HouseId
FROM dbo.Houses h

OPEN cur
FETCH NEXT FROM cur INTO @HouseId_
WHILE @@fetch_status = 0
BEGIN
  INSERT INTO dbo.HouseAttrs (HouseId, AttrId, ValueDate, SValue, NValue, DValue)
    SELECT
      @HouseId_
     ,'COUNT_RESIDENTS'
     ,d.dataiz
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.dandoma d
    WHERE d.prj > 0
    AND d.koddom = @HouseId_
    UNION ALL
    SELECT
      @HouseId_
     ,'COUNT_RESIDENTS'
     ,SYSDATETIME()
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.doma d
    WHERE d.prj > 0
    AND d.koddom = @HouseId_;  
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @HouseId_
     ,'TOTAL_AREA'
     ,d.dataiz
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.dandoma d
    WHERE d.prj > 0
    AND d.koddom = @HouseId_
    UNION ALL
    SELECT
      @HouseId_
     ,'TOTAL_AREA'
     ,SYSDATETIME()
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.doma d
    WHERE d.prj > 0
    AND d.koddom = @HouseId_;  
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @HouseId_
     ,'Q_OT'
     ,d.dataiz
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.dandoma d
    WHERE d.prj > 0
    AND d.koddom = @HouseId_
    UNION ALL
    SELECT
      @HouseId_
     ,'Q_OT'
     ,SYSDATETIME()
     ,NULL
     ,d.prj
     ,NULL
    FROM dbo.doma d
    WHERE d.prj > 0
    AND d.koddom = @HouseId_;

  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'NORMA_HOT_WATER'
     ,SYSDATETIME()
     ,NULL
     ,o.ngvs
     ,NULL
    FROM dbo.obekt o
    WHERE o.ngvs > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_OT'
     ,d.dataiz
     ,NULL
     ,d.q
     ,NULL
    FROM dbo.danobk d
    WHERE d.q > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'Q_OT'
     ,SYSDATETIME()
     ,NULL
     ,o.q
     ,NULL
    FROM dbo.obekt o
    WHERE o.q > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'VOLUME'
     ,d.dataiz
     ,NULL
     ,d.v
     ,NULL
    FROM dbo.danobk d
    WHERE d.v > 0
    AND d.kodobk = @ConsumerId_
    UNION ALL
    SELECT
      @ConsumerId_
     ,'VOLUME'
     ,SYSDATETIME()
     ,NULL
     ,o.v
     ,NULL
    FROM dbo.obekt o
    WHERE o.v > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_V'
     ,SYSDATETIME()
     ,NULL
     ,o.qv
     ,NULL
    FROM dbo.obekt o
    WHERE o.qv > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_K'
     ,SYSDATETIME()
     ,NULL
     ,o.qk
     ,NULL
    FROM dbo.obekt o
    WHERE o.qk > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'Q_G'
     ,SYSDATETIME()
     ,NULL
     ,o.qg
     ,NULL
    FROM dbo.obekt o
    WHERE o.qg > 0
    AND o.kodobk = @ConsumerId_;
  INSERT INTO dbo.ConsumerAttrs (ConsumerAttrId, ConsumerId, AttrRefId, ValueDate, SValue, NValue, DValue)
    SELECT
      @ConsumerId_
     ,'ECOLOGY_TAX'
     ,SYSDATETIME()
     ,NULL
     ,o.ecnal
     ,NULL
    FROM dbo.obekt o
    WHERE o.ecnal > 0
    AND o.kodobk = @ConsumerId_;
  FETCH NEXT FROM cur INTO @ConsumerId_
END
CLOSE cur
DEALLOCATE cur
GO
PRINT 'Заполнили атрибуты по потребителям'


PRINT 'ГОТОВО!!!'