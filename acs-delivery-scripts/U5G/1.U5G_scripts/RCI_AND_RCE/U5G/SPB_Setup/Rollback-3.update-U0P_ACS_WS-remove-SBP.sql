USE `U0P_ACS_WS`;

SET @BankB = 'Sparda-Bank';
SET @SharedIssuer = 'sharedBIN';
SET @Issuer_01 = 'SBK_Hessen';
SET @Issuer_02 = 'SBK_Hamburg';
SET @Issuer_03 = 'SBK_Ostbayern';
SET @Issuer_04 = 'SBK_Augsburg';
SET @Issuer_05 = 'SBK_München';
SET @Issuer_06 = 'SBK_Baden-Württemberg';
SET @Issuer_07 = 'SBK_Nürnberg';
SET @Issuer_08 = 'SBK_Südwest ';
SET @Issuer_09 = 'SBK_Hannover';
-- SET @Issuer_10 = 'SBK_West';

SET @IssuerCode = '16950';
SET @SharedIssuerCode = '99999';
SET @SubIssuerCode_01 = '15009';
SET @SubIssuerCode_02 = '12069';
SET @SubIssuerCode_03 = '17509';
SET @SubIssuerCode_04 = '17209';
SET @SubIssuerCode_05 = '17009';
SET @SubIssuerCode_06 = '16009';
SET @SubIssuerCode_07 = '17609';
SET @SubIssuerCode_08 = '15519';
SET @SubIssuerCode_09 = '12509';
-- SET @SubIssuerCode_10 = '13606';

SET @Role1 = 'SUPER_ADMIN_Sparda';
SET @Role2 = 'ADMIN_Sparda';
SET @Role3 = 'AGENT_Sparda';

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2, @Role3));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2, @Role3));

-- 3. Remove Role
DELETE
FROM `Role`
WHERE `name` in (@Role1, @Role2, @Role3);

-- 4. Remove Customer

SET @parent_ids = (SELECT group_concat(id)
                   FROM `Customer`
                   WHERE name = @BankB);

DELETE
FROM Customer
WHERE find_in_set(parent_id, @parent_ids)
  AND `code` IN
      (@IssuerCode, @SharedIssuerCode, @SubIssuerCode_01, @SubIssuerCode_02, @SubIssuerCode_03, @SubIssuerCode_04,
       @SubIssuerCode_05, @SubIssuerCode_06, @SubIssuerCode_07, @SubIssuerCode_08, @SubIssuerCode_09);
SET FOREIGN_KEY_CHECKS = 1;
