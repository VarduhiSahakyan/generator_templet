USE `U5G_ACS_BO`;

SET @id_transactionStatuses = (SELECT id FROM TransactionStatuses WHERE transactionStatusType='MERCHANT_URL_IN_NEGATIVE_LIST' AND reversed=FALSE);
SET @id_condition = (SELECT id FROM RuleCondition WHERE name = 'C5_P_16500_01_FRAUD');

UPDATE Condition_TransactionStatuses SET id_transactionStatuses = @id_transactionStatuses WHERE id_condition = @id_condition;