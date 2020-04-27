INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_report_by_bin_range', 'REPORT_BIN_RANGE:READ');

INSERT INTO Role_Permission(id_permission, id_role)
  SELECT p.id, r.id FROM Role r, Permission p WHERE p.name = 'Consult_report_by_bin_range' AND r.name LIKE '%ADMIN_WORLDLINE%';
  
INSERT INTO PermissionDescription (value, language, fk_id_permission)
	SELECT 'Consultation des rapports groupés par jeu de bin range', 'fr', id FROM Permission WHERE name = 'Consult_report_by_bin_range';
	
INSERT INTO PermissionDescription (value, language, fk_id_permission)
	SELECT 'Consult reports grouping by bin range', 'en', id FROM Permission WHERE name = 'Consult_report_by_bin_range';
