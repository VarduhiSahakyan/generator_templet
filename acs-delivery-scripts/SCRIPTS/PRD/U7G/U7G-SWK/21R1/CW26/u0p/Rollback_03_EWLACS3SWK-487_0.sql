/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @subIssuer = 'Swisskey Unified AG';


SET FOREIGN_KEY_CHECKS = 0;
SET @CustomerId = (SELECT id FROM Customer WHERE `name` = @subIssuer AND `customerType` = 'SUB_ISSUER');

/*!40000 ALTER TABLE `Role_Customer` DISABLE KEYS */;
SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@subIssuer));

-- 1. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_customer, @customer_ids);

/*!40000 ALTER TABLE `Role_Customer` ENABLE KEYS */;

-- 2. Remove Customer
DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);


SET FOREIGN_KEY_CHECKS = 1;
