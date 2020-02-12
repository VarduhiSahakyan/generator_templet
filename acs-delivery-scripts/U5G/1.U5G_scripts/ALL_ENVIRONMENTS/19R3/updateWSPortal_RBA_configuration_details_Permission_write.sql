INSERT INTO Permission (name, shiroExpression) VALUES ('Write_Rba_configuration_details', 'RBA_CONFIGURATION_DETAILS:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modification du détail des configurations RBA', 'fr', id FROM Permission WHERE name = 'Write_Rba_configuration_details';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Modify RBA configuration details', 'en', id FROM Permission WHERE name = 'Write_Rba_configuration_details';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_Rba_configuration_details' AND r.name LIKE '%ADMIN_WORLDLINE%';

