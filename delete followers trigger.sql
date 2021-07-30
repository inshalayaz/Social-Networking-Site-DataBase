Create Trigger remove_followers on user_followers
after insert 
As
Begin
Declare @sourceId INT
Declare @targetId Int
Declare @currentFollowers INT
select @sourceId = sourceId from deleted
select @targetId = targetId from deleted

select  @currentFollowers = totalFollowers from users Where @targetId = userId
	update users
		set totalFollowers = @currentFollowers - 1 where @targetId = userId


END
