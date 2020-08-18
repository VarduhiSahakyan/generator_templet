USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Administrator SpardaBank'; 
SET @roleName = 'ADMIN_SPARDA'; 

SET @roleParentId = (SELECT ROLE_ID FROM `ROLE` WHERE ROLE_NAME="ADMIN_WORLDLINE");

INSERT INTO `ROLE` (`ROLE_DESCRIPTION`, `ROLE_NAME`, `ROLE_PROTECTED`, `ROLE_PARENT`)
VALUES (@roleDescription, @roleName, false, @roleParentId);



USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Agent SpardaBank'; 
SET @roleName = 'AGENT_SPARDA'; 

SET @roleParentId = (SELECT ROLE_ID FROM `ROLE` WHERE ROLE_NAME="ADMIN_WORLDLINE");

INSERT INTO `ROLE` (`ROLE_DESCRIPTION`, `ROLE_NAME`, `ROLE_PROTECTED`, `ROLE_PARENT`)
VALUES (@roleDescription, @roleName, false, @roleParentId);



USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Super Admin SpardaBank'; 
SET @roleName = 'SUPER_ADMIN_SPARDA'; 

SET @roleParentId = (SELECT ROLE_ID FROM `ROLE` WHERE ROLE_NAME="ADMIN_WORLDLINE");

INSERT INTO `ROLE` (`ROLE_DESCRIPTION`, `ROLE_NAME`, `ROLE_PROTECTED`, `ROLE_PARENT`)
VALUES (@roleDescription, @roleName, false, @roleParentId);
