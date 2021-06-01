USE PORTAL_SERVICE_PARAM;

-- check existing 
SET @serviceName = 'ACS_U5G' COLLATE utf8_unicode_ci;
SET @roleName = 'INTERNAL_CONSORS' COLLATE utf8_unicode_ci; 

SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);


-- insert any user by login to a specific role
SET @roleId = (SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
SET @serviceId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceName);

-- Nicolas Pascal
SET @userLogin = 'fr22563';
DELETE FROM PROFIL WHERE USER_XARM_LOGIN = @userLogin AND ROLE_ID = @roleId AND SERVICE_ID = @serviceId;

-- Aarti Priya
SET @userLogin = 'EWLA185629';
DELETE FROM PROFIL WHERE USER_XARM_LOGIN = @userLogin AND ROLE_ID = @roleId AND SERVICE_ID = @serviceId;

-- Dajana Eisenhauer
SET @userLogin = 'EWLdEisenhauer';
DELETE FROM PROFIL WHERE USER_XARM_LOGIN = @userLogin AND ROLE_ID = @roleId AND SERVICE_ID = @serviceId;

-- Nicolas Engel
SET @userLogin = 'A663859';
DELETE FROM PROFIL WHERE USER_XARM_LOGIN = @userLogin AND ROLE_ID = @roleId AND SERVICE_ID = @serviceId;

-- Tim Milde
SET @userLogin = 'A758569';
DELETE FROM PROFIL WHERE USER_XARM_LOGIN = @userLogin AND ROLE_ID = @roleId AND SERVICE_ID = @serviceId;

-- check existing 
SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
