USE `U7G_ACS_BO`;

SET @ZKBBankUB = 'ZKB';


SET @refusalPageType = 'REFUSAL_PAGE';
SET @missngCustomItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @ZKBBankUB, '_MISSING_AUTHENTICATION_REFUSAL'));


SET @ordinal = 32;
SET @textValue = 'Zahlungsfreigabe nicht möglich';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;

SET @textValue = 'Payment approval not possible.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;

SET @textValue = 'Activation de paiement impossible';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;

SET @textValue = 'Autorizzazione di pagamento non possibile';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;


SET @ordinal = 33;
SET @textValue = 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode (SMS oder App) für Ihre Karte gefunden haben. Bitte hinterlegen Sie für Ihre Karte eine entsprechende Freigabe-Methode im Registrierungsportal gemäss der Anleitung Ihrer Bank.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;

SET @textValue = 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method for your card on the registration portal according to your bank''s instructions.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;

SET @textValue = 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. Veuillez consigner une méthode d''activation pour votre carte dans le portail d’inscription, conformément aux instructions de votre banque.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;

SET @textValue = 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE ordinal = @ordinal AND pageTypes = @refusalPageType AND locale = @local AND fk_id_customItemSet = @missngCustomItemSetId;
