INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_trusted_beneficiaries', 'TRUSTED_BENEFICIARIES:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des marchands de confiance pour le porteur', 'fr', id FROM Permission WHERE name = 'Consult_trusted_beneficiaries';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult trusted beneficiaries', 'en', id FROM Permission WHERE name = 'Consult_trusted_beneficiaries';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_trusted_beneficiaries' AND r.name LIKE '%ADMIN_WORLDLINE%';