USE `U0P_ACS_WS`;

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='ADMIN_RB')
AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
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
    'Consult_monitoring'
)
);

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='F-Call_RB')
      AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
  'Consult_clear_pan',
    'Consult_clear_means',
    'Consult_events',
    'Consult_reporting',
    'Consult_card_management',
    'Write_authentication_means'
)
);

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='BOPP_RB')
      AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
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
    'Consult_monitoring'
)
);

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='IT_RB')
      AND   id_permission IN (SELECT p.id FROM `Permission` p WHERE p.name IN (
    'Write_bin_management',
    'Consult_export_bins_for_ds',
    'Write_fraud_management',
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
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ENTITY' AND c.name='ReiseBank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_RB', 'F-Call_RB', 'BOPP_RB', 'IT_RB'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ISSUER' AND c.name='ReiseBank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_RB', 'F-Call_RB', 'BOPP_RB', 'IT_RB'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='SUBISSUER' AND c.name='ReiseBank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_RB', 'F-Call_RB', 'BOPP_RB', 'IT_RB'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType in ('ENTITY', 'SUBISSUER', 'ISSUER')  AND c.name='ReiseBank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_WORLDLINE'));

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` IN ('ADMIN_RB', 'F-Call_RB', 'BOPP_RB', 'IT_RB');

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `code`='12000' AND `customerType`='SUB_ISSUER' AND `name`='ReiseBank';
DELETE FROM `Customer` WHERE `code`='10300' AND `customerType`='ISSUER' AND `name`='ReiseBank';
DELETE FROM `Customer` WHERE `customerType`='ENTITY' AND `name`='ReiseBank';