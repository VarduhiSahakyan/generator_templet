USE `U0P_ACS_WS`;

SET @BankB = 'Commerzbank AG';
SET @IssuerB = 'Commerzbank AG';
SET @Role1 = 'ADMIN_CoBa';

SET FOREIGN_KEY_CHECKS=0;
-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', @BankB, c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
/*sssss*/
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '19440', 'ISSUER', @IssuerB,   c.id FROM `Customer` c WHERE c.name=@BankB AND c.customerType='ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '19440', 'SUB_ISSUER', @IssuerB,  c.id FROM `Customer` c WHERE c.name=@IssuerB AND c.customerType='ISSUER';


-- 2. Add Role
/*INSERT INTO `Role` (`name`)
VALUES
  (@Role1);*/

-- 3. Add Role-Customer

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name=@BankB AND r.name IN ('ADMIN_WORLDLINE', @Role1);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name=@IssuerB AND r.name IN ( @Role1);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='SUB_ISSUER' AND c.name=@IssuerB AND r.name IN ( @Role1);

-- 4. Add Role-Permission
/* INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT r.id, p.id
FROM `Role` r,
     `Permission` p
WHERE r.name = @Role1
  AND p.name IN (
                 'Consult_clear_pan',
                 'Consult_clear_means',
                 'Consult_instance_config',
                 'Consult_transactions_3DS1',
                 'Consult_transactions_3DS2',
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
                 'Write_scoring_management'
  ); */
SET FOREIGN_KEY_CHECKS=1;