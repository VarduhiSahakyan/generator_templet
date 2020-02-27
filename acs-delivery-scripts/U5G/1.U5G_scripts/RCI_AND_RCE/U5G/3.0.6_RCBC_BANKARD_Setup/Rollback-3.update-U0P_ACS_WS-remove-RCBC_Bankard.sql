USE `U0P_ACS_WS`;

SET @BankB = 'RCBC Bankard';
SET @IssuerA = 'Bankard Credit';
SET @IssuerB = 'RCBC Debit';
SET @SubIssuerCodeA = '00006';
SET @SubIssuerCodeB = '00018';

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name like'%_BKD');

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name like'%_RCB');

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name like'%_BKD');

DELETE FROM `Role_Customer`
WHERE `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name like'%_RCB');

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` like'%_BKD';

DELETE FROM `Role` WHERE `name` like'%_RCB';

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `code`=@SubIssuerCodeA AND `customerType`='SUB_ISSUER' AND `name`=@IssuerA;

DELETE FROM `Customer` WHERE `code`=@SubIssuerCodeB AND `customerType`='SUB_ISSUER' AND `name`=@IssuerB;

SET FOREIGN_KEY_CHECKS=0; 
DELETE FROM `Customer` WHERE `name`=@BankB;
SET FOREIGN_KEY_CHECKS=1; 
