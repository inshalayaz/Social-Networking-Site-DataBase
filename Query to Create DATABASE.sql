USE [master]
GO
/****** Object:  Database [social]    Script Date: 7/30/2021 6:41:03 PM ******/
CREATE DATABASE [social]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'social', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.INSHAL\MSSQL\DATA\social.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'social_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.INSHAL\MSSQL\DATA\social_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [social] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [social].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [social] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [social] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [social] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [social] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [social] SET ARITHABORT OFF 
GO
ALTER DATABASE [social] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [social] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [social] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [social] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [social] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [social] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [social] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [social] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [social] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [social] SET  ENABLE_BROKER 
GO
ALTER DATABASE [social] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [social] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [social] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [social] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [social] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [social] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [social] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [social] SET RECOVERY FULL 
GO
ALTER DATABASE [social] SET  MULTI_USER 
GO
ALTER DATABASE [social] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [social] SET DB_CHAINING OFF 
GO
ALTER DATABASE [social] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [social] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [social] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [social] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'social', N'ON'
GO
ALTER DATABASE [social] SET QUERY_STORE = OFF
GO
USE [social]
GO
/****** Object:  UserDefinedFunction [dbo].[totalGroupFollowers]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[totalGroupFollowers](@groupId INT)
RETURNS int
BEGIN
	Return (select count(groupId) as "Total Followers" from group_followers WHERE groupId = 33 )
	
END
GO
/****** Object:  Table [dbo].[users]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[userId] [bigint] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](50) NULL,
	[middleName] [varchar](50) NULL,
	[lastName] [nvarchar](50) NULL,
	[mobile] [varchar](15) NULL,
	[email] [varchar](50) NULL,
	[passwordHash] [varchar](255) NULL,
	[username] [nchar](30) NULL,
	[registeredAt] [datetime] NULL,
	[lastLogin] [datetime] NULL,
	[profileDescription] [varchar](50) NULL,
	[noOfPosts] [int] NULL,
	[profilePicture] [varchar](100) NULL,
	[totalFollowers] [int] NULL,
	[totalFriends] [int] NULL,
 CONSTRAINT [PK__users__CB9A1CFF7B35A3EA] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_MyTable_Email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_friends]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_friends](
	[friendId] [bigint] IDENTITY(1,1) NOT NULL,
	[sourceId] [bigint] NOT NULL,
	[targetId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[friendId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[calculate_friends]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[calculate_friends](@userId int)
RETURNS TABLE
AS 

	RETURN(
		select users.userId, count(friends.friendId) as 'totalFriends'
FROM users 
Inner Join user_friends AS friends
ON users.userId = friends.sourceId
WHERE users.userId = @userId
GROUP BY users.userId
	)
GO
/****** Object:  Table [dbo].[user_posts]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_posts](
	[postId] [bigint] IDENTITY(1,1) NOT NULL,
	[userId] [bigint] NOT NULL,
	[userMessages] [varchar](255) NULL,
	[totalLikes] [bigint] NULL,
	[createAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getUserPosts]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[getUserPosts](@userId INT)
RETURNS TABLE
AS 
RETURN(
	select users.username, users.email, user_posts.postId,user_posts.userMessages,user_posts.totalLikes
	FROM users
	INNER JOIN user_posts
	on user_posts.userId = users.userId
	where users.userId = @userId
)
GO
/****** Object:  Table [dbo].[user_message]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_message](
	[messageId] [bigint] IDENTITY(1,1) NOT NULL,
	[sourceId] [bigint] NOT NULL,
	[targetId] [bigint] NOT NULL,
	[userMessage] [text] NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[messageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[display_chat]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[display_chat](@sourceId INT, @targetId INT)
RETURNS TABLE
AS 
RETURN(
	select users.username,users.userId, msg.messageId, msg.sourceId, msg.targetId,msg.userMessage
	from users
	inner join user_message as msg
	on msg.sourceId = users.userId 
	where msg.sourceId = @sourceId and msg.targetId = @targetId or msg.sourceId = @targetId and msg.targetId = @sourceId
)
GO
/****** Object:  Table [dbo].[social_group]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[social_group](
	[groupId] [bigint] IDENTITY(1,1) NOT NULL,
	[createdBy] [bigint] NULL,
	[title] [varchar](50) NULL,
	[details] [text] NULL,
	[groupStatus] [varchar](8) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[groupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[group_followers]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[group_followers](
	[groupFollowerId] [bigint] IDENTITY(1,1) NOT NULL,
	[groupId] [bigint] NOT NULL,
	[userId] [bigint] NOT NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[groupFollowerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[userFollowedGroups]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[userFollowedGroups](@userId INT)
RETURNS TABLE
RETURN(
select users.userId, users.username,group_followers.groupId as "Groups Followed", social_group.title as "Group Name", social_group.details ,social_group.createdBy as "Group Creator ID"
FROM users
INNER JOIN group_followers
ON users.userId = group_followers.userId 
Inner JOIN social_group
ON group_followers.groupId = social_group.groupId 
Where users.userId = @userId
)
GO
/****** Object:  Table [dbo].[group_member]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[group_member](
	[memberId] [bigint] IDENTITY(1,1) NOT NULL,
	[groupId] [bigint] NOT NULL,
	[userId] [bigint] NOT NULL,
	[joinedAt] [datetime] NULL,
	[updaredAt] [datetime] NULL,
	[totalPosts] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[group_post]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[group_post](
	[postId] [bigint] IDENTITY(1,1) NOT NULL,
	[groupId] [bigint] NOT NULL,
	[memberId] [bigint] NOT NULL,
	[post] [varchar](255) NULL,
 CONSTRAINT [PK__group_po__DD0C739A2B3C655E] PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[post_likes]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[post_likes](
	[likeId] [bigint] IDENTITY(1,1) NOT NULL,
	[postId] [bigint] NOT NULL,
	[userId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[likeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_followers]    Script Date: 7/30/2021 6:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_followers](
	[followerId] [bigint] IDENTITY(1,1) NOT NULL,
	[sourceId] [bigint] NOT NULL,
	[targetId] [bigint] NOT NULL,
	[status] [varchar](8) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[followerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[group_member] ADD  CONSTRAINT [DF_group_member_totalPosts]  DEFAULT ((0)) FOR [totalPosts]
GO
ALTER TABLE [dbo].[group_followers]  WITH CHECK ADD  CONSTRAINT [fk_gfollowers_group] FOREIGN KEY([groupId])
REFERENCES [dbo].[social_group] ([groupId])
GO
ALTER TABLE [dbo].[group_followers] CHECK CONSTRAINT [fk_gfollowers_group]
GO
ALTER TABLE [dbo].[group_followers]  WITH CHECK ADD  CONSTRAINT [fk_gfollowers_user] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[group_followers] CHECK CONSTRAINT [fk_gfollowers_user]
GO
ALTER TABLE [dbo].[group_member]  WITH CHECK ADD  CONSTRAINT [fk_member_group] FOREIGN KEY([groupId])
REFERENCES [dbo].[social_group] ([groupId])
GO
ALTER TABLE [dbo].[group_member] CHECK CONSTRAINT [fk_member_group]
GO
ALTER TABLE [dbo].[group_member]  WITH CHECK ADD  CONSTRAINT [fk_member_user] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[group_member] CHECK CONSTRAINT [fk_member_user]
GO
ALTER TABLE [dbo].[group_post]  WITH CHECK ADD  CONSTRAINT [fk_post_group] FOREIGN KEY([groupId])
REFERENCES [dbo].[social_group] ([groupId])
GO
ALTER TABLE [dbo].[group_post] CHECK CONSTRAINT [fk_post_group]
GO
ALTER TABLE [dbo].[group_post]  WITH CHECK ADD  CONSTRAINT [fk_post_member] FOREIGN KEY([memberId])
REFERENCES [dbo].[group_member] ([memberId])
GO
ALTER TABLE [dbo].[group_post] CHECK CONSTRAINT [fk_post_member]
GO
ALTER TABLE [dbo].[post_likes]  WITH CHECK ADD  CONSTRAINT [fk_post] FOREIGN KEY([postId])
REFERENCES [dbo].[user_posts] ([postId])
GO
ALTER TABLE [dbo].[post_likes] CHECK CONSTRAINT [fk_post]
GO
ALTER TABLE [dbo].[post_likes]  WITH CHECK ADD  CONSTRAINT [fk_user] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[post_likes] CHECK CONSTRAINT [fk_user]
GO
ALTER TABLE [dbo].[user_followers]  WITH CHECK ADD  CONSTRAINT [fk_follower_source] FOREIGN KEY([sourceId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_followers] CHECK CONSTRAINT [fk_follower_source]
GO
ALTER TABLE [dbo].[user_followers]  WITH CHECK ADD  CONSTRAINT [fk_followers_target] FOREIGN KEY([targetId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_followers] CHECK CONSTRAINT [fk_followers_target]
GO
ALTER TABLE [dbo].[user_friends]  WITH CHECK ADD  CONSTRAINT [fk_follower_targer] FOREIGN KEY([targetId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_friends] CHECK CONSTRAINT [fk_follower_targer]
GO
ALTER TABLE [dbo].[user_friends]  WITH CHECK ADD  CONSTRAINT [fk_friend_source] FOREIGN KEY([sourceId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_friends] CHECK CONSTRAINT [fk_friend_source]
GO
ALTER TABLE [dbo].[user_friends]  WITH CHECK ADD  CONSTRAINT [fk_friend_targer] FOREIGN KEY([sourceId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_friends] CHECK CONSTRAINT [fk_friend_targer]
GO
ALTER TABLE [dbo].[user_friends]  WITH CHECK ADD  CONSTRAINT [fk_friends_targer] FOREIGN KEY([targetId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_friends] CHECK CONSTRAINT [fk_friends_targer]
GO
ALTER TABLE [dbo].[user_message]  WITH CHECK ADD  CONSTRAINT [fk_message_source] FOREIGN KEY([sourceId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_message] CHECK CONSTRAINT [fk_message_source]
GO
ALTER TABLE [dbo].[user_message]  WITH CHECK ADD  CONSTRAINT [fk_message_target] FOREIGN KEY([targetId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_message] CHECK CONSTRAINT [fk_message_target]
GO
ALTER TABLE [dbo].[user_posts]  WITH CHECK ADD  CONSTRAINT [fk_posts] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_posts] CHECK CONSTRAINT [fk_posts]
GO
USE [master]
GO
ALTER DATABASE [social] SET  READ_WRITE 
GO
