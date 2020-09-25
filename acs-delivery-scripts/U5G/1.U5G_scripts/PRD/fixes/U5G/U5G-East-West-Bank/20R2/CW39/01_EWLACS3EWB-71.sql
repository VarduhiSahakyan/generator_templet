USE `U5G_ACS_BO`;

SET @EWB_SMS_CustomItemSet  = 'customitemset_EWB_SMS';
SET @EWB_SMS_CustomItemSet_Id  = (SELECT id FROM `U5G_ACS_BO`.`CustomItemSet` WHERE `name` =@EWB_SMS_CustomItemSet);

SET @pageTypes  = 'MESSAGE_BODY';

UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='EWB: You have a pending transaction at @merchant for @amount. DO NOT SHARE. If valid, use OTP @otp. Call +63288881700 for concerns.' WHERE  fk_id_customItemSet IN (@EWB_SMS_CustomItemSet_Id) AND pageTypes = @pageTypes;
