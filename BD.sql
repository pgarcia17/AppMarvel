USE [master]
GO
/****** Object:  Database [marvel]    Script Date: 07/06/2022 14:55:49 ******/
CREATE DATABASE [marvel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'marvel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\marvel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'marvel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\marvel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [marvel] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [marvel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [marvel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [marvel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [marvel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [marvel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [marvel] SET ARITHABORT OFF 
GO
ALTER DATABASE [marvel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [marvel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [marvel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [marvel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [marvel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [marvel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [marvel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [marvel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [marvel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [marvel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [marvel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [marvel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [marvel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [marvel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [marvel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [marvel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [marvel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [marvel] SET RECOVERY FULL 
GO
ALTER DATABASE [marvel] SET  MULTI_USER 
GO
ALTER DATABASE [marvel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [marvel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [marvel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [marvel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [marvel] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'marvel', N'ON'
GO
ALTER DATABASE [marvel] SET QUERY_STORE = OFF
GO
USE [marvel]
GO
/****** Object:  Table [dbo].[likes]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[likes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [int] NULL,
	[name] [varchar](200) NULL,
	[cantidad] [int] NULL,
	[fecha] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[heroes]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[heroes](
	[codigo] [int] NOT NULL,
	[name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[top5]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[top5] as (
select TOP (5) a.codigo,a.name, case when sum(b.cantidad) is null then 0 else sum(b.cantidad) end cantidad from heroes a
left join likes b on a.codigo=b.codigo
group by a.codigo,a.name order by sum(b.cantidad) desc);
GO
/****** Object:  View [dbo].[conteo_heroe]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[conteo_heroe] as (
select a.codigo,a.name,case when sum(b.cantidad) is null then 0 else sum(b.cantidad) end cantidad from heroes a
left join likes b on a.codigo=b.codigo
group by a.codigo,a.name);
GO
ALTER TABLE [dbo].[likes] ADD  DEFAULT ((1)) FOR [cantidad]
GO
ALTER TABLE [dbo].[likes] ADD  DEFAULT (getdate()) FOR [fecha]
GO
/****** Object:  StoredProcedure [dbo].[sp_like_add]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_like_add]
@codigo int
as
begin
insert into likes (codigo) values (@codigo)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_like_add_prueba]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_like_add_prueba]
@codigo varchar
as
begin
insert into likes (name) values (@codigo)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_listar]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_listar]
as 
begin
	select * from likes
end
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener]    Script Date: 07/06/2022 14:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_obtener] (@codigo int)
as
begin
	select codigo,name,sum(cantidad) cantidad from likes where codigo=@codigo group by codigo,name order by sum(cantidad) desc
end
GO
USE [master]
GO
ALTER DATABASE [marvel] SET  READ_WRITE 
GO
