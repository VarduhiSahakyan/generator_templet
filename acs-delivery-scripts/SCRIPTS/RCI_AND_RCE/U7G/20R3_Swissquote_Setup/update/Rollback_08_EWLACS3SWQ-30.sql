USE U7G_ACS_BO;

SET @createdBy = 'A758582';

SET @BankB = 'SWISSQUOTE';
SET @BankUB = 'SQB';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'MESSAGE_BODY';
SET @locale = 'de';
SET @text = 'Ihr Authentifizierungscode lautet @otp für Ihren Kauf von @Betrag bei @Händler mit Karte @maskiertPan, am @formatiertenDatum.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 0
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;

SET @locale = 'en';
SET @text = 'Your authentication code is @otp for your @amount purchase at @merchant with card @maskedPan, on @formattedDate.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 0
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;

SET @locale = 'fr';
SET @text = 'Votre code d''authentification est le @otp pour votre achat de @amount auprès de @merchant avec votre carte @maskedPan, le @formattedDate.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 0
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;

SET @locale = 'it';
SET @text = 'Il suo codice di autenticazione è il @otp per suo acquisto di @amount da @merchant con la sua carta @maskedPan, il @formattedDate.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 0
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;