USE `U0P_ACS_WS`;

-- 1. Remove Role-Permission
DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='CONSORS_ADMIN');

DELETE FROM `Role_Permission`
WHERE id_role IN (SELECT r.id FROM `Role` r WHERE r.name='CONSORS_INTERN');

-- 2. Remove Role-Customer
DELETE FROM `Role_Customer`
WHERE `id_customer` IN (SELECT c.id FROM `Customer` c WHERE c.name='Consorsbank')
 AND  `id_role` IN (SELECT r.id FROM `Role` r WHERE r.name IN ('ADMIN_WORLDLINE','CONSORS_ADMIN', 'CONSORS_INTERN'));

-- 3. Remove Role
DELETE FROM `Role` WHERE `name` IN ('CONSORS_ADMIN', 'CONSORS_INTERN');

-- 4. Remove Customer
DELETE FROM `Customer` WHERE `code`='16900' AND `customerType`='SUB_ISSUER' AND `name`='Consorsbank';
DELETE FROM `Customer` WHERE `code`='16900' AND `customerType`='ISSUER' AND `name`='Consorsbank';
DELETE FROM `Customer` WHERE `customerType`='ENTITY' AND `name`='Consorsbank';
