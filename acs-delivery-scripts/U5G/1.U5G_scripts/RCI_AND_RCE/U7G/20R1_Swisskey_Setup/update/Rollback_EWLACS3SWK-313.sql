USE U7G_ACS_BO;

SET @locale = 'de';
SET @helpPage = 'HELP_PAGE';
SET @ordinal = '174';


SET @BankUB = 'CS';
SET @customItemSetSMS_CS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMobileApp_CS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @BankUB = 'NAB';
SET @customItemSetSMS_NAB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMobileApp_NAB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @BankUB = 'SGKB';
SET @customItemSetSMS_SGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMobileApp_SGKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @BankUB = 'SOBA';
SET @customItemSetSMS_SOBA = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMobileApp_SOBA = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @BankUB = 'LUKB';
SET @customItemSetSMS_LUKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMobileApp_LUKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));


UPDATE `CustomItem` SET `value` = 'Hilfe schließen'
					WHERE  `fk_id_customItemSet` IN (@customItemSetSMS_CS,
													 @customItemSetMobileApp_CS,
													 @customItemSetSMS_NAB,
													 @customItemSetMobileApp_NAB,
													 @customItemSetSMS_SGKB,
													 @customItemSetMobileApp_SGKB,
													 @customItemSetSMS_SOBA,
													 @customItemSetMobileApp_SOBA,
													 @customItemSetSMS_LUKB,
													 @customItemSetMobileApp_LUKB)
					AND `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` = @helpPage;