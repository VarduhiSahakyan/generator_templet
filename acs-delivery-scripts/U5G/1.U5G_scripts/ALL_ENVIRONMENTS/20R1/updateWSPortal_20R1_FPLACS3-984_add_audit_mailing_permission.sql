INSERT INTO `Permission` (`name`, `shiroExpression`) VALUES ("Create_audit_configuration", "AUDIT_CONFIGURATION:WRITE");

INSERT INTO `Permission` (`name`, `shiroExpression`) VALUES ("Consult_audit_configuration", "AUDIT_CONFIGURATION:READ");

INSERT INTO `PermissionDescription` (`value`, `language`, `fk_id_permission`)
VALUES ("Creation des configurations d'envoie d'audits par email", "fr", (SELECT id FROM `Permission` WHERE shiroExpression = "AUDIT_CONFIGURATION:WRITE"));
INSERT INTO `PermissionDescription` (`value`, `language`, `fk_id_permission`)
VALUES ("Create audit mailing configuration", "en", (SELECT id FROM `Permission` WHERE shiroExpression = "AUDIT_CONFIGURATION:WRITE"));

INSERT INTO `PermissionDescription` (`value`, `language`, `fk_id_permission`)
VALUES ("Consultation des configurations d'envoie d'audits par email", "fr", (SELECT id FROM `Permission` WHERE shiroExpression = "AUDIT_CONFIGURATION:READ"));
INSERT INTO `PermissionDescription` (`value`, `language`, `fk_id_permission`)
VALUES ("Consult audit mailing configuration", "en", (SELECT id FROM `Permission` WHERE shiroExpression = "AUDIT_CONFIGURATION:READ"));

INSERT INTO `Role_Permission` (`id_permission`, `id_role`)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.shiroExpression = 'AUDIT_CONFIGURATION:WRITE' AND r.name LIKE '%ADMIN_WORLDLINE%';

INSERT INTO `Role_Permission` (`id_permission`, `id_role`)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.shiroExpression = 'AUDIT_CONFIGURATION:READ' AND r.name LIKE '%ADMIN_WORLDLINE%';