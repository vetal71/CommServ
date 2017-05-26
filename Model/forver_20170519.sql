/* Заполнение таблиц */
DELETE FROM dbo.TariffServsVal
GO
DELETE FROM dbo.TariffServs
GO
DELETE FROM dbo.ServiceKindRef
GO
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(1, N'Отпуск тепловой энергии')
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(2, N'Отпуск холодной воды')
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(3, N'Пропуск сточных вод')
INSERT INTO dbo.ServiceKindRef(ServiceKindRefId, ServiceKindName) VALUES(4, N'Вывоз мусора')
GO

DELETE FROM dbo.VatsRef
GO
INSERT INTO dbo.VatsRef(VatId, VatName, VatValue) VALUES(1, N'Без НДС', 0.00)
INSERT INTO dbo.VatsRef(VatId, VatName, VatValue) VALUES(2, N'НДС 20%', 20.00)
INSERT INTO dbo.VatsRef(VatId, VatName, VatValue) VALUES(3, N'НДС 20% в цене', 16.67)
GO
PRINT 'Заполнили вспомагательные таблицы'

DELETE FROM dbo.TariffServs
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
PRINT 'Заполнили виды тарифов'

DELETE FROM dbo.TariffServsVal
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, dd.DATAN, dd.CENA FROM dbo.TariffServs ts, 
    (SELECT DISTINCT dt.KODTT, dt.CENA, (SELECT MAX(d.DATAN) FROM dbo.datatarif d WHERE dt.KODTT=d.KODTT AND dt.CENA = d.CENA) AS DATAN FROM dbo.datatarif dt) dd
    WHERE dd.KODTT = ts.ServId AND dd.DATAN > '30-09-2005'
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, dd.DATAN, dd.CENAV FROM dbo.TariffServs ts, 
    (SELECT DISTINCT dt.KODTV, dt.CENAV, (SELECT MAX(d.DATAN) FROM dbo.datatarifv d WHERE dt.KODTV=d.KODTV AND dt.CENAV = d.CENAV) AS DATAN FROM dbo.datatarifv dt) dd
    WHERE dd.KODTV + 100 = ts.ServId
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)
  SELECT ts.ServId, dd.DATAN, dd.CENAK FROM dbo.TariffServs ts, 
    (SELECT DISTINCT dt.KODTV, dt.CENAK, (SELECT MAX(d.DATAN) FROM dbo.datatarifv d WHERE dt.KODTV=d.KODTV AND dt.CENAK = d.CENAK) AS DATAN FROM dbo.datatarifv dt) dd
    WHERE dd.KODTV + 200 = ts.ServId
GO
INSERT INTO dbo.TariffServsVal (ServId, DateFrom, Value)  
  SELECT ts.ServId, dd.DATAN, dd.CENAG FROM dbo.TariffServs ts, 
    (SELECT DISTINCT dt.KODTG, dt.CENAG, (SELECT MAX(d.DATAN) FROM dbo.datatarifg d WHERE dt.KODTG=d.KODTG AND dt.CENAG = d.CENAG) AS DATAN FROM dbo.datatarifg dt) dd
    WHERE dd.KODTG + 300 = ts.ServId
GO
PRINT 'Заполнили значения тарифов'

PRINT 'ГОТОВО!!!'