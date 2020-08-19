USE PORTAL_XARM;

SET @roleName = 'SUPER_ADMIN_SPARDA'; 
SET @rocId = (SELECT `roc_id` FROM `RM_ROLE_CONFIGURATION` WHERE `rol_name`=@roleName);

DELETE FROM `RM_ROC_PIPES` WHERE `roc_id`=@rocId;
DELETE FROM `RM_ROLE_CONFIGURATION` WHERE `roc_id`=@rocId;
DELETE FROM `RM_ROLE` WHERE `rol_name`=@roleName;


SET @roleName = 'ADMIN_SPARDA'; 
SET @rocId = (SELECT `roc_id` FROM `RM_ROLE_CONFIGURATION` WHERE `rol_name`=@roleName);

DELETE FROM `RM_ROC_PIPES` WHERE `roc_id`=@rocId;
DELETE FROM `RM_ROLE_CONFIGURATION` WHERE `roc_id`=@rocId;
DELETE FROM `RM_ROLE` WHERE `rol_name`=@roleName;


SET @roleName = 'AGENT_SPARDA'; 
SET @rocId = (SELECT `roc_id` FROM `RM_ROLE_CONFIGURATION` WHERE `rol_name`=@roleName);

DELETE FROM `RM_ROC_PIPES` WHERE `roc_id`=@rocId;
DELETE FROM `RM_ROLE_CONFIGURATION` WHERE `roc_id`=@rocId;
DELETE FROM `RM_ROLE` WHERE `rol_name`=@roleName;