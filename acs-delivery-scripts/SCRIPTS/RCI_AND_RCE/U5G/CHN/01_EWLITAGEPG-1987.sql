USE U5G_ACS_BO;

SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_00070_SMS');

SET @textValue = 'Your OTP is @otp valid for 5 mins for @amount at @merchantLimit25. NEVER SHARE OTP WITH ANYONE! Call +63285119555 if OTP was not requested.';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 0 AND pageTypes = 'MESSAGE_BODY' AND fk_id_customItemSet = @customItemSetId;