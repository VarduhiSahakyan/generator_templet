USE U5G_ACS_BO;

SET @idImageVisaScheme = (SELECT id FROM `Image` im WHERE im.name = 'VISA_LOGO');


SET @customItemSetFraudRefusal = 'customitemset_16600_FRAUD_REFUSAL';
SET @customItemSetRBARefusal = 'customitemset_16600_RBA_REFUSAL';
SET @customItemSetPhotoTan_1 = 'customitemset_16600_PHOTOTAN_1';
SET @customItemSetSMS_1 = 'customitemset_16600_SMS_1';
SET @customItemSetITAN_1 = 'customitemset_16600_ITAN_1';
SET @customItemSetPhotoTan_2 = 'customitemset_16600_PHOTOTAN_2';
SET @customItemSetSMS_2 = 'customitemset_16600_SMS_2';
SET @customItemSetITAN_2 = 'customitemset_16600_ITAN_2';

SET @customItemSetFraudRefusal_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetFraudRefusal );
SET @customItemSetRBARefusal_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetRBARefusal );
SET @customItemSetPhotoTan_1_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetPhotoTan_1 );
SET @customItemSetSMS_1_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetSMS_1 );
SET @customItemSetITAN_1_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetITAN_1 );
SET @customItemSetPhotoTan_2_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetPhotoTan_2 );
SET @customItemSetSMS_2_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetSMS_2 );
SET @customItemSetITAN_2_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetITAN_2 );

UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetFraudRefusal_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetRBARefusal_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetPhotoTan_1_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetSMS_1_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetITAN_1_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetPhotoTan_2_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetSMS_2_ID ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 171 AND `fk_id_customItemSet` = @customItemSetITAN_2_ID ;



# Rollback of Default Refusal logos
SET @customItemSetDefaultRefusal = 'customitemset_16600_DEFAULT_REFUSAL';
SET @customItemSetDefaultRefusal_ID = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetDefaultRefusal );



DELETE FROM `CustomItem` WHERE `ordinal` = 170 AND fk_id_customItemSet = @customItemSetDefaultRefusal_ID;
DELETE FROM `CustomItem` WHERE `ordinal` = 171 AND fk_id_customItemSet = @customItemSetDefaultRefusal_ID;

DELETE FROM `Image` WHERE `name` LIKE  '%VISA_LOGO_SMALL%';