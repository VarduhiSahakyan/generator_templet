use U5G_ACS_BO;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @subIssuerCode = '12000';

/* CustomItem */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_DEFAULT_REFUSAL'));
SET @MasterCardId = (SELECT `id` FROM `Image` WHERE `name` = 'MC_ID_LOGO');
SET @locale = 'de';
SET @ordinal = 20;
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Zahlung abgelehnt';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSAL
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;

SET @pageTypes = 'ALL';
SET @ordinal = 2;
UPDATE `CustomItem` SET `fk_id_image` =@MasterCardId  WHERE `fk_id_customItemSet` = @customItemSetREFUSAL
                                                      AND `pageTypes` = @pageTypes
                                                      AND `locale` = @locale
                                                      AND `ordinal` = @ordinal
                                                      AND `name` = 'Mastercard Logo';

SET @locale = 'en';
SET @ordinal = 20;
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Payment refused';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSAL
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;

SET @pageTypes = 'ALL';
SET @ordinal = 2;
UPDATE `CustomItem` SET `fk_id_image` =@MasterCardId  WHERE `fk_id_customItemSet` = @customItemSetREFUSAL
                                                      AND `pageTypes` = @pageTypes
                                                      AND `locale` = @locale
                                                      AND `ordinal` = @ordinal
                                                      AND `name` = 'Mastercard Logo';



SET @customItemSetREFUSALFRAUD = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_DEFAULT_FRAUD'));
SET @locale = 'de';
SET @ordinal = 20;
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Zahlung abgelehnt';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSALFRAUD
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;

SET @pageTypes = 'ALL';
SET @ordinal = 2;
UPDATE `CustomItem` SET `fk_id_image` =@MasterCardId  WHERE `fk_id_customItemSet` = @customItemSetREFUSALFRAUD
                                                      AND `pageTypes` = @pageTypes
                                                      AND `locale` = @locale
                                                      AND `ordinal` = @ordinal
                                                      AND `name` = 'Mastercard Logo';

SET @locale = 'en';
SET @ordinal = 20;
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Payment refused';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSALFRAUD
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;

SET @pageTypes = 'ALL';
SET @ordinal = 2;
UPDATE `CustomItem` SET `fk_id_image` =@MasterCardId  WHERE `fk_id_customItemSet` = @customItemSetREFUSALFRAUD
                                                      AND `pageTypes` = @pageTypes
                                                      AND `locale` = @locale
                                                      AND `ordinal` = @ordinal
                                                      AND `name` = 'Mastercard Logo';
