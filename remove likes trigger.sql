USE [social]
GO
/****** Object:  Trigger [dbo].[remove_likes]    Script Date: 7/29/2021 1:37:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[remove_likes] on [dbo].[post_likes]
After Delete
As
BEGIN
Declare @postId INT
Declare @currentLikes INT
select @postId = postId from deleted
select  @currentLikes = totalLikes from user_posts Where postId = @postId
	update user_posts
		set totalLikes = @currentLikes - 1 where postId = @postId
END
