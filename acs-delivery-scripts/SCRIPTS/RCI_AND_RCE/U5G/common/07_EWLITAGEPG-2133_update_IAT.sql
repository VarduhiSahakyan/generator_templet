USE U5G_ACS_BO;

SET @createdBy = 'A757435';

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @updateState =  'PUSHED_TO_CONFIG';
SET @currentPageType = 'ALL';
SET @currentAuthentMean = 'REFUSAL';

SET @customItemSetREFUSAL_ReiseBank_old = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_REISEBANK_DEFAULT_REFUSAL');
SET @customItemSetREFUSAL_ReiseBank = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_REISEBANK_DEFAULT_FRAUD');

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSAL_ReiseBank
WHERE `fk_id_customItemSet` = @customItemSetREFUSAL_ReiseBank_old AND
      `ordinal` in (1000,1001,1002);

SET @customItemSetREFUSAL_COB_old = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_DEFAULT_REFUSAL');
SET @customItemSetREFUSAL_COB = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');


UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSAL_COB
WHERE `fk_id_customItemSet` = @customItemSetREFUSAL_COB_old AND
        `ordinal` in (1000,1001,1002);

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1000'), @updateState,
 'en', 1000, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1001'), @updateState,
 'en', 1001, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1002'), @updateState,
 'en', 1002, @currentPageType, 'Ihre Karte wurde noch nicht für das sichere Einkaufen registriert. Infos finden Sie unter www.commerzbank.de/sicher-einkaufen', @MaestroVID, NULL, @customItemSetREFUSAL);
