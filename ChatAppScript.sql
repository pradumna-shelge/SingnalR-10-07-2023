USE [master]
GO
/****** Object:  Database [ChatApp_oneToOne]    Script Date: 26-07-2023 13:48:04 ******/
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
/****** Object:  Table [dbo].[Conversations]    Script Date: 26-07-2023 13:48:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user1] [int] NULL,
	[user2] [int] NULL,
	[groupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 26-07-2023 13:48:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](50) NULL,
	[CreatedBy] [int] NULL,
	[image_url] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupMember]    Script Date: 26-07-2023 13:48:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMember](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 26-07-2023 13:48:05 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 26-07-2023 13:48:05 ******/
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
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (12, 11, 10, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (13, 12, 10, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (14, 12, 11, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (17, 10, 13, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (18, NULL, NULL, 4)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (19, 10, 16, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (20, 11, 16, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (21, 12, 16, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (22, 13, 16, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (24, 13, 11, NULL)
GO
INSERT [dbo].[Conversations] ([id], [user1], [user2], [groupId]) VALUES (25, NULL, NULL, 6)
GO
SET IDENTITY_INSERT [dbo].[Conversations] OFF
GO
SET IDENTITY_INSERT [dbo].[Group] ON 
GO
INSERT [dbo].[Group] ([Id], [GroupName], [CreatedBy], [image_url]) VALUES (4, N'MyGroup', 10, N'https://static.theprint.in/wp-content/uploads/2023/07/pm-modi-in-17th-ICC.jpg')
GO
INSERT [dbo].[Group] ([Id], [GroupName], [CreatedBy], [image_url]) VALUES (5, N'', 11, N'')
GO
INSERT [dbo].[Group] ([Id], [GroupName], [CreatedBy], [image_url]) VALUES (6, N'Family', 11, N'data:image/jpeg;base64,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')
GO
SET IDENTITY_INSERT [dbo].[Group] OFF
GO
SET IDENTITY_INSERT [dbo].[GroupMember] ON 
GO
INSERT [dbo].[GroupMember] ([Id], [GroupId], [UserId]) VALUES (7, 4, 13)
GO
INSERT [dbo].[GroupMember] ([Id], [GroupId], [UserId]) VALUES (8, 4, 11)
GO
INSERT [dbo].[GroupMember] ([Id], [GroupId], [UserId]) VALUES (9, 4, 10)
GO
INSERT [dbo].[GroupMember] ([Id], [GroupId], [UserId]) VALUES (14, 6, 13)
GO
INSERT [dbo].[GroupMember] ([Id], [GroupId], [UserId]) VALUES (15, 6, 11)
GO
SET IDENTITY_INSERT [dbo].[GroupMember] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (38, 12, 10, N'i am Nirmal', CAST(N'2023-07-11T15:13:32.813' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (39, 12, 11, N'i am boss', CAST(N'2023-07-11T15:13:40.443' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (40, 12, 11, N'hello', CAST(N'2023-07-11T15:14:59.177' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (41, 12, 10, N'hellu meri awaz aa rhi hai', CAST(N'2023-07-11T15:15:23.520' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (42, 12, 11, N'nai aa rhi', CAST(N'2023-07-11T15:15:33.397' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (43, 12, 10, N'Hello', CAST(N'2023-07-11T15:35:54.213' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (44, 12, 10, N'Heyy', CAST(N'2023-07-11T15:38:44.537' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (45, 12, 10, N'hello', CAST(N'2023-07-11T15:49:24.457' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (46, 12, 10, N'Scroll Done', CAST(N'2023-07-11T15:49:34.313' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (47, 12, 10, N'Sibten', CAST(N'2023-07-11T15:49:41.557' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (48, 13, 10, N'hii sibu', CAST(N'2023-07-11T17:22:46.873' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (49, 17, 13, N'hii pradumna', CAST(N'2023-07-12T12:07:11.793' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (50, 17, 10, N'hello choti', CAST(N'2023-07-12T12:07:21.860' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (51, 17, 10, N'hi', CAST(N'2023-07-12T12:07:38.443' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (52, 17, 10, N'hii', CAST(N'2023-07-12T12:07:49.337' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (53, 17, 10, N'hii', CAST(N'2023-07-12T12:09:06.040' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (54, 17, 13, N'hi', CAST(N'2023-07-12T12:09:10.593' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (55, 18, 10, N'hi', CAST(N'2023-07-12T12:10:18.240' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (56, 17, 13, N'Hii', CAST(N'2023-07-12T12:11:58.190' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (57, 17, 10, N'huu', CAST(N'2023-07-12T12:13:04.813' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (58, 17, 13, N'hiii', CAST(N'2023-07-12T12:13:46.427' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (59, 17, 13, N'lhiu', CAST(N'2023-07-12T12:18:07.863' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (60, 17, 13, N'1', CAST(N'2023-07-12T12:18:23.057' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (61, 17, 10, N'2', CAST(N'2023-07-12T12:20:00.650' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (62, 17, 13, N'2', CAST(N'2023-07-12T12:20:03.080' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (63, 17, 13, N'5', CAST(N'2023-07-12T12:20:04.250' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (64, 17, 13, N'2', CAST(N'2023-07-12T12:20:04.490' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (65, 17, 13, N'2', CAST(N'2023-07-12T12:20:04.730' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (66, 17, 13, N'2', CAST(N'2023-07-12T12:20:04.953' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (67, 17, 13, N'254', CAST(N'2023-07-12T12:20:07.297' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (68, 17, 13, N'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Vitae ad architecto praesentium maiores iusto ex minus aut? Beatae repellat obcaecati voluptate, optio reprehenderit officiis possimus porro doloribus consequatur laudantium nemo! Perspiciatis tempore facere molestiae tempora nisi perferendis cupiditate nostrum illo provident, obcaecati libero debitis ab reiciendis eum? Suscipit, commodi. Incidunt error adipisci consequuntur at cumque magni natus recusandae ut maiores.', CAST(N'2023-07-12T13:28:41.970' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (69, 18, 13, N'hii', CAST(N'2023-07-12T13:53:35.687' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (70, 18, 13, N'hiii', CAST(N'2023-07-12T13:54:30.603' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (71, 22, 13, N'Hii choti', CAST(N'2023-07-12T14:02:29.243' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (72, 22, 16, N'Hii Mark', CAST(N'2023-07-12T14:02:40.193' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (73, 22, 13, N'Kya kar rahi hai', CAST(N'2023-07-12T14:03:02.750' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (74, 18, 11, N'hiii chalo', CAST(N'2023-07-12T14:05:09.110' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (75, 18, 13, N'g', CAST(N'2023-07-12T14:16:44.967' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (76, 18, 11, N'hii', CAST(N'2023-07-12T14:46:33.290' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (77, 18, 10, N'hi am pradumna', CAST(N'2023-07-12T15:50:46.460' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (78, 18, 10, N'hiiii', CAST(N'2023-07-12T15:51:17.767' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (79, 18, 10, N'hii', CAST(N'2023-07-12T15:54:21.027' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (80, 12, 11, N'Hii', CAST(N'2023-07-12T16:14:51.027' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (81, 18, 11, N'Hii', CAST(N'2023-07-12T16:15:02.107' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (82, 18, 11, N'Hello', CAST(N'2023-07-12T16:15:12.047' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (83, 12, 10, N'hi', CAST(N'2023-07-12T16:54:38.987' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (84, 12, 10, N'Hello', CAST(N'2023-07-12T16:55:21.883' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (85, 12, 10, N'Heyy', CAST(N'2023-07-12T16:58:42.907' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (86, 12, 10, N'Hello', CAST(N'2023-07-12T17:01:32.480' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (87, 12, 10, N'Hello', CAST(N'2023-07-12T17:04:05.603' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (88, 18, 11, N'Hii all', CAST(N'2023-07-12T17:08:07.203' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (89, 18, 13, N'Hyyyyyy', CAST(N'2023-07-12T17:12:04.210' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (90, 18, 13, N'Hyyy', CAST(N'2023-07-12T17:13:00.367' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (91, 18, 13, N'Hemllooo', CAST(N'2023-07-12T17:13:35.767' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (92, 18, 10, N'Hemmmm', CAST(N'2023-07-12T17:13:45.823' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (93, 18, 10, N'jahar', CAST(N'2023-07-12T17:17:59.860' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (94, 18, 13, N'sending something', CAST(N'2023-07-12T17:19:31.070' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (95, 18, 13, N'd', CAST(N'2023-07-12T17:21:30.793' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (96, 18, 13, N'gi', CAST(N'2023-07-12T17:22:12.303' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (97, 18, 13, N'ggg', CAST(N'2023-07-12T17:22:22.967' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (98, 18, 10, N'g', CAST(N'2023-07-12T17:22:50.817' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (99, 17, 10, N'Heyy Choti', CAST(N'2023-07-12T17:25:14.880' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (100, 17, 10, N'Hey v', CAST(N'2023-07-12T17:25:29.480' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (101, 17, 10, N'ee', CAST(N'2023-07-12T17:27:15.947' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (102, 12, 10, N'hi', CAST(N'2023-07-12T17:32:32.247' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (103, 17, 13, N'hi', CAST(N'2023-07-12T17:32:54.010' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (104, 17, 10, N'hi', CAST(N'2023-07-12T17:32:59.660' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (105, 22, 13, N'hi', CAST(N'2023-07-12T17:33:06.707' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (106, 17, 10, N'hi', CAST(N'2023-07-12T17:33:10.753' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (107, 18, 10, N'hi', CAST(N'2023-07-12T17:33:35.347' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (108, 18, 10, N'group', CAST(N'2023-07-12T17:33:40.243' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (109, 18, 10, N'hi ii', CAST(N'2023-07-12T17:33:47.857' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (110, 18, 10, N'yo yo ', CAST(N'2023-07-12T17:38:39.040' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (111, 18, 13, N'yo bro', CAST(N'2023-07-12T17:38:46.217' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (112, 18, 11, N'yooo bros', CAST(N'2023-07-12T17:39:07.220' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (113, 24, 11, N'hiii where are you', CAST(N'2023-07-12T17:43:09.200' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (114, 24, 13, N'at home ! why ???', CAST(N'2023-07-12T17:43:24.303' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (115, 25, 11, N'hiii bacho', CAST(N'2023-07-12T17:44:29.390' AS DateTime))
GO
INSERT [dbo].[Messages] ([id], [conversation_id], [author], [content], [timestamp]) VALUES (116, 25, 13, N'hiii', CAST(N'2023-07-12T17:45:02.317' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (10, N'pradumna', N'11111111', N'https://media.licdn.com/dms/image/C4D03AQGnnyzRWy7h6A/profile-displayphoto-shrink_800_800/0/1652931232954?e=2147483647&v=beta&t=NiyUdG5SuwJqMCgHV5xzfxcTBd8F0cK-xWAnNE-N-oM')
GO
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (11, N'Nirmal', N'11111111', N'https://media.licdn.com/dms/image/D4D03AQF3DtPoAORTHQ/profile-displayphoto-shrink_800_800/0/1667391845019?e=2147483647&v=beta&t=H_1YnLaCIP0oMupIatiZ-KOZbLYl6bYU8Av_yE06lEk')
GO
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (12, N'sibu', N'11111111', N'https://media.licdn.com/dms/image/C4D03AQHxbYeE-IhtXw/profile-displayphoto-shrink_800_800/0/1654935041754?e=2147483647&v=beta&t=eXudwZFhIE9AIQtPJRm45RVSSYhX5u3Y5sbJtlLjsIk')
GO
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (13, N'Choti', N'11111111', N'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Young_girl_smiling_in_sunshine_%282%29.jpg/1200px-Young_girl_smiling_in_sunshine_%282%29.jpg')
GO
INSERT [dbo].[Users] ([id], [username], [password], [image_url]) VALUES (16, N'markz', N'11111111', N'https://qph.cf2.quoracdn.net/main-qimg-c79d8425c2c42b699d44fe34524ddda0-lq')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD FOREIGN KEY([groupId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD FOREIGN KEY([user1])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD FOREIGN KEY([user2])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD  CONSTRAINT [FK_Conversations_User1] FOREIGN KEY([user1])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Conversations] CHECK CONSTRAINT [FK_Conversations_User1]
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD  CONSTRAINT [FK_Conversations_User2] FOREIGN KEY([user2])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Conversations] CHECK CONSTRAINT [FK_Conversations_User2]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[GroupMember]  WITH CHECK ADD FOREIGN KEY([GroupId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[GroupMember]  WITH CHECK ADD FOREIGN KEY([UserId])
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
