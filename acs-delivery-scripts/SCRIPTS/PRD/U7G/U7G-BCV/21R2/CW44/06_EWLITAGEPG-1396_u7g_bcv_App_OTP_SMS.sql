USE `U7G_ACS_BO`;

SET @amName = 'OTP_SMS_EXT_MESSAGE';
SET @username = 'A709391';
SET @BankB = 'BCV';
SET @Banklb = LOWER(@BankB);

SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));

SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');

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

-- 3x VISA logo

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, @pageType, 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, @pageType, 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, @pageType, 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';



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

-- 3x VISA logo

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, @pageType, 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, @pageType, 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, @pageType, 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


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

-- 3x VISA logo

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, @pageType, 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, @pageType, 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, @pageType, 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


/* 3DS2 Native UI */
/* Texts */
SET @pageType = @pageType;
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Zahlungsfreigabe per SMS';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Payment confirmation via text message';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Activation de paiement par SMS';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;

SET @text = 'Wir haben Ihnen zur Bestätigung der Zahlung eine SMS mit dem Freigabecode geschickt. Falls Sie die Zahlung in Auftrag gegeben haben, bestätigen Sie sie bitte durch Eingabe des Freigabecodes. \n\n Wenn Sie die Zahlung freigeben, zahlen Sie dem Händler @merchant am @formattedDate einen Betrag von @amount․';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'We have sent you a payment confirmation code. If you wish to make this payment, please confirm it by entering this code. \n\n If you confirm the payment, you will pay @amount to @merchant on @formattedDate.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Nous vous avons envoyé un code d''activation pour la confirmation du paiement. Si c''est bien vous qui avez ordonné le paiement, confirmez-le en saisissant ce code. \n\n En confirmant, vous payez au commerçant @merchant le montant de @amount le @formattedDate.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = 'Bitte geben Sie hier den Freigabecode ein:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Enter your confirmation code here:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Veuillez saisir ici le code de confirmation:';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS SUBMIT BUTTON LABEL
SET @ordinal = 154;
SET @text = 'Senden';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Send';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Envoyer';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS RESEND BUTTON LABEL
SET @ordinal = 155;
SET @text = 'Neuen Code anfordern';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Send a new code';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Renvoyer un nouveau code';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Benötigen Sie Hilfe?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Do you need help?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Avez-vous besoin d''aide?';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Falls Sie weiteren Support benötigen, wenden Sie sich bitte an die BCV.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Please contact BCV if you require further support.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Veuillez contacter la BCV pour plus de support.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);

-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'it'), @updateState, 'it', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Der erfasste Freigabecode ist nicht korrekt. Bitte versuchen Sie es erneut oder fordern Sie einen neuen Freigabecode an.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'The confirmation code you have entered is incorrect. Please enter the confirmation code again or request a new one.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
SET @text = 'Le code de confirmation saisi n''est pas correct. Veuillez essayer à nouveau ou demandez un nouveau code de confirmation.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);



-- 3DS WHITELISTING_INFO_TEXT (Some text for whitelist cases)
SET @ordinal = 161;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);


-- 3DS CHALLENGE_ADDITIONAL_INFO (More text provided)
SET @ordinal = 162;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'de'), @updateState, 'de', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fr'), @updateState, 'fr', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	 n.id in (@networkVISA);
