INSERT INTO Permission (name, shiroExpression) VALUES('Consult_rule', 'RULE:READ');
INSERT INTO Permission (name, shiroExpression) VALUES('Write_rule', 'RULE:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des règles', 'fr', id FROM Permission WHERE name = 'Consult_rule';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult rules', 'en', id FROM Permission WHERE name = 'Consult_rule';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modification des règles', 'fr', id FROM Permission WHERE name = 'Write_rule';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modify rules', 'en', id FROM Permission WHERE name='Write_rule';

INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id FROM Role r, Permission p WHERE p.name = 'Consult_rule' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id FROM Role r, Permission p WHERE p.name = 'Write_rule' AND r.name LIKE '%ADMIN_WORLDLINE%';