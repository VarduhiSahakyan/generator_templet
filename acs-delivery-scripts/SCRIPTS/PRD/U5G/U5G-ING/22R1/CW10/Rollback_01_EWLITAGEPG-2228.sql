USE U5G_ACS_BO;

SET @mobileAppCIS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_16500_MOBILE_APP');

SET @pageType = 'APP_VIEW';

SET @challengeInfoText = 'Banking to go App starten und Auftrag freigeben';

UPDATE `CustomItem` SET `value` = @challengeInfoText WHERE `fk_id_customItemSet` = @mobileAppCIS AND
                                                           `pageTypes` = @pageType AND
                                                           `ordinal` = 152;


SET @oobContinuationText = 'Ausführen';

UPDATE `CustomItem` SET `value` = @oobContinuationText WHERE `fk_id_customItemSet` = @mobileAppCIS AND
        `pageTypes` = @pageType AND
        `ordinal` = 165;