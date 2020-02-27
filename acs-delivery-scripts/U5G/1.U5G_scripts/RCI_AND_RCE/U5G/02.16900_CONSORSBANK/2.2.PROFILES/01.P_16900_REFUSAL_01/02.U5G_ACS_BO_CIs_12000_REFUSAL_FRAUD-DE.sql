USE `U5G_ACS_BO`;
SET @codeSubIssuer = '16900';
SET @nameCustomItemSet = 'customitemset_16900_1_REFUSAL';
SET @issuerIdREISEBANK = (SELECT id FROM `SubIssuer` WHERE `code` = @codeSubIssuer);

SET @idCustomItemSet = (SELECT id FROM `CustomItemSet` WHERE `name` = @nameCustomItemSet);

SET @idImageVisa = (SELECT id FROM `Image` WHERE `name` = 'VISA_LOGO');
SET @bankLogo = (SELECT id FROM `Image` WHERE `name` = 'Consorsbank');

SELECT @idImageVisa, @bankLogo;

SET @idNetworkVisa = (SELECT id FROM `Network` WHERE `code` = 'VISA');

SET @locale = 'de';

-- 12. CustomItem

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
-- ('I', 'A169318',  NOW(), NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 1, 'ALL', 'Consorsbank', @idNetworkVisa,  NULL, @idCustomItemSet),
('I' ,'A169318' , NOW() ,NULL ,'Bank Logo' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'ALL' ,'Consorsbank' ,@idNetworkVisa , @bankLogo,@idCustomItemSet),
('I' ,'A169318' , NOW() ,NULL ,'VISA Logo' ,'PUSHED_TO_CONFIG' ,@locale ,2 ,'ALL' ,'VISA' ,@idNetworkVisa , @idImageVisa ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_1_de' ,'PUSHED_TO_CONFIG' ,@locale ,1 ,'REFUSAL_PAGE' ,'Bitte bestätigen Sie folgende Zahlung' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_5_de' ,'PUSHED_TO_CONFIG' ,@locale ,5 ,'REFUSAL_PAGE' ,'Hilfe & FAQ' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_6_de' ,'PUSHED_TO_CONFIG' ,@locale ,6 ,'REFUSAL_PAGE' ,'Wir sind für Sie da: 0911 - 369 30 00' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_7_de' ,'PUSHED_TO_CONFIG' ,@locale ,7 ,'REFUSAL_PAGE' ,'Mo-So: 7:00 Uhr - 22:30 Uhr' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_8_de' ,'PUSHED_TO_CONFIG' ,@locale ,8 ,'REFUSAL_PAGE' ,'(Halten Sie als Kunde bitte Ihre Kontonummer bereit.)' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_9_de' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'REFUSAL_PAGE' ,'VISA Secure - ein Service von VISA in Kooperation mit Consorsbank' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_10_de' ,'PUSHED_TO_CONFIG' ,@locale ,10 ,'REFUSAL_PAGE' ,'&copy; VISA Europe' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_22_de' ,'PUSHED_TO_CONFIG' ,@locale ,22,'REFUSAL_PAGE' ,'Ihre  Zahlung mit VISA Secure wurde abgelehnt' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_23_de' ,'PUSHED_TO_CONFIG' ,@locale ,23 ,'REFUSAL_PAGE' ,'Aus Sicherheitsgründen wurde der Einkauf mit VISA Secure abgelehnt. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_32_de' ,'PUSHED_TO_CONFIG' ,@locale ,32,'REFUSAL_PAGE' ,'Technischer Fehler' ,@idNetworkVisa , NULL ,@idCustomItemSet),
('T' ,'A169318' , NOW() ,NULL ,'VISA_OTP_PHOTOTAN_REFUSAL_PAGE_33_de' ,'PUSHED_TO_CONFIG' ,@locale ,33 ,'REFUSAL_PAGE' ,'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut. Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreuungsteam.' ,@idNetworkVisa , NULL ,@idCustomItemSet);

