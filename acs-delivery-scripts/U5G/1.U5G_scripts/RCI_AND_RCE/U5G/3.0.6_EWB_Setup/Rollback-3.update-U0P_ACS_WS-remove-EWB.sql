USE `U0P_ACS_WS`;

SET @BankB = 'East West Bank';

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name like '%_EWB');

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name like '%_EWB');

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` like'%_EWB';

-- 4. Remove Customer
SET FOREIGN_KEY_CHECKS=0; 
DELETE FROM `Customer` WHERE `name`=@BankB;
SET FOREIGN_KEY_CHECKS=1; 
