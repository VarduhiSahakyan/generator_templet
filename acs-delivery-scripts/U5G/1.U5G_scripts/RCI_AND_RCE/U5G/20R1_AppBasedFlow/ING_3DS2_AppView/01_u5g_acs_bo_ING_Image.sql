
USE `U5G_ACS_BO`;

SET @createdBy ='A708534';
SET @BankB ='ING';
SET @Banklb ='ing';


INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_LARGE_Logo'), NULL, NULL, CONCAT(@Banklb,'_large.png'), 'PUSHED_TO_CONFIG','','/Issuers/16500-ING/ing_large.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_MEDIUM_Logo'), NULL, NULL, CONCAT(@Banklb,'_medium.png'), 'PUSHED_TO_CONFIG','','/Issuers/16500-ING/ing_medium.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_SMALL_Logo'), NULL, NULL, CONCAT(@Banklb,'_small.png'), 'PUSHED_TO_CONFIG','','/Issuers/16500-ING/ing_small.png');
