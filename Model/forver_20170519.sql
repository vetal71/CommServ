/* Заполнение таблиц */
DELETE FROM dbo.TariffServsVal
GO
DELETE FROM dbo.TariffServs
GO
DELETE FROM dbo.ServiceKindRef
GO
SET IDENTITY_INSERT dbo.ServiceKindRef ON
GO
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(1, N'Отпуск тепловой энергии')
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(2, N'Отпуск холодной воды')
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(3, N'Пропуск сточных вод')
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(4, N'Вывоз мусора')
GO
SET IDENTITY_INSERT dbo.ServiceKindRef OFF
GO

DELETE FROM dbo.VatsRef
GO
SET IDENTITY_INSERT dbo.VatsRef ON
GO
INSERT INTO dbo.VatsRef(VatId, VatName, VatValue) VALUES(1, N'Без НДС', 0.00)
INSERT INTO dbo.VatsRef(VatId, VatName, VatValue) VALUES(2, N'НДС 20%', 20.00)
INSERT INTO dbo.VatsRef(VatId, VatName, VatValue) VALUES(3, N'НДС 20% в цене', 16.67)
GO
SET IDENTITY_INSERT dbo.VatsRef OFF
PRINT 'Заполнили вспомагательные таблицы'

DELETE FROM dbo.TariffServs
GO
SET IDENTITY_INSERT dbo.TariffServs ON
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT kodtt, nazt, 1, 2 FROM dbo.Tarift
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT kodtv + 100, nazt, 2, 2 FROM dbo.Tarifv
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT kodtv + 200, nazt, 3, 2 FROM dbo.Tarifv
GO
INSERT INTO dbo.TariffServs (ServId, ServTitle, ServiceKindId, VatID)
  SELECT kodtg + 300, nazt, 4, 2 FROM dbo.Tarifg
GO
SET IDENTITY_INSERT dbo.TariffServs OFF
GO
PRINT 'Заполнили виды тарифов'

DELETE FROM dbo.TariffServsVal
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, d.DATAN, d.CENA FROM dbo.TariffServs ts, dbo.datatarif d
    WHERE d.KODTT = ts.ServId AND d.DATAN = (SELECT MAX(d1.DATAN) FROM dbo.datatarif d1)
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, d.DATAN, d.CENAV FROM dbo.TariffServs ts, dbo.datatarifv d
    WHERE d.KODTV + 100 = ts.ServId AND d.DATAN = (SELECT MAX(d1.DATAN) FROM dbo.datatarifv d1)
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, d.DATAN, d.CENAK FROM dbo.TariffServs ts, dbo.datatarifv d
    WHERE d.KODTV + 200 = ts.ServId AND d.DATAN = (SELECT MAX(d1.DATAN) FROM dbo.datatarifv d1)
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, d.DATAN, d.CENAG FROM dbo.TariffServs ts, dbo.datatarifg d
    WHERE d.KODTG + 300 = ts.ServId AND d.DATAN = (SELECT MAX(d1.DATAN) FROM dbo.datatarifg d1)
GO
PRINT 'Заполнили значения тарифов'

PRINT 'ГОТОВО!!!'