/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U0P_ACS_WS`;

-- 1. Remove Role-Permission
/*!40000 ALTER TABLE `Role_Permission` DISABLE KEYS */;
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='ADMIN_AN_ENTITY')
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
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='HELPDESK_AN_ENTITY')
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
/*!40000 ALTER TABLE `Role_Permission` ENABLE KEYS */;

-- 2. Remove Role-Customer
/*!40000 ALTER TABLE `Role_Customer` DISABLE KEYS */;
DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ENTITY' AND c.name='AnEntity')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_WORLDLINE', 'ADMIN_AN_ENTITY', 'HELPDESK_AN_ENTITY'));

DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.customerType='ISSUER' AND c.name='AnIssuer')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_AN_ENTITY', 'HELPDESK_AN_ENTITY'));
/*!40000 ALTER TABLE `Role_Customer` ENABLE KEYS */;

-- 3. Remove Role
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
DELETE FROM `Role` WHERE `name` IN
   ('ADMIN_AN_ENTITY',
    'HELPDESK_AN_ENTITY');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;

-- 4. Remove Customer
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
DELETE FROM `Customer` WHERE `code`='00001' AND `customerType`='SUB_ISSUER' AND `name`='ASubIssuer';
DELETE FROM `Customer` WHERE `code`='00010' AND `customerType`='ISSUER' AND `name`='AnIssuer';
DELETE FROM `Customer` WHERE `customerType`='ENTITY' AND `name`='AnEntity';
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;