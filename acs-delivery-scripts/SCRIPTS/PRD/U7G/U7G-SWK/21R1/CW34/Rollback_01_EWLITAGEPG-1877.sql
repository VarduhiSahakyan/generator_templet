USE `U7G_ACS_BO`;
-- PWD --
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_PASSWORD');

-- PWD main --
SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = '<b>Eingabe persönliches Password<b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Bestätigung der Zahlung erforderlich'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Confirmation of payment required'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Confirmation du paiement requise'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Richiesta conferma di pagamento'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;


-- SMS OVERRIDE and EXT --

SET @customItemSetSMSOverride = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_SMS_OVERRIDE');
SET @customItemSetSMSEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS');

-- SMS Processing --
UPDATE `CustomItem` SET value = 'Bestätigung der Zahlung erforderlich'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Sie erhalten in Kürze einen Freigabe-Code per SMS zur Bestätigung der Zahlung. '
WHERE locale = 'de' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Confirmation of payment required'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'You will receive an approval code via SMS shortly to confirm the payment. '
WHERE locale = 'en' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Confirmation du paiement requise'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Vous recevrez sous peu un code d''activation par SMS pour confirmer le paiement. '
WHERE locale = 'fr' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Richiesta conferma di pagamento'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'A breve riceverà un codice di autenticazione via SMS per confermare il pagamento.  '
WHERE locale = 'it' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
