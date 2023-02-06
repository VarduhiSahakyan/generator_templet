USE `U0P_ACS_WS`;

SET @createdBy = 'A758582';

SET @BankB_1 = 'Volkswagen Bank';
SET @BankB_2 = 'Audi Bank';
SET @IssuerCode = '19150';
SET @SubIssuerCode_1 = '19151';
SET @SubIssuerCode_2 = '19152';


SET @Role1 = 'VW ADMIN';
SET @Role2 = 'VW Karteninhaberservice';


SET FOREIGN_KEY_CHECKS = 0;
SET @roleIds = (SELECT group_concat(id)
                       FROM `Role`
                       WHERE name in (@Role1, @Role2));
-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2));

SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@BankB_1, @BankB_2));


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
