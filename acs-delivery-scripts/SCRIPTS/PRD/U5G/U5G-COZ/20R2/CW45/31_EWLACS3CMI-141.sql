
USE `U5G_ACS_BO`;

SET @customItemSetId = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_SMS');

UPDATE `CustomItem` SET `value` = 'Händler: @merchant\nBetrag: @amount\nDatum: @formattedDate\nKartennummer: @displayedPan' WHERE `fk_id_customItemSet` = @customItemSetId AND
                                    `pageTypes` = 'APP_VIEW' AND
                                    `ordinal` = 152;