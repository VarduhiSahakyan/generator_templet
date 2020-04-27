USE `U0P_ACS_WS`;

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_batch_reports', 'BATCH_REPORTS:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des rapports batch', 'fr', id FROM Permission WHERE name = 'Consult_batch_reports';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult batch reports', 'en', id FROM Permission WHERE name = 'Consult_batch_reports';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_batch_reports' AND r.name LIKE '%ADMIN_WORLDLINE%';