USE `U5G_ACS_BO`;

SET @locale = 'de';
SET @amName = 'OOB';
SET @username = 'A707825';
SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16600_APP_1');
SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT id FROM `Network` WHERE `code` = 'MASTERCARD');

/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 251, 'APP_VIEW', 'COMDIRECT_SMALL_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'comdirect_small.png';
  
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 252, 'APP_VIEW', 'COMDIRECT_MEDIUM_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'comdirect_medium.png';
  

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 253, 'APP_VIEW', 'COMDIRECT_LARGE_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'comdirect_large.png';

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
SET @text = 'Freigabe mit photoTAN App';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Öffnen Sie jetzt die photoTAN App und geben Sie folgende Zahlung frei:\n\nHändler: @merchant \nBetrag: @amount \nDatum: @formattedDate \nKartennummer: @maskedPan';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = 'Freigabe durch mobileTAN';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Nähere Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de.';
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
SET @text = 'Der Zugang wurde gesperrt.\nAus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- OOB_CONTINUE_LABEL
SET @ordinal = 165;
SET @text = 'Fortfahren';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
