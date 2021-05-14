USE `U0P_ACS_WS`;

SET @BankB = 'Zürcher Kantonalbank';
SET @subIssuerA = 'Zürcher Kantonalbank';

SET @IssuerCode = '70000';
SET @SubIssuerCodeA = '70000';

SET @Role1 = 'Zürcher Kantonalbank Admin';
SET @Role2 = 'Zürcher Kantonalbank Reporting';
SET @Role3 = 'Zürcher Kantonalbank Helpdesk';

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