INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_audit_tools', 'AUDIT:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_audit_tools', 'AUDIT:WRITE');
INSERT INTO Permission (name, shiroExpression) VALUES ('FO_Synchronization', 'FO_SYNCHRONIZATION:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Consultation de l\'outil d\'audit', 'fr', id FROM Permission WHERE name = 'Consult_audit_tools';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Consult audit tool', 'en', id FROM Permission WHERE name = 'Consult_audit_tools';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Ajout d\'audit', 'fr', id FROM Permission WHERE name = 'Write_audit_tools';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Add audit', 'en', id FROM Permission WHERE name = 'Write_audit_tools';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Synchronisation des données avec le front-office', 'fr', id FROM Permission WHERE name = 'FO_Synchronization';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Front-office data synchronization', 'en', id FROM Permission WHERE name = 'FO_Synchronization';

INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_audit_tools' AND r.name like '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id from Role r, Permission p where p.name = 'Write_audit_tools' AND r.name like '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id from Role r, Permission p where p.name = 'FO_Synchronization' AND r.name like '%ADMIN_WORLDLINE%';