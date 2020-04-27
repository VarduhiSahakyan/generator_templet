USE `U0P_ACS_WS`;

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='ADMIN_BANK_B')
AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
  'Consult_events',
  'Consult_clear_pan',
  'Consult_clear_means',
  'Consult_reporting',
  'Consult_Merchant_test'
  'Consult_card_management',
  'Consult_issuer_config',             'Write_issuer_config',
  'Consult_bin_management',            'Write_bin_management',
  'Consult_fraud_management',          'Write_fraud_management',
  'Consult_profiles_management',       'Write_profiles_management',
  'Consult_html_authentication_pages', 'Write_html_authentication_pages',
  'Write_authentication_means',
  'Write_reset_static_counter',
  'Write_add_remove_card_to_blacklist'
)
);

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='HELPDESK_BANK_B')
      AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
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
)
);

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ENTITY' AND c.name='BankB')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_WORLDLINE', 'ADMIN_BANK_B', 'HELPDESK_BANK_B'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ISSUER' AND c.name='IssuerB')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_BANK_B', 'HELPDESK_BANK_B'));

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` IN ('ADMIN_BANK_B', 'HELPDESK_BANK_B');

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `code`='00012' AND `customerType`='SUB_ISSUER' AND `name`='SubIssuerB';
DELETE FROM `Customer` WHERE `code`='00002' AND `customerType`='ISSUER' AND `name`='IssuerB';
DELETE FROM `Customer` WHERE `customerType`='ENTITY' AND `name`='BankB';