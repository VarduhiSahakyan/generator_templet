INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_Rba_configuration_details', 'RBA_CONFIGURATION_DETAILS:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation du détail des configurations RBA', 'fr', id FROM Permission WHERE name = 'Consult_Rba_configuration_details';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consult RBA configuration details', 'en', id FROM Permission WHERE name = 'Consult_Rba_configuration_details';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_Rba_configuration_details' AND r.name LIKE '%ADMIN_WORLDLINE%';

