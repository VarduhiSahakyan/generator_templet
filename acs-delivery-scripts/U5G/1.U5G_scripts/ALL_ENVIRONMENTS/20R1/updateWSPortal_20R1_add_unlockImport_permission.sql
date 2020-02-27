INSERT INTO Permission (name, shiroExpression) VALUES ('Unlock_import', 'IMPORT_EXPORT_TOOL:UNLOCK');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Permission de débloquer manuellement l''import', 'fr', id FROM Permission WHERE name = 'Unlock_import';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Permission to manually unlock imports', 'en', id from Permission WHERE name = 'Unlock_import';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Unlock_import' AND r.name LIKE 'SUPER_ADMIN_WORLDLINE';