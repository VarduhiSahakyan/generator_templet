USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Administrator SpardaBank'; 
SET @roleName = 'ADMIN_SPARDA'; 

INSERT INTO `ROLE` (`ROLE_DESCRIPTION`, `ROLE_NAME`, `ROLE_PROTECTED`)
VALUES (@roleDescription, @roleName, false);



USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Agent SpardaBank'; 
SET @roleName = 'AGENT_SPARDA'; 

INSERT INTO `ROLE` (`ROLE_DESCRIPTION`, `ROLE_NAME`, `ROLE_PROTECTED`)
VALUES (@roleDescription, @roleName, false);



USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Super Admin SpardaBank'; 
SET @roleName = 'SUPER_ADMIN_SPARDA'; 

INSERT INTO `ROLE` (`ROLE_DESCRIPTION`, `ROLE_NAME`, `ROLE_PROTECTED`)
VALUES (@roleDescription, @roleName, false);
