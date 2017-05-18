/* Заполнение таблиц */
IF EXISTS (SELECT * FROM sys.all_objects ao
  WHERE ao.name='tmp_org' AND ao.type='U')
  DROP TABLE tmp_org
GO
PRINT 'Удалили tmp_org'

DELETE FROM dbo.Banks
GO
INSERT INTO Banks (BankId, BankName, BankAddress)
  SELECT b.kod_bank, b.nazv_bank, b.adres_bank FROM bank b;
GO
PRINT 'Добавили банки'

SELECT kodorg
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
      ,data_per INTO dbo.tmp_org FROM dbo.org
GO
PRINT 'Создали tmp_org'

UPDATE dbo.tmp_org SET tiporg = 4 WHERE tiporg = 3
UPDATE dbo.tmp_org SET tiporg = 3 WHERE tiporg = 2
UPDATE dbo.tmp_org SET tiporg = 2 WHERE tiporg = 1
UPDATE dbo.tmp_org SET tiporg = 1 WHERE tiporg = 0

UPDATE dbo.tmp_org SET tipbud = 4 WHERE tipbud = 3
UPDATE dbo.tmp_org SET tipbud = 3 WHERE tipbud = 2
UPDATE dbo.tmp_org SET tipbud = 2 WHERE tipbud = 1
UPDATE dbo.tmp_org SET tipbud = 1 WHERE tipbud = 0

UPDATE dbo.tmp_org SET kodbank = null WHERE kodbank = 0
GO
PRINT 'Обновили tmp_org'

DELETE FROM dbo.MinistryRef
GO
SELECT DISTINCT IDENTITY(INT, 1, 1) AS Id, 'Министерство ' + o._min AS Name INTO tmp_Ministry 
  FROM dbo.tmp_org o WHERE o._min IS NOT NULL
GO
INSERT INTO dbo.MinistryRef (MinistryRefId, MinistryName) 
  SELECT * FROM dbo.tmp_Ministry tm
GO
DROP TABLE tmp_Ministry
GO

DELETE FROM dbo.ConsumersKindRef
GO
INSERT INTO dbo.ConsumersKindRef (ConsumerKindRefId, ConsumerKindName)
  VALUES (1, 'Бюджетные организации');
INSERT INTO dbo.ConsumersKindRef (ConsumerKindRefId, ConsumerKindName)
  VALUES (2, 'Хозрасчетные организации');
    INSERT INTO dbo.ConsumersKindRef (ConsumerKindRefId, ConsumerKindName)
  VALUES (3, 'ЖСК');
    INSERT INTO dbo.ConsumersKindRef (ConsumerKindRefId, ConsumerKindName)
  VALUES (4, 'ЖСК (БГСХА)');
GO

DELETE FROM dbo.BudgetKindRef
GO
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (1, 'Местный бюджет');
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (2, 'Областной бюджет');
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (3, 'Республиканский бюджет');
INSERT INTO dbo.BudgetKindRef (BudgetKindRefId, BudgetKindName)
  VALUES (4, 'Прочее финансирование');
GO
PRINT 'Заполнили вспомагательные таблицы'

DELETE FROM dbo.Consumers
GO
SET IDENTITY_INSERT dbo.Consumers ON
GO
INSERT INTO dbo.Consumers (
  ConsumerId,
  ConsumerName,
  ConsumerAddress,
  Account,
  UNN,
  ConsumerKindId,
  MinistryId,
  BudgetKindId,
  BankId,
  IsDeleted)
SELECT kodorg
  ,nazv
  ,adres
  ,rschet
  ,unn
  ,tiporg
  ,(SELECT mr.MinistryRefId FROM dbo.MinistryRef mr WHERE mr.MinistryName = 'Министерство ' + _min)
  ,tipbud
  ,kodbank
  ,0 FROM dbo.tmp_org
GO
SET IDENTITY_INSERT dbo.Consumers OFF
GO
PRINT 'ГОТОВО!!!'