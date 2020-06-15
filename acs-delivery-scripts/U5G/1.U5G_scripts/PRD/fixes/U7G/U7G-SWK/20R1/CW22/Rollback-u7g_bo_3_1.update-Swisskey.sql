/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuerCS = 'Crédit Suisse AG';
SET @subIssuerNAB = 'Neue Aargauer Bank';
SET @subIssuerSGKB = 'St. Galler Kantonalbank AG';
SET @subIssuerSOBA = 'Baloise Bank SoBa AG';

SET @IssuerCode = '41001';
SET @SubIssuerCodeCS = '48350';
SET @SubIssuerCodeNAB = '58810';
SET @SubIssuerCodeSGKB = '78100';
SET @SubIssuerCodeSOBA = '83340';

SET @Role1 = 'Swisskey Admin';
SET @Role2 = 'Swisskey Reporting';
SET @Role3 = 'Swisskey Helpdesk';

SET @RoleCS = 'Credit Suisse Admin';
SET @RoleNAB = 'Neue Aargauer Bank Admin';
SET @RoleSGKB = 'St Galler Kantonalbank Admin';
SET @RoleSOBA = 'Baloise Bank SoBa AG Admin';

SET FOREIGN_KEY_CHECKS = 0;

SET @role_ids = (SELECT group_concat(id)
                 FROM `Role`
                 WHERE name in (@Role2, @Role3, @RoleCS, @RoleNAB, @RoleSGKB, @RoleSOBA));

-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE find_in_set(id_role, @role_ids);

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_role, @role_ids);


-- 3. Remove Role
DELETE
FROM `Role`
WHERE find_in_set(id, @role_ids);

-- 4. Remove Customer
SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@subIssuerSOBA));
DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
