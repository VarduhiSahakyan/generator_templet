INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_Rba_configuration', 'RBA_CONFIGURATION:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des configurations RBA', 'fr', id FROM Permission WHERE name = 'Consult_Rba_configuration';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consult RBA configuration', 'en', id FROM Permission WHERE name = 'Consult_Rba_configuration';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_Rba_configuration' AND r.name LIKE '%ADMIN_WORLDLINE%';

