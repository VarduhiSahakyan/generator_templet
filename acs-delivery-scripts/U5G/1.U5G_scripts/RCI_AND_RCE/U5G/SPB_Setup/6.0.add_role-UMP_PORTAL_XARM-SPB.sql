USE PORTAL_XARM;

SET @roleName = 'SUPER_ADMIN_SPARDA'; 

INSERT INTO `RM_ROLE` (`rol_name`, `rol_version`)
VALUES (@roleName, '0');

SET @rocId = (SELECT MAX(`roc_id`)+1 FROM `RM_ROC_PIPES`);

INSERT INTO `RM_ROLE_CONFIGURATION` (`roc_id`, `roc_version`, `roc_authz_pipe_name`, `rol_name`)
VALUES (@rocId, '0', 'AuthzPipe', @roleName);

INSERT INTO `RM_ROC_PIPES` (`roc_id`, `pip_name`, `pip_type`, `pip_key`)
VALUES (@rocId, 'AuthzPipe', 'authz', 'authz/AuthzPipe');


SET @roleName = 'ADMIN_SPARDA'; 

INSERT INTO `RM_ROLE` (`rol_name`, `rol_version`)
VALUES (@roleName, '0');

SET @rocId = (SELECT MAX(`roc_id`)+1 FROM `RM_ROC_PIPES`);

INSERT INTO `RM_ROLE_CONFIGURATION` (`roc_id`, `roc_version`, `roc_authz_pipe_name`, `rol_name`)
VALUES (@rocId, '0', 'AuthzPipe', @roleName);

INSERT INTO `RM_ROC_PIPES` (`roc_id`, `pip_name`, `pip_type`, `pip_key`)
VALUES (@rocId, 'AuthzPipe', 'authz', 'authz/AuthzPipe');


SET @roleName = 'AGENT_SPARDA'; 

INSERT INTO `RM_ROLE` (`rol_name`, `rol_version`)
VALUES (@roleName, '0');

SET @rocId = (SELECT MAX(`roc_id`)+1 FROM `RM_ROC_PIPES`);

INSERT INTO `RM_ROLE_CONFIGURATION` (`roc_id`, `roc_version`, `roc_authz_pipe_name`, `rol_name`)
VALUES (@rocId, '0', 'AuthzPipe', @roleName);

INSERT INTO `RM_ROC_PIPES` (`roc_id`, `pip_name`, `pip_type`, `pip_key`)
VALUES (@rocId, 'AuthzPipe', 'authz', 'authz/AuthzPipe');