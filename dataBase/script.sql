USE [master]
GO
/****** Object:  Database [Sport Club]    Script Date: 2020-07-17 3:30:05 PM ******/
CREATE DATABASE [Sport Club]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sport Club', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Sport Club.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Sport Club_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Sport Club_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Sport Club] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sport Club].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sport Club] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sport Club] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sport Club] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sport Club] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sport Club] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sport Club] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sport Club] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sport Club] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sport Club] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sport Club] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sport Club] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sport Club] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sport Club] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sport Club] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sport Club] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sport Club] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sport Club] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sport Club] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sport Club] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sport Club] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sport Club] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sport Club] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sport Club] SET RECOVERY FULL 
GO
ALTER DATABASE [Sport Club] SET  MULTI_USER 
GO
ALTER DATABASE [Sport Club] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sport Club] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sport Club] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sport Club] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Sport Club] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Sport Club', N'ON'
GO
ALTER DATABASE [Sport Club] SET QUERY_STORE = OFF
GO
USE [Sport Club]
GO
/****** Object:  User [abolfazl]    Script Date: 2020-07-17 3:30:06 PM ******/
CREATE USER [abolfazl] FOR LOGIN [abolfazl] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[customerPhone]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[customerPhone] (@customer nvarchar(50))
returns nvarchar(11)
as
begin

return(
	select Customer.phone
	from Customer
	where Customer.fullName = @customer
)

end
GO
/****** Object:  UserDefinedFunction [dbo].[lockerNumber]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[lockerNumber](@customer nvarchar(50))
returns int
as
begin

return(
select Locker.number
from Locker
inner join Customer
on
Customer.id = Locker.customer_id
)

end
GO
/****** Object:  UserDefinedFunction [dbo].[numberOfLockers]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[numberOfLockers]()
returns int
as 
begin
	return( 
	select count(Locker.id)
	from Locker
	)
end
GO
/****** Object:  UserDefinedFunction [dbo].[numberOfMachineDamages]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[numberOfMachineDamages] (@machine int)
returns int
as
begin

return (
	select count(Damage_Report.id)
	from Damage_Report
	inner join machine
	on Machine.id = Damage_Report.machine_id
)

end


GO
/****** Object:  UserDefinedFunction [dbo].[numberOfMachines]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[numberOfMachines]()
returns int
as 
begin
	return( 
	select count(Machine.id)
	from Machine
	)
end
GO
/****** Object:  Table [dbo].[Damage_Report]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Damage_Report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NOT NULL,
	[machine_id] [int] NOT NULL,
	[reportDate] [datetime] NOT NULL,
	[who] [nvarchar](50) NULL,
	[detail] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[theWorstMachine]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[theWorstMachine] ()
returns table
as
return
	select count(Damage_Report.id) as damages
	from Damage_Report
	group by Damage_Report.machine_id
GO
/****** Object:  Table [dbo].[Trainer]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trainer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[manager_id] [int] NOT NULL,
	[fullName] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](11) NOT NULL,
	[address] [nvarchar](max) NULL,
	[ssn] [varchar](10) NOT NULL,
	[degree] [nvarchar](50) NULL,
	[hourlySalary] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[trainersList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[trainersList_view] as
select fullName from Trainer
GO
/****** Object:  Table [dbo].[Locker]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locker](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[number] [int] NOT NULL,
	[lastUse] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[lockersList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[lockersList_view] as

select * from Locker
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Machine](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[lastFix] [date] NULL,
	[timePerPerson] [time](7) NULL,
	[condition] [nvarchar](10) NULL,
	[detail] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[machinesList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[machinesList_view] as

select * from Machine
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullName] [nvarchar](50) NOT NULL,
	[ssn] [varchar](10) NOT NULL,
	[phone] [varchar](11) NOT NULL,
	[address] [nvarchar](max) NULL,
	[registerDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[customersList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[customersList_view] as

select fullName, phone from Customer
GO
/****** Object:  Table [dbo].[Customer_Report]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[reportDate] [date] NOT NULL,
	[bloodPressure] [int] NULL,
	[height] [int] NULL,
	[weight] [int] NULL,
	[calloriesBurnedPerMonth] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[customersReportList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[customersReportList_view] as

select * from Customer_Report
GO
/****** Object:  Table [dbo].[Advice]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trainer_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[writtenDate] [datetime] NOT NULL,
	[training] [nvarchar](50) NULL,
	[period] [nvarchar](50) NULL,
	[routine] [nvarchar](50) NULL,
	[time] [time](7) NULL,
	[detail] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[advicesList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[advicesList_view] as
select * from Advice
GO
/****** Object:  Table [dbo].[Exercise]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exercise](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[machine_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[exercisesList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[exercisesList_view] as
select * from Exercise
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[manager_id] [int] NOT NULL,
	[fullName] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](11) NOT NULL,
	[address] [nvarchar](max) NULL,
	[ssn] [varchar](10) NOT NULL,
	[monthlySalary] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[employeesList_view]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[employeesList_view] as
select * from Employee
GO
/****** Object:  Table [dbo].[Company]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[phone] [varchar](11) NOT NULL,
	[address] [nvarchar](max) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullName] [nvarchar](50) NOT NULL,
	[phone] [varchar](11) NOT NULL,
	[ssn] [varchar](10) NOT NULL,
	[address] [nvarchar](max) NULL,
	[monthlySalary] [money] NOT NULL,
 CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Advice]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Advice]  WITH CHECK ADD FOREIGN KEY([trainer_id])
REFERENCES [dbo].[Trainer] ([id])
GO
ALTER TABLE [dbo].[Customer_Report]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Damage_Report]  WITH CHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Damage_Report]  WITH CHECK ADD FOREIGN KEY([machine_id])
REFERENCES [dbo].[Machine] ([id])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[Manager] ([id])
GO
ALTER TABLE [dbo].[Exercise]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Exercise]  WITH CHECK ADD FOREIGN KEY([machine_id])
REFERENCES [dbo].[Machine] ([id])
GO
ALTER TABLE [dbo].[Locker]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Machine]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[Company] ([id])
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[Manager] ([id])
GO
/****** Object:  StoredProcedure [dbo].[insertDamageReport]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[insertDamageReport]
(@employee int, @machine int, @reportDate datetime, @who nvarchar(50), @detail nvarchar(max))

as

insert into Damage_Report
(employee_id, machine_id, reportDate, who, detail)
values
(@employee, @machine, @reportDate, @who, @detail)


GO
/****** Object:  StoredProcedure [dbo].[selcetExercise_customer]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selcetExercise_customer] @customer int

as
select machine.name ,Exercise.date, Exercise.time
from Exercise
inner join Machine
on Machine.id = Exercise.machine_id
where customer_id = @customer
GO
/****** Object:  StoredProcedure [dbo].[selcetExercise_machine]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selcetExercise_machine] @machine int

as
select Customer.fullName, Customer.phone ,Exercise.date, Exercise.time
from Exercise
inner join Machine
on Machine.id = Exercise.machine_id
inner join Customer
on Customer.id = Exercise.customer_id
where customer_id = @machine
GO
/****** Object:  StoredProcedure [dbo].[selectAdvices_customer]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectAdvices_customer] @customer int
as
select * from Advice
where customer_id = @customer
GO
/****** Object:  StoredProcedure [dbo].[selectAdvices_trainer]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectAdvices_trainer] @trainer int
as
select * from Advice
where trainer_id = @trainer
GO
/****** Object:  StoredProcedure [dbo].[selectCustomerReport]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectCustomerReport] @customer int
as
select reportDate, bloodPressure, height, weight, calloriesBurnedPerMonth from Customer_Report
where customer_id = @customer
GO
/****** Object:  StoredProcedure [dbo].[selectLocker]    Script Date: 2020-07-17 3:30:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectLocker] @customer int
as
select * from Locker
where Locker.customer_id = @customer
GO
USE [master]
GO
ALTER DATABASE [Sport Club] SET  READ_WRITE 
GO
