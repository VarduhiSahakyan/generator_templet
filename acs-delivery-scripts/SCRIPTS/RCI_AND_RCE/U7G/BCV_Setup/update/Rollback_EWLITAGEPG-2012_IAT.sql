USE `U7G_ACS_BO`;

SET @createdBy ='A758582';
SET @issuerCode = '76700';
SET @subIssuerCode = '76700';

SET @bank = 'BCV';
SET @helpPagePageType = 'HELP_PAGE';
SET @customItemSetRefusalMissingAuth = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_MISSING_AUTHENTICATION_REFUSAL'));

DELETE FROM CustomItem WHERE `FK_ID_CUSTOMITEMSET` = @customItemSetRefusalMissingAuth
                        AND `pageTypes` = @helpPagePageType;