USE `U7G_ACS_BO`;

SET @createdBy ='A758582';
SET @issuerCode = '76700';
SET @subIssuerCode = '76700';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

SET @bank = 'BCV';

SET @maestroVID = NULL;
SET @maestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @helpPagePageType = 'HELP_PAGE';
SET @updateState = 'PUSHED_TO_CONFIG';


-- Refusal Missing Auth --

SET @customItemSetRefusalMissingAuth = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @InfoAuthentMean = 'INFO';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'de', 1, @helpPagePageType, '<b>Hilfe</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'de', 2, @helpPagePageType, 'Um die Sicherheit bei Online-Zahlungen zu erhöhen, hat die BCV ein System zur Zahlungsfreigabe durch den/die Karteninhaber/in eingerichtet. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'de', 3, @helpPagePageType, 'Bevor die Zahlung ausgeführt wird, muss sie zuerst in der App BCV Mobile freigegeben werden. Bei Fragen wenden Sie sich bitte direkt an die BCV.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'de', 174, @helpPagePageType, 'Hilfe schliessen', @maestroVID, NULL, @customItemSetRefusalMissingAuth);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'en', 1, @helpPagePageType, '<b>Help</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'en', 2, @helpPagePageType, 'To make your online payments more secure, BCV uses a system that requires card users to verify their identity first. ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'en', 3, @helpPagePageType, 'Payments are therefore not executed until they are approved in BCV Mobile. Please contact BCV directly if you have any questions.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'en', 174, @helpPagePageType, 'Close help', @maestroVID, NULL, @customItemSetRefusalMissingAuth);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_1'), @updateState,
 'fr', 1, @helpPagePageType, '<b>Aide</b>', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_2'), @updateState,
 'fr', 2, @helpPagePageType, 'Afin d''augmenter la sécurité lors de vos paiements en ligne, la BCV a mis en place un système de validation par authentification du détenteur de la carte.  ', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_3'), @updateState,
 'fr', 3, @helpPagePageType, 'Pour être exécuté, le paiement doit, au préalable, être confirmé dans l''application BCV Mobile. Pour toute question, vous pouvez prendre contact directement avec la BCV.', @maestroVID, NULL, @customItemSetRefusalMissingAuth),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@maestroVName,'_',@InfoAuthentMean,'_',@helpPagePageType,'_174'), @updateState,
 'fr', 174, @helpPagePageType, 'Fermer l''aide', @maestroVID, NULL, @customItemSetRefusalMissingAuth);