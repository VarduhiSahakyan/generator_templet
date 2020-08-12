USE `U0P_ACS_WS`;

SET @BankB = 'Postbank';
SET @Issuer = 'Postbank';
SET @SubIssuerB = 'Postbank-EBK';
SET @SubIssuerC = 'Postbank-FBK';
SET @SubIssuer = 'Postbank-Shared';
SET @Role1 = 'ADMIN_Postbank';
SET @Role2 = 'Postbank_GRUPPENADMIN';
SET @Role3 = 'Postbank_MITARBEITER';

SET FOREIGN_KEY_CHECKS=0;
-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2, @Role3));

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name in (@Role1, @Role2, @Role3));

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` in (@Role1, @Role2, @Role3);

-- 4. Remove Customer

DELETE FROM `Customer` WHERE `name`=@SubIssuerB;
DELETE FROM `Customer` WHERE `name`=@SubIssuerC;
DELETE FROM `Customer` WHERE `name`=@SubIssuer;
DELETE FROM `Customer` WHERE `name`=@Issuer;
DELETE FROM `Customer` WHERE `name`=@BankB;
SET FOREIGN_KEY_CHECKS=1; 
