USE `U0P_ACS_WS`;

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_RBA_Decision', 'RBA_DECISION:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation de l''onglet RBA Decision', 'fr', id FROM Permission WHERE name = 'Consult_RBA_Decision';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult RBA Decision section', 'en', id FROM Permission WHERE name = 'Consult_RBA_Decision';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_RBA_Decision' AND r.name LIKE '%ADMIN_WORLDLINE%';