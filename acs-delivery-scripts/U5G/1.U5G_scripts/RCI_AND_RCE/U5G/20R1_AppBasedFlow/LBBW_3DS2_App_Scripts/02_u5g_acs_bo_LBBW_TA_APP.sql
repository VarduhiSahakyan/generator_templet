
USE `U5G_ACS_BO`;

SET @locale = 'de';
SET @amName = 'OOB';
SET @username = 'InitPhase';
SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_MOBILE_APP');

SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT id FROM `Network` WHERE `code` = 'MASTERCARD');

/* 3DS2 */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 251, 'APP_VIEW', 'LBBW_SMALL_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'lbbw_small.png';
  
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 252, 'APP_VIEW', 'LBBW_MEDIUM_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'lbbw_medium.png';
  

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 253, 'APP_VIEW', 'LBBW_LARGE_LOGO', NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = 'lbbw_large.png';

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.id = @networkMC;
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.id = @networkMC;
  
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.id = @networkMC;

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.id = @networkVISA;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.id = @networkVISA;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) 
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.id = @networkVISA;

-- ADD CB logo

/* 3DS2 Native UI */
/* Texts */
SET @pageType = 'APP_VIEW';
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'Freigabe mit BW-Secure';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Öffnen Sie die BW-Secure-App und klicken Sie auf den neuen Vorgang \"Kreditkartenzahlung\", um die Transaktion zu bestätigen. Bitte prüfen Sie die aufgeführten Transaktionsdetails der Zahlung und geben Sie diese frei. Klicken Sie im Anschluss auf dieser Seite \"Fortfahren\".';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Ihre Kreditkartenzahlung muss in der BW-Secure App mit 3D-Secure bestätigt werden.\n \n Nähere Informationen finden Sie im BW-Secure Portal. Hier können Sie auch Geräte hinzufügen oder registrierte Geräte entfernen: https://sicheres-bezahlen.bw-bank.de/';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);
	
	
-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Die Zahlung konnte nicht mit BW-Secure bestätigt werden, bitte versuchen Sie es erneut.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- OOB_CONTINUE_LABEL
SET @ordinal = 165;
SET @text = 'Fortfahren';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  	SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, n.id, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

