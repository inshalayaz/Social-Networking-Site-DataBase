select users.username, users.email, user_posts.postId,user_posts.userMessages as "Post",user_posts.totalLikes
FROM users
INNER JOIN user_posts
on user_posts.userId = users.userId
where users.userId = 1

CREATE FUNCTION getUserPosts(@userId INT)
RETURNS TABLE
AS 
RETURN(
	select users.username, users.email, user_posts.postId,user_posts.userMessages,user_posts.totalLikes
	FROM users
	INNER JOIN user_posts
	on user_posts.userId = users.userId
	where users.userId = @userId
)

select * from dbo.getUserPosts(2)