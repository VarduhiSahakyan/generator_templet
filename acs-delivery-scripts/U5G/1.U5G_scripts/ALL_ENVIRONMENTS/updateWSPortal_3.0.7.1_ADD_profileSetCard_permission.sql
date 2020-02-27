INSERT INTO Permission (name, shiroExpression) VALUES ('Write_card_profileSet', 'CARD_PROFILESET_NAME:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Modification du jeu de profils de la carte', 'fr', id FROM Permission WHERE name = 'Write_card_profileSet';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Modify profileSet card', 'en', id FROM Permission WHERE name = 'Write_card_profileSet';


INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_card_profileSet' AND r.name LIKE '%ADMIN_WORLDLINE%';

INSERT INTO Permission (name, shiroExpression) VALUES ('read_card_profileSet', 'CARD_PROFILESET_NAME:READ');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Affichage du jeu de profils de la carte', 'fr', id FROM Permission WHERE name = 'read_card_profileSet';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
  SELECT 'Display profileSet card', 'en', id FROM Permission WHERE name = 'read_card_profileSet';


INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'read_card_profileSet' AND r.name LIKE '%ADMIN_WORLDLINE%';
