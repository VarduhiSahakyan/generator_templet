USE `U0P_ACS_WS`;

-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
SELECT  NULL , 'ENTITY', 'ReiseBank',   c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '10300', 'ISSUER', 'ReiseBank',   c.id FROM `Customer` c WHERE c.name='ReiseBank' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '12000', 'SUB_ISSUER', 'ReiseBank',  c.id FROM `Customer` c WHERE c.name='ReiseBank' AND c.customerType='ISSUER';

-- 2. Add Role

INSERT INTO `Role` (`name`) VALUES ('ADMIN_RB');
INSERT INTO `Role` (`name`) VALUES ('F-Call_RB');
INSERT INTO `Role` (`name`) VALUES ('BOPP_RB');
INSERT INTO `Role` (`name`) VALUES ('IT_RB');

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name='ReiseBank'
        AND r.name IN ('ADMIN_RB', 'F-Call_RB', 'BOPP_RB', 'IT_RB');

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name='ReiseBank'
        AND r.name IN ('ADMIN_WORLDLINE');

-- 4. Add role permissions

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'ADMIN_RB'
        AND  p.name IN (
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
    'Consult_monitoring');

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'F-Call_RB'
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_clear_means',
    'Consult_events',
    'Consult_reporting',
    'Consult_card_management',
    'Write_authentication_means');

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'BOPP_RB'
        AND  p.name IN (
    'Consult_clear_pan',
    'Consult_clear_means',
    'Consult_instance_config',
    'Consult_events',
    'Consult_reporting',
    'Consult_bin_management',
    'Consult_card_management',
    'Write_card_management',
    'Write_authentication_means',
    'Consult_fraud_management',
    'Write_add_remove_card_to_blacklist',
    'Consult_Merchant_test',
    'Consult_monitoring');

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'IT_RB'
        AND  p.name IN (
    'Write_bin_management',
    'Consult_export_bins_for_ds',
    'Write_fraud_management',
    'Consult_profiles_management',
    'Write_profiles_management',
    'Consult_html_authentication_pages',
    'Write_html_authentication_pages',
    'Consult_Merchant_test',
    'Consult_monitoring');
