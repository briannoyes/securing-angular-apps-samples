SET NOCOUNT ON
GO

USE master
GO
if exists (select * from sysdatabases where name='ps_securing_angular_apps_sts')
		drop database "ps_securing_angular_apps_sts"
go

CREATE DATABASE "ps_securing_angular_apps_sts"
go

if exists (select * from sysdatabases where name='ps_securing_angular_apps_sts')
		drop database "ps_securing_angular_apps_sts"
go

CREATE DATABASE "ps_securing_angular_apps_sts"
go
