USE `U0P_ACS_WS`;

set @issuerName = 'Comdirect';
set @issuerCode = '16600';
set @subIssuerCode = '16600';

-- roles for comdirect

set @serviceRole = 'COMDIRECT_Service ACS';
set @adminRole = 'COMDIRECT_ADMIN';

-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', @issuerName, c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  @issuerCode, 'ISSUER', @issuerName,   c.id FROM `Customer` c WHERE c.name=@issuerName AND c.customerType='ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @subIssuerCode, 'SUB_ISSUER', @issuerName,  c.id FROM `Customer` c WHERE c.name=@issuerName AND c.customerType='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  (@serviceRole),
  (@adminRole);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name=@issuerName AND r.name IN ('ADMIN_WORLDLINE', @serviceRole, @adminRole);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name=@issuerName AND r.name IN ( @serviceRole, @adminRole);

-- 4. Add Role-Permission
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = @adminRole
        AND  p.name IN (
    'Consult_instance_config',
    'Consult_events',
    'Consult_reporting',
    'Consult_bin_management',
    'Write_bin_management',
    'Consult_export_bins_for_ds',
    'Consult_card_management',
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
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'HELPDESK_BANK_B'
        AND  p.name IN (
    'Consult_events',
    'Consult_clear_pan',
    'Consult_clear_means',
    'Consult_issuer_config',
    'Consult_instance_config',
    'Consult_bin_management',
    'Consult_card_management',
    'Consult_fraud_management',
    'Consult_profiles_management',
    'Consult_html_authentication_pages',
    'Write_reset_static_counter',
    'Write_add_remove_card_to_blacklist'
  );
