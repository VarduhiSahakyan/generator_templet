USE U0P_ACS_WS;

INSERT INTO `Permission` (`name`, `shiroExpression`) VALUES ('Consult_enrolment_report_page', 'ENROLMENT_REPORT:READ');
INSERT INTO `PermissionDescription` (`value`, `language`, `fk_id_permission`) VALUES ('Consult enrolment report page', 'en', (SELECT id FROM Permission WHERE name = 'Consult_enrolment_report_page'));
INSERT INTO `PermissionDescription` (`value`, `language`, `fk_id_permission`) VALUES ('Consultation des rapports d\'enrôlement', 'fr', (SELECT id FROM Permission WHERE name = 'Consult_enrolment_report_page'));
 
INSERT INTO Role_Permission (id_permission, id_role)
    SELECT p.id, r.id FROM Permission p, Role r
    WHERE p.name = 'Consult_enrolment_report_page' AND r.name LIKE '%ADMIN_WORLDLINE%';
 
