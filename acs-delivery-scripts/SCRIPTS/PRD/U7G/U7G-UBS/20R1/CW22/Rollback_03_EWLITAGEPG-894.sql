USE U7G_ACS_BO;

set @BankUB = 'UBS';
set @createdBy = 'A757435';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @currentPageType = 'FAILURE_PAGE';

DELETE FROM `CustomItem` WHERE `pageTypes` = @currentPageType AND `fk_id_customItemSet` = @customItemSetMobileApp;