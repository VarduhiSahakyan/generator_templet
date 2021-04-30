USE U7G_ACS_BO;
SET @createdBy ='A757435';
SET @BankUB = 'UBS';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));

DELETE FROM `CustomItem` where ordinal in (51,52 ) and fk_id_customItemSet = @customItemSetSMS;