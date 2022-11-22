USE `U5G_ACS_BO`;

SET @createdBy ='A758582';
SET @BankB ='COMDIRECT';
SET @updateState = 'PUSHED_TO_CONFIG';

SET @profileFraud = (SELECT id FROM `Profile` WHERE name = '16600_COMDIRECT_FRAUD_REFUSAL');

SET @ruleFraud = (SELECT id FROM `Rule` WHERE fk_id_profile = @profileFraud);

/* Condition_TransactionStatuses */
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C3_',@BankB,'_REFUSAL_FRAUD'));
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C4_',@BankB,'_REFUSAL_FRAUD'));
DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition` = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C5_',@BankB,'_REFUSAL_FRAUD'));


/* RuleCondition */
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @ruleFraud AND `name` = CONCAT('C3_',@BankB,'_REFUSAL_FRAUD');
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @ruleFraud AND `name` = CONCAT('C4_',@BankB,'_REFUSAL_FRAUD');
DELETE FROM `RuleCondition` WHERE `fk_id_rule` = @ruleFraud AND `name` = CONCAT('C5_',@BankB,'_REFUSAL_FRAUD');

