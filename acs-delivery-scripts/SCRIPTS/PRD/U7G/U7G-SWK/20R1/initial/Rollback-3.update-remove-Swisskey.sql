USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuerA = 'Crédit Suisse AG';
SET @subIssuerB = 'Neue Aargauer Bank';
SET @subIssuerC = 'St. Galler Kantonalbank AG';

SET @IssuerCode = '41001';
SET @SubIssuerCodeA = '48350';
SET @SubIssuerCodeB = '58810';
SET @SubIssuerCodeC = '78100';

SET @Role1 = 'Swisskey Admin';
START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1));

SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@BankB, @subIssuerA, @subIssuerB, @subIssuerC));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_customer, @customer_ids);

-- 3. Remove Role
DELETE
FROM `Role`
WHERE `name` in (@Role1);

-- 4. Remove Customer

DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;