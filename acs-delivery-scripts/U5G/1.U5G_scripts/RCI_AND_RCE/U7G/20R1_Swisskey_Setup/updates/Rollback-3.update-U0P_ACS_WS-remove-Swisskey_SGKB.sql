USE `U0P_ACS_WS`;

SET @subIssuerC = 'St. Galler Kantonalbank AG';

SET @SubIssuerCodeC = '78100';

START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;
-- 1. Remove Role-Permission


SET @customer_ids = (SELECT group_concat(id)
                     FROM `Customer`
                     WHERE name in (@subIssuerC));

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE find_in_set(id_customer, @customer_ids);

-- 4. Remove Customer

DELETE
FROM Customer
WHERE find_in_set(id, @customer_ids);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;