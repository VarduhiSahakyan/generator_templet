USE `U0P_ACS_WS`;

SET @createdBy = 'W100851';

SET @BankB_1 = 'RCBC';
SET @BankB_2 = 'RCBC Debit';
SET @BankB_3 = 'Bankard Credit';



SET @Role1 = 'RCBC';
SET @Role2 = 'RCBC Debit';
SET @Role3 = 'Bankard Credit';


SET FOREIGN_KEY_CHECKS = 0;
SET @roleIds = (SELECT group_concat(id)
					FROM `Role`
					WHERE name in (@Role1, @Role2, @Role3));
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2, @Role3));

SET @customer_ids = (SELECT group_concat(id)
					FROM `Customer`
					WHERE name in (@BankB_1, @BankB_2, @BankB_3));


-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(`id_role`, @roleIds);

-- 3. Remove Role
DELETE
FROM `Role`
WHERE find_in_set(`id`, @roleIds);

-- 4. Remove Customer
DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);


SET FOREIGN_KEY_CHECKS = 1;
