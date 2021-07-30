CREATE TRIGGER increase_post_like
on post_likes
after insert
As
Begin 

Declare @postId INT
Declare @currentLikes INT
select @postId = postId from inserted 
select  @currentLikes = totalLikes from user_posts Where postId = @postId
	update user_posts
		set totalLikes = @currentLikes + 1 where postId = @postId
		
End