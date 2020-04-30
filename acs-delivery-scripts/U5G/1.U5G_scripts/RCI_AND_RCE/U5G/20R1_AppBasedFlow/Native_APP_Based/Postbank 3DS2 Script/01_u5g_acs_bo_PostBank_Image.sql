USE `U5G_ACS_BO`;


SET @createdBy ='A708290';
SET @BankB ='POSTBANK';
SET @Banklb ='postbank';


INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_LARGE_Logo'), NULL, NULL, CONCAT(@Banklb,'_large.png'), 'PUSHED_TO_CONFIG','','/Issuers/18500-POSTBANK/postbank_large.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_MEDIUM_Logo'), NULL, NULL, CONCAT(@Banklb,'_medium.png'), 'PUSHED_TO_CONFIG','','/Issuers/18500-POSTBANK/postbank_medium.png');

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`,relativepath)
VALUES (@createdBy, NOW(), CONCAT(@BankB,'_SMALL_Logo'), NULL, NULL, CONCAT(@Banklb,'_small.png'), 'PUSHED_TO_CONFIG','','/Issuers/18500-POSTBANK/postbank_small.png');
