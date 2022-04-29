USE U5G_ACS_BO;

SET @mobileAppCIS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_16500_MOBILE_APP');

SET @pageType = 'APP_VIEW';

SET @challengeInfoText = 'Starten Sie zunächst die Banking to go App und geben Sie die Zahlung dort frei.';

UPDATE `CustomItem` SET `value` = @challengeInfoText WHERE `fk_id_customItemSet` = @mobileAppCIS AND
                                                           `pageTypes` = @pageType AND
                                                           `ordinal` = 152;


SET @oobContinuationText = 'Fortfahren nach erfolgter Freigabe';

UPDATE `CustomItem` SET `value` = @oobContinuationText WHERE `fk_id_customItemSet` = @mobileAppCIS AND
        `pageTypes` = @pageType AND
        `ordinal` = 165;