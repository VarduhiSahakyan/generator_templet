/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuerC = 'St. Galler Kantonalbank AG';

SET @SubIssuerCodeC = '78100';

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
  SELECT @SubIssuerCodeC, 'SUB_ISSUER', @subIssuerC,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
  (@Role1);

-- 3. Add Role-Customer

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
  SELECT c.id, r.id
  FROM `Customer` c, `Role` r
  WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerC AND r.name IN (@Role1);

SET FOREIGN_KEY_CHECKS = 1;
