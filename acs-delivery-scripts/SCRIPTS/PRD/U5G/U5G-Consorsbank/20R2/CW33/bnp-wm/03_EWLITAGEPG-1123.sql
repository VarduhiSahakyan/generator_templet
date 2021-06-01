/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Consorsbank';
SET @subIssuerA = 'BNP Paribas Wealth Management';

SET @Role1 = 'BNPWM Admin';
SET @Role2 = 'BNPWM Intern';

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2));


INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT  r.id, p.id
FROM `Role` r , `Permission` p
WHERE r.name = @Role1
  AND  p.name IN (
        'Consult_clear_pan',
        'Consult_clear_means',
        'Consult_instance_config',
        'Consult_transactions_3DS1',
        'Consult_transactions_3DS2',
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
        'Write_html_authentication_pages',
        'Consult_Merchant_test',
        'Consult_monitoring'
    );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT  r.id, p.id
FROM `Role` r , `Permission` p
WHERE r.name = @Role2
  AND  p.name IN (
        'Consult_clear_pan',
        'Consult_transactions_3DS1',
        'Consult_transactions_3DS2',
        'Consult_reporting',
        'Consult_card_management',
        'Consult_fraud_management',
        'Write_fraud_management',
        'Write_add_remove_card_to_blacklist',
        'Consult_profiles_management',
        'Write_profiles_management',
        'Write_html_authentication_pages',
        'Consult_Merchant_test'
        );
SET FOREIGN_KEY_CHECKS = 1;
