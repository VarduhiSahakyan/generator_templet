USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_MISSING_AUTHENT_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL);


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_MISSING_AUTHENT_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'de', 1000, @currentPageType, 'Ihr TAN-Verfahren ist gesperrt oder Ihre Karte wurde noch nicht im Online-Banking registriert. Kontakt: 069 / 5 8000 8000', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'de', 1001, @currentPageType, 'Ihr TAN-Verfahren ist gesperrt oder Ihre Karte wurde noch nicht im Online-Banking registriert. Kontakt: 069 / 5 8000 8000', @MaestroVID, NULL, @customItemSetREFUSAL),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'de', 1002, @currentPageType, 'Ihr TAN-Verfahren ist gesperrt oder Ihre Karte wurde noch nicht im Online-Banking registriert. Kontakt: 069 / 5 8000 8000', @MaestroVID, NULL, @customItemSetREFUSAL);