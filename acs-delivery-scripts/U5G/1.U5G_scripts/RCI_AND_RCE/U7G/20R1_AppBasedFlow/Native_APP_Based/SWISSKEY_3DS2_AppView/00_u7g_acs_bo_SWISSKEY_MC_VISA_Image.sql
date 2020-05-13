/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U7G_ACS_BO`;

SET @createdBy ='A707825';

-- MC --
INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), 'MC_large.png', NULL, NULL, 'MC_large.png', 'PUSHED_TO_CONFIG', '', '/Schemes/MC_large.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), 'MC_medium.png', NULL, NULL, 'MC_medium.png', 'PUSHED_TO_CONFIG', '', '/Schemes/MC_medium.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), 'MC_small.png', NULL, NULL, 'MC_small.png', 'PUSHED_TO_CONFIG', '', '/Schemes/MC_small.png');

-- VISA --
INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), 'VISA_large.png', NULL, NULL, 'VISA_large.png', 'PUSHED_TO_CONFIG', '', '/Schemes/VISA_large.png';

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), 'VISA_medium.png', NULL, NULL, 'VISA_medium.png', 'PUSHED_TO_CONFIG', '', '/Schemes/VISA_medium.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), 'VISA_small.png', NULL, NULL, 'VISA_small.png', 'PUSHED_TO_CONFIG', '', '/Schemes/VISA_small.png');
