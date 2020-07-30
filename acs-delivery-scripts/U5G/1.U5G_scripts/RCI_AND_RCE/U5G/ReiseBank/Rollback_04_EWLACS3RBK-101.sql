USE U5G_ACS_BO;

SET @subIssuerCode = 12000;

SET @subIssuerId = (SELECT id FROM SubIssuer WHERE code = @subIssuerCode);

SET @customItemSetName = 'customitemset_12000_REISEBANK_SMS_01';

SET @customItemSetId = (SELECT id FROM CustomItemSet where fk_id_subIssuer = @subIssuerId AND name = @customItemSetName);

UPDATE CustomItem SET value = 'Authnentication successful'
    WHERE fk_id_customItemSet = @customItemSetId
      AND ordinal = 26
      AND name = 'OTP_FORM_PAGE'
      AND locale = 'en';

UPDATE CustomItem SET value = 'Your authentication has been validated.you will be redirected to the merchant website.'
    WHERE fk_id_customItemSet = @customItemSetId
      AND ordinal = 27
      AND name = 'OTP_FORM_PAGE'
      AND locale = 'en';