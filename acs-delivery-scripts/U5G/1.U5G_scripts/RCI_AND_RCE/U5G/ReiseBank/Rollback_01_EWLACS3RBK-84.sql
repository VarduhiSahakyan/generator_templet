USE `U5G_ACS_BO`;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @subIssuerCode = '12000';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@subIssuerCode, '_', @BankUB, '_SMS_01'));

DELETE FROM `CustomItem` WHERE
ordinal = '12' and fk_id_customItemSet = @customItemSetSMS and locale = 'de' and DTYPE = 'T' and createdBy = @createdBy;