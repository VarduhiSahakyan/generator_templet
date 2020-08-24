USE `U7G_ACS_BO`;

SET @createdBy ='A758582';
SET @subIssuerCode = '77800';
SET @BankUB = 'LUKB';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @visaSmallLogoId = (SELECT id from `Image` WHERE `name` = 'VISA_SMALL_LOGO');

UPDATE `CustomItem` SET `fk_id_image` = @visaSmallLogoId
					WHERE `DTYPE` = 'I'
					AND `value` = 'Verified by Visa™'
					AND `fk_id_customItemSet` IN (@customItemSetSMS, @customItemSetMobileApp);