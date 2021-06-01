
USE `U5G_ACS_BO`;

SET @BankUB = '12000';
SET @polingPageType = 'POLLING_PAGE';
SET @failurePageType = 'FAILURE_PAGE';

SET @customItemSetMobileAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));

SET @textValue = 'Open your RBMC Secure App and click on "Card payment", to confirm your transaction. Please check listed transaction details and approve transaction.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @polingPageType AND ordinal = 2 AND locale = 'en' AND fk_id_customItemSet = @customItemSetMobileAPP;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @failurePageType AND ordinal = 2 AND locale = 'en' AND fk_id_customItemSet = @customItemSetMobileAPP;