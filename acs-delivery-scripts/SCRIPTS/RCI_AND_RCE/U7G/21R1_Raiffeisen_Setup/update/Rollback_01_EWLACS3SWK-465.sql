USE U7G_ACS_BO;

SET @createdBy ='A757435';
SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_RCH_SMS');
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @currentPageType = 'OTP_FORM_PAGE';

DELETE FROM `CustomItem` where ordinal in (51,52 ) and
                               fk_id_customItemSet = @customItemSetSMS and
                               pageTypes = @currentPageType;