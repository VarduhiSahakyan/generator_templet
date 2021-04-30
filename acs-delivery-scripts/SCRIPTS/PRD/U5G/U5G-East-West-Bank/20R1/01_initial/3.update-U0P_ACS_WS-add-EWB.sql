USE `U0P_ACS_WS`;

SET @BankB = 'East West Bank';
SET @IssuerB = 'East West Bank';
SET @Role1 = 'ADMIN_EWB';
SET @Role2 = 'MARK_EWB';
SET @Role3 = 'CBSD_EWB';
SET @Role4 = 'CSR_EWB';
SET @Role5 = 'CREDIT_EWB';
SET @Role6 = 'FRAUD_EWB';
SET @Role7 = 'CF_EWB';
SET @Role8 = 'AUTHS_EWB';
SET @Role9 = 'REPORTING_EWB';
SET @Role10 = 'INQUIRY_EWB';
SET @Role11 = 'TEST_EWL_EWB';




-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', @BankB, c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
/*sssss*/
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '00062', 'ISSUER', @IssuerB,   c.id FROM `Customer` c WHERE c.name=@BankB AND c.customerType='ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '00062', 'SUB_ISSUER', @IssuerB,  c.id FROM `Customer` c WHERE c.name=@IssuerB AND c.customerType='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  (@Role1),
  (@Role2),
  (@Role3),
  (@Role4),
  (@Role5),
  (@Role6),
  (@Role7),
  (@Role8),
  (@Role9),
  (@Role10),
  (@Role11);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name=@BankB AND r.name IN ('ADMIN_WORLDLINE', @Role1,  @Role2,  @Role3,  @Role4,  @Role5,  @Role6,  @Role7,  @Role8,  @Role9,  @Role10,  @Role11);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name=@IssuerB AND r.name IN ( @Role1,  @Role2,  @Role3,  @Role4,  @Role5,  @Role6,  @Role7,  @Role8,  @Role9,  @Role10,  @Role11);

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
    'Consult_html_authentication_pages'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role3
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_instance_config',
	'Consult_reporting',
    'Consult_bin_management',            'Write_bin_management',
    'Consult_card_management',			 'Write_card_management',
										 'Write_authentication_means',
    'Consult_fraud_management',          'Write_fraud_management',
										 'Write_add_remove_card_to_blacklist',
    'Consult_profiles_management',       'Write_profiles_management'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role4
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_card_management',			 'Write_card_management',
										 'Write_authentication_means'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role5
        AND  p.name IN (
    'Write_authentication_means'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role6
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_instance_config',
	'Consult_reporting',
    'Consult_card_management',			 'Write_card_management',
										 'Write_authentication_means'
    'Consult_fraud_management',          'Write_fraud_management',
										 'Write_add_remove_card_to_blacklist'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role7
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_card_management',			 'Write_card_management',
										 'Write_authentication_means'
  );
  /*
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role8
        AND  p.name IN (
    
  );*/
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role9
        AND  p.name IN (
    'Consult_reporting'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role10
        AND  p.name IN (
    'Consult_clear_means'
  );
  
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @Role11
        AND  p.name IN (
    'Consult_clear_means',
    'Consult_instance_config',
	'Consult_events',
	'Consult_reporting',
    'Consult_card_management'
  );
