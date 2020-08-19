/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuerTGKB = 'Thurgauer Kantonalbank';

SET @IssuerCode = '41001';
SET @SubIssuerCodeTGKB = '78400';

SET @Role1 = 'Swisskey Admin';
SET @Role2 = 'Swisskey Reporting';
SET @Role3 = 'Swisskey Helpdesk';
SET @RoleTGKB = 'Thurgauer Kantonalbank Admin';

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
SELECT @SubIssuerCodeTGKB, 'SUB_ISSUER', @subIssuerTGKB,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType ='ISSUER';

-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES (@RoleTGKB);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
SELECT c.id, r.id
FROM `Customer` c, `Role` r
WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerTGKB AND r.name IN (@Role1, @Role2, @Role3, @RoleTGKB);

-- 4. Add Role-Permission
INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
SELECT  r.id, p.id
FROM `Role` r , `Permission` p
WHERE r.name = @Role1
  AND  p.name IN (
                  'Consult_events',
                  'Consult_reporting',
                  'Consult_Merchant_test',
                  'Consult_transactions_3DS1',
                  'Consult_transactions_3DS2'
    );

SET FOREIGN_KEY_CHECKS = 1;
