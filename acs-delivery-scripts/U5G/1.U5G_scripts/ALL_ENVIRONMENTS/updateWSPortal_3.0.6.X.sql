INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_Merchant_test_3DS2', 'MERCHANT_TEST_3DS2:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Accès à l’outil commerçant de tests ACS3 (3DS2)', 'fr', id FROM Permission WHERE name = 'Consult_Merchant_test_3DS2';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consult merchant test (3DS2)', 'en', id FROM Permission WHERE name = 'Consult_Merchant_test_3DS2';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_Merchant_test_3DS2' AND r.name LIKE '%ADMIN_WORLDLINE%';
