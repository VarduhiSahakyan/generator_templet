/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U0P_ACS_WS`;

-- 1. Customer
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT NULL, 'ENTITY', 'AnEntity', c.id FROM `Customer` c WHERE c.name='Worldline' AND c.customerType='ENTITY';
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT  '00010', 'ISSUER', 'AnIssuer',   c.id FROM `Customer` c WHERE c.name='AnEntity' AND c.customerType='ENTITY';
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT '00001', 'SUB_ISSUER', 'ASubIssuer',  c.id FROM `Customer` c WHERE c.name='AnIssuer' AND c.customerType='ISSUER';
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;

-- 2. Add Role
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` (`name`) VALUES
  ('ADMIN_AN_ENTITY'),
  ('HELPDESK_AN_ENTITY');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;

-- 3. Add Role-Customer
/*!40000 ALTER TABLE `Role_Customer` DISABLE KEYS */;
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ENTITY' AND c.name='AnEntity' AND r.name IN ('ADMIN_WORLDLINE', 'ADMIN_AN_ENTITY', 'HELPDESK_AN_ENTITY');

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType='ISSUER' AND c.name='AnIssuer' AND r.name IN ( 'ADMIN_AN_ENTITY', 'HELPDESK_AN_ENTITY');
/*!40000 ALTER TABLE `Role_Customer` ENABLE KEYS */;

-- 4. Add Role-Permission
/*!40000 ALTER TABLE `Role_Permission` DISABLE KEYS */;
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'ADMIN_AN_ENTITY'
        AND  p.name IN (
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
  );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
  SELECT  r.id, p.id
  FROM `Role` r , `Permission` p
  WHERE r.name  = 'HELPDESK_AN_ENTITY'
        AND  p.name IN (
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
  );
/*!40000 ALTER TABLE `Role_Permission` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;