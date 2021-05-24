USE U7G_ACS_BO;

SET @createdBy ='A757435';
SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_RCH_SMS');
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @currentPageType = 'OTP_FORM_PAGE';


SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
 'de', 51, @currentPageType, 'Keine Verbindung zur Access App', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
 'en', 51, @currentPageType, 'No connection to Access App', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
 'fr', 51, @currentPageType, 'La connexion avec l''app Access est impossible', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_51'), 'PUSHED_TO_CONFIG',
 'it', 51, @currentPageType, 'Non fosse possibile stabilire alcun collegamento con l''app Access', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
 'de', 52, @currentPageType, 'Keine Verbindung zur Access App möglich.Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobiltelefon gesendet.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
 'en', 52, @currentPageType, 'As we did not reach your Access App.We sent an approval code to your mobile phone, which you can use to confirm the payment.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
 'fr', 52, @currentPageType, 'La connexion avec l''app Access est impossible. Pour confirmer le paiement, nous vous avons envoyé un code de validation sur votre téléphone mobile.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_52'), 'PUSHED_TO_CONFIG',
 'it', 52, @currentPageType, 'Il collegamento con l’app Access non è possibile. Le abbiamo inviato un codice di autorizzazione sul suo cellulare per confermare il pagamento.', @MaestroVID, NULL, @customItemSetSMS);
