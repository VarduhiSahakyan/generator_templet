USE U5G_ACS_BO;

SET @createdBy = 'A757435';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LBBW_DEFAULT_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'BW-Secure ist erforderlich. Bitte gehen Sie auf https://sicheres-bezahlen.bw-bank.de und registrieren Ihre Karte.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'BW-Secure ist erforderlich. Bitte gehen Sie auf https://sicheres-bezahlen.bw-bank.de und registrieren Ihre Karte.', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'BW-Secure ist erforderlich. Bitte gehen Sie auf https://sicheres-bezahlen.bw-bank.de und registrieren Ihre Karte.', @MaestroVID, NULL, @customItemSetREFUSAL);



SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_REISEBANK_DEFAULT_FRAUD');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Zahlung nicht ausgeführt. Registrieren Sie sich in der RBMC Secure App für 3D Secure. Infos auf www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Zahlung nicht ausgeführt. Registrieren Sie sich in der RBMC Secure App für 3D Secure. Infos auf www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Zahlung nicht ausgeführt. Registrieren Sie sich in der RBMC Secure App für 3D Secure. Infos auf www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'Payment not executed. Register for 3D Secure in the RBMC Secure App. Info on www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'Payment not executed. Register for 3D Secure in the RBMC Secure App. Info on www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'Payment not executed. Register for 3D Secure in the RBMC Secure App. Info on www.reisebank.de/mastercard', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL);

