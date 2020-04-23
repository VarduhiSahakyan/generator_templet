/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
USE `U7G_ACS_BO`;

SET @amName = 'OTP_SMS_EXT_MESSAGE';
SET @username = 'A758582';
SET @BankB = 'LUKB';
SET @Banklb = LOWER(@BankB);
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));

SET @networkVISA = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');

/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', NULL, 251, 'APP_VIEW', CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', NULL, 252, 'APP_VIEW', CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', NULL, 253, 'APP_VIEW', CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', NULL, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', NULL, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', NULL, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

-- ADD CB logo

/* 3DS2 Native UI */
/* Texts */
SET @pageType = 'APP_VIEW';
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Zahlungsfreigabe via SMS';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Payment approval via SMS';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Activation de paiement par SMS';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Autorizzazione di pagamento tramite SMS';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code gesendet. Sofern die Zahlung durch Sie veranlasst worden ist, bestätigen Sie dies durch die Eingabe dieses Codes. \n\n Durch die Freigabe bezahlen Sie dem Händler @merchantName den Betrag von @amount am @formattedDate.\n' ||
            'Händler: @merchantName\n' ||
            'Betrag: @amount\n' ||
            'Datum: @formattedDate\n' ||
            'Kartennummer: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'We have sent you an approval code for confirmation of the payment. If the payment has been made by you, please confirm this by entering this code. \n\n With the approval you pay the merchant @merchantName the amount of @amount on @formattedDate.\n' ||
            'Merchant: @merchantName\n' ||
            'Amount: @amount\n' ||
            'Date: @formattedDate\n' ||
            'Card number: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Nous vous avons envoyé un code d''activation pour la confirmation du paiement. Si c''est bien vous qui avez ordonné le paiement, confirmez-le en saisissant ce code. \n\n Par l''activation, vous payez au commerçant @merchantName le montant de @amount le @formattedDate.\n' ||
            'Commerçant: @merchantName\n' ||
            'Montant: @amount\n' ||
            'Date: @formattedDate\n' ||
            'Numéro de carte: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Le abbiamo inviato un codice di autenticazione per confermare il pagamento. Se il pagamento è stato disposto da lei, lo confermi inserendo questo codice. \n\n Attraverso l’autorizzazione, lei paga al commerciante @merchantName l’importo di @amount in data @formattedDate.\n' ||
            'Commerciante: @merchantName\n' ||
            'Importo: @amount\n' ||
            'Data: @formattedDate\n' ||
            'Numero della carta: @maskedPan\n';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = 'Freigabe-Code bitte hier eingeben:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Please enter approval code here:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Veuillez saisir ici le code d''activation:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Inserisca qui il codice di autenticazione:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS SUBMIT BUTTON LABEL
SET @ordinal = 154;
SET @text = 'Freigeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Approve';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Activer';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Autorizzare';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS RESEND BUTTON LABEL 
SET @ordinal = 155;
SET @text = 'Neuen Freigabe-Code anfordern';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Request new approval code';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Demander un nouveau code d''activation';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Richiede un nuovo codice di autenticazione';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Benötigen Sie Hilfe?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Do you need help?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Avez-vous besoin d''aide?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Ha bisogno di aiuto?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Bitte kontaktieren Sie Ihre Bank für weiteren Support.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Please contact your bank for additional support.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Veuillez contacter votre banque pour plus de support.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Contatti la sua banca per ottenere ulteriore assistenza.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Der eingegebene Freigabe-Code ist nicht korrekt. Bitte versuchen Sie es erneut, oder fordern Sie einen neuen Freigabe-Code an.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'The approval code entered is incorrect. Please try again or request a new approval code.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Le code d''activation saisi n''est pas correct. Veuillez essayer à nouveau ou demandez un nouveau code d''activation.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
SET @text = 'Il codice di autenticazione inserito non è corretto. La preghiamo di provare nuovamente oppure richieda un nuovo codice di autenticazione.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;


-- 3DS WHITELISTING_INFO_TEXT (Some text for whitelist cases)
SET @ordinal = 161;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;

-- 3DS CHALLENGE_ADDITIONAL_INFO (More text provided)
SET @ordinal = 162;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), 'PUSHED_TO_CONFIG', 'de', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), 'PUSHED_TO_CONFIG', 'en', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), 'PUSHED_TO_CONFIG', 'fr', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), 'PUSHED_TO_CONFIG', 'it', @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id = @networkVISA;
