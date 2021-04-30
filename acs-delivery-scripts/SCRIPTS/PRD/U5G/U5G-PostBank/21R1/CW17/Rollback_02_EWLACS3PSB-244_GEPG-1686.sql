USE U5G_ACS_BO;

SET @cisSMSChoice = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_SMS_Choice');
SET @cisSMSnormal = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_SMS');
SET @cisTAChoice = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_TA_Choice');
SET @cisTAnormal = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_TA');
SET @cisTAChoice_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_MOBILE_APP_Choice');
SET @cisTAnormal_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_MOBILE_APP');
SET @pageType = 'APP_VIEW';
SET @ordinal = 156;

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisSMSChoice AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisSMSnormal AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisTAChoice AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisTAnormal AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;


#GEPG-1686
SET @text = 'Fortsetzen';
SET @pageType = 'APP_VIEW';
UPDATE `CustomItem` SET `value` = @text WHERE pageTypes = @pageType AND
        fk_id_customItemSet = @cisTAChoice_18501 AND
        `ordinal` = 165;


SET @text = 'Fortsetzen';
SET @pageType = 'APP_VIEW';
UPDATE `CustomItem` SET `value` = @text WHERE pageTypes = @pageType AND
        fk_id_customItemSet = @cisTAChoice AND
        `ordinal` = 165;

SET @text = 'Fortsetzen';
SET @pageType = 'APP_VIEW';
UPDATE `CustomItem` SET `value` = @text WHERE pageTypes = @pageType AND
        fk_id_customItemSet = @cisTAnormal AND
        `ordinal` = 165;



SET @ordinal = 153;
SET @cisKBA = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_LOGIN');

UPDATE `CustomItem` SET `value` = '' WHERE `fk_id_customItemSet` = @cisKBA AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;


SET @pageType = 'APP_VIEW_DEVICE_SELECT';
SET @cisSMSChoice_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_SMS_Choice');
SET @cisSMSnormal_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_SMS');

SET @ordinal = 152;
SET @text = 'Abrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSChoice_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSnormal_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;


SET @ordinal = 153;
SET @text = 'Bitte wählen Sie Ihr gewünschtes Gerät aus.';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSChoice_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSnormal_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;

SET @pageType = 'APP_VIEW_MEAN_SELECT';
SET @cisUndefined_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_UNDEFINED');

SET @ordinal = 152;
SET @text = 'Abrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;


SET @ordinal = 153;
SET @text = 'Bitte wählen Sie Ihr gewünschtes Gerät aus.';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18501 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;



SET @pageType = 'APP_VIEW_MEAN_SELECT';
SET @cisUndefined_18502 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_UNDEFINED');

SET @ordinal = 152;
SET @text = 'Damit Sie noch sicherer mit Ihrer Kreditkarte zahlen, haben wir eine zusätzliche Abfrage eingefügt.\n\n Abrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18502 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;


SET @ordinal = 153;
SET @text = 'Bitte wählen Sie Ihr gewünschtes Gerät aus.';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18502 AND
        `pageTypes` = @pageType AND
        `ordinal` = @ordinal;


