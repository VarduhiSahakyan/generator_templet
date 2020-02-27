INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_transactions_3DS2', 'PROTOCOL_VERSION_2:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_transactions_3DS1', 'PROTOCOL_VERSION_102:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consultation des transactions 3DS1', 'fr', id FROM Permission WHERE name = 'Consult_transactions_3DS1';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consult 3DS1 transactions', 'en', id FROM Permission WHERE name = 'Consult_transactions_3DS1';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consultation des transactions 3DS2', 'fr', id FROM Permission WHERE name = 'Consult_transactions_3DS2';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consult 3DS2 transactions', 'en', id FROM Permission WHERE name = 'Consult_transactions_3DS2';


INSERT INTO Role_Permission(id_permission, id_role)
  SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_transactions_3DS2' AND r.name like '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission(id_permission, id_role)
  SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_transactions_3DS1' AND r.name like '%ADMIN_WORLDLINE%';

INSERT INTO Role_Permission(id_permission, id_role)
  SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_transactions_3DS2' AND r.name like '%ADMIN_CMB%';
INSERT INTO Role_Permission(id_permission, id_role)
  SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_transactions_3DS1' AND r.name not like '%ADMIN_WORLDLINE%';