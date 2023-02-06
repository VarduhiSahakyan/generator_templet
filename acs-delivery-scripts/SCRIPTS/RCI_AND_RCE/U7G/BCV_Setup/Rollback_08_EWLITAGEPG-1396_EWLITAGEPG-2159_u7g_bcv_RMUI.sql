USE `U7G_ACS_BO`;

SELECT @adminId := id FROM Association WHERE groupPath = '/All/76700' AND role = 'ADMIN';
SELECT @helpdeskId := id FROM Association WHERE groupPath = '/All/76700' AND role = 'HELPDESK';
SELECT @reportingId := id FROM Association WHERE groupPath = '/All/76700' AND role = 'REPORTING';

DELETE FROM `PermissionAssociation` WHERE associationId IN (@adminId, @helpdeskId, @reportingId);
DELETE FROM `Association` WHERE id IN (@adminId, @helpdeskId, @reportingId);

