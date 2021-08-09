USE `U0P_ACS_WS`;

SET @BankB = 'Banque Cantonale Vaudoise';
SET @subIssuerA = 'Banque Cantonale Vaudoise';

SET @IssuerCode = '76700';
SET @SubIssuerCodeA = '76700';

SET @Role1 = 'Banque Cantonale Vaudoise Admin';
SET @Role2 = 'Banque Cantonale Vaudoise Reporting';
SET @Role3 = 'Banque Cantonale Vaudoise Helpdesk';

START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2, @Role3));

SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@BankB, @subIssuerA));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_customer, @customer_ids);

-- 3. Remove Role
DELETE
FROM `Role`
WHERE `name` in (@Role1, @Role2, @Role3);

-- 4. Remove Customer

DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;