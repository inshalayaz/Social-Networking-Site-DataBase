
select users.username,users.userId, msg.messageId, msg.sourceId, msg.targetId,msg.userMessage
from users
inner join user_message as msg
on msg.sourceId = users.userId 
where msg.sourceId = 19 and msg.targetId = 3 or msg.sourceId = 3 and msg.targetId = 19

create FUNCTION display_chat(@sourceId INT, @targetId INT)
RETURNS TABLE
AS 
RETURN(
	select users.username,users.userId, msg.messageId, msg.sourceId, msg.targetId,msg.userMessage
	from users
	inner join user_message as msg
	on msg.sourceId = users.userId 
	where msg.sourceId = @sourceId and msg.targetId = @targetId or msg.sourceId = @targetId and msg.targetId = @sourceId
)

select * from dbo.display_chat(19,3)