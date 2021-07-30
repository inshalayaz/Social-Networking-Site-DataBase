CREATE TRIGGER increase_posts on group_post
AFTER INSERT
AS
BEGIN
Declare @memberId INT
Declare @currentPosts INT
select @memberId = memberId from inserted 
select  @currentPosts = totalPosts from group_member Where memberId = @memberId
	update group_member
		set totalPosts = @currentPosts + 1 where memberId = @memberId
END
