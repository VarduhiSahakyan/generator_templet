/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @Role1 = 'Swisskey Admin';

SET FOREIGN_KEY_CHECKS = 0;

SET @role_id = (SELECT id
                 FROM `Role`
                 WHERE name = @Role1);


-- 1. Remove Role-Permission
DELETE
FROM `Role_Permission`
WHERE id_role = @role_id;

-- 2. Remove Role-Customer
DELETE
FROM `Role_Customer`
WHERE id_role = @role_id;

DELETE
    FROM `Role`
WHERE id = @role_id;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
