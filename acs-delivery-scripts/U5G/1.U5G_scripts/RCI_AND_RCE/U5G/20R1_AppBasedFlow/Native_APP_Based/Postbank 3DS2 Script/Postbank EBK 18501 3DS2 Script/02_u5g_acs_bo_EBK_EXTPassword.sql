
USE `U5G_ACS_BO`;

SET @locale = 'de';
SET @amName = 'KBA';
SET @username = 'InitPhase';
SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18501_PB_LOGIN');
SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT id FROM `Network` WHERE `code` = 'MASTERCARD');

/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 251, 'APP_VIEW', 'POSTBANK_SMALL_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'postbank_small.png';
  
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 252, 'APP_VIEW', 'POSTBANK_MEDIUM_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'postbank_medium.png';
  

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 253, 'APP_VIEW', 'POSTBANK_LARGE_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'postbank_large.png';

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
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

-- ADD CB logo
SET @networkVISA = NULL;
/* 3DS2 Native UI */
/* Texts */
SET @pageType = 'APP_VIEW';
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Sicherheitscheck';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Damit Sie noch sicherer mit Ihrer Kreditkarte zahlen, haben wir eine zusätzliche Abfrage eingefügt. Bitte geben Sie das Passwort zu Ihrer Postbank-ID ein. \n\nAbrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS SUBMIT BUTTON LABEL
SET @ordinal = 154;
SET @text = 'Fortsetzen';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS RESEND BUTTON LABEL 
SET @ordinal = 155;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Mehr zum Sicherheitscheck unter www.postbank.de/3d_secure';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
	
-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

	
-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Ihre Eingabe war nicht korrekt. \n\nGeben Sie bitte erneut das Passwort zu Ihrer Postbank-ID ein. \n\nNach 3 Fehleingaben wird Ihre Postbank-ID vorläufig gesperrt. Nutzen Sie in diesem Fall die Funktion "Zugangsdaten vergessen?" auf der Startseite des Online-Bankings und wählen Sie auf der Folgeseite aus, dass Sie Ihr Passwort vergessen haben.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHITELISTING_INFO_TEXT (Some text for whitelist cases)
SET @ordinal = 161;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS CHALLENGE_ADDITIONAL_INFO (More text provided)
SET @ordinal = 162;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


