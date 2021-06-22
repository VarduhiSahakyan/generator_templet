USE U7G_ACS_BO;

SET @createdBy ='W100851';
SET @customItemSetSMS = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_ZKB_SMS_EXT');
SET @otpFormPagePageType = 'OTP_FORM_PAGE';

DELETE FROM `CustomItem` where ordinal in (51,52 ) and
                               fk_id_customItemSet = @customItemSetSMS and
                               pageTypes = @otpFormPagePageType;