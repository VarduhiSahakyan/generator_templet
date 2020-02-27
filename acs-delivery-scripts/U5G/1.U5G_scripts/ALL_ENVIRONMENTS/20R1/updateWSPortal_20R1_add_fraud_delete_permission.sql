INSERT INTO Permission (name, shiroExpression) VALUES ('Fraud_management_blacklist_deletion', 'FRAUD:DELETE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Suppression d''éléments de fraude', 'fr', id FROM Permission WHERE name = 'Fraud_management_blacklist_deletion';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Fraud element deletion', 'en', id FROM Permission WHERE name = 'Fraud_management_blacklist_deletion';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Fraud_management_blacklist_deletion' AND r.name LIKE '%ADMIN_WORLDLINE%';