USE `U5G_ACS_BO`;

SET @createdBy ='A758582';
SET @BankB ='COMDIRECT';
SET @updateState = 'PUSHED_TO_CONFIG';

SET @profileFraud = (SELECT id FROM `Profile` WHERE name = '16600_COMDIRECT_FRAUD_REFUSAL');

SET @ruleFraud = (SELECT id FROM `Rule` WHERE fk_id_profile = @profileFraud);

/* RuleCondition */
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C3_',@BankB,'_REFUSAL_FRAUD'), @updateState, @ruleFraud),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C4_',@BankB,'_REFUSAL_FRAUD'), @updateState, @ruleFraud),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C5_',@BankB,'_REFUSAL_FRAUD'), @updateState, @ruleFraud);

/* Condition_TransactionStatuses */
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C3_',@BankB,'_REFUSAL_FRAUD') AND (ts.`transactionStatusType`='CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C4_',@BankB,'_REFUSAL_FRAUD') AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C5_',@BankB,'_REFUSAL_FRAUD') AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

