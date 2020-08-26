USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Administrator SpardaBank' COLLATE utf8_unicode_ci; 
SET @roleName = 'ADMIN_SPARDA' COLLATE utf8_unicode_ci; 


DELETE FROM ROLE WHERE ROLE_DESCRIPTION=@roleDescription AND ROLE_NAME=@roleName AND ROLE_PROTECTED=false;


USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Agent SpardaBank' COLLATE utf8_unicode_ci; 
SET @roleName = 'AGENT_SPARDA' COLLATE utf8_unicode_ci; 

DELETE FROM ROLE WHERE ROLE_DESCRIPTION=@roleDescription AND ROLE_NAME=@roleName AND ROLE_PROTECTED=false;



USE PORTAL_SERVICE_PARAM;

SET @roleDescription = 'Super Admin SpardaBank' COLLATE utf8_unicode_ci; 
SET @roleName = 'SUPER_ADMIN_SPARDA' COLLATE utf8_unicode_ci; 