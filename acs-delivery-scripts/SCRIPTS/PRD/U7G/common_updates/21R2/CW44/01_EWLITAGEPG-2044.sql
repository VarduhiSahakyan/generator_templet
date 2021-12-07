USE U7G_ACS_BO;

SET @createdBy = 'A758582';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_UBS_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL);



SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL);



SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_RCH_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL);



 SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_ZKB_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'it', 1000, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'it', 1001, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'it', 1002, @currentPageType, 'La transazione non è andata a buon fine. Si rivolga alla sua banca per registrare la sua carta al servizio 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL);


 SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_BCV_MISSING_AUTHENTICATION_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Die Zahlung kann nicht ausgeführt werden. Bitte kontaktieren Sie Ihre Bank, um Ihre Karte für 3D Secure zu registrieren.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'The payment cannot be processed. Please contact your bank to register your card for 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'fr', 1000, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'fr', 1001, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'fr', 1002, @currentPageType, 'La transaction n''a pas abouti. Veuillez vous adresser à votre banque pour enregistrer votre carte pour 3D Secure.', @MaestroVID, NULL, @customItemSetREFUSAL);