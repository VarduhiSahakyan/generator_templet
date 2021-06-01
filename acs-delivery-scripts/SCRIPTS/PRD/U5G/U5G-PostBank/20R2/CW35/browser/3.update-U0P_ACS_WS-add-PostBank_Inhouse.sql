USE `U0P_ACS_WS`;

SET @BankB = 'Postbank';
SET @Issuer = 'Postbank';
SET @SubIssuerB = 'Postbank-EBK';
SET @SubIssuerC = 'Postbank-FBK';
SET @SubIssuer = 'Postbank';
SET @Role1 = 'ADMIN_Postbank';
SET @Role2 = 'Postbank_GRUPPENADMIN';
SET @Role3 = 'Postbank_MITARBEITER';

SET FOREIGN_KEY_CHECKS=0;
-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', @BankB, c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
/*sssss*/
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '18500', 'ISSUER', @Issuer,   c.id FROM `Customer` c WHERE c.name=@BankB AND c.customerType='ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '18501', 'SUB_ISSUER', @SubIssuerB,  c.id FROM `Customer` c WHERE c.name=@Issuer AND c.customerType='ISSUER';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '18502', 'SUB_ISSUER', @SubIssuerC,  c.id FROM `Customer` c WHERE c.name=@Issuer AND c.customerType='ISSUER';
/* This next command should be executed only if there is need of shared bin */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '18500', 'SUB_ISSUER', @SubIssuer,  c.id FROM `Customer` c WHERE c.name=@Issuer AND c.customerType='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`)
VALUES
  (@Role1),
  (@Role2),
  (@Role3);

-- 3. Add Role-Customer

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name=@BankB AND r.name IN ('ADMIN_WORLDLINE', @Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name=@Issuer AND r.name IN ( @Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='SUB_ISSUER' AND c.name=@SubIssuerB AND r.name IN ( @Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='SUB_ISSUER' AND c.name=@SubIssuerC AND r.name IN ( @Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='SUB_ISSUER' AND c.name=@SubIssuer AND r.name IN ( @Role1, @Role2, @Role3);

-- 4. Add Role-Permission
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT r.id, p.id
FROM `Role` r,
     `Permission` p
WHERE r.name = @Role1
  AND p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_instance_config',
                 'Consult_events',
                 'Consult_reporting',
                 'Consult_transactions_3DS1',
                 'Consult_transactions_3DS2',
                 'Consult_bin_management',
                 'Write_bin_management',
                 'Consult_export_bins_for_ds',
                 'Consult_card_management',
                 'Write_card_management',
                 'Write_authentication_means',
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
SELECT r.id, p.id
FROM `Role` r,
     `Permission` p
WHERE r.name = @Role2
  AND p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_instance_config',
                 'Consult_events',
                 'Consult_reporting',
                 'Consult_transactions_3DS1',
                 'Consult_transactions_3DS2',
                 'Consult_bin_management',
                 'Consult_card_management',
                 'Write_card_management',
                 'Write_authentication_means',
                 'Consult_profiles_management',
                 'Write_profiles_management',
                 'Consult_scoring_management',
                 'Consult_user_xp'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT r.id, p.id
FROM `Role` r,
     `Permission` p
WHERE r.name = @Role3
  AND p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_events',
                 'Consult_card_management',
                 'Write_authentication_means',
                 'Consult_user_xp'
  );
SET FOREIGN_KEY_CHECKS=1;