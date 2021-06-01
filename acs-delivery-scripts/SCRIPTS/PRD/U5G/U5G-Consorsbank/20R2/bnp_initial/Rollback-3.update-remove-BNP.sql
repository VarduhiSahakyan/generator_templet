/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Consorsbank';
SET @subIssuerBNP = 'BNP Paribas Wealth Management';

SET @IssuerCode = '16900';
SET @SubIssuerCodeBNP = '16901';
SET @Role1 = 'BNPWM Admin';
SET @Role2 = 'BNPWM Intern';

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2));


SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@subIssuerBNP));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_customer, @customer_ids);

-- 3. Remove Role
DELETE
FROM `Role`
WHERE `name` in (@Role1, @Role2);

-- 4. Remove Customer
DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
