USE `U0P_ACS_WS`;

SET @createdBy = 'W100851';

-- Delete LBB

SET @Bank_LBB = 'LANDESBANK_BERLIN';

SET @Role1_LBB = 'ADMIN_LBB';
SET @Role2_LBB = 'RISK_LBB';
SET @Role3_LBB = 'ORGA_LBB';
SET @Role4_LBB = 'CB_LBB';
SET @Role5_LBB = 'C24_LBB';

SET FOREIGN_KEY_CHECKS = 0;

SET @RoleIds_LBB = (SELECT group_concat(id)
                FROM `Role`
                WHERE name in (@Role1_LBB, @Role2_LBB, @Role3_LBB, @Role4_LBB, @Role5_LBB));

SET @CustomerIds_LBB = (SELECT group_concat(id) FROM `Customer` WHERE name like '%LANDESBANK_BERLIN%');

-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1_LBB, @Role2_LBB, @Role3_LBB, @Role4_LBB, @Role5_LBB));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(`id_role`, @RoleIds_LBB);

-- 3. Remove Role
DELETE
FROM `Role`
WHERE find_in_set(`id`, @RoleIds_LBB);

-- 4. Remove Customer
DELETE
FROM Customer
WHERE find_in_set(id, @CustomerIds_LBB);

SET FOREIGN_KEY_CHECKS = 1;