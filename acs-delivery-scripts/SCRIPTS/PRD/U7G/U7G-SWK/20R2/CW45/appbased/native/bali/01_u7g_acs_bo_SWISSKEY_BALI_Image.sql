/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U7G_ACS_BO`;

SET @createdBy ='A709391';
SET @BankB = 'BALI';
SET @Banklb = LOWER(@BankB);
SET @IssuerCode = '41001';
SET @SubIssuerCode = '87310';
SET @RelativePathPrefix = CONCAT('/Issuers/', @IssuerCode , '/' ,@SubIssuerCode, '-', @BankB, '/', @Banklb);

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_LARGE_LOGO'), NULL, NULL, CONCAT(@Banklb,'_large.png'), 'PUSHED_TO_CONFIG', '', CONCAT(@RelativePathPrefix,'_large.png'));

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_MEDIUM_LOGO'), NULL, NULL, CONCAT(@Banklb,'_medium.png'), 'PUSHED_TO_CONFIG', '', CONCAT(@RelativePathPrefix,'_medium.png'));

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_SMALL_LOGO'), NULL, NULL, CONCAT(@Banklb,'_small.png'), 'PUSHED_TO_CONFIG', '', CONCAT(@RelativePathPrefix,'_small.png'));
