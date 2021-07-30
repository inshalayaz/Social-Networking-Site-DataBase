CREATE TRIGGER remove_like on post_likes
after delete
as 
begin 

Declare @postId INT
Declare @currentLikes INT
select @postId = postId from inserted 
select  @currentLikes = totalLikes from user_posts Where postId = @postId
	update user_posts
		set totalLikes = @currentLikes - 1 where postId = @postId

end
select * from user_posts