USE PORTAL_SERVICE_PARAM;

-- check existing 
SET @serviceName = 'ACS_U5G';
SET @roleName = 'INTERNAL_CONSORS'; 

SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);


-- insert any user by login to a specific role
SET @roleId = (SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
SET @serviceId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceName);

-- Nicolas Pascal
SET @userLogin = 'fr22563';
INSERT INTO PROFIL (`USER_XARM_LOGIN`, `ROLE_ID`, `SERVICE_ID`) VALUES (@userLogin, @roleId, @serviceId);

-- Aarti Priya
SET @userLogin = 'EWLA185629';
INSERT INTO PROFIL (`USER_XARM_LOGIN`, `ROLE_ID`, `SERVICE_ID`) VALUES (@userLogin, @roleId, @serviceId);

-- Dajana Eisenhauer
SET @userLogin = 'EWLdEisenhauer';
INSERT INTO PROFIL (`USER_XARM_LOGIN`, `ROLE_ID`, `SERVICE_ID`) VALUES (@userLogin, @roleId, @serviceId);

-- Nicolas Engel
SET @userLogin = 'A663859';
INSERT INTO PROFIL (`USER_XARM_LOGIN`, `ROLE_ID`, `SERVICE_ID`) VALUES (@userLogin, @roleId, @serviceId);

-- Tim Milde
SET @userLogin = 'A758569';
INSERT INTO PROFIL (`USER_XARM_LOGIN`, `ROLE_ID`, `SERVICE_ID`) VALUES (@userLogin, @roleId, @serviceId);

-- check existing 
SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
