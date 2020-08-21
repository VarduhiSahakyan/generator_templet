USE PORTAL_SERVICE_PARAM;

-- check existing 
SET @serviceName = 'ACS_U5G';
SET @serviceNamePortail = 'PORTAIL';
SET @roleName = 'ADMIN_SPARDA'; 

SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);

-- insert any user by login to a specific role
SET @roleId = (SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
SET @serviceId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceName);
SET @servicePortailId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceNamePortail);

/* Christian Schnur */
SET @userLogin = 'EWLA790281';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Nicolas Pascal
SET @userLogin = 'A176981';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);
-- Aarti Priya
SET @userLogin = 'EWLA185629';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Dajana Eisenhauer
SET @userLogin = 'EWLdEisenhauer';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Tillmann Schmitt
SET @userLogin = 'A562490';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Nicolas Engel
SET @userLogin = 'A663859';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Tim Milde
SET @userLogin = 'A758569';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);


-- check existing 
SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);

USE PORTAL_SERVICE_PARAM;

-- check existing 
SET @serviceName = 'ACS_U5G';
SET @serviceNamePortail = 'PORTAIL';
SET @roleName = 'AGENT_SPARDA'; 

SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);


-- insert any user by login to a specific role
SET @roleId = (SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
SET @serviceId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceName);
SET @servicePortailId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceNamePortail);

-- Christian Schnur
SET @userLogin = 'EWLA790281';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Nicolas Pascal
SET @userLogin = 'A176981';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);
-- Aarti Priya
SET @userLogin = 'EWLA185629';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Dajana Eisenhauer
SET @userLogin = 'EWLdEisenhauer';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Tillmann Schmitt
SET @userLogin = 'A562490';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Nicolas Engel
SET @userLogin = 'A663859';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Tim Milde
SET @userLogin = 'A758569';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- check existing 
SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);

USE PORTAL_SERVICE_PARAM;

-- check existing 
SET @serviceName = 'ACS_U5G';
SET @serviceNamePortail = 'PORTAIL';
SET @roleName = 'SUPER_ADMIN_SPARDA'; 

SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);

-- insert any user by login to a specific role
SET @roleId = (SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
SET @serviceId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceName);
SET @servicePortailId = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = @serviceNamePortail);

-- Christian Schnur
SET @userLogin = 'EWLA790281';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Nicolas Pascal
SET @userLogin = 'A176981';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Aarti Priya
SET @userLogin = 'EWLA185629';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Dajana Eisenhauer
SET @userLogin = 'EWLdEisenhauer';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Tillmann Schmitt
SET @userLogin = 'A562490';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Nicolas Engel
SET @userLogin = 'A663859';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- Tim Milde
SET @userLogin = 'A758569';
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @serviceId);
INSERT INTO PROFIL (USER_XARM_LOGIN, ROLE_ID, SERVICE_ID) VALUES (@userLogin, @roleId, @servicePortailId);

-- check existing 
SELECT * FROM PROFIL p 
WHERE p.SERVICE_ID = (SELECT SERVICE_ID FROM SERVICE WHERE SERVICE_NAME = 'ACS_U5G' LIMIT 1)
AND p.ROLE_ID IN 
(SELECT ROLE_ID FROM ROLE WHERE ROLE_NAME = @roleName);
