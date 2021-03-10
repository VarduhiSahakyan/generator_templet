USE U5G_ACS_BO;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @subIssuerCode = '12000';

SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_MOBILE_APP'));
SET @ordinal = 15;
SET @pageTypes = 'POLLING_PAGE';
SET @locale = 'de';
SET @value = 'Zur Sicherheit wurde der Bezahlvorgang auf der Webseite mit diesem Logo Mastercard ID Check abgebrochen und Ihre Karte nicht belastet. Sie werden nun automatisch zum Haendler weitergeleitet.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetMOBILEAPP
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;

SET @locale = 'en';
SET @value = 'For security reasons, your purchase is canceled on the website displaying this logo Mastercard ID Check and your card was not debited. You will be automatically redirected to the merchant website.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetMOBILEAPP
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;