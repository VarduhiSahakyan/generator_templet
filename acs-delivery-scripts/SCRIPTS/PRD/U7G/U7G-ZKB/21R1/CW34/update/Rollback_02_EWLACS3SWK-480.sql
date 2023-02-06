USE `U7G_ACS_BO`;

SET @ZKBBankUB = 'ZKB';
SET @customItemSetREFUSALZKB = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @ZKBBankUB, '_DEFAULT_REFUSAL'));
SET @refusalPageType = 'REFUSAL_PAGE';


# -------- ZKB ---------
SET @ordinal = 22;

SET @textValue = 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Payment not completed – card is not registered for 3D Secure.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Pagamento non eseguito - La carta non è registrata per 3D Secure';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;


SET @ordinal = 23;

SET @textValue = 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, bitten wir Sie Ihre Karte gemäss der Anleitung Ihrer Bank entsprechend zu registrieren.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;


SET @ordinal = 32;

SET @textValue = 'Zahlung nicht ausgeführt - Technischer Fehler';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Payment not completed – technical error';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Paiement non effectué - Problème technique';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Pagamento non eseguito - Errore tecnico';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;


SET @ordinal = 33;

SET @textValue = 'Auf Grund eines technischen Fehlers konnte die Zahlung nicht ausgeführt werden. Sollten Sie die den Kauf fortsetzen wollen, bitten wir Sie es erneut zu versuchen.';
SET @local = 'de';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.';
SET @local = 'en';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.';
SET @local = 'fr';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;
SET @textValue = 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.';
SET @local = 'it';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetREFUSALZKB AND locale = @local AND ordinal = @ordinal AND pageTypes = @refusalPageType;