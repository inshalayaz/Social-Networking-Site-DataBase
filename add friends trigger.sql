create trigger increase_friends on user_friends
after insert
As
Begin

Declare @sourceId INT
Declare @targetId Int
Declare @currentFriends1 INT
Declare @currentFriends2 INT
select @sourceId = sourceId from inserted 
select @targetId = targetId from inserted 

select  @currentFriends1 = totalFriends from users Where @sourceId = userId
select  @currentFriends2 = totalFriends from users Where @targetId = userId
	update users
		set totalFriends = @currentFriends1 + 1 where @sourceId = userId
	update users
		set totalFriends = @currentFriends2 + 1 where @targetId = 

End