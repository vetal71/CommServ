/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     18/05/2017 15:10:40                          */
/*==============================================================*/


/*==============================================================*/
/* Table: Banks                                                 */
/*==============================================================*/
create table dbo.Banks (
   BankId               int                  not null,
   BankName             varchar(100)         collate Cyrillic_General_CI_AS not null,
   BankAddress          varchar(100)         collate Cyrillic_General_CI_AS null,
   constraint PK_BANKS primary key (BankId)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: BudgetKindRef                                         */
/*==============================================================*/
create table dbo.BudgetKindRef (
   BudgetKindRefId      smallint             not null,
   BudgetKindName       varchar(50)          not null,
   constraint PK_BUDGETKINDREF primary key (BudgetKindRefId)
)
go

/*==============================================================*/
/* Table: Consumers                                             */
/*==============================================================*/
create table dbo.Consumers (
   ConsumerId           int                  identity(1, 1) not for replication,
   ConsumerName         varchar(100)         collate Cyrillic_General_CI_AS not null,
   ConsumerAddress      varchar(100)         collate Cyrillic_General_CI_AS not null,
   Account              varchar(30)          collate Cyrillic_General_CI_AS not null,
   UNN                  varchar(10)          collate Cyrillic_General_CI_AS not null,
   ConsumerKindId       smallint             not null,
   MinistryId           smallint             null,
   BudgetKindId         smallint             null,
   BankId               int                  null,
   IsDeleted            smallint             null,
   constraint PK_CONSUMERS primary key (ConsumerId)
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: ConsumerKind_Idx                                      */
/*==============================================================*/
create index ConsumerKind_Idx on dbo.Consumers (
ConsumerKindId ASC
)
go

/*==============================================================*/
/* Index: ConsumerName_Idx                                      */
/*==============================================================*/
create index ConsumerName_Idx on dbo.Consumers (
ConsumerName ASC
)
go

/*==============================================================*/
/* Table: ConsumersKindRef                                      */
/*==============================================================*/
create table dbo.ConsumersKindRef (
   ConsumerKindRefId    smallint             not null,
   ConsumerKindName     varchar(50)          not null,
   constraint PK_CONSUMERSKINDREF primary key (ConsumerKindRefId)
)
go

/*==============================================================*/
/* Table: MinistryRef                                           */
/*==============================================================*/
create table dbo.MinistryRef (
   MinistryRefId        smallint             not null,
   MinistryName         varchar(100)         not null,
   constraint PK_MINISTRYREF primary key (MinistryRefId)
)
go

alter table dbo.Consumers
   add constraint FK_CONSUMER_FK_CONSUM_BANKS foreign key (BankId)
      references dbo.Banks (BankId)
go

alter table dbo.Consumers
   add constraint FK_CONSUMER_FK_CONSUM_BUDGETKI foreign key (BudgetKindId)
      references dbo.BudgetKindRef (BudgetKindRefId)
go

alter table dbo.Consumers
   add constraint FK_CONSUMER_FK_CONSUM_CONSUMER foreign key (ConsumerKindId)
      references dbo.ConsumersKindRef (ConsumerKindRefId)
go

alter table dbo.Consumers
   add constraint FK_CONSUMER_FK_MINIST_MINISTRY foreign key (MinistryId)
      references dbo.MinistryRef (MinistryRefId)
go

