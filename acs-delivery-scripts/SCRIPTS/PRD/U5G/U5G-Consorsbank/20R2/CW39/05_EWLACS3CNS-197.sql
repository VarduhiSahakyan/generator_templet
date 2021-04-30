USE `U5G_ACS_BO`;

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
					AND  `locale` = @locale
					AND `pageTypes` IN (@currentPageType_OTP,
										@currentPageType_FAILURE,
										@currentPageType_POLLING)
					AND `fk_id_customItemSet` IN (@customItemSetPASSWORD,
												  @customItemSetPhotoTan,
												  @customItemSetMobileApp);