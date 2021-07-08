USE `U7G_ACS_BO`;
-- PWD --
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_PASSWORD');

-- PWD main --
SET @pageOTP = 'OTP_FORM_PAGE';

UPDATE `CustomItem` SET value = '<b>Eingabe persönliches Passwort<b>'
WHERE locale = 'de' and  `ordinal` = 1 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;

UPDATE `CustomItem` SET value = 'Überprüfung der Zahlungsfreigabe'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'Payment approval is being verified'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'L''activation de paiement va être vérifiée'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;
UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento viene controllata'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet = @customItemSetPassword;


-- SMS OVERRIDE and EXT --

SET @customItemSetSMSOverride = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_UNIFIED_SMS_OVERRIDE');
SET @customItemSetSMSEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS');

-- SMS Processing --
UPDATE `CustomItem` SET value = 'Überprüfung der Zahlungsfreigabe'
WHERE locale = 'de' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Bitte haben Sie einen Moment Geduld. Wir prüfen Ihre Zahlungsfreigabe und somit die Authentifikation für die gewünschte Zahlung. '
WHERE locale = 'de' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'Payment approval is being verified'
WHERE locale = 'en' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment. '
WHERE locale = 'en' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L''activation de paiement va être vérifiée'
WHERE locale = 'fr' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité. '
WHERE locale = 'fr' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );

UPDATE `CustomItem` SET value = 'L’autorizzazione di pagamento viene controllata'
WHERE locale = 'it' and  `ordinal` = 12 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
UPDATE `CustomItem` SET value = 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.  '
WHERE locale = 'it' and  `ordinal` = 13 and pageTypes = @pageOTP and fk_id_customItemSet in ( @customItemSetSMSOverride, @customItemSetSMSEXT );
