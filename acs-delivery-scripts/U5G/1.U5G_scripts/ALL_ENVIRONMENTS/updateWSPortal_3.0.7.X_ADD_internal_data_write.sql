INSERT INTO Permission (name, shiroExpression) VALUES ('write_internal_datas', 'INTERNAL_DATA:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modifications des données internes', 'fr', id FROM Permission WHERE name = 'write_internal_datas';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Modify internal datas', 'en', id FROM Permission WHERE name = 'write_internal_datas';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'write_internal_datas' AND r.name LIKE '%ADMIN_WORLDLINE%';
