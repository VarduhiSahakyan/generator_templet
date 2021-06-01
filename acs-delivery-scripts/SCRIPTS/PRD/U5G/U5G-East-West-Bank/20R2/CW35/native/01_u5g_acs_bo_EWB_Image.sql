
USE `U5G_ACS_BO`;

SET @createdBy ='A708290';
SET @BankB ='EWB';
SET @Banklb ='ewb';


INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_LARGE_Logo'), NULL, NULL, CONCAT(@Banklb,'_large.png'), 'PUSHED_TO_CONFIG','','/Issuers/00062-EWB/ewb_large.jpg'); 

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_MEDIUM_Logo'), NULL, NULL, CONCAT(@Banklb,'_medium.png'), 'PUSHED_TO_CONFIG','','/Issuers/00062-EWB/ewb_medium.jpg');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_SMALL_Logo'), NULL, NULL, CONCAT(@Banklb,'_small.png'), 'PUSHED_TO_CONFIG','','/Issuers/00062-EWB/ewb_small.jpg');
