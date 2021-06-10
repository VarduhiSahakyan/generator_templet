USE U5G_ACS_BO;

SET @BankUB = 'SPB';
SET @appViewPageType = 'APP_VIEW';
SET @pollingPageType = 'POLLING_PAGE';

SET @mobileAppExtCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_sharedBIN_MOBILE_APP_EXT'));
SET @mobileAppExtChoiceCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_sharedBIN_MOBILE_APP_EXT_CHOICE'));

SET @textValue = 'Bitte geben Sie den Auftrag in Ihrer SpardaSecureApp frei. Wechseln Sie hierzu in die SpardaSecureApp und bestätigen Sie die Zahlungsfreigabe.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 152 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 152 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;

SET @textValue = 'Beenden';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 165 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 165 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;

SET @textValue = 'Bitte versuchen Sie erneut die Zahlung in der SpardaSecureApp freizugeben.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 160 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 160 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;

SET @textValue = 'Bitte geben Sie den Auftrag in Ihrer SpardaSecureApp frei. Wechseln Sie hierzu in die SpardaSecureApp und bestätigen Sie die Zahlungsfreigabe.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @pollingPageType AND ordinal = 2 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @pollingPageType AND ordinal = 2 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;