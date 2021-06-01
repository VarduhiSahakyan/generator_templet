USE `U0P_ACS_WS`;

SET @BankB = 'Commerzbank Cobrands';
SET @Role1 = 'CoBa_ADMIN';

SET FOREIGN_KEY_CHECKS=0; 
-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name = @Role1);

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name = @Role1);

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` = @Role1;

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `name`=@BankB;
SET FOREIGN_KEY_CHECKS=1; 
