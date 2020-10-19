USE U5G_ACS_BO;
SET @createdBy = 'A757435';
SET @customItemSetPWD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_PASSWORD');
SET @currentPageType = 'MEANS_PAGE';
SET @customItemSetOTP_SMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_SMS');
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name = 'OTP_SMS_Logo' );

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetOTP_SMS WHERE `fk_id_customItemSet` = @customItemSetPWD AND
                                                                            `pageTypes` = @currentPageType AND
                                                                            `ordinal` = 9;