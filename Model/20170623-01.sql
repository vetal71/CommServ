/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     23/06/2017 17:19:08                          */
/*==============================================================*/


/*==============================================================*/
/* Table: AttrsRef                                              */
/*==============================================================*/
create table dbo.AttrsRef (
   AttrRefId            varchar(20)          not null,
   AttrFullName         varchar(150)         not null,
   AttrType             char(1)              not null,
   constraint PK_ATTRSREF primary key (AttrRefId)
)
go

/*==============================================================*/
/* Table: Banks                                                 */
/*==============================================================*/
create table dbo.Banks (
   BankId               int                  not null,
   BankName             varchar(100)         collate Cyrillic_General_CI_AS not null,
   BankAddress          varchar(100)         collate Cyrillic_General_CI_AS null,
   constraint PK_BANKS primary key (BankId)
)
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
/* Table: Clients                                               */
/*==============================================================*/
create table dbo.Clients (
   ClientId             int                  identity(1, 1) not for replication,
   ClientName           varchar(100)         collate Cyrillic_General_CI_AS not null,
   ClientAddress        varchar(100)         collate Cyrillic_General_CI_AS not null,
   Account              varchar(30)          collate Cyrillic_General_CI_AS not null,
   UNN                  varchar(10)          collate Cyrillic_General_CI_AS not null,
   ClientKindRefId      smallint             not null,
   MinistryRefId        smallint             null,
   BudgetKindRefId      smallint             null,
   BankId               int                  null,
   IsDeleted            smallint             null,
   constraint PK_CLIENTS primary key (ClientId)
)
go

/*==============================================================*/
/* Index: ConsumerKind_Idx                                      */
/*==============================================================*/
create index ConsumerKind_Idx on dbo.Clients (
ClientKindRefId ASC
)
go

/*==============================================================*/
/* Index: ConsumerName_Idx                                      */
/*==============================================================*/
create index ConsumerName_Idx on dbo.Clients (
ClientName ASC
)
go

/*==============================================================*/
/* Table: ClientsKindRef                                        */
/*==============================================================*/
create table dbo.ClientsKindRef (
   ClientKindRefId      smallint             not null,
   ClientKindName       varchar(50)          not null,
   constraint PK_CLIENTSKINDREF primary key (ClientKindRefId)
)
go

/*==============================================================*/
/* Table: CommonsRef                                            */
/*==============================================================*/
create table dbo.CommonsRef (
   CommonRefId          int                  identity,
   CommonName           varchar(100)         not null,
   CommonTableName      varchar(50)          null,
   constraint PK_COMMONSREF primary key (CommonRefId)
)
go

/*==============================================================*/
/* Table: ConsumerAttrs                                         */
/*==============================================================*/
create table dbo.ConsumerAttrs (
   ConsumerAttrId       int                  not null,
   ConsumerId           int                  null,
   AttrRefId            varchar(20)          null,
   ValueDate            datetime             null,
   SValue               varchar(100)         null,
   NValue               numeric(20,4)        null,
   DValue               datetime             null,
   constraint PK_CONSUMERATTRS primary key (ConsumerAttrId)
)
go

/*==============================================================*/
/* Index: UNQ_CONSUMER_ATTR_VALDATE                             */
/*==============================================================*/
create unique index UNQ_CONSUMER_ATTR_VALDATE on dbo.ConsumerAttrs (
ConsumerId ASC,
AttrRefId ASC,
ValueDate ASC
)
go

/*==============================================================*/
/* Table: ConsumerServs                                         */
/*==============================================================*/
create table dbo.ConsumerServs (
   ConsumerServId       int                  identity(1, 1) not for replication,
   ConsumerId           int                  not null,
   ServId               int                  not null,
   ProductSiteId        int                  null,
   CounterId            int                  null,
   IsActive             smallint             not null default 1,
   constraint PK_CONSUMERSERVS primary key (ConsumerServId)
)
go

/*==============================================================*/
/* Table: Consumers                                             */
/*==============================================================*/
create table dbo.Consumers (
   ConsumerId           int                  identity(1, 1) not for replication,
   ClientId             int                  not null,
   ConsumerName         varchar(100)         collate Cyrillic_General_CI_AS not null,
   IsHousingStock       smallint             null default 0,
   LocalityId           int                  null,
   constraint PK_CONSUMERS primary key (ConsumerId)
)
go

/*==============================================================*/
/* Table: CounterKindsRef                                       */
/*==============================================================*/
create table dbo.CounterKindsRef (
   CounterKindRefId     smallint             not null,
   CounterKindName      varchar(30)          null,
   constraint PK_COUNTERKINDSREF primary key (CounterKindRefId)
)
go

/*==============================================================*/
/* Table: Counters                                              */
/*==============================================================*/
create table dbo.Counters (
   CounterId            int                  identity(1, 1) not for replication,
   CounterName          varchar(50)          collate Cyrillic_General_CI_AS not null,
   ClientId             int                  null,
   CounterKindRefId     smallint             null,
   IsGroupCounter       smallint             null,
   constraint PK_COUNTERS primary key (CounterId)
)
go

/*==============================================================*/
/* Table: FuelNormAttrs                                         */
/*==============================================================*/
create table dbo.FuelNormAttrs (
   FuelNormAttrID       int                  identity(1, 1) not for replication,
   FuelNormId           int                  not null,
   AttrRefId            varchar(20)          not null,
   ValueDate            datetime             not null,
   SValue               varchar(100)         null,
   NValue               numeric(15,2)        null,
   DValue               datetime             null,
   constraint PK_FUELNORMATTRS primary key (FuelNormAttrID)
)
go

/*==============================================================*/
/* Index: UNQ_FUELNORM_ATTRID                                   */
/*==============================================================*/
create unique index UNQ_FUELNORM_ATTRID on dbo.FuelNormAttrs (
FuelNormId ASC,
AttrRefId ASC,
ValueDate ASC
)
go

/*==============================================================*/
/* Table: FuelNorms                                             */
/*==============================================================*/
create table dbo.FuelNorms (
   FuelNormId           int                  identity,
   ProductSiteId        int                  not null,
   FuelRefId            int                  not null,
   FuelNormVal          decimal(18,4)        null,
   constraint PK_FUELNORMID primary key (FuelNormId)
)
go

/*==============================================================*/
/* Table: FuelRef                                               */
/*==============================================================*/
create table dbo.FuelRef (
   FuelRefId            int                  identity(1, 1),
   FuelName             char(50)             collate Cyrillic_General_CI_AS null,
   ConvertRatio         decimal(18,4)        null,
   constraint PK_FUELREF primary key (FuelRefId)
)
go

/*==============================================================*/
/* Table: HouseAttrs                                            */
/*==============================================================*/
create table dbo.HouseAttrs (
   HouseAttrID          int                  identity(1, 1) not for replication,
   HouseId              int                  not null,
   AttrRefId            varchar(20)          not null,
   ValueDate            datetime             not null,
   SValue               varchar(100)         null,
   NValue               numeric(15,2)        null,
   DValue               datetime             null,
   constraint PK_HOUSEATTRS primary key (HouseAttrID)
)
go

/*==============================================================*/
/* Index: UNQ_HOUSE_ATTRID                                      */
/*==============================================================*/
create unique index UNQ_HOUSE_ATTRID on dbo.HouseAttrs (
HouseId ASC,
AttrRefId ASC,
ValueDate ASC
)
go

/*==============================================================*/
/* Table: Houses                                                */
/*==============================================================*/
create table dbo.Houses (
   HouseId              int                  not null,
   ProductSiteId        int                  not null,
   LocalityId           int                  null,
   StreetRefId          int                  not null,
   HouseNum             varchar(5)           collate Cyrillic_General_CI_AS not null,
   HCounterId           int                  null,
   HWCounterId          int                  null,
   CWCounterId          int                  null,
   IsHeat               smallint             null,
   IsHotWater           smallint             null,
   constraint PK_HOUSEID primary key (HouseId)
)
go

/*==============================================================*/
/* Table: LocalitiesRef                                         */
/*==============================================================*/
create table dbo.LocalitiesRef (
   LocalityRefID        int                  identity(1, 1) not for replication,
   LocalityName         varchar(50)          collate Cyrillic_General_CI_AS not null,
   LocalityCouncil      varchar(100)         collate Cyrillic_General_CI_AS null,
   constraint PK_LOCALITIES primary key (LocalityRefID)
)
go

/*==============================================================*/
/* Table: LocationTypesRef                                      */
/*==============================================================*/
create table dbo.LocationTypesRef (
   LocationTypeRefId    smallint             not null,
   LocationTypeName     varchar(100)         not null,
   constraint PK_LOCATIONTYPES primary key (LocationTypeRefId)
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

/*==============================================================*/
/* Table: ProdSiteAttrs                                         */
/*==============================================================*/
create table dbo.ProdSiteAttrs (
   ProductSiteAttrID    int                  identity(1, 1) not for replication,
   ProductSiteId        int                  not null,
   AttrRefId            varchar(20)          not null,
   ValueDate            datetime             not null,
   SValue               varchar(100)         null,
   NValue               numeric(15,2)        null,
   DValue               datetime             null,
   constraint PK_PRODSITEATTRS primary key (ProductSiteAttrID)
)
go

/*==============================================================*/
/* Index: UNQ_AttrID_Date                                       */
/*==============================================================*/
create unique index UNQ_AttrID_Date on dbo.ProdSiteAttrs (
AttrRefId ASC,
ValueDate ASC,
ProductSiteId ASC
)
go

/*==============================================================*/
/* Table: ProductSites                                          */
/*==============================================================*/
create table dbo.ProductSites (
   ProductSiteId        int                  not null,
   ProductSiteName      varchar(50)          collate Cyrillic_General_CI_AS not null,
   LocationTypeId       smallint             not null,
   Chief                varchar(50)          collate Cyrillic_General_CI_AS null,
   CounterId            int                  null,
   constraint PK_PRODUCTSITES primary key (ProductSiteId)
)
go

/*==============================================================*/
/* Table: ServiceKindRef                                        */
/*==============================================================*/
create table dbo.ServiceKindRef (
   ServiceKindRefId     int                  identity,
   ServiceKindName      varchar(100)         not null,
   constraint PK_SERVICEKINDREF primary key (ServiceKindRefId)
)
go

/*==============================================================*/
/* Table: StreetRef                                             */
/*==============================================================*/
create table dbo.StreetRef (
   StreetRefId          int                  identity(1, 1) not for replication,
   StreetName           varchar(50)          collate Cyrillic_General_CI_AS not null,
   constraint PK_STREETREFID primary key (StreetRefId)
)
go

/*==============================================================*/
/* Table: TariffServs                                           */
/*==============================================================*/
create table dbo.TariffServs (
   ServId               int                  identity,
   ServTitle            varchar(50)          not null,
   ServiceKindRefId     int                  not null,
   VatID                int                  not null,
   constraint PK_TARIFFSERVS primary key (ServId)
)
go

/*==============================================================*/
/* Table: TariffServsVal                                        */
/*==============================================================*/
create table dbo.TariffServsVal (
   ServId               int                  not null,
   DateFrom             datetime             not null,
   Value                decimal(15,4)        not null,
   constraint PK_TARIFFSERVSVAL primary key (ServId, DateFrom)
)
go

/*==============================================================*/
/* Table: VatsRef                                               */
/*==============================================================*/
create table dbo.VatsRef (
   VatId                int                  identity,
   VatName              varchar(50)          not null,
   VatValue             decimal(5,2)         null,
   constraint PK_VATSREF primary key (VatId)
)
go

alter table dbo.Clients
   add constraint FK_CLIENTS_BANKID foreign key (BankId)
      references dbo.Banks (BankId)
go

alter table dbo.Clients
   add constraint FK_CLIENTS_BUDGETKINDID foreign key (BudgetKindRefId)
      references dbo.BudgetKindRef (BudgetKindRefId)
go

alter table dbo.Clients
   add constraint FK_CLIENTS_CLIENTKINDID foreign key (ClientKindRefId)
      references dbo.ClientsKindRef (ClientKindRefId)
go

alter table dbo.Clients
   add constraint FK_CLIENTS_MINISTRYID foreign key (MinistryRefId)
      references dbo.MinistryRef (MinistryRefId)
go

alter table dbo.ConsumerAttrs
   add constraint FK_CONSUMERATTRS_CONSUMERID foreign key (ConsumerId)
      references dbo.Consumers (ConsumerId)
go

alter table dbo.ConsumerAttrs
   add constraint FK_CONSUMERATTS_ATTRID foreign key (AttrRefId)
      references dbo.AttrsRef (AttrRefId)
         on update cascade on delete cascade
go

alter table dbo.ConsumerServs
   add constraint FK_CONSUMERSERVS_CONSUMERID foreign key (ConsumerId)
      references dbo.Consumers (ConsumerId)
         on update cascade on delete cascade
go

alter table dbo.ConsumerServs
   add constraint FK_CONSUMERSERVS_COUNTERID foreign key (CounterId)
      references dbo.Counters (CounterId)
go

alter table dbo.ConsumerServs
   add constraint FK_CONSUMERSERVS_PRODSITEID foreign key (ProductSiteId)
      references dbo.ProductSites (ProductSiteId)
go

alter table dbo.ConsumerServs
   add constraint FK_CONSUMERSERVS_SERVID foreign key (ServId)
      references dbo.TariffServs (ServId)
         on update cascade on delete cascade
go

alter table dbo.Consumers
   add constraint FK_CONSUMERS_CLIENTID foreign key (ClientId)
      references dbo.Clients (ClientId)
         on update cascade on delete cascade
go

alter table dbo.Consumers
   add constraint FK_CONSUMERS_LOCALITYID foreign key (LocalityId)
      references dbo.LocalitiesRef (LocalityRefID)
go

alter table dbo.Counters
   add constraint FK_COUNTERS_CLIENTID foreign key (ClientId)
      references dbo.Clients (ClientId)
go

alter table dbo.Counters
   add constraint FK_COUNTERS_COUNTERKINDID foreign key (CounterKindRefId)
      references dbo.CounterKindsRef (CounterKindRefId)
go

alter table dbo.FuelNormAttrs
   add constraint FK_FUELNORM_FK_FUELNO_FUELNORM foreign key (FuelNormId)
      references dbo.FuelNorms (FuelNormId)
go

alter table dbo.FuelNorms
   add constraint FK_FUELNORMS_FUELREF foreign key (FuelRefId)
      references dbo.FuelRef (FuelRefId)
go

alter table dbo.FuelNorms
   add constraint FK_FUELNORMS_PRODUCTSITEID foreign key (ProductSiteId)
      references dbo.ProductSites (ProductSiteId)
go

alter table dbo.HouseAttrs
   add constraint FK_HOUSEATTRS_ATTREFID foreign key (AttrRefId)
      references dbo.AttrsRef (AttrRefId)
go

alter table dbo.HouseAttrs
   add constraint FK_HOUSES_HOUSEATTRID foreign key (HouseId)
      references dbo.Houses (HouseId)
go

alter table dbo.Houses
   add constraint FK_HOUSES_COUNTERID1 foreign key (HCounterId)
      references dbo.Counters (CounterId)
go

alter table dbo.Houses
   add constraint FK_HOUSES_COUNTERID2 foreign key (HWCounterId)
      references dbo.Counters (CounterId)
go

alter table dbo.Houses
   add constraint FK_HOUSES_COUNTERID3 foreign key (CWCounterId)
      references dbo.Counters (CounterId)
go

alter table dbo.Houses
   add constraint FK_HOUSES_LOCALITYID foreign key (LocalityId)
      references dbo.LocalitiesRef (LocalityRefID)
go

alter table dbo.Houses
   add constraint FK_HOUSES_PRODSITEID foreign key (ProductSiteId)
      references dbo.ProductSites (ProductSiteId)
go

alter table dbo.Houses
   add constraint FK_HOUSES_STREETREFID foreign key (StreetRefId)
      references dbo.StreetRef (StreetRefId)
go

alter table dbo.ProdSiteAttrs
   add constraint FK_PSATTRSVAL_ATTRSID foreign key (AttrRefId)
      references dbo.AttrsRef (AttrRefId)
         on update cascade on delete cascade
go

alter table dbo.ProdSiteAttrs
   add constraint FK_PSATTRSVAL_PRODSITEID foreign key (ProductSiteId)
      references dbo.ProductSites (ProductSiteId)
         on update cascade on delete cascade
go

alter table dbo.ProductSites
   add constraint FK_PRODSITES_COUNTERID foreign key (CounterId)
      references dbo.Counters (CounterId)
go

alter table dbo.ProductSites
   add constraint FK_PRODSITES_LOCATIONTYPEID foreign key (LocationTypeId)
      references dbo.LocationTypesRef (LocationTypeRefId)
go

alter table dbo.TariffServs
   add constraint FK_TSERVS_SERVKINDID foreign key (ServiceKindRefId)
      references dbo.ServiceKindRef (ServiceKindRefId)
         on update cascade on delete cascade
go

alter table dbo.TariffServs
   add constraint FK_TSERVS_VATID foreign key (VatID)
      references dbo.VatsRef (VatId)
go

alter table dbo.TariffServsVal
   add constraint FK_TSV_TSERVID foreign key (ServId)
      references dbo.TariffServs (ServId)
go

