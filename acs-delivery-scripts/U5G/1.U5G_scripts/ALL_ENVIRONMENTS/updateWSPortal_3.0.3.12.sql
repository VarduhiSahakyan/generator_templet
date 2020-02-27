INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_user_xp', 'USER_XP:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_merchant_pivot', 'MERCHANT_PIVOT:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_merchant_pivot', 'MERCHANT_PIVOT:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation du parcours client', 'fr', id FROM Permission WHERE name = 'Consult_user_xp';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult user experience', 'en', id FROM Permission WHERE name = 'Consult_user_xp';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des montants pivots commerçants', 'fr', id FROM Permission WHERE name = 'Consult_merchant_pivot';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult merchant pivot amounts', 'en', id FROM Permission WHERE name = 'Consult_merchant_pivot';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modification des montants pivots commerçants', 'fr', id FROM Permission WHERE name = 'Write_merchant_pivot';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Merchant pivot amounts modification', 'en', id FROM Permission WHERE name = 'Write_merchant_pivot';

INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_user_xp' AND r.name like '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id from Role r, Permission p where p.name = 'Consult_merchant_pivot' AND r.name like '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission(id_permission, id_role)
SELECT p.id, r.id from Role r, Permission p where p.name = 'Write_merchant_pivot' AND r.name like '%ADMIN_WORLDLINE%';
