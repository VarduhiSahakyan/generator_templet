INSERT INTO Permission (name, shiroExpression) VALUES ('Edit_cryptoconfigs', 'CRYPTO_CONFIG:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Edition des configurations cryptographiques', 'fr', id FROM Permission WHERE name = 'Edit_cryptoconfigs';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Edit cryptographic configurations', 'en', id from Permission WHERE name = 'Edit_cryptoconfigs';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Edit_cryptoconfigs' AND r.name LIKE '%ADMIN_WORLDLINE%';