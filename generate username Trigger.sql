CREATE TRIGGER generate_username
on users
after insert
as
begin
update users
	/*Declare @username varchar(20)
	select @username = firstName from inserted 
	select @username = concat(@username, '01') */
	
	--insert into users(username) Values(@username)
	set username = LOWER(concat(firstName, lastName,(select count(userId) from users)))
	WHERE userId = (select userId from inserted)
end

INSERT INTO users VALUES('Gertrude','','Scott','(558)-487-7362','gertrude.scott@example.com','c1c7c32b99df6b2012904c76d83fa486','2008-06-20T19:26:52.994Z','','2008-06-20T19:26:52.994Z','Kaliningrad, South Africabologna',0,'https://randomuser.me/api/portraits/thumb/women/60.jpg', 0);