
USE `U5G_ACS_BO`;

UPDATE `SubIssuer` SET `hubCallMode` = 'VE_AND_PA_MODE' where `id` in (36,40,41);

DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition`=193 AND `id_transactionStatuses`=29;
DELETE FROM `RuleCondition` WHERE `id`=193;
