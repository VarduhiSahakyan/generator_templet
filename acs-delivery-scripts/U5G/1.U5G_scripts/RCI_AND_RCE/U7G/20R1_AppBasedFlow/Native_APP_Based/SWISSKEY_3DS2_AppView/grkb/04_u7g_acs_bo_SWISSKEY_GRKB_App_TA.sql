/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U7G_ACS_BO`;

SET @amName = 'OOB';
SET @username = 'A707825';
SET @BankB = 'GRKB';
SET @Banklb = LOWER(@BankB);
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP'));

SET @networkMC = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @pageType = 'APP_VIEW';
SET @updateState = 'PUSHED_TO_CONFIG';
/* 3DS2 implem */
/* IMAGES */

SET @locale = 'de';
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, @pageType, CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, @pageType, CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, @pageType, CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, @pageType, 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, @pageType, 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, @pageType, 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';


SET @locale = 'en';
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, @pageType, CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, @pageType, CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, @pageType, CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, @pageType, 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, @pageType, 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, @pageType, 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';


SET @locale = 'fr';
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, @pageType, CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, @pageType, CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, @pageType, CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, @pageType, 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, @pageType, 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, @pageType, 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';


SET @locale = 'it';
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, @pageType, CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, @pageType, CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, @pageType, CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, @pageType, 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, @pageType, 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, @pageType, 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- ADD CB logo

/* 3DS2 Native UI */
/* Texts */
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Zahlung im App freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Approve payment in the app';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Activer le paiement dans l''App';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Autorizzare il pagamento nell’app';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Zur zusätzlichen Sicherheit müssen Sie die Zahlung in Ihrer Authentifikations-App freigeben. Öffnen Sie dazu ihre Authentifikations-App Ihrer Bank und bestätigen Sie die Zahlung dort.\nHändler: @merchantName\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'You must approve the payment in your authentication app for added security. To do so, open the authentication app provided by your bank and approve the payment there.\nMerchant: @merchantName\nAmount: @amount\nDate: @formattedDate\nCard number: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Pour plus de sécurité, vous devez activer le paiement dans votre App d''authentification. Pour cela, ouvrez l''App d''authentification de votre banque et confirmez le paiement.\nCommerçant: @merchantName\nMontant: @amount\nDate: @formattedDate\nNuméro de carte: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Per ulteriore sicurezza, deve autorizzare il pagamento nella sua app di autenticazione. Per fare ciò, apra l’app di autenticazione della sua banca e confermi qui il pagamento.\nCommerciante: @merchantName\nImporto: @amount\nData: @formattedDate\nNumero della carta: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Help';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Aide';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Aiuto';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Ihre Kreditkartenzahlung muss mit 3-D Secure bestätigt werden.\n \n Nähere Informationen finden Sie im Onlinebanking.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Your payment has to be approved with 3-D Secure.\n \n Further information can be found in your online banking.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Veuillez contacter votre banque pour plus de support.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Contatti la sua banca per ottenere ulteriore supporto.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Die Authentifikation auf Ihrem Mobil-Telefon ist fehlgeschlagen. Die Zahlung konnte nicht abgeschlossen werden und Ihre Karte wurde nicht belastet. Bitte versuchen Sie es erneut.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'The authentication on your mobile phone failed. Your payment could not be completed and your card was not debited. Please try it again.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'L''authentification sur votre téléphone portable a échoué. Le paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Veuillez réessayer à nouveau.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'L’autenticazione sul suo cellulare non è riuscita. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. La preghiamo di riprovare.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;


-- OOB_CONTINUE_LABEL
SET @ordinal = 165;
SET @text = 'Zahlung freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Approve payment';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Activer le paiement';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
SET @text = 'Autorizzare il pagamento';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkMC;
