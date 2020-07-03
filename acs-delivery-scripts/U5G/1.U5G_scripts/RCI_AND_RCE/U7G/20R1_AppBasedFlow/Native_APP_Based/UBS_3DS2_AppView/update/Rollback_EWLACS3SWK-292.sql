USE `U7G_ACS_BO`;

SET @amName = 'OTP_SMS_EXT_MESSAGE';
SET @username = 'A758582';
SET @BankB = 'UBS';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));

SET @networkVISA = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @ordinal = 155;


SET @locale = 'de';
SET @text = 'Neuen Bestätigungscode anfordern';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
                                        AND `fk_id_customItemSet` = @customItemSetId
                                        AND `value` = 'Neuer Code';

SET @locale = 'en';
SET @text = 'Request another confirmation code';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
                                        AND `fk_id_customItemSet` = @customItemSetId
                                        AND `value` = 'New code';
SET @locale = 'fr';
SET @text = 'Demander un nouveau code de confirmation';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
                                        AND `fk_id_customItemSet` = @customItemSetId
                                        AND `value` = 'Nouveau code';

SET @locale = 'it';
SET @text = 'Richiedere nuovo codice di conferma';

UPDATE `CustomItem` SET `value` = @text WHERE  `ordinal` = @ordinal AND `locale` = @locale
                                        AND `fk_id_customItemSet` = @customItemSetId
                                        AND `value` = 'Nuovo codice';