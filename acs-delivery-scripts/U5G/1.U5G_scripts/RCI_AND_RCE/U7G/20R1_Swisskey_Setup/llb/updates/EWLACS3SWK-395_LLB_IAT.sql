USE U7G_ACS_BO;
SET @createdBy ='A757435';
SET @BankB = 'SWISSKEY';
SET @BankUB = 'LLB';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @currentAuthentMean = 'EXT_PASSWORD';
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @currentPageType = 'OTP_FORM_PAGE';
  /*PASSWORD_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
'de', 34, @currentPageType, 'SMS-Code wird versendet', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie einen neuen Bestätigungscode an Ihre Mobilnummer für Sicherheitsnachrichten.', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
'en', 34, @currentPageType, 'SMS code sent', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
'en', 35, @currentPageType, 'Please wait, this may take a moment. A new confirmation code for security messages will be sent to your mobile phone.', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
'fr', 34, @currentPageType, 'Vous allez recevoir un code par SMS', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
'fr', 35, @currentPageType, 'Veuillez patienter un instant. Vous recevrez d’ici peu un nouveau code de confirmation sur votre numéro de mobile pour les notifications de sécurité.', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
'it', 34, @currentPageType, 'Codice SMS inviato.', @MaestroVID, NULL, @customItemSetPassword),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
'it', 35, @currentPageType, 'La preghiamo di attendere. A breve riceverà un nuovo codice di conferma sul suo numero di cellulare per messaggi sulla sicurezza.', @MaestroVID, NULL, @customItemSetPassword);