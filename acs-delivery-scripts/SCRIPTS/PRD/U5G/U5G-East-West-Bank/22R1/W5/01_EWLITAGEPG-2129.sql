USE U5G_ACS_BO;


SET @messagePageType = 'MESSAGE_BODY';
SET @messageNPAPageType = 'MESSAGE_BODY_NPA';
SET @customItemSet = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_EWB_SMS');
SET @ordinal = 0;

SET @textValue ='EW ALERT: Are you PAYING @amount at @merchant? If not, DO NOT SHARE OTP. If yes, use OTP @otp. Call +63288881700 for concerns.';

UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSet AND ordinal = @ordinal AND pageTypes = @messagePageType;

UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSet AND ordinal = @ordinal AND pageTypes = @messageNPAPageType;