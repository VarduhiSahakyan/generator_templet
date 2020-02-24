USE `U0P_ACS_WS`;

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='ADMIN_CBC')
AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
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
)
);

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='Helpdesk_CBC')
      AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
    'Consult_clear_means', 'Consult_clear_pan',
    'Consult_events',
    'Consult_card_management',
    'Write_authentication_means'
)
);

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ENTITY' AND c.name='China Bank Corporation')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_WORLDLINE','ADMIN_CBC', 'Helpdesk_CBC'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ISSUER' AND c.name='China Bank Corporation')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_CBC', 'Helpdesk_CBC'));

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` IN ('ADMIN_CBC', 'Helpdesk_CBC');

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `code`='00070' AND `customerType`='SUB_ISSUER' AND `name`='China Bank Corporation';
DELETE FROM `Customer` WHERE `code`='00070' AND `customerType`='ISSUER' AND `name`='China Bank Corporation';
DELETE FROM `Customer` WHERE `customerType`='ENTITY' AND `name`='China Bank Corporation';
