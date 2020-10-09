USE `U5G_ACS_BO`;

SET @subIssuerId = (SELECT id FROM SubIssuer WHERE code = '16500');

UPDATE `ProfileSet` SET name = 'PS_16500_01' WHERE fk_id_subIssuer in (@subIssuerId);
