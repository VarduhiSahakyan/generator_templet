USE U7G_ACS_BO;

SET @createdBy ='W100851';
SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_ZKB_SMS_EXT');
SET @otpSMSExtMessageAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @otpFormPagePageType = 'OTP_FORM_PAGE';
SET @updateState = 'PUSHED_TO_CONFIG';

SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
							`name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
							`fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'de', 51, @otpFormPagePageType, 'Keine Verbindung zur Access App', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'en', 51, @otpFormPagePageType, 'No connection to Access App', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'fr', 51, @otpFormPagePageType, 'La connexion avec l''app Access est impossible', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_51'), @updateState,
 'it', 51, @otpFormPagePageType, 'Non fosse possibile stabilire alcun collegamento con l''app Access', @MaestroVID, NULL, @customItemSetSMS),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'de', 52, @otpFormPagePageType, 'Keine Verbindung zur Access App möglich.Wir haben Ihnen zur Bestätigung der Zahlung einen Freigabe-Code auf Ihr Mobiltelefon gesendet. ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'en', 52, @otpFormPagePageType, 'As we did not reach your Access App.We sent an approval code to your mobile phone, which you can use to confirm the payment. ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'fr', 52, @otpFormPagePageType, 'La connexion avec l''app Access est impossible. Pour confirmer le paiement, nous vous avons envoyé un code de validation sur votre téléphone mobile.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@otpSMSExtMessageAuthentMean,'_',@otpFormPagePageType,'_52'), @updateState,
 'it', 52, @otpFormPagePageType, 'Il collegamento con l’app Access non è possibile. Le abbiamo inviato un codice di autorizzazione sul suo cellulare per confermare il pagamento.', @MaestroVID, NULL, @customItemSetSMS);