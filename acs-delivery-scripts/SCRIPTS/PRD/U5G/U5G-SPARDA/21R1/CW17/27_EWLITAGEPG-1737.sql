USE U5G_ACS_BO;

SET @cisPWD = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_SPB_sharedBIN_PASSWORD');
SET @pageType = 'APP_VIEW';
SET @ordinal = 152;
SET @text = 'Bitte geben Sie die zu der angezeigten Kundennummer passende Online-PIN ein, wie Sie es von Ihrem SpardaOnline-Banking gewohnt sind. Um fortzufahren, bestätigen Sie die Eingabe mit "Senden"';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisPWD AND
                                              `ordinal` = @ordinal AND
                                              `pageTypes` = @pageType;

SET @pageType = 'OTP_FORM_PAGE';
SET @ordinal = 2;
UPDATE `CustomItem` SET `value` = @text
 WHERE `fk_id_customItemSet` = @cisPWD AND `ordinal` = @ordinal AND `pageTypes` = @pageType;