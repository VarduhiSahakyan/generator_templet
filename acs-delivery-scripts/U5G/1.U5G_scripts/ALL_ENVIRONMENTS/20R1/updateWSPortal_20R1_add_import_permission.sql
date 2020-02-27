INSERT INTO Permission (name, shiroExpression) VALUES ('Allow_import', 'IMPORT_EXPORT_TOOL:IMPORT');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Permission d''importer', 'fr', id FROM Permission WHERE name = 'Allow_import';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Import permission', 'en', id FROM Permission WHERE name = 'Allow_import';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Allow_import' AND r.name LIKE '%ADMIN_WORLDLINE%';