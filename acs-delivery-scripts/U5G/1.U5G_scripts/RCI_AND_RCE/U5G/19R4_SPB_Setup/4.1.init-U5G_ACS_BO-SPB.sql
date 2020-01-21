/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

/* add the new authentication means */
INSERT INTO `AuthentMeans` (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
  SELECT 'InitPhase', sysdate(), 'CHIP_TAN', NULL, NULL, 'CHIP_TAN', 'PUSHED_TO_CONFIG' FROM dual
  WHERE NOT EXISTS (SELECT id FROM `AuthentMeans` where name = 'CHIP_TAN');

-- create the missing entries in MeansProcessStatuses

INSERT INTO `MeansProcessStatuses` (meansProcessStatusType, reversed, fk_id_authentMean)
  SELECT * FROM
  (SELECT DISTINCT(meansProcessStatusType) as stat FROM `MeansProcessStatuses`) as mp,
  (SELECT flag
   from (SELECT 0 as flag UNION SELECT 1) as temp ) as b,
  (SELECT a.id as aid FROM `AuthentMeans` a where a.name in ('CHIP_TAN')) as c
  WHERE NOT EXISTS (SELECT id
                    FROM `MeansProcessStatuses`
                    WHERE meansProcessStatusType = mp.stat
                      AND b.flag = reversed
                      and aid = fk_id_authentMean);

/* Issuer
   At first, the different authentication means need to be activated, so 'validate' is set to 'true'.
*/

SET @availableAuthMeans = 'REFUSAL|EXT_PASSWORD|UNDEFINED|OTP_SMS_EXT_MESSAGE|CHIP_TAN|MOBILE_APP_EXT';
SET @issuerNameAndLabel = 'Sparda-Bank';
SET @issuerCode = '16950';
SET @createdBy = 'A707825';

INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `availaibleAuthentMeans`) VALUES
  (@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, 'PUSHED_TO_CONFIG', @issuerNameAndLabel,
   @availableAuthMeans);

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
