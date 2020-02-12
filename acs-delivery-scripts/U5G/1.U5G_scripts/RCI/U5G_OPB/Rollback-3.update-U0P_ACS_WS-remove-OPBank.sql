USE `U0P_ACS_WS`;

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='HELPDESK_OP')
AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
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
)
);

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='ADMIN_OP')
      AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
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
)
);

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ISSUER' AND c.name='OP Bank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_OP', 'HELPDESK_OP'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ENTITY' AND c.name='OP Bank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_WORLDLINE'));

DELETE FROM Role_Permission where ID_ROLE in (select id from Role where name in ('ADMIN_OP', 'HELPDESK_OP'));

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` IN ('ADMIN_OP', 'HELPDESK_OP');

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `code`='20000' AND `customerType`='SUB_ISSUER' AND `name`='OP Bank';
DELETE FROM `Customer` WHERE `code`='20000' AND `customerType`='ISSUER' AND `name`='OP Bank';
DELETE FROM `Customer` WHERE `customerType`='ENTITY' AND `name`='OP Bank';