INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_psd2_reports', 'PSD2_REPORTS:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des rapports PSD2', 'fr', id FROM Permission WHERE name = 'Consult_psd2_reports';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult PSD2 reports', 'en', id FROM Permission WHERE name = 'Consult_psd2_reports';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_psd2_reports' AND r.name LIKE '%ADMIN_WORLDLINE%';