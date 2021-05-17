USE U5G_ACS_BO;

SET @BankUB = 'SPB';
SET @appViewPageType = 'APP_VIEW';
SET @pollingPageType = 'POLLING_PAGE';

SET @mobileAppExtCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_sharedBIN_MOBILE_APP_EXT'));
SET @mobileAppExtChoiceCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_sharedBIN_MOBILE_APP_EXT_CHOICE'));

SET @textValue = 'Bitte geben Sie den Auftrag in der SpardaSecureApp frei./n Hinweis: Sie können die Zahlungsfreigabe in der SpardaSecureApp auch ablehnen.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 152 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 152 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;

SET @textValue = 'Weiter';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 165 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 165 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;

SET @textValue = 'Eine Freigabe der Zahlung ist nicht möglich.

 Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 160 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @appViewPageType AND ordinal = 160 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;

SET @textValue = 'Bitte geben Sie den Auftrag in der SpardaSecureApp frei.';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @pollingPageType AND ordinal = 2 AND fk_id_customItemSet = @mobileAppExtCustomItemSet;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @pollingPageType AND ordinal = 2 AND fk_id_customItemSet = @mobileAppExtChoiceCustomItemSet;