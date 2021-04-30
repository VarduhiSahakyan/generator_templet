
USE `U5G_ACS_BO`;

UPDATE `SubIssuer` SET `hubCallMode` = 'PA_ONLY_MODE' where `id` in (36,40,41);

DELETE FROM `RuleCondition` WHERE `id`=193;
INSERT INTO `RuleCondition` (`id`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_rule`) 
VALUES (193, 'A169318', '2018-06-07 14:20:49', NULL, NULL, NULL, 'C5_P_00070_01_FRAUD', 'PUSHED_TO_CONFIG', 145);

DELETE FROM `Condition_TransactionStatuses` WHERE `id_condition`=193 AND `id_transactionStatuses`=29;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`) VALUES (193, 29);