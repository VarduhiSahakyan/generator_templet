/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuerCS = 'Crédit Suisse AG';
SET @subIssuerNAB = 'Neue Aargauer Bank';
SET @subIssuerSGKB = 'St. Galler Kantonalbank AG';
SET @subIssuerSOBA = 'Baloise Bank SoBa AG';
SET @subIssuerLUKB = 'Luzerner KB AG';

SET @IssuerCode = '41001';
SET @SubIssuerCodeCS = '48350';
SET @SubIssuerCodeNAB = '58810';
SET @SubIssuerCodeSGKB = '78100';
SET @SubIssuerCodeSOBA = '83340';
SET @SubIssuerCodeLUKB = '77800';

SET @Role1 = 'Swisskey Admin';
SET @Role2 = 'Swisskey Reporting';
SET @Role3 = 'Swisskey Helpdesk';

SET @RoleCS = 'Credit Suisse Admin';
SET @RoleNAB = 'Neue Aargauer Bank Admin';
SET @RoleSGKB = 'St Galler Kantonalbank Admin';
SET @RoleSOBA = 'Baloise Bank SoBa AG Admin';
SET @RoleLUKB = 'Luzerner KB AG Admin';

SET FOREIGN_KEY_CHECKS = 0;


INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
    SELECT @SubIssuerCodeSOBA, 'SUB_ISSUER', @subIssuerSOBA,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';

INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
    SELECT @SubIssuerCodeLUKB, 'SUB_ISSUER', @subIssuerLUKB,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType = 'ISSUER';


-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
    (@Role2),
    (@Role3),
    (@RoleCS),
    (@RoleNAB),
    (@RoleSGKB),
    (@RoleSOBA),
    (@RoleLUKB);

-- 3. Add Role-Customer
INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'ENTITY' AND c.name = @BankB AND r.name IN (@Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'ISSUER' AND c.name = @BankB AND r.name IN (@Role2, @Role3);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerCS AND r.name IN (@Role2, @Role3, @RoleCS);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerNAB AND r.name IN (@Role2, @Role3, @RoleNAB);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerSGKB AND r.name IN (@Role2, @Role3, @RoleSGKB);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerSOBA AND r.name IN (@Role1, @Role2, @Role3, @RoleSOBA);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerLUKB AND r.name IN (@Role1, @Role2, @Role3, @RoleLUKB);

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
    SELECT  r.id, p.id
    FROM `Role` r , `Permission` p
    WHERE r.name = @Role2
        AND  p.name IN (
                      'Consult_reporting',
                      'Consult_psd2_reports'
        );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
    SELECT  r.id, p.id
    FROM `Role` r , `Permission` p
    WHERE r.name = @Role3
        AND  p.name IN (
                      'Consult_events',
                      'Consult_reporting',
                      'Consult_user_xp',
                      'Consult_transactions_3DS1',
                      'Consult_transactions_3DS2',
                      'Consult_RBA_Decision'
        );

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
    SELECT  r.id, p.id
    FROM `Role` r , `Permission` p
    WHERE r.name IN (@RoleCS, @RoleNAB, @RoleSGKB, @RoleSOBA, @RoleLUKB)
        AND  p.name IN (
                      'Consult_events',
                      'Consult_reporting',
                      'Consult_Merchant_test',
                      'Consult_transactions_3DS1',
                      'Consult_transactions_3DS2'
        );

SET FOREIGN_KEY_CHECKS = 1;
