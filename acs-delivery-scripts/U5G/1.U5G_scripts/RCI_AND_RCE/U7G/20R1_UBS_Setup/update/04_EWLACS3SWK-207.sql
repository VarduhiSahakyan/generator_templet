USE U7G_ACS_BO;
SET @createdBy ='A757435';
SET @BankB = 'UBS';
SET @BankUB = 'UBS';

SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
		 'de', 51, @currentPageType, 'Keine Verbindung zur UBS Access App', @MaestroVID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
		 'en', 51, @currentPageType, 'No connection to UBS Access App', @MaestroVID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
		 'fr', 51, @currentPageType, 'La connexion avec l\'app UBS Access est impossible', @MaestroVID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
		 'it', 51, @currentPageType, 'Non fosse possibile stabilire alcun collegamento con l\'app UBS Access', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
		 'de', 52, @currentPageType, 'Keine Verbindung zur UBS Access App möglich.Wir haben Ihnen einen Bestätigungscode an Ihre Mobilnummer für Sicherheitsnachrichten gesendet.', @MaestroVID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
		 'en', 52, @currentPageType, 'As we did not reach your UBS Access App, we sent a confirmation code to your mobile number for security messages.', @MaestroVID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
		 'fr', 52, @currentPageType, 'La connexion avec l''app UBS Access est impossible, nous vous enverrons un code de confirmation sur votre numéro de téléphone mobile pour les messages de sécurité.', @MaestroVID, NULL, @customItemSetSMS),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
		 'it', 52, @currentPageType, 'Il collegamento con l’app UBS Access non è possibile. Le abbiamo inviato un codice di conferma sul suo numero di cellulare per i messaggi di sicurezza.', @MaestroVID, NULL, @customItemSetSMS);
