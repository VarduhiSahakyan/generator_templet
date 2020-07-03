USE `U7G_ACS_BO`;

SET @amName = 'OTP_SMS_EXT_MESSAGE';
SET @username = 'A758582';
SET @BankB = 'UBS';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));

SET @networkVISA = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @ordinal = 155;


SET @locale = 'de';
SET @text = 'Neuer Code';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
										AND `fk_id_customItemSet` = @customItemSetId
										AND `value` = 'Neuen Bestätigungscode anfordern';

SET @locale = 'en';
SET @text = 'New code';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
										AND `fk_id_customItemSet` = @customItemSetId
										AND `value` = 'Request another confirmation code';
SET @locale = 'fr';
SET @text = 'Nouveau code';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
										AND `fk_id_customItemSet` = @customItemSetId
										AND `value` = 'Demander un nouveau code de confirmation';

SET @locale = 'it';
SET @text = 'Nuovo codice';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
										AND `fk_id_customItemSet` = @customItemSetId
										AND `value` = 'Richiedere nuovo codice di conferma';