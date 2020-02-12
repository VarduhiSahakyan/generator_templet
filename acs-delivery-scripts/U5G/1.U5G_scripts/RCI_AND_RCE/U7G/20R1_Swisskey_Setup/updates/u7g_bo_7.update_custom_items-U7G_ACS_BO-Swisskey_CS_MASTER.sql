/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A757436';
SET @issuerCode = '41001';
SET @subIssuerCode = '48350';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB = 'CS';

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;

/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';

/*ENGLISH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method for your card on the enrollment portal according to your bank''s instructions.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174,@currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175,@currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, '<b>Help</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'To boost security while paying online, your bank has introduced two-level authentification. To complete a payment, you must confirm it either by means of an approval code per SMS, or through verification of your identity with a mobile authentication app. You need to register once for this service. Contact your bank for the corresponding registration process or changes to your authentification method.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @helpPage, 'Close help text', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetREFUSAL);


/*FRENCH translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. Veuillez consigner une méthode d''activation pour votre carte dans le portail d''Enrollment, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174,@currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175,@currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @helpPage, '<b>Aide</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @helpPage, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. Afin de pouvoir effectuer un paiement, vous devez le confirmer soit au moyen d''un code d''activation par SMS, soit par la vérification de votre personne sur une App d''authentification mobile. Pour ce service, vous devez vous enregistrer une fois. Pour la procédure d''enregistrement correspondante, ou pour les modifications de votre méthode d''authentification, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @helpPage, 'Fermer le texte d''aide', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetREFUSAL);



/*Italian translations for DEFAULT_REFUSAL*/
SET @currentPageType = 'REFUSAL_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetREFUSAL
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174,@currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175,@currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetREFUSAL);

SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @helpPage, '<b>Aiuto</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @helpPage, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. Per poter effettuare un pagamento, deve confermarlo utilizzando un codice di autenticazione tramite SMS o verificando la sua persona su un’app di autenticazione mobile. Deve effettuare una volta la registrazione per questo servizio. Si rivolga alla sua banca per il processo di registrazione corrispondente o per modifiche al metodo di autenticazione.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @helpPage, 'Chiudere il testo di aiuto', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';

/*ENGLISH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'You have requested an approval code for an online purchase. Please use the following code: @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>SMS approval of the payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'We have sent an approval code to your mobile phone to confirm the payment. Please check the payment details to the left and confirm the payment by entering the approval code.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, 'Payment approval is being verified', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Please be patient. We are verifying your payment approval and thereby the authentication for the requested payment.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, 'Payment confirmation cancelled', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'en', 19, @currentPageType, 'Request new approval code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Confirmation failed', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, 'Successful payment confirmation', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'You have successfully confirmed the payment and will be automatically routed back to the merchant.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, 'Incorrect approval code', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The approval code you entered is incorrect. The payment was not conducted and your card was not debited. Please try again if you wish to continue the purchase.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, 'Payment not completed – session expired', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'Too much time has passed before the payment was confirmed. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel payment', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'en', 42, @currentPageType, 'Approve', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Help</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To boost security while paying online, your bank has introduced two-level authentification. To approve a payment, please confirm it with the approval code you receive via SMS. For each purchase an SMS is sent to you with a new one-time code at the telephone number you registered. For changes to your telephone number, or other questions about online shopping with you card, please contact your bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Confirmation failed', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'You have entered an incorrect approval code multiple times. Your payment could not be completed and your card was not debited. Your card will now be temporarily blocked for online payments for security reasons. ', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Payment approval not possible.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Unfortunately, we cannot complete your request, because we could not find an approval method (SMS or app) for your card. Please set up a corresponding approval method for your card on the enrollment portal according to your bank''s instructions.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, 'Payment not completed – card is not registered for 3D Secure.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register your card according the instructions issued by your bank.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'The payment could not be completed due to a technical error. If you wish to continue with the purchase, please try again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to online shop', @MaestroMID, NULL, @customItemSetSMS);




/*FRENCH translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'fr', 0, 'MESSAGE_BODY',
        'Vous avez demandé un code d’activation pour un paiement en ligne. Veuillez utiliser le code suivant : @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>SMS - Activation du paiement</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Pour la confirmation du paiement, nous vous avons envoyé un code d''activation sur votre téléphone portable. Veuillez vérifier les détails du paiement à gauche et confirmez le paiement en saisissant le code d''activation.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'fr', 12, @currentPageType, 'L''activation de paiement va être vérifiée', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'fr', 13, @currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'fr', 14, @currentPageType, 'Activation de paiement interrompue', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'fr', 15, @currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'fr', 19, @currentPageType, 'Demander un nouveau code d''activation', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'L''activation a échoué', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'fr', 26, @currentPageType, 'L’activation du paiement a réussi', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'fr', 27, @currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'fr', 28, @currentPageType, 'Code d''activation erroné', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'fr', 29, @currentPageType, 'Le code d''activation que vous avez saisi n''est pas correct. Le paiement n''a pas été effectué et votre carte n''a pas été débitée. Si vous voulez continuer l''achat, essayez à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'fr', 30, @currentPageType, 'Paiement non effectué - La session a expiré', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'fr', 31, @currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'fr', 42, @currentPageType, 'Activer', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'Vous avez saisi 3 fois un mauvais code d''activation. Votre paiement n''a pas pu être terminé et votre carte n''a pas été débitée. Pour des raisons de sécurité, votre carte va, pour une courte durée, être bloquée pour les paiements en ligne.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activation de paiement impossible</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Nous n''avons malheureusement pas pu répondre à votre demande car nous n''avons trouvé aucune méthode d''activation (SMS ou App) pour votre carte. Veuillez consigner une méthode d''activation pour votre carte dans le portail d''Enrollment, conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'fr', 22, @currentPageType, 'Le paiement n''a pas été effectué - La carte n''est pas enregistrée pour 3D Secure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'fr', 23, @currentPageType, 'Le paiement n''as pas pu être effectué car votre carte n''est pas enregistrée pour les paiements 3D Secure. Si vous souhaitez poursuivre l''achat, nous vous prions d''enregistrer votre carte conformément aux instructions de votre banque.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d''une erreur technique, le paiement n''a pas pu être effectué. Si vous souhaitez poursuivre l''achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer le message', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetSMS);




/*ITALIAN translations for OTP_SMS*/
/* Here are the images for all pages associated to the SMS Profile */
SET @currentPageType = 'OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetSMS
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'it', 0, 'MESSAGE_BODY',
        'Ha richiesto un codice di autenticazione per un pagamento online. Utilizzi il seguente codice: @otp', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione del pagamento via SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Le abbiamo inviato un codice di autenticazione sul suo cellulare per confermare il pagamento. Controlli i dettagli del pagamento a sinistra e confermi il pagamento inserendo il codice di autorizzazione.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'it', 12, @currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'it', 13, @currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'it', 14, @currentPageType, 'Autorizzazione di pagamento annullata', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'it', 15, @currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_19'), 'PUSHED_TO_CONFIG',
         'it', 19, @currentPageType, 'Richiede un nuovo codice di autenticazione', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Autenticazione fallita', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'it', 26, @currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'it', 27, @currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'it', 28, @currentPageType, 'Codice di autenticazione errato', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'it', 29, @currentPageType, 'Il codice di autenticazione da lei inserito non è corretto. Il pagamento non è stato eseguito e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, provi nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'it', 30, @currentPageType, 'Indietro al negozio online Pagamento non effettuato - Sessione scaduta', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'it', 31, @currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
         'it', 42, @currentPageType, 'Autorizzare', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. Per autorizzare un pagamento, lo confermi con un codice di autenticazione che riceverà tramite SMS. A ogni acquisto le verrà inviato tramite SMS un nuovo codice univoco al numero di telefono da lei registrato. Si rivolga alla sua banca per modificare il suo numero di telefono o per altre domande sugli acquisti online con la sua carta.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'Ha inserito 3 volte il codice di autenticazione errato. Non è stato possibile portare a termine il pagamento e la sua carta non è stata addebitata. Per motivi di sicurezza la sua carta verrà ora bloccata per i pagamenti online per un breve periodo di tempo.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);

SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzazione di pagamento non possibile</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Purtroppo non siamo riusciti a elaborare la sua richiesta perché non abbiamo trovato un metodo di autenticazione (SMS o app) per la sua carta. Stabilisca un metodo di autenticazione corrispondente per la sua carta nel portale di registrazione secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'it', 22, @currentPageType, 'Pagamento non eseguito - La carta non è registrata per 3D Secure', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'it', 23, @currentPageType, 'Non è stato possibile effettuare il pagamento perché la sua carta non è registrata per i pagamenti 3D Secure. Se desidera continuare l’acquisto, la preghiamo di registrare la sua carta secondo le istruzioni della sua banca.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non eseguito - Errore tecnico', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere messaggio', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetSMS);




SET @currentAuthentMean = 'MOBILE_APP';
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @currentPageType = 'POLLING_PAGE';
SET @updateState = 'PUSHED_TO_CONFIG';

/*ENGLISH translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Confirm payment in the app</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To complete the payment, you must confirm it in the app provided by your bank. You should already have received a corresponding message on your mobile phone. Otherwise, you can open the app directly and confirm the payment there.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'Request confirmation via SMS instead.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12,@currentPageType, 'Payment approval is being verified', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13,@currentPageType, 'Please be patient. We are verifying your payment confirmation and thereby the authentification for the requested payment.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14,@currentPageType, 'Payment confirmation cancelled', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15,@currentPageType, 'The payment was cancelled and your card was not debited. If you wish to nevertheless continue the payment process, please start the payment attempt again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26,@currentPageType, 'Successful payment confirmation', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27,@currentPageType, 'You have successfully confirmed the payment and will be automatically routed back to the merchant.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30,@currentPageType, 'Payment not completed – session expired', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31,@currentPageType, 'Too much time has passed before the payment was confirmed. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32,@currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33,@currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel payment', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'en', 100, 'ALL', 'Merchant', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'en', 101, 'ALL', 'Amount', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'en', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'en', 103, 'ALL', 'Card number', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'en', 104, 'ALL', 'Phone number', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Help</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'To boost security while paying online, your bank has introduced two-level authentification. You can approve online payments on your mobile telephone in the app provided by your bank. If you have questions, please contact your bank directly.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'en', 11, @currentPageType, '<b>Information about payment</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, 'Confirmation failed', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'The authentication on your mobile phone and thus the payment confirmation failed. The payment process was cancelled and your card was not debited. If you wish to continue the payment process, please start the payment attempt again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, 'Payment not completed – technical error', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Due to a technical error, the payment could not be completed and your card was not debited. If you wish to continue with the purchase, please try it again.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'en', 174, @currentPageType, 'Close Help', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'en', 175, @currentPageType, 'Back to the online shop', @MaestroMID, NULL, @customItemSetMobileApp);



/*FRENCH translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'fr', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'fr', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Activer le paiement dans l''App</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Pour que le paiement puisse être terminé, vous devez l''activer dans l''App mise à disposition par votre banque. Vous devriez déjà avoir reçu un message correspondant sur votre téléphone portable. Dans le cas contraire, vous pouvez aller directement dans votre App et y vérifier le paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'fr', 3, @currentPageType, 'À la place, demander l''activation pas SMS', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'fr', 12,@currentPageType, 'Payment approval is being verified', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'fr', 13,@currentPageType, 'Merci de patienter. Nous vérifions votre activation de paiement et donc l''authentification pour le paiement souhaité.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'fr', 14,@currentPageType, 'Activation de paiement interrompue', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'fr', 15,@currentPageType, 'Le paiement a été interrompu et votre carte n’a pas été débitée. Si vous souhaitez malgré tout continuer le processus d’achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'fr', 26,@currentPageType, 'L’activation du paiement a réussi', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'fr', 27,@currentPageType, 'Vous avez réussi à activer le paiement et vous serez redirigé automatiquement vers le site du commerçant.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'fr', 30,@currentPageType, 'Paiement non effectué - La session a expiré', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'fr', 31,@currentPageType, 'Trop de temps s’est écoulé avant le paiement. Pour des raisons de sécurité, la procédure de paiement a donc été interrompue. Veuillez retourner sur la boutique en ligne et recommencez la procédure de paiement si vous voulez effectuer le paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32,@currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33,@currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'fr', 40, @currentPageType, 'Interrompre le paiement', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'fr', 100, 'ALL', 'Commerçant', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'fr', 101, 'ALL', 'Montant', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'fr', 102, 'ALL', 'Date', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'fr', 103, 'ALL', 'Numéro de carte', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'fr', 104, 'ALL', 'Numéro de téléphone', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'fr', 1, @currentPageType, '<b>Aide</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'fr', 2, @currentPageType, 'Afin d''augmenter votre sécurité lors des paiements en ligne, votre banque a mis en place une authentification en deux étapes. Afin d''activer un paiement, confirmez celui-ci avec un code d''activation que vous avez reçu par SMS. Lors de chaque achat, un nouveau code unique vous sera envoyé par SMS au numéro de téléphone que vous avez enregistré. Pour modifier votre numéro de téléphone ou pour toute autre question concernant les achats en ligne avec votre carte, veuillez vous adresser à votre banque.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'fr', 11, @currentPageType, '<b>Informations concernant le paiement.</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'fr', 16, @currentPageType, 'L''activation a échoué', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'fr', 17, @currentPageType, 'L''authentification sur votre téléphone portable et donc l''activation de paiement, ont échoué. Le processus de paiement a été interrompu et votre carte n''a pas été débitée. Si vous souhaitez continuer le processus d''achat, veuillez recommencer la tentative de paiement.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'fr', 32, @currentPageType, 'Paiement non effectué - Problème technique', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'fr', 33, @currentPageType, 'En raison d’un problème technique, le paiement n’a pas pu être effectué et votre carte n’a pas été débitée. Si vous souhaitez poursuivre l’achat, nous vous prions de bien vouloir essayer à nouveau.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'fr', 41, @currentPageType, 'Aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'fr', 174, @currentPageType, 'Fermer l''aide', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'fr', 175, @currentPageType, 'Retour vers la boutique en ligne', @MaestroMID, NULL, @customItemSetMobileApp);



/*ITALIAN translations for MOBILE_APP*/
SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'it', 1, 'ALL', @BankUB, @MaestroMID, im.id, @customItemSetMobileApp
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankUB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'it', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetMobileApp
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

   /*MOBILE_APP_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Autorizzare il pagamento nell’app</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Per poter completare il pagamento, è necessario autorizzarlo nell’app fornita sua banca.  Dovrebbe aver già ricevuto una notifica sul suo cellulare.  In caso contrario può accedere direttamente all''app e verificare il pagamento lì.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'it', 3, @currentPageType, 'Al posto di questo, richiedere l’autorizzazione tramite SMS', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'it', 12,@currentPageType, 'L’autorizzazione di pagamento viene controllata', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'it', 13,@currentPageType, 'Abbia un attimo di pazienza. Stiamo verificando la sua autorizzazione di pagamento e quindi l’autenticazione per il pagamento desiderato.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'it', 14,@currentPageType, 'Autorizzazione di pagamento annullata', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'it', 15,@currentPageType, 'Il pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare comunque il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'it', 26,@currentPageType, 'L’autorizzazione di pagamento è andata a buon fine', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'it', 27,@currentPageType, 'Ha autorizzato correttamente il pagamento e viene automaticamente inoltrato al commerciante.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'it', 30,@currentPageType, 'Indietro al negozio online Pagamento non effettuato - Sessione scaduta', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'it', 31,@currentPageType, 'È passato troppo tempo per autorizzare il pagamento. Il processo di pagamento è stato quindi annullato per motivi di sicurezza. Ritorni al negozio online e inizi di nuovo il processo di pagamento se desidera effettuare il pagamento.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32,@currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33,@currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'it', 40, @currentPageType, 'Interrompere il pagamento', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
         'it', 100, 'ALL', 'Commerciante', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
         'it', 101, 'ALL', 'Importo', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
         'it', 102, 'ALL', 'Data', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
         'it', 103, 'ALL', 'Numero della carta', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
         'it', 104, 'ALL', 'Numero di telefono', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetMobileApp);



/* Elements for the HELP page, for MOBILE APP Profile */

SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'it', 1, @currentPageType, '<b>Aiuto</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'it', 2, @currentPageType, 'Al fine di aumentare la sicurezza per i pagamenti online, la sua banca ha introdotto una procedura di autenticazione in due fasi. Può autorizzare i pagamenti online sul suo cellulare nell’app di autenticazione fornita dalla sua banca. In caso di domande o chiarimenti, la preghiamo di contattare la sua banca.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetMobileApp);


/* Elements for the FAILURE page, for MOBILE APP Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
         'it', 11, @currentPageType, '<b>Informazioni sul pagamento</b>', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'it', 16, @currentPageType, 'Autenticazione fallita', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'it', 17, @currentPageType, 'L’autenticazione sul suo cellulare e quindi l’autorizzazione del pagamento non sono riuscite. Il processo di pagamento è stato annullato e la sua carta non è stata addebitata. Se desidera continuare il processo di acquisto, provi a iniziare di nuovo il pagamento.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'it', 32, @currentPageType, 'Pagamento non effettuato - Problema tecnico', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'it', 33, @currentPageType, 'Non è stato possibile eseguire il pagamento a causa di un errore tecnico e la sua carta non è stata addebitata. Se desidera continuare l’acquisto, la preghiamo di riprovare nuovamente.', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'it', 41, @currentPageType, 'Aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
         'it', 174, @currentPageType, 'Chiudere l’aiuto', @MaestroMID, NULL, @customItemSetMobileApp),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
         'it', 175, @currentPageType, 'Indietro al negozio online', @MaestroMID, NULL, @customItemSetMobileApp);



/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
