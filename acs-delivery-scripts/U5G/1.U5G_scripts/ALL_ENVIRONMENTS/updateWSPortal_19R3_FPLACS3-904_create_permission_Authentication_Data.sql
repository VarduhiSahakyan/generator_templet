-- 24/04/2019
-- FPLACS3-904
-- insert new permission for adding authentication Data (only for worldline admin for now)

USE U0P_ACS_WS;

INSERT INTO Permission (name, shiroExpression) VALUES ('add_authentication_Data', 'Authent_DATA:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Ajouter des données d\'authentification', 'fr', id FROM Permission WHERE name = 'add_authentication_Data';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Add authentication Data', 'en', id FROM Permission WHERE name = 'add_authentication_Data';

INSERT INTO Role_Permission(id_permission, id_role)
    SELECT p.id, r.id from Role r, Permission p where p.name = 'add_authentication_Data' AND r.name like '%ADMIN_WORLDLINE%';
	
	