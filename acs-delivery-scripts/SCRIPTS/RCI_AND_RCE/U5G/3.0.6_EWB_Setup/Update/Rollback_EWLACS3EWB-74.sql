
USE `U5G_ACS_BO`;

SET @currentPageType = 'MESSAGE_BODY';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_EWB_SMS');


UPDATE CustomItem SET VALUE = 'EWB: You have a pending transaction at @merchant for @amount. DO NOT SHARE. If valid, use OTP @otp. Call +63288881700 for concerns.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 0 and DTYPE='T';