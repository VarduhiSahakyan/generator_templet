USE `U0P_ACS_WS`;

SET @BankB = 'Swissquote';
SET @subIssuerA = 'SWISSQUOTE BANK SA';

SET @IssuerCode = '00601';
SET @SubIssuerCodeA = '00601';

SET @Role1 = 'Swissquote Admin';
SET @Role2 = 'Swissquote Helpdesk';

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
SELECT NULL, 'ENTITY', @BankB, c.id FROM `Customer` c WHERE c.name = 'Worldline' AND c.customerType = 'ENTITY';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
SELECT  @IssuerCode, 'ISSUER', @BankB,   c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ENTITY';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
SELECT @SubIssuerCodeA, 'SUB_ISSUER', @subIssuerA,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType ='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
(@Role1);
INSERT INTO `Role` (`name`) VALUES
(@Role2);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
SELECT c.id, r.id
FROM `Customer` c, `Role` r
WHERE c.customerType = 'ENTITY' AND c.name = @BankB AND r.name IN ('ADMIN_WORLDLINE', @Role1, @Role2);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
SELECT c.id, r.id
FROM `Customer` c, `Role` r
WHERE c.customerType = 'ISSUER' AND c.name = @BankB AND r.name IN (@Role1, @Role2);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
SELECT c.id, r.id
FROM `Customer` c, `Role` r
WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerA AND r.name IN (@Role1, @Role2);

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT  r.id, p.id
FROM `Role` r , `Permission` p
WHERE r.name = @Role1
  AND  p.name IN (
        'Consult_bin_management',
        'Consult_blacklisted_authentication_means',
        'Consult_blacklisted_countries',
        'Consult_blacklisted_merchants',
        'Consult_card_management',
        'Consult_cards_in_blacklist',
        'Consult_cards_in_whitelist',
        'Consult_clear_means',
        'Consult_clear_pan',
        'Consult_customitem',
        'Consult_events',
        'Consult_external_ws_data',
        'Consult_fraud_management',
        'Consult_hub_datas',
        'Consult_html_authentication_pages',
        'Consult_instance_config',
        'Consult_ip_filters',
        'Consult_issuer_config',
        'Consult_Merchant_test',
        'Consult_Merchant_test_3DS2',
        'Consult_profiles_management',
        'Consult_psd2_reports',
        'Consult_report_by_bin_range',
        'Consult_report_by_profile_set',
        'Consult_reporting',
        'Consult_role_customers',
        'Consult_role_permissions',
        'Consult_transactions_3DS1',
        'Consult_transactions_3DS2',
        'Consult_user_xp',
        'Fraud_management_blacklist_deletion',
        'read_card_profileSet',
        'Write_add_remove_card_to_blacklist',
        'Write_add_remove_card_to_whitelist',
        'Write_blacklisted_authentication_means',
        'Write_blacklisted_countries',
        'Write_blacklisted_merchants',
        'Write_ip_filters',
        'Write_reset_static_counter'
      );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT  r.id, p.id
FROM `Role` r , `Permission` p
WHERE r.name = @Role2
  AND  p.name IN (
                  'Consult_bin_management',
                  'Consult_blacklisted_authentication_means',
                  'Consult_blacklisted_countries',
                  'Consult_blacklisted_merchants',
                  'Consult_card_management',
                  'Consult_cards_in_blacklist',
                  'Consult_cards_in_whitelist',
                  'Consult_clear_means',
                  'Consult_clear_pan',
                  'Consult_customitem',
                  'Consult_events',
                  'Consult_fraud_management',
                  'Consult_html_authentication_pages',
                  'Consult_instance_config',
                  'Consult_ip_filters',
                  'Consult_issuer_config',
                  'Consult_Merchant_test',
                  'Consult_Merchant_test_3DS2',
                  'Consult_profiles_management',
                  'Consult_report_by_bin_range',
                  'Consult_transactions_3DS1',
                  'Consult_transactions_3DS2',
                  'Consult_user_xp',
                  'Write_add_remove_card_to_blacklist',
                  'Write_add_remove_card_to_whitelist',
                  'Write_blacklisted_countries',
                  'Write_blacklisted_merchants',
                  'Write_ip_filters',
                  'Write_reset_static_counter'
    );

SET FOREIGN_KEY_CHECKS = 1;