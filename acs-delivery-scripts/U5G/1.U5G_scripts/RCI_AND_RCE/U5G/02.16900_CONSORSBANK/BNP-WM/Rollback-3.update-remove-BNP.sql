/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Consorsbank';
SET @subIssuerBNP = 'BNP Paribas Wealth Management';

SET @IssuerCode = '16900';
SET @SubIssuerCodeBNP = '16901';

SET FOREIGN_KEY_CHECKS = 0;

SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@subIssuerBNP));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_customer, @customer_ids);

-- 4. Remove Customer
DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
