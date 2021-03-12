USE `U7G_ACS_BO`;

SET @amName = 'OOB';
SET @username = 'A757435';
SET @BankB = 'SWISSKEY';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP'));
SET @updateState = 'PUSHED_TO_CONFIG';

-- 3x VISA logo
SET @locale = 'de';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'fr';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'it';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


UPDATE `CustomItem` SET `fk_id_network` = NULL WHERE `pageTypes` = 'APP_VIEW' AND `fk_id_customItemSet` = @customItemSetId AND `DTYPE` = 'T';



SET @BankB = 'CS';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '48350';

SET @locale = 'de';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


SET @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


SET @locale = 'fr';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


SET @locale = 'it';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');



SET @BankB = 'NAB';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '58810';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;


SET @BankB = 'SGKB';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '78100';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;


SET @BankB = 'SOBA';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '83340';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;


SET @BankB = 'LUKB';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '77800';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;


SET @BankB = 'BEKB';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '79000';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;


SET @BankB = 'GRKB';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '77400';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;


SET @BankB = 'TGKB';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '78400';
UPDATE `CustomItem` SET `subIssuerCode` =@subIssuerCode WHERE `value` LIKE CONCAT('%', @Banklb, '_%')
                                                        AND `DTYPE` = 'I'
                                                        AND `name` = 'Bank Logo'
                                                        AND `pageTypes` = 'APP_VIEW'
                                                        AND `subIssuerCode` IS NULL;



SET @amName = 'OTP_SMS_EXT_MESSAGE';
SET @username = 'A757435';
SET @BankB = 'SWISSKEY';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));

SET @BankB = 'CS';
SET @Banklb = LOWER(@BankB);
SET @subIssuerCode = '48350';


-- 3x VISA logo
SET @locale = 'de';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'fr';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'it';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

UPDATE `CustomItem` SET `fk_id_network` = NULL WHERE `pageTypes` = 'APP_VIEW' AND `fk_id_customItemSet` = @customItemSetId AND `DTYPE` = 'T';

SET @locale = 'de';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


SET @locale = 'en';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


SET @locale = 'fr';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


SET @locale = 'it';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`, `subIssuerCode`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId, @subIssuerCode
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');
