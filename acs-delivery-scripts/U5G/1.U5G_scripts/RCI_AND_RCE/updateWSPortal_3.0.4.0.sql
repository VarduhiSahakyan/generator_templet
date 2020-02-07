INSERT INTO Permission (id, name, shiroExpression) VALUES ('37', 'Consult_audit_tools', 'AUDIT:READ');
INSERT INTO Permission (id, name, shiroExpression) VALUES ('38', 'Write_audit_tools', 'AUDIT:WRITE');
INSERT INTO Permission (`id`, `name`, `shiroExpression`) VALUES ('39', 'FO_Synchronization', 'FO_SYNCHRONIZATION:WRITE');

INSERT INTO PermissionDescription (id,value,language,fk_id_permission) VALUES (71,'Consultation de l\'outil d\'audit','fr',37);
INSERT INTO PermissionDescription (id,value,language,fk_id_permission) VALUES (72,'Consult audit tool','en',37);
INSERT INTO PermissionDescription (id,value,language,fk_id_permission) VALUES (73,'Ajout d\'audit','fr',38);
INSERT INTO PermissionDescription (id,value,language,fk_id_permission) VALUES (74,'Add audit','en',38);
INSERT INTO PermissionDescription (id,value,language,fk_id_permission) VALUES (75, 'Synchronisation des données avec le front-office', 'fr', '39');
INSERT INTO PermissionDescription (id,value,language,fk_id_permission) VALUES (76, 'Front-office data synchronization', 'en', '39');

INSERT INTO Role_Permission (id_permission, id_role) VALUES (37, 1);
INSERT INTO Role_Permission (id_permission, id_role) VALUES (38, 1);
INSERT INTO Role_Permission (id_permission, id_role) VALUES (39, 1);
