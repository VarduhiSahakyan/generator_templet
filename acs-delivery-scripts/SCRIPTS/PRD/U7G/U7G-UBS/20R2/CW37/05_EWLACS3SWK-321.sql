USE U7G_ACS_BO;
SET @BankB = 'UBS';
SET @BankUB = 'UBS';
SET @subIssuerCode = '23000';
SET @subIssuerNameAndLabel = 'UBS Switzerland AG';
SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';



SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
UPDATE `Profile` SET `description` = 'REFUSAL (FRAUD)',
                     `name`= CONCAT(@BankUB,'_REFUSAL_FRAUD')
                WHERE `fk_id_customItemSetCurrent` = @customItemSetRefusal
                  AND `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL');

UPDATE CustomItemSet SET `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD') ,
                         `description` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD_Current')
                        WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL');



/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;



SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `dataEntryFormat`, `dataEntryAllowedPattern`,`fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);


SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));

UPDATE `Rule` SET `fk_id_profile` = @profileRefusal WHERE `description` = 'REFUSAL_DEFAULT'
                                                           AND `name` = 'REFUSAL (DEFAULT)'
                                                           AND fk_id_profile = @profileRefusalFraud;


/********* Refusal Missing Profile *********/
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_REFUSAL_FRAUD'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetREFUSAL FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetRefusalFraud;

SET @currentPageType = 'REFUSAL_PAGE';
set @text = 'Keine Verbindung zur UBS Access App';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
                                        AND pageTypes = @currentPageType
                                        AND locale = 'de'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;

set @text = 'No connection to UBS Access App';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
                                        AND pageTypes = @currentPageType
                                        AND locale = 'en'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;

set @text = 'La connexion avec l\'app UBS Access est impossible';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
                                        AND pageTypes = @currentPageType
                                        AND locale = 'fr'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;

set @text = 'Non fosse possibile stabilire alcun collegamento con l\'app UBS Access';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
                                        AND pageTypes = @currentPageType
                                        AND locale = 'it'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;


set @text = 'Keine Verbindung zur UBS Access App möglich und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
                                        AND pageTypes = @currentPageType
                                        AND locale = 'de'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;

set @text = 'As we did not reach your UBS Access App and your purchase could not be made. Please try again later.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
                                        AND pageTypes = @currentPageType
                                        AND locale = 'en'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;

set @text = 'La connexion avec l\'app UBS Access est impossible et votre achat n’a pas pu être finalisé. Veuillez réessayer.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
                                        AND pageTypes = @currentPageType
                                        AND locale = 'fr'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;

set @text = 'Il collegamento con l’app UBS Access non è possibile e il suo acquisto non può essere concluso. La preghiamo di riprovare più tardi.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
                                        AND pageTypes = @currentPageType
                                        AND locale = 'it'
                                        AND `fk_id_customItemSet` = @customItemSetREFUSAL;