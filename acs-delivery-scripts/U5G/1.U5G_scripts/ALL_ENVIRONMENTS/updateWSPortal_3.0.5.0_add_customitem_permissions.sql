INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_customitem', 'CUSTOMITEM:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_customitem', 'CUSTOMITEM:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des éléments personnalisables', 'fr', id FROM Permission WHERE name = 'Consult_customitem';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult customitem', 'en', id from Permission WHERE name = 'Consult_customitem';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modification des éléments personnalisables', 'fr', id FROM Permission WHERE name = 'Write_customitem';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Pagelayout customitem', 'en', id FROM Permission WHERE name = 'Write_customitem';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_customitem' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_customitem' AND r.name LIKE '%ADMIN_WORLDLINE%';