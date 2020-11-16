/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuer = 'Swisskey AG';

SET @IssuerCode = '41001';
SET @SubIssuerCode = '41001';

SET @Role1 = 'Swisskey Admin';

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Customer
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode, 'SUB_ISSUER', @subIssuer,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType ='ISSUER';


-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  (@Role1);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuer AND r.name IN (@Role1);


INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT  r.id, p.id
FROM `Role` r , `Permission` p
WHERE r.name = @Role1
  AND  p.name IN (
        'Consult_clear_pan',
        'Consult_events',
        'Consult_reporting',
        'Consult_bin_management',
        'Write_bin_management',
        'Consult_export_bins_for_ds',
        'Consult_card_management',
        'Write_authentication_means',
        'Write_reset_static_counter',
        'Consult_fraud_management',
        'Write_fraud_management',
        'Write_add_remove_card_to_blacklist',
        'Consult_profiles_management',
        'Consult_html_authentication_pages',
        'Consult_Merchant_test',
        'Consult_monitoring',
        'Consult_instance_config',
        'Consult_hub_datas',
        'Consult_user_list',
        'Consult_role_permissions',
        'Write_role_permissions',
        'Consult_role_customers',
        'Write_role_customers',
        'Consult_merchant_pivot',
        'Write_merchant_pivot',
        'Consult_audit_tools',
        'Consult_external_ws_data',
        'Consult_transactions_3DS1',
        'Consult_transactions_3DS2',
        'Consult_RBA_Decision',
        'Consult_blacklisted_authentication_means',
        'Write_blacklisted_authentication_means',
        'Consult_ip_filters',
        'Write_ip_filters',
        'Consult_blacklisted_merchants',
        'Write_blacklisted_merchants',
        'Consult_blacklisted_countries',
        'Write_blacklisted_countries',
        'Consult_cards_in_blacklist',
        'Consult_cards_in_whitelist',
        'Write_add_remove_card_to_whitelist',
        'write_internal_datas',
        'Write_card_profileSet',
        'read_card_profileSet',
        'Consult_cards_in_exemption_list',
        'Write_add_remove_card_to_exemption_list',
        'Consult_psd2_reports'
    );
SET FOREIGN_KEY_CHECKS = 1;
