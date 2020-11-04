USE `U5G_ACS_BO`;

SET @createdBy = 'W100851';
SET @BankUB = '16900';
SET @locale = 'de';
SET @currentPageType_OTP = 'OTP_FORM_PAGE';
SET @currentPageType_FAILURE = 'FAILURE_PAGE';
SET @currentPageType_APP_VIEW = 'APP_VIEW';
SET @customItemName = 'VISA_MOBILE_APP_FAILURE_PAGE_9_de';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetMOBILEAPPEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

UPDATE	`CustomItem` SET `value` = 'Hilfe & FAQ'
						WHERE `ordinal` = 41
						AND `locale` = @locale
						AND `pageTypes` = @currentPageType_FAILURE
						AND `fk_id_customItemSet` = @customItemSetSMS;

UPDATE	`CustomItem` SET `value` = 'Hilfe & FAQ'
						WHERE `ordinal` = 41
						AND `locale` = @locale
						AND `pageTypes` = @currentPageType_OTP
						AND `fk_id_customItemSet`= @customItemSetSMS;


UPDATE	`CustomItem` SET `value` = 'Hilfe & FAQ'
						WHERE `ordinal` = 9
						AND `locale` = @locale
						AND name = @customItemName
						AND `pageTypes` = @currentPageType_FAILURE
						AND `fk_id_customItemSet` = @customItemSetMOBILEAPPEXT;

UPDATE	`CustomItem` SET `value` = 'Hilfe & FAQ'
						WHERE `ordinal` = 156
						AND `locale` = @locale
						AND `pageTypes` = @currentPageType_APP_VIEW
						AND `fk_id_customItemSet` = @customItemSetMOBILEAPPEXT;

SET @createdBy ='A757435';
SET @BankUB = 'BNP_WM';
SET @locale = 'de';
SET @currentPageType_OTP = 'OTP_FORM_PAGE';
SET @currentPageType_FAILURE = 'FAILURE_PAGE';
SET @currentPageType_POLLING = 'POLLING_PAGE';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @customItemSetPhotoTan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PHOTO_TAN'));
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));

UPDATE `CustomItem` SET `value` = 'Hilfe & FAQ'
					WHERE `ordinal` = 5
					AND	 `locale` = @locale
					AND `pageTypes` IN (@currentPageType_OTP,
										@currentPageType_FAILURE,
										@currentPageType_POLLING)
					AND `fk_id_customItemSet` IN (@customItemSetPASSWORD,
												  @customItemSetPhotoTan,
												  @customItemSetMobileApp);