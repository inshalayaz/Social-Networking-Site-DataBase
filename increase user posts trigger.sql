CREATE TRIGGER add_posts on user_posts
After Insert
AS
BEGIN
	Declare @userId INT
	Declare @currentPosts INT
	select @userId = userId from inserted 
	select  @currentPosts = noOfPosts from users Where userId = @userId
	update users
		set noOfPosts = @currentPosts + 1 where userId = @userId
END



