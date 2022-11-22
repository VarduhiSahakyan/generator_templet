USE `U0P_ACS_WS`;

SET @BankB = 'Swissquote';

SET @subIssuerA = 'SWISSQUOTE BANK SA';

SET @IssuerCode = '00601';
SET @SubIssuerCodeA = '00601';

SET @Role1 = 'Swissquote Admin';
SET @Role2 = 'Swissquote Helpdesk';


SET FOREIGN_KEY_CHECKS = 0;
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2));

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
WHERE `name` in (@Role1, @Role2);

-- 4. Remove Customer

DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;