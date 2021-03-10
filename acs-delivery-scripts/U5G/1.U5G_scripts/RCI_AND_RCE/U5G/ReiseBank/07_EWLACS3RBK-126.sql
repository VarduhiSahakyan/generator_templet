USE U5G_ACS_BO;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @subIssuerCode = '12000';

SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_MOBILE_APP'));
SET @ordinal = 15;
SET @pageTypes = 'POLLING_PAGE';
SET @locale = 'de';
SET @value = 'Der Bezahlvorgang wurde aus Sicherheitsgründen abgebrochen. Ihre Karte wird nicht belastet. Sie werden nun automatisch zur Händler-Webseite weitergeleitet.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetMOBILEAPP
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;

SET @locale = 'en';
SET @value = 'The payment process was cancelled for security reasons. Your card will not be charged. You will be automatically redirected to the merchant website.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetMOBILEAPP
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;