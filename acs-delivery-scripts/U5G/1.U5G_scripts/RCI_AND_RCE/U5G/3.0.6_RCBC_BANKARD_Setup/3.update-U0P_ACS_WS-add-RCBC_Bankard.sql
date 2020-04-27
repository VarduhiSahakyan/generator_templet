USE `U0P_ACS_WS`;

SET @BankB = 'RCBC Bankard';
SET @IssuerA = 'Bankard Credit';
SET @IssuerB = 'RCBC Debit';
SET @IssuerCode = '00006';
SET @SubIssuerCodeA = '00006';
SET @SubIssuerCodeB = '00018';
SET @Role1 = 'ADMIN_BKD';
SET @Role2 = 'CustomerSVC_BKD';
SET @Role3 = 'FMAG_BKD';
SET @Role4 = 'ADMIN_RCB';
SET @Role5 = 'CustomerSVC_RCB';
SET @Role6 = 'FMAG_RCB';



-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', @BankB, c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
/*sssss*/
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  @IssuerCode, 'ISSUER', @BankB,   c.id FROM `Customer` c WHERE c.name=@BankB AND c.customerType='ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCodeA, 'SUB_ISSUER', @IssuerA,  c.id FROM `Customer` c WHERE c.name=@BankB AND c.customerType='ISSUER';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCodeB, 'SUB_ISSUER', @IssuerB,  c.id FROM `Customer` c WHERE c.name=@BankB AND c.customerType='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  (@Role1),
  (@Role2),
  (@Role3),
  (@Role4),
  (@Role5),
  (@Role6);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name=@BankB AND r.name IN ('ADMIN_WORLDLINE', @Role1, @Role2, @Role3, @Role4, @Role5, @Role6);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='SUB_ISSUER' AND c.name=@IssuerA AND r.name IN ( @Role1, @Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='SUB_ISSUER' AND c.name=@IssuerB AND r.name IN ( @Role4, @Role5, @Role6);

-- 4. Add Role-Permission
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role1
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_clear_means',
	'Consult_instance_config',
	'Consult_events',
    'Consult_reporting',
    'Consult_bin_management',            'Write_bin_management',
	'Consult_export_bins_for_ds',
	'Consult_card_management',			 'Write_card_management',
										 'Write_authentication_means',
	'Consult_fraud_management',          'Write_fraud_management',
										 'Write_add_remove_card_to_blacklist',
    'Consult_profiles_management',       'Write_profiles_management',
    'Consult_html_authentication_pages', 'Write_html_authentication_pages',
    'Consult_Merchant_test',
	'Consult_monitoring'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role2
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_events',
    'Consult_card_management',
    'Write_authentication_means'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role3
        AND  p.name IN (
    'Consult_clear_means',
	'Consult_instance_config',
    'Consult_events',
	'Consult_reporting',
	'Consult_bin_management',
    'Consult_card_management',
	'Consult_fraud_management',
	'Write_fraud_management',
    'Write_add_remove_card_to_blacklist',
	'Consult_html_authentication_pages',
    'Consult_monitoring'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role4
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_clear_means',
	'Consult_instance_config',
	'Consult_events',
    'Consult_reporting',
    'Consult_bin_management',            'Write_bin_management',
	'Consult_export_bins_for_ds',
	'Consult_card_management',			 'Write_card_management',
										 'Write_authentication_means',
	'Consult_fraud_management',          'Write_fraud_management',
										 'Write_add_remove_card_to_blacklist',
    'Consult_profiles_management',       'Write_profiles_management',
    'Consult_html_authentication_pages', 'Write_html_authentication_pages',
    'Consult_Merchant_test',
	'Consult_monitoring'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role5
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_events',
    'Consult_card_management',
    'Write_authentication_means'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role6
        AND  p.name IN (
    'Consult_clear_means',
	'Consult_instance_config',
    'Consult_events',
	'Consult_reporting',
	'Consult_bin_management',
    'Consult_card_management',
	'Consult_fraud_management',
	'Write_fraud_management',
    'Write_add_remove_card_to_blacklist',
	'Consult_html_authentication_pages',
    'Consult_monitoring'
  );
