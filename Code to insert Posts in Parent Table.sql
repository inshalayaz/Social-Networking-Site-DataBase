
Declare @counter INT
set @counter = 1

WHILE(@counter <= 52)
BEGIN
	declare @totalPosts INT
	declare @userId INT

	select @userId = userId from user_posts where userId = @counter
	select @totalPosts = count(postId) from user_posts where userId = @userId

	update users 
		set noOfPosts = @totalPosts Where users.userId = @userId
	set @counter = @counter + 1

END