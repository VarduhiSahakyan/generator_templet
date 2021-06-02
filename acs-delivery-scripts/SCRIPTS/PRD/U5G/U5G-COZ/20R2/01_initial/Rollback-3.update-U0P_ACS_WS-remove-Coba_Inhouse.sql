USE `U0P_ACS_WS`;

SET @BankB = 'Commerzbank AG';
SET @IssuerB = 'Commerzbank AG';
SET @Role1 = 'ADMIN_CoBa';

SET FOREIGN_KEY_CHECKS=0; 
-- 1. Remove Role-Permission
/* DELETE FROM `Role_Permission`
WHERE id_customer IN (SELECT c.id FROM `Customer` c WHERE c.name=@IssuerB); */

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.name=@BankB);

-- 3. Remove Role
/* DELETE FROM `Role` WHERE `name` = @Role1; */

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `name`=@BankB;
SET FOREIGN_KEY_CHECKS=1; 
