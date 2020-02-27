USE `U0P_ACS_WS`;

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_report_by_profile_set', 'REPORT_PROFILESET:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des rapports groupés par jeu de profil', 'fr', id FROM Permission WHERE name = 'Consult_report_by_profile_set';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Consult reports grouping by profile set', 'en', id FROM Permission WHERE name = 'Consult_report_by_profile_set';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_report_by_profile_set' AND r.name LIKE '%ADMIN_WORLDLINE%';