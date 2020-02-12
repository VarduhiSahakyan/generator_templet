USE `U0P_ACS_WS`;

DELETE FROM Role_Permission WHERE Role_Permission.id_permission = (SELECT id FROM Permission WHERE shiroExpression = 'FRAUD:WRITE');

DELETE FROM PermissionDescription WHERE PermissionDescription.fk_id_permission = (SELECT id FROM Permission WHERE shiroExpression = 'FRAUD:WRITE');

DELETE FROM Permission WHERE shiroExpression = 'FRAUD:WRITE';