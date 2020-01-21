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
SET @Issuer_10 = 'SBK_West';

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
SET @SubIssuerCode_10 = '13606';

SET @Role1 = 'SUPER_ADMIN_Sparda';
SET @Role2 = 'ADMIN_Sparda';
SET @Role3 = 'AGENT_Sparda';

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', @BankB, c.id FROM `Customer` c WHERE c.name = 'Worldline' AND c.customerType = 'ENTITY';
/*sssss*/
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @IssuerCode, 'ISSUER', @BankB,   c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SharedIssuerCode, 'SUB_ISSUER', @SharedIssuer,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_01, 'SUB_ISSUER', @Issuer_01,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_02, 'SUB_ISSUER', @Issuer_02,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_03, 'SUB_ISSUER', @Issuer_03,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_04, 'SUB_ISSUER', @Issuer_04,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_05, 'SUB_ISSUER', @Issuer_05,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_06, 'SUB_ISSUER', @Issuer_06,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_07, 'SUB_ISSUER', @Issuer_07,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_08, 'SUB_ISSUER', @Issuer_08,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_09, 'SUB_ISSUER', @Issuer_09,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode_10, 'SUB_ISSUER', @Issuer_10,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';


-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  (@Role1),
  (@Role2),
  (@Role3);

-- 3. Add Role-Customer

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'ENTITY' AND c.name = @BankB AND r.name IN ('ADMIN_WORLDLINE', @Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @SharedIssuer AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_01 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_02 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_03 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_04 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_05 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_06 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_07 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_08 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_09 AND r.name IN (@Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @Issuer_10 AND r.name IN (@Role1, @Role2, @Role3);

-- 4. Add Role-Permission
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT r.id, p.id
FROM `Role` r, `Permission` p
WHERE r.name = @Role1
  AND p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_instance_config',
                 'Consult_events',
                 'Consult_reporting',
                 'Consult_bin_management',
                 'Write_bin_management',
                 'Consult_export_bins_for_ds',
                 'Consult_card_management',
                 'Write_card_management',
                 'Write_authentication_means',
                 'Consult_fraud_management',
                 'Write_fraud_management',
                 'Write_add_remove_card_to_blacklist',
                 'Consult_profiles_management',
                 'Write_profiles_management',
                 'Consult_html_authentication_pages',
                 'Write_html_authentication_pages',
                 'Consult_Merchant_test',
                 'Consult_monitoring',
                 'Consult_scoring_management',
				 'Write_scoring_management',
				 'Consult_user_xp'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name = @Role2
        AND  p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_events',
                 'Consult_reporting',
                 'Consult_bin_management',
                 'Consult_export_bins_for_ds',
                 'Consult_card_management',
                 'Write_card_management',
                 'Write_authentication_means',
                 'Consult_fraud_management',
                 'Write_fraud_management',
                 'Write_add_remove_card_to_blacklist',
                 'Consult_profiles_management',
                 'Consult_html_authentication_pages',
                 'Write_html_authentication_pages',
                 'Consult_Merchant_test',
                 'Consult_monitoring',
                 'Consult_scoring_management',
				 'Consult_user_xp'
  );

  INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name = @Role3
        AND  p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_events',
                 'Consult_bin_management',
                 'Consult_card_management',
                 'Write_authentication_means',
                 'Consult_fraud_management',
				 'Consult_user_xp'
  );
SET FOREIGN_KEY_CHECKS = 1;