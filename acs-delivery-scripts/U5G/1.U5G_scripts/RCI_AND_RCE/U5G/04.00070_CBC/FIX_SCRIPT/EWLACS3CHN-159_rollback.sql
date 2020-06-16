USE `U5G_ACS_BO`;

SET @createdBy = 'InitPhase';
SET @issuerCode = '00070';

SET @idCustomItemSet = (SELECT max(id) from `CustomItemSet` where `description` = 'customitemset_00070_SMS_Current');

DELETE FROM `CustomItem` WHERE name='MASTERCARD_OTP_SMS_ALL_1_en' AND locale='en' AND ordinal=1 and `pageTypes`='ALL' AND `fk_id_network`=2 AND `fk_id_customItemSet`=@idCustomItemSet;
DELETE FROM `CustomItem` WHERE name='MASTERCARD_OTP_SMS_ALL_2_en' AND locale='en' AND ordinal=2 and `pageTypes`='ALL' AND `fk_id_network`=2 AND `fk_id_customItemSet`=@idCustomItemSet;
DELETE FROM `CustomItem` WHERE name='MASTERCARD_OTP_SMS_ALL_20_en' AND locale='en' AND ordinal=20 and `pageTypes`='ALL' AND `fk_id_network`=2 AND `fk_id_customItemSet`=@idCustomItemSet;
DELETE FROM `CustomItem` WHERE name='MASTERCARD_OTP_SMS_ALL_40_en' AND locale='en' AND ordinal=40 and `pageTypes`='ALL' AND `fk_id_network`=2 AND `fk_id_customItemSet`=@idCustomItemSet;
DELETE FROM `CustomItem` WHERE name='MASTERCARD_OTP_SMS_ALL_41_en' AND locale='en' AND ordinal=41 and `pageTypes`='ALL' AND `fk_id_network`=2 AND `fk_id_customItemSet`=@idCustomItemSet;
