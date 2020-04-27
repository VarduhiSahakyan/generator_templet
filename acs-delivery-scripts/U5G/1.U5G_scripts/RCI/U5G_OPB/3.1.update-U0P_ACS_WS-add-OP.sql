USE `U0P_ACS_WS`;

-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
SELECT  NULL , 'ENTITY', 'OP Bank',   c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '20000', 'ISSUER', 'OP Bank',   c.id FROM `Customer` c WHERE c.name='OP Bank' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '20000', 'SUB_ISSUER', 'OP Bank',  c.id FROM `Customer` c WHERE c.name='OP Bank' AND c.customerType='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES ('ADMIN_OP');
INSERT INTO `Role` (`name`) VALUES ('HELPDESK_OP');

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name='OP Bank'
        AND r.name IN ( 'ADMIN_OP', 'HELPDESK_OP');

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name='OP Bank'
        AND r.name IN ('ADMIN_WORLDLINE');

-- 4. Add role permissions

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'ADMIN_OP'
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_clear_means',
    'Consult_instance_config',
    'Consult_events ',
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
    'Consult_monitoring'
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'HELPDESK_OP'
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_clear_means',
    'Consult_instance_config',
    'Consult_events ',
    'Consult_bin_management',
    'Consult_card_management',
    'Consult_fraud_management',
    'Write_add_remove_card_to_blacklist',
    'Consult_profiles_management',
    'Consult_html_authentication_pages'
  );