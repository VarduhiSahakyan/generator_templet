USE U5G_ACS_BO;

SET @cisSMSChoice = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_SMS_Choice');
SET @cisSMSnormal = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_SMS');
SET @cisTAChoice = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_TA_Choice');
SET @cisTAnormal = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_TA');
SET @cisTAChoice_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_MOBILE_APP_Choice');
SET @cisTAnormal_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_MOBILE_APP');
SET @pageType = 'APP_VIEW';
SET @ordinal = 156;

UPDATE `CustomItem` SET `value` = 'Hilfe' WHERE `fk_id_customItemSet` = @cisSMSChoice AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = 'Hilfe' WHERE `fk_id_customItemSet` = @cisSMSnormal AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = 'Hilfe' WHERE `fk_id_customItemSet` = @cisTAChoice AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = 'Hilfe' WHERE `fk_id_customItemSet` = @cisTAnormal AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = 'Hilfe' WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = 'Hilfe' WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
                                                `pageTypes` = @pageType AND
                                                `ordinal` = @ordinal;

