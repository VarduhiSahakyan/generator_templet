/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U0P_ACS_WS`;

SET @BankB = 'Swisskey AG';
SET @subIssuerNidwalden =  'Nidwalden Kantonalbank';

SET @IssuerCode = '41001';
SET @subIssuerCodeNidwalden = '77900';

SET @Role1 = 'ADMIN_SWISSKEY';
SET @Role2 = 'REPORTING_SWISSKEY';
SET @Role3 = 'HELPDESK_SWISSKEY';
SET @RoleNidwalden = 'Nidwalden Banking Admin';

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Customer
INSERT INTO `Customer` (`code`, `customerType`, `name`, `parent_id`)
    SELECT @subIssuerCodeNidwalden, 'SUB_ISSUER', @subIssuerNidwalden,  c.id FROM `Customer` c WHERE c.name = @BankB AND c.customerType ='ISSUER';


-- 2. Add Role
INSERT INTO `Role` (`name`) VALUES
(@RoleNidwalden);

INSERT INTO `Role_Customer` (`id_customer`, `id_role`)
    SELECT c.id, r.id
    FROM `Customer` c, `Role` r
    WHERE c.customerType = 'SUB_ISSUER' AND c.name = @subIssuerNidwalden AND r.name IN (@Role1, @Role2, @Role3,@RoleNidwalden);

INSERT INTO `Role_Permission` (`id_role`, `id_permission`)
    SELECT  r.id, p.id
    FROM `Role` r , `Permission` p
    WHERE r.name = @RoleNidwalden
      AND  p.name IN (
                      'Consult_events',
                      'Consult_reporting',
                      'Consult_Merchant_test',
                      'Consult_transactions_3DS1',
                      'Consult_transactions_3DS2'
        );

SET FOREIGN_KEY_CHECKS = 1;
