USE `U0P_ACS_WS`;

SET @BankB = 'Raiffeisenbank Schweiz';

SET @subIssuerA = 'Raiffeisenbank Schweiz';

SET @IssuerCode = '80808';
SET @SubIssuerCodeA = '80808';

SET @Role1 = 'Raiffeisenbank Schweiz Admin';
SET @Role2 = 'Raiffeisenbank Schweiz Reporting';
SET @Role3 = 'Raiffeisenbank Schweiz Helpdesk';

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