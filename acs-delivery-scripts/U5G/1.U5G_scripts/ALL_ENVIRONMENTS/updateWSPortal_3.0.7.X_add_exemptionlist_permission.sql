INSERT INTO Permission (name, shiroExpression) VALUES ('Consult_cards_in_exemption_list', 'CARD_EXEMPTION:READ');
INSERT INTO Permission (name, shiroExpression) VALUES ('Write_add_remove_card_to_exemption_list', 'CARD_EXEMPTION:WRITE');

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consultation des cartes en liste dérogatoire', 'fr', id FROM Permission WHERE name = 'Consult_cards_in_exemption_list';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Consult cards in exemption list', 'en', id FROM Permission WHERE name = 'Consult_cards_in_exemption_list';

INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Ajout ou suppression d\’une carte en liste dérogatoire', 'fr', id FROM Permission WHERE name = 'Write_add_remove_card_to_exemption_list';
INSERT INTO PermissionDescription (value, language, fk_id_permission)
SELECT 'Write add/remove card to exemption list', 'en', id FROM Permission WHERE name = 'Write_add_remove_card_to_exemption_list';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Consult_cards_in_exemption_list' AND r.name LIKE '%ADMIN_WORLDLINE%';

INSERT INTO Role_Permission (id_permission, id_role)
SELECT p.id, r.id FROM Permission p, Role r WHERE p.name = 'Write_add_remove_card_to_exemption_list' AND r.name LIKE '%ADMIN_WORLDLINE%';