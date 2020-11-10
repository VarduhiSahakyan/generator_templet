/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U7G_ACS_BO`;

SET @amName = 'OOB';
SET @username = 'A709391';
SET @BankB = 'RCH';
SET @Banklb = LOWER(@BankB);
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP'));

SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @updateState = 'PUSHED_TO_CONFIG';

SET @locale = 'de';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


SET @locale = 'en';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'fr';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'it';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


/* 3DS2 Native UI */
/* Texts */
SET @pageType = 'APP_VIEW';
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Zahlung in der App freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Approve payment in the app';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Activer le paiement dans l''App';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Autorizzare il pagamento nell’app';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);



-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Zur zusätzlichen Sicherheit müssen Sie die Zahlung in Ihrer Authentifikations-App freigeben. Öffnen Sie dazu die entsprechende App von Raiffeisen und bestätigen Sie die Zahlung.\nHändler: @merchantName\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'For the sake of increased security, you must approve the payment in your authentication app. To do so, open the corresponding Raiffeisen app and confirm the payment.\nMerchant: @merchantName\nAmount: @amount\nDate: @formattedDate\nCard number: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Pour plus de sécurité, vous devez valider le paiement dans votre app d’authentification. Pour ce faire, ouvrez l’app correspondante de Raiffeisen et confirmez le paiement.\nCommerçant: @merchantName\nMontant: @amount\nDate: @formattedDate\nNuméro de carte: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Per una maggiore sicurezza, deve autorizzare il pagamento nella sua app di autentificazione. A tale scopo, apra la rispettiva app di Raiffeisen e confermi il pagamento.\nCommerciante: @merchantName\nImporto: @amount\nData: @formattedDate\nNumero della carta: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Help';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Aide';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Aiuto';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Ihre Zahlung muss mit 3-D Secure bestätigt werden.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Your payment must be confirmed with 3-D Secure.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Votre paiement doit être confirmé avec 3-D Secure.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Il pagamento deve essere confermato con 3-D Secure.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Die Authentifikation auf Ihrem Smartphone ist fehlgeschlagen. Die Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Bitte versuchen Sie es erneut.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

SET @text = 'Authentication on your smartphone has failed. Your payment could not be completed and your card was not debited. Please try it again.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

SET @text = 'L’authentification sur votre smartphone a échoué. Le paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Veuillez réessayer à nouveau.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

SET @text = 'L''autentificazione sul suo smartphone non è andata a buon fine. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. La preghiamo di riprovare.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- OOB_CONTINUE_LABEL
SET @ordinal = 165;
SET @text = 'Zahlung freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Approve payment';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Activer le paiement';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Autorizzare il pagamento';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);



-- MOBILE_APP_EXT --

SET @customItemSetId_APP_EXT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP_EXT'));

SET @locale = 'de';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');


-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


SET @locale = 'en';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'fr';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

SET @locale = 'it';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId_APP_EXT
FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId_APP_EXT
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


/* 3DS2 Native UI */
/* Texts */
SET @pageType = 'APP_VIEW';
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Zahlung in der App freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Approve payment in the app';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Activer le paiement dans l''App';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Autorizzare il pagamento nell’app';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);



-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Zur zusätzlichen Sicherheit müssen Sie die Zahlung in Ihrer Authentifikations-App freigeben. Öffnen Sie dazu die entsprechende App von Raiffeisen und bestätigen Sie die Zahlung.\nHändler: @merchantName\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'For the sake of increased security, you must approve the payment in your authentication app. To do so, open the corresponding Raiffeisen app and confirm the payment.\nMerchant: @merchantName\nAmount: @amount\nDate: @formattedDate\nCard number: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Pour plus de sécurité, vous devez valider le paiement dans votre app d’authentification. Pour ce faire, ouvrez l’app correspondante de Raiffeisen et confirmez le paiement.\nCommerçant: @merchantName\nMontant: @amount\nDate: @formattedDate\nNuméro de carte: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Per una maggiore sicurezza, deve autorizzare il pagamento nella sua app di autentificazione. A tale scopo, apra la rispettiva app di Raiffeisen e confermi il pagamento.\nCommerciante: @merchantName\nImporto: @amount\nData: @formattedDate\nNumero della carta: @displayedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Help';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Aide';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Aiuto';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Ihre Zahlung muss mit 3-D Secure bestätigt werden.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Your payment must be confirmed with 3-D Secure.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Votre paiement doit être confirmé avec 3-D Secure.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Il pagamento deve essere confermato con 3-D Secure.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Die Authentifikation auf Ihrem Smartphone ist fehlgeschlagen. Die Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Bitte versuchen Sie es erneut.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

SET @text = 'Authentication on your smartphone has failed. Your payment could not be completed and your card was not debited. Please try it again.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

SET @text = 'L’authentification sur votre smartphone a échoué. Le paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Veuillez réessayer à nouveau.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

SET @text = 'L''autentificazione sul suo smartphone non è andata a buon fine. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. La preghiamo di riprovare.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- OOB_CONTINUE_LABEL
SET @ordinal = 165;
SET @text = 'Zahlung freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Approve payment';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Activer le paiement';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
SET @text = 'Autorizzare il pagamento';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId_APP_EXT FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

