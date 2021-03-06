/*==============================================================*/
/* DBMS name:      InterBase 6.x                                */
/* Created on:     26/06/2017 16:33:49                          */
/*==============================================================*/


/*==============================================================*/
/* Table: AttrsRef                                              */
/*==============================================================*/
create table AttrsRef (
AttrId               varchar(20)                    not null,
AttrFullName         varchar(150)                   not null,
AttrType             char(1)                        not null,
constraint PK_ATTRSREF primary key (AttrId)
);

/*==============================================================*/
/* Table: Banks                                                 */
/*==============================================================*/
create table Banks (
BankId               int generated by default as identity not null,
BankName             varchar(100)                   not null,
BankAddress          varchar(100),
constraint PK_BANKS primary key (BankId)
);

/*==============================================================*/
/* Table: BudgetKindRef                                         */
/*==============================================================*/
create table BudgetKindRef (
BudgetKindId         smallint generated by default as identity not null,
BudgetKindName       varchar(50)                    not null,
constraint PK_BUDGETKINDREF primary key (BudgetKindId)
);

/*==============================================================*/
/* Table: Clients                                               */
/*==============================================================*/
create table Clients (
ClientId             int                            not null,
ClientName           varchar(100)                   not null,
ClientAddress        varchar(100)                   not null,
Account              varchar(30)                    not null,
UNN                  varchar(10)                    not null,
ClientKindId         smallint                       not null,
MinistryId           smallint,
BudgetKindId         smallint,
BankId               int,
IsDeleted            smallint,
constraint PK_CLIENTS primary key (ClientId)
);

/*==============================================================*/
/* Index: ConsumerKind_Idx                                      */
/*==============================================================*/
create asc index ConsumerKind_Idx on Clients (
ClientKindId
);

/*==============================================================*/
/* Index: ConsumerName_Idx                                      */
/*==============================================================*/
create asc index ConsumerName_Idx on Clients (
ClientName
);

/*==============================================================*/
/* Table: ClientsKindRef                                        */
/*==============================================================*/
create table ClientsKindRef (
ClientKindId         smallint                       not null,
ClientKindName       varchar(50)                    not null,
constraint PK_CLIENTSKINDREF primary key (ClientKindId)
);

/*==============================================================*/
/* Table: CommonsRef                                            */
/*==============================================================*/
create table CommonsRef (
CommonId             int                            not null,
CommonName           varchar(100)                   not null,
CommonTableName      varchar(50),
constraint PK_COMMONSREF primary key (CommonId)
);

/*==============================================================*/
/* Table: ConsumerAttrs                                         */
/*==============================================================*/
create table ConsumerAttrs (
ConsumerAttrId       int                            not null,
ConsumerId           int,
AttrId               varchar(20),
ValueDate            datetime,
SValue               varchar(100),
NValue               numeric(20,4),
DValue               datetime,
constraint PK_CONSUMERATTRS primary key (ConsumerAttrId)
);

/*==============================================================*/
/* Index: UNQ_CONSUMER_ATTR_VALDATE                             */
/*==============================================================*/
create unique asc index UNQ_CONSUMER_ATTR_VALDATE on ConsumerAttrs (
ConsumerId,
AttrId,
ValueDate
);

/*==============================================================*/
/* Table: ConsumerServs                                         */
/*==============================================================*/
create table ConsumerServs (
ConsumerServId       int                            not null,
ConsumerId           int                            not null,
ServId               int                            not null,
ProductSiteId        int,
CounterId            int,
IsActive             smallint                       default 1 not null,
constraint PK_CONSUMERSERVS primary key (ConsumerServId)
);

/*==============================================================*/
/* Table: Consumers                                             */
/*==============================================================*/
create table Consumers (
ConsumerId           int                            not null,
ClientId             int                            not null,
ConsumerName         varchar(100)                   not null,
IsHousingStock       smallint                       default 0,
LocalityId           int,
constraint PK_CONSUMERS primary key (ConsumerId)
);

/*==============================================================*/
/* Table: CounterKindsRef                                       */
/*==============================================================*/
create table CounterKindsRef (
CounterKindId        smallint                       not null,
CounterKindName      varchar(30),
constraint PK_COUNTERKINDSREF primary key (CounterKindId)
);

/*==============================================================*/
/* Table: Counters                                              */
/*==============================================================*/
create table Counters (
CounterId            int                            not null,
CounterName          varchar(50)                    not null,
ClientId             int,
CounterKindId        smallint,
IsGroupCounter       smallint,
constraint PK_COUNTERS primary key (CounterId)
);

/*==============================================================*/
/* Table: FuelNormAttrs                                         */
/*==============================================================*/
create table FuelNormAttrs (
FuelNormAttrID       int                            not null,
FuelNormId           int                            not null,
AttrId               varchar(20)                    not null,
ValueDate            datetime                       not null,
SValue               varchar(100),
NValue               numeric(15,2),
DValue               datetime,
constraint PK_FUELNORMATTRS primary key (FuelNormAttrID)
);

/*==============================================================*/
/* Index: UNQ_FUELNORM_ATTRID                                   */
/*==============================================================*/
create unique asc index UNQ_FUELNORM_ATTRID on FuelNormAttrs (
FuelNormId,
AttrId,
ValueDate
);

/*==============================================================*/
/* Table: FuelNorms                                             */
/*==============================================================*/
create table FuelNorms (
FuelNormId           int                            not null,
ProductSiteId        int                            not null,
FuelRefId            int                            not null,
FuelNormVal          decimal(18,4),
constraint PK_FUELNORMID primary key (FuelNormId)
);

/*==============================================================*/
/* Table: FuelRef                                               */
/*==============================================================*/
create table FuelRef (
FuelId               int                            not null,
FuelName             char(50),
ConvertRatio         decimal(18,4),
constraint PK_FUELREF primary key (FuelId)
);

/*==============================================================*/
/* Table: HouseAttrs                                            */
/*==============================================================*/
create table HouseAttrs (
HouseAttrID          int                            not null,
HouseId              int                            not null,
AttrId               varchar(20)                    not null,
ValueDate            datetime                       not null,
SValue               varchar(100),
NValue               numeric(15,2),
DValue               datetime,
constraint PK_HOUSEATTRS primary key (HouseAttrID)
);

/*==============================================================*/
/* Index: UNQ_HOUSE_ATTRID                                      */
/*==============================================================*/
create unique asc index UNQ_HOUSE_ATTRID on HouseAttrs (
HouseId,
AttrId,
ValueDate
);

/*==============================================================*/
/* Table: Houses                                                */
/*==============================================================*/
create table Houses (
HouseId              int                            not null,
ProductSiteId        int                            not null,
LocalityId           int,
StreetId             int                            not null,
HouseNum             varchar(5)                     not null,
HCounterId           int,
HWCounterId          int,
CWCounterId          int,
IsHeat               smallint,
IsHotWater           smallint,
constraint PK_HOUSEID primary key (HouseId)
);

/*==============================================================*/
/* Table: LocalitiesRef                                         */
/*==============================================================*/
create table LocalitiesRef (
LocalityID           int                            not null,
LocalityName         varchar(50)                    not null,
LocalityCouncil      varchar(100),
constraint PK_LOCALITIES primary key (LocalityID)
);

/*==============================================================*/
/* Table: LocationTypesRef                                      */
/*==============================================================*/
create table LocationTypesRef (
LocationTypeId       smallint                       not null,
LocationTypeName     varchar(100)                   not null,
constraint PK_LOCATIONTYPES primary key (LocationTypeId)
);

/*==============================================================*/
/* Table: MinistryRef                                           */
/*==============================================================*/
create table MinistryRef (
MinistryId           smallint                       not null,
MinistryName         varchar(100)                   not null,
constraint PK_MINISTRYREF primary key (MinistryId)
);

/*==============================================================*/
/* Table: ProdSiteAttrs                                         */
/*==============================================================*/
create table ProdSiteAttrs (
ProductSiteAttrID    int                            not null,
ProductSiteId        int                            not null,
AttrId               varchar(20)                    not null,
ValueDate            datetime                       not null,
SValue               varchar(100),
NValue               numeric(15,2),
DValue               datetime,
constraint PK_PRODSITEATTRS primary key (ProductSiteAttrID)
);

/*==============================================================*/
/* Index: UNQ_AttrID_Date                                       */
/*==============================================================*/
create unique asc index UNQ_AttrID_Date on ProdSiteAttrs (
AttrId,
ValueDate,
ProductSiteId
);

/*==============================================================*/
/* Table: ProductSites                                          */
/*==============================================================*/
create table ProductSites (
ProductSiteId        int                            not null,
ProductSiteName      varchar(50)                    not null,
LocationTypeId       smallint                       not null,
Chief                varchar(50),
CounterId            int,
constraint PK_PRODUCTSITES primary key (ProductSiteId)
);

/*==============================================================*/
/* Table: ServiceKindRef                                        */
/*==============================================================*/
create table ServiceKindRef (
ServiceKindId        int                            not null,
ServiceKindName      varchar(100)                   not null,
constraint PK_SERVICEKINDREF primary key (ServiceKindId)
);

/*==============================================================*/
/* Table: StreetRef                                             */
/*==============================================================*/
create table StreetRef (
StreetId             int                            not null,
StreetName           varchar(50)                    not null,
constraint PK_STREETREFID primary key (StreetId)
);

/*==============================================================*/
/* Table: TariffServs                                           */
/*==============================================================*/
create table TariffServs (
ServId               int                            not null,
ServTitle            varchar(50)                    not null,
ServiceKindId        int                            not null,
VatID                int                            not null,
constraint PK_TARIFFSERVS primary key (ServId)
);

/*==============================================================*/
/* Table: TariffServsVal                                        */
/*==============================================================*/
create table TariffServsVal (
ServId               int                            not null,
DateFrom             datetime                       not null,
Value                decimal(15,4)                  not null,
constraint PK_TARIFFSERVSVAL primary key (ServId, DateFrom)
);

/*==============================================================*/
/* Table: VatsRef                                               */
/*==============================================================*/
create table VatsRef (
VatId                int                            not null,
VatName              varchar(50)                    not null,
VatValue             decimal(5,2),
constraint PK_VATSREF primary key (VatId)
);

alter table Clients
   add constraint FK_CLIENTS_BANKID foreign key (BankId)
      references Banks (BankId);

alter table Clients
   add constraint FK_CLIENTS_BUDGETKINDID foreign key (BudgetKindId)
      references BudgetKindRef (BudgetKindId);

alter table Clients
   add constraint FK_CLIENTS_CLIENTKINDID foreign key (ClientKindId)
      references ClientsKindRef (ClientKindId);

alter table Clients
   add constraint FK_CLIENTS_MINISTRYID foreign key (MinistryId)
      references MinistryRef (MinistryId);

alter table ConsumerAttrs
   add constraint FK_CONSUMERATTRS_CONSUMERID foreign key (ConsumerId)
      references Consumers (ConsumerId);

alter table ConsumerAttrs
   add constraint FK_CONSUMERATTS_ATTRID foreign key (AttrId)
      references AttrsRef (AttrId)
      on delete cascade
      on update cascade;

alter table ConsumerServs
   add constraint FK_CONSUMERSERVS_CONSUMERID foreign key (ConsumerId)
      references Consumers (ConsumerId)
      on delete cascade
      on update cascade;

alter table ConsumerServs
   add constraint FK_CONSUMERSERVS_COUNTERID foreign key (CounterId)
      references Counters (CounterId);

alter table ConsumerServs
   add constraint FK_CONSUMERSERVS_PRODSITEID foreign key (ProductSiteId)
      references ProductSites (ProductSiteId);

alter table ConsumerServs
   add constraint FK_CONSUMERSERVS_SERVID foreign key (ServId)
      references TariffServs (ServId)
      on delete cascade
      on update cascade;

alter table Consumers
   add constraint FK_CONSUMERS_CLIENTID foreign key (ClientId)
      references Clients (ClientId)
      on delete cascade
      on update cascade;

alter table Consumers
   add constraint FK_CONSUMERS_LOCALITYID foreign key (LocalityId)
      references LocalitiesRef (LocalityID);

alter table Counters
   add constraint FK_COUNTERS_CLIENTID foreign key (ClientId)
      references Clients (ClientId);

alter table Counters
   add constraint FK_COUNTERS_COUNTERKINDID foreign key (CounterKindId)
      references CounterKindsRef (CounterKindId);

alter table FuelNormAttrs
   add constraint FK_FUELNORM_FK_FUELNO_FUELNORM foreign key (FuelNormId)
      references FuelNorms (FuelNormId);

alter table FuelNorms
   add constraint FK_FUELNORMS_FUELREF foreign key (FuelRefId)
      references FuelRef (FuelId);

alter table FuelNorms
   add constraint FK_FUELNORMS_PRODUCTSITEID foreign key (ProductSiteId)
      references ProductSites (ProductSiteId);

alter table HouseAttrs
   add constraint FK_HOUSEATTRS_ATTREFID foreign key (AttrId)
      references AttrsRef (AttrId);

alter table HouseAttrs
   add constraint FK_HOUSES_HOUSEATTRID foreign key (HouseId)
      references Houses (HouseId);

alter table Houses
   add constraint FK_HOUSES_COUNTERID1 foreign key (HCounterId)
      references Counters (CounterId);

alter table Houses
   add constraint FK_HOUSES_COUNTERID2 foreign key (HWCounterId)
      references Counters (CounterId);

alter table Houses
   add constraint FK_HOUSES_COUNTERID3 foreign key (CWCounterId)
      references Counters (CounterId);

alter table Houses
   add constraint FK_HOUSES_LOCALITYID foreign key (LocalityId)
      references LocalitiesRef (LocalityID);

alter table Houses
   add constraint FK_HOUSES_PRODSITEID foreign key (ProductSiteId)
      references ProductSites (ProductSiteId);

alter table Houses
   add constraint FK_HOUSES_STREETREFID foreign key (StreetId)
      references StreetRef (StreetId);

alter table ProdSiteAttrs
   add constraint FK_PSATTRSVAL_ATTRSID foreign key (AttrId)
      references AttrsRef (AttrId)
      on delete cascade
      on update cascade;

alter table ProdSiteAttrs
   add constraint FK_PSATTRSVAL_PRODSITEID foreign key (ProductSiteId)
      references ProductSites (ProductSiteId)
      on delete cascade
      on update cascade;

alter table ProductSites
   add constraint FK_PRODSITES_COUNTERID foreign key (CounterId)
      references Counters (CounterId);

alter table ProductSites
   add constraint FK_PRODSITES_LOCATIONTYPEID foreign key (LocationTypeId)
      references LocationTypesRef (LocationTypeId);

alter table TariffServs
   add constraint FK_TSERVS_SERVKINDID foreign key (ServiceKindId)
      references ServiceKindRef (ServiceKindId)
      on delete cascade
      on update cascade;

alter table TariffServs
   add constraint FK_TSERVS_VATID foreign key (VatID)
      references VatsRef (VatId);

alter table TariffServsVal
   add constraint FK_TSV_TSERVID foreign key (ServId)
      references TariffServs (ServId);

