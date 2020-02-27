-- 19/04/2019
-- FPLACS3-1045
-- insert new permission for bin range emergency creation (only for worldline admin for now)

USE U0P_ACS_WS;

INSERT INTO Permission (name, shiroExpression) VALUES ('Write_bin_emergency', 'BIN_EMERGENCY:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Activation d\'une plage de bin en urgence', 'fr', id FROM Permission WHERE name = 'Write_bin_emergency';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
    SELECT 'Emergency bin range activation', 'en', id FROM Permission WHERE name = 'Write_bin_emergency';

INSERT INTO Role_Permission(id_permission, id_role)
    SELECT p.id, r.id from Role r, Permission p where p.name = 'Write_bin_emergency' AND r.name like '%ADMIN_WORLDLINE%';