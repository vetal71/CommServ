/* Заполнение таблиц */
DELETE FROM dbo.CommonsRef
GO
INSERT INTO dbo.CommonsRef(CommonName, CommonTableName) VALUES(N'Виды организаций', N'ConsumersKindRef')
INSERT INTO dbo.CommonsRef(CommonName, CommonTableName) VALUES(N'Типы финансирования', N'BudgetKindRef')
INSERT INTO dbo.CommonsRef(CommonName, CommonTableName) VALUES(N'Министерства', N'MinistryRef')
INSERT INTO dbo.CommonsRef(CommonName, CommonTableName) VALUES(N'Виды расчетов НДС', N'VatsRef')
GO