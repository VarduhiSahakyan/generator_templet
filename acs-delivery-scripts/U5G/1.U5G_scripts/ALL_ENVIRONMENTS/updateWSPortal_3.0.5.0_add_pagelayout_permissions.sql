INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_pagelayout', 'PAGELAYOUT:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_pagelayout', 'PAGELAYOUT:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation de pagelayout', 'fr', id FROM Permission WHERE name = 'Consult_pagelayout';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult pagelayout', 'en', id from Permission WHERE name = 'Consult_pagelayout';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modification de pagelayout', 'fr', id FROM Permission WHERE name = 'Write_pagelayout';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Pagelayout modification', 'en', id FROM Permission WHERE name = 'Write_pagelayout';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_pagelayout' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_pagelayout' AND r.name LIKE '%ADMIN_WORLDLINE%';