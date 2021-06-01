/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuer = 'Swisskey AG';

SET @IssuerCode = '41001';
SET @SubIssuerCode = '41001';

SET @Role1 = 'ADMIN_SWISSKEY';
SET @Role2 = 'REPORTING_SWISSKEY';
SET @Role3 = 'HELPDESK_SWISSKEY';

SET FOREIGN_KEY_CHECKS = 0;

SET @IdRole1 = (SELECT id FROM `Role` WHERE `name` = 'ADMIN_SWISSKEY');
SET @IdRole2 = (SELECT id FROM `Role` WHERE `name` = 'REPORTING_SWISSKEY');
SET @IdRole3 = (SELECT id FROM `Role` WHERE `name` = 'HELPDESK_SWISSKEY');

-- 1. Customer
/* This next command should be executed only if there is no migration process (ACS1 > ACS3) */
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCode, 'SUB_ISSUER', @subIssuer,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType ='ISSUER';

SET @CustomerId = (SELECT id FROM Customer WHERE `name` = @subIssuer AND `customerType` = 'SUB_ISSUER');

-- 2. Add Role-Customer
/*!40000 ALTER TABLE `Role_Customer` DISABLE KEYS */;

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.id =@CustomerId  AND r.id  IN (@IdRole1, @IdRole2, @IdRole3);

/*!40000 ALTER TABLE `Role_Customer` ENABLE KEYS */;

SET FOREIGN_KEY_CHECKS = 1;
