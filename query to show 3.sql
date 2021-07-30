select users.userId, users.username,group_followers.groupId as "Groups Followed", social_group.title as "Group Name", social_group.details ,social_group.createdBy as "Group Creator ID"
FROM users
INNER JOIN group_followers
ON users.userId = group_followers.userId 
Inner JOIN social_group
ON group_followers.groupId = social_group.groupId 
Where users.userId = 4

CREATE FUNCTION userFollowedGroups(@userId INT)
RETURNS TABLE
RETURN(
select users.userId, users.username,group_followers.groupId as "Groups Followed", social_group.title as "Group Name", social_group.details ,social_group.createdBy as "Group Creator ID"
FROM users
INNER JOIN group_followers
ON users.userId = group_followers.userId 
Inner JOIN social_group
ON group_followers.groupId = social_group.groupId 
Where users.userId = @userId
)


select * from dbo.userFollowedGroups(4)

--select * from group_followers where userId = 4
--INNER JOIN social_group
--ON group_follower.groupId = social_group.groupId

--ON group_followers.userId = users.userId 
--WHERE users.userId = 4 and @groupId = 4

--select * from group_followers where groupId = 1