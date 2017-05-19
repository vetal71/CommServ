/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     19/05/2017 16:03:44                          */
/*==============================================================*/


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
/* Table: TariffServs                                           */
/*==============================================================*/
create table dbo.TariffServs (
   ServId               int                  identity,
   ServTitle            varchar(50)          not null,
   ServiceKindId        int                  not null,
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

alter table dbo.TariffServs
   add constraint FK_TARIFFSE_SERVKIND_SERVICEK foreign key (ServiceKindId)
      references dbo.ServiceKindRef (ServiceKindRefId)
         on update cascade on delete cascade
go

alter table dbo.TariffServs
   add constraint FK_TARIFFSE_VAT_VATSREF foreign key (VatID)
      references dbo.VatsRef (VatId)
go

alter table dbo.TariffServsVal
   add constraint FK_TARIFFSE_SERVID_TARIFFSE foreign key (ServId)
      references dbo.TariffServs (ServId)
go

