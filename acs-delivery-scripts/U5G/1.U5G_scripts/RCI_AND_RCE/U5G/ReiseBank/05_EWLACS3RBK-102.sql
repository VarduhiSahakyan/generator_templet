USE U5G_ACS_BO;

SET @subIssuerCode = 12000;

SET @subIssuerId = (SELECT id FROM SubIssuer WHERE code = @subIssuerCode);

SET @customItemSetName = 'customitemset_12000_REISEBANK_SMS_01';

SET @customItemSetId = (SELECT id FROM CustomItemSet where fk_id_subIssuer = @subIssuerId AND name = @customItemSetName);

UPDATE CustomItem SET value = 'Die eingegebene mobile TAN ist ungültig. Sie haben Ihre maximale Anzahl an Versuchen ausgeschöpft.'
    WHERE fk_id_customItemSet = @customItemSetId
      AND ordinal = 17
      AND name = 'FAILURE_PAGE'
      AND locale = 'de';

