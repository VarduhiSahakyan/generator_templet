USE `U5G_ACS_BO`;
SET @createdBy = 'A758582';

SET @BankUB = 'BNP_WM';
SET @issuerCode = '16900';
SET @subIssuerCode = '16901';


SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuer = (SELECT `id` from SubIssuer where `fk_id_issuer` = @issuerId and `code` = @subIssuerCode);

SET @profileAccept = (SELECT id FROM `Profile` WHERE `fk_id_subIssuer` = @subIssuer AND `name` = CONCAT(@BankUB, '_ACCEPT_01'));
SET @ruleAcceptMaint = (SELECT id FROM `Rule` WHERE `description` = 'ACCEPT_MAINTANCE_NORMAL' AND `fk_id_profile` = @profileAccept);
SET @ruleCondition = (SELECT id FROM `RuleCondition` WHERE `name` = 'C1_P_BNP_WM_01_ACCEPT' AND `fk_id_rule` = @ruleAcceptMaint);

DELETE FROM `TransactionValue` WHERE `fk_id_condition` = @ruleCondition;