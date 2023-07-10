USE [master]
GO
/****** Object:  Database [ChatApp_oneToOne]    Script Date: 08-07-2023 10:01:10 ******/
CREATE DATABASE [ChatApp_oneToOne]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ChatApp_oneToOne', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQL2019\MSSQL\DATA\ChatApp_oneToOne.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ChatApp_oneToOne_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQL2019\MSSQL\DATA\ChatApp_oneToOne_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ChatApp_oneToOne] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ChatApp_oneToOne].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ChatApp_oneToOne] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET ARITHABORT OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ChatApp_oneToOne] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ChatApp_oneToOne] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ChatApp_oneToOne] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ChatApp_oneToOne] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ChatApp_oneToOne] SET  MULTI_USER 
GO
ALTER DATABASE [ChatApp_oneToOne] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ChatApp_oneToOne] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ChatApp_oneToOne] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ChatApp_oneToOne] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ChatApp_oneToOne] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ChatApp_oneToOne] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ChatApp_oneToOne] SET QUERY_STORE = OFF
GO
USE [ChatApp_oneToOne]
GO
/****** Object:  Table [dbo].[Conversations]    Script Date: 08-07-2023 10:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user1] [int] NOT NULL,
	[user2] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 08-07-2023 10:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[conversation_id] [int] NOT NULL,
	[author] [int] NOT NULL,
	[content] [varchar](max) NOT NULL,
	[timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08-07-2023 10:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[image_url] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Conversations] ON 

INSERT [dbo].[Conversations] ([id], [user1], [user2]) VALUES (1, 1, 2)
INSERT [dbo].[Conversations] ([id], [user1], [user2]) VALUES (2, 1, 3)
SET IDENTITY_INSERT [dbo].[Conversations] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (1, 1, 1, N'Hello user2!', CAST(N'2023-07-07T15:39:06.517' AS DateTime))
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (2, 1, 2, N'Hi user1, how are you?', CAST(N'2023-07-07T15:39:06.517' AS DateTime))
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (3, 2, 1, N'Hey user3, how is it going?', CAST(N'2023-07-07T15:39:06.517' AS DateTime))
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (4, 2, 3, N'Hey Nirmal, how is it going?', CAST(N'2023-07-07T16:28:49.710' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (1, N'Nirmal', N'password1', N'https://tse2.mm.bing.net/th/id/OIP.QsTQiIXafX4lsEPvCmognAHaHS?w=212&h=208&c=7&r=0&o=5&pid=1.7')
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (2, N'Pradumna', N'password2', N'https://tse2.mm.bing.net/th/id/OIP.QsTQiIXafX4lsEPvCmognAHaHS?w=212&h=208&c=7&r=0&o=5&pid=1.7')
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (3, N'Jay', N'password3', N'https://tse2.mm.bing.net/th/id/OIP.QsTQiIXafX4lsEPvCmognAHaHS?w=212&h=208&c=7&r=0&o=5&pid=1.7')
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (4, N'Choti', N'00000000', N'https://tse2.mm.bing.net/th/id/OIP.QsTQiIXafX4lsEPvCmognAHaHS?w=212&h=208&c=7&r=0&o=5&pid=1.7')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD FOREIGN KEY([user1])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD FOREIGN KEY([user2])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([author])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([conversation_id])
REFERENCES [dbo].[Conversations] ([id])
GO
USE [master]
GO
ALTER DATABASE [ChatApp_oneToOne] SET  READ_WRITE 
GO
