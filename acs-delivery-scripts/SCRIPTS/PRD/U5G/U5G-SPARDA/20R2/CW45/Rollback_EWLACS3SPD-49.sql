USE `U5G_ACS_BO`;

SET @customItemSetSMSChoice = 'customitemset_SPB_sharedBIN_SMS_CHOICE';
SET @customItemSetSMS ='customitemset_SPB_sharedBIN_SMS';

SET @customItemSetSMSChoiceId = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetSMSChoice);
SET @customItemSetSMSId = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetSMS);

UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`= 'Neue TAN anfordern' WHERE fk_id_customItemSet IN (@customItemSetSMSChoiceId, @customItemSetSMSId) AND pageTypes = 'APP_VIEW' AND ordinal = 155;