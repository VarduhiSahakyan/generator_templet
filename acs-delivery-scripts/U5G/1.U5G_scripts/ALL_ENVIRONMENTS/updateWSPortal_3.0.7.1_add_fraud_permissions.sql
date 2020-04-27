INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_blacklisted_authentication_means', 'BLACKLISTED_AUTHENTICATION_MEANS:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_blacklisted_authentication_means', 'BLACKLISTED_AUTHENTICATION_MEANS:WRITE');

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_ip_filters', 'IP_FILTERS:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_ip_filters', 'IP_FILTERS:WRITE');

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_blacklisted_merchants', 'BLACKLISTED_MERCHANTS:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_blacklisted_merchants', 'BLACKLISTED_MERCHANTS:WRITE');

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_blacklisted_countries', 'BLACKLISTED_COUNTRIES:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_blacklisted_countries', 'BLACKLISTED_COUNTRIES:WRITE');

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_cards_in_blacklist', 'CARD_BLACKLIST:READ');

INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_cards_in_whitelist', 'CARD_WHITELIST:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_add_remove_card_to_whitelist', 'CARD_WHITELIST:WRITE');


INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des moyens d\'authentification en liste noire', 'fr', id FROM Permission WHERE name = 'Consult_blacklisted_authentication_means';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult authentication means in black list', 'en', id FROM Permission WHERE name = 'Consult_blacklisted_authentication_means';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Ajout et modification des moyens d\'authentification en liste noire', 'fr', id FROM Permission WHERE name = 'Write_blacklisted_authentication_means';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Add and modify authentication means in black list', 'en', id FROM Permission WHERE name = 'Write_blacklisted_authentication_means';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des filtres IP', 'fr', id FROM Permission WHERE name = 'Consult_ip_filters';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult IP filters', 'en', id FROM Permission WHERE name = 'Consult_ip_filters';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Ajout et modification des filtres IP', 'fr', id FROM Permission WHERE name = 'Write_ip_filters';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Add and modify IP filters', 'en', id FROM Permission WHERE name = 'Write_ip_filters';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des marchands en liste noire', 'fr', id FROM Permission WHERE name = 'Consult_blacklisted_merchants';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult blacklisted merchants', 'en', id FROM Permission WHERE name = 'Consult_blacklisted_merchants';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Ajout et modification des marchands en liste noire', 'fr', id FROM Permission WHERE name = 'Write_blacklisted_merchants';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Add and modify blacklisted merchants', 'en', id FROM Permission WHERE name = 'Write_blacklisted_merchants';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des pays en liste noire', 'fr', id FROM Permission WHERE name = 'Consult_blacklisted_countries';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult blacklisted countries', 'en', id FROM Permission WHERE name = 'Consult_blacklisted_countries';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Ajout et modification des pays en liste noire', 'fr', id FROM Permission WHERE name = 'Write_blacklisted_countries';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Add and modify blacklisted countries', 'en', id FROM Permission WHERE name = 'Write_blacklisted_countries';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des cartes en liste noire', 'fr', id FROM Permission WHERE name = 'Consult_cards_in_blacklist';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult cards in blacklist', 'en', id FROM Permission WHERE name = 'Consult_cards_in_blacklist';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des cartes en liste blanche', 'fr', id FROM Permission WHERE name = 'Consult_cards_in_whitelist';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult cards in whitelist', 'en', id FROM Permission WHERE name = 'Consult_cards_in_whitelist';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Ajout ou suppression d’une carte en liste blanche', 'fr', id FROM Permission WHERE name = 'Write_add_remove_card_to_whitelist';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Write add/remove card to whitelist', 'en', id FROM Permission WHERE name = 'Write_add_remove_card_to_whitelist';

INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_blacklisted_authentication_means' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_blacklisted_authentication_means' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_ip_filters' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_ip_filters' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_blacklisted_merchants' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_blacklisted_merchants' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_blacklisted_countries' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_blacklisted_countries' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_cards_in_blacklist' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_cards_in_whitelist' AND r.name LIKE '%ADMIN_WORLDLINE%';
INSERT INTO Role_Permission (id_permission, id_role)
  SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_add_remove_card_to_whitelist' AND r.name LIKE '%ADMIN_WORLDLINE%';
