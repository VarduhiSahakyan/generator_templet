USE `U0P_ACS_WS`;

SET @BankB = 'UBS Switzerland AG';
SET @subIssuerA = 'UBS Switzerland AG';

SET @IssuerCode = '23000';
SET @SubIssuerCodeA = '23000';


SET @Role1 = 'UBS Admin';
START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1));

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
WHERE `name` in (@Role1);

-- 4. Remove Customer

DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;