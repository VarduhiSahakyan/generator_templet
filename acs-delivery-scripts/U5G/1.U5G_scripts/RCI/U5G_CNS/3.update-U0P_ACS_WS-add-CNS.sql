USE `U0P_ACS_WS`;

-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', 'Consorsbank', c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '16900', 'ISSUER', 'Consorsbank',   c.id FROM `Customer` c WHERE c.name='Consorsbank' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '16900', 'SUB_ISSUER', 'Consorsbank',  c.id FROM `Customer` c WHERE c.name='Consorsbank' AND c.customerType='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  ('CONSORS_ADMIN'),
  ('CONSORS_INTERN');

-- 3. Add Role-Customer

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name='Consorsbank' AND r.name IN ('CONSORS_ADMIN', 'CONSORS_INTERN');


 INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name='Consorsbank'
        AND r.name IN ('CONSORS_ADMIN', 'CONSORS_INTERN');
		

-- 4. Add Role-Permission
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'CONSORS_ADMIN'
        AND  p.name IN (
    'Consult_clear_means', 'Consult_clear_pan',
    'Consult_instance_config',
    'Consult_events',
    'Consult_reporting',
    'Consult_export_bins_for_ds',
    'Consult_bin_management', 'Write_bin_management',
    'Consult_card_management', 'Write_card_management',
    'Write_authentication_means',
    'Consult_fraud_management', 'Write_fraud_management',
    'Write_add_remove_card_to_blacklist',
    'Consult_Profiles_management', 'Write_Profiles_management',
    'Consult_html_authentication_pages', 'Write_html_authentication_pages',
    'Consult_Merchant_test',
    'Consult_monitoring'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'CONSORS_INTERN'
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_events',
    'Consult_card_management',
    'Consult_reporting',
	'Consult_fraud_management',
	'Write_fraud_management',
	'Write_add_remove_card_to_blacklist',
	'Consult_Profiles_management',
    'Consult_html_authentication_pages', 'Write_html_authentication_pages',
    'Consult_Merchant_test'
    
  );