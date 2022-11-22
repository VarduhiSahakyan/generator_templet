USE U5G_ACS_BO;

SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_00070_SMS');

SET @textValue = 'Your OTP is @otp valid for 5 mins for purchase of @amount at @merchant. Pls call +63285119555 if you didn''t request this OTP.';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 0 AND pageTypes = 'MESSAGE_BODY' AND fk_id_customItemSet = @customItemSetId;