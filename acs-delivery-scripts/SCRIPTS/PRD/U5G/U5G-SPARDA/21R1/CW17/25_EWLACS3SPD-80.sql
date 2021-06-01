
USE `U5G_ACS_BO`;

SET @ruleId = (SELECT group_concat(id) FROM `RuleCondition` WHERE fk_id_rule IS NULL);

DELETE FROM Condition_MeansProcessStatuses where find_in_set(id_condition, @ruleId);

DELETE FROM Condition_TransactionStatuses where find_in_set(id_condition, @ruleId);

DELETE FROM RuleCondition WHERE find_in_set(id, @ruleId); 

SET @CoBaIn  = (Select `id` from `RuleCondition` where `name` = 'C1_P_COZ_01_PASSWORD_NORMAL');

SET @CoBaCo  = (Select `id` from `RuleCondition` where `name` = 'C1_P_COB_01_PASSWORD_NORMAL');

SET @PostbankIn  = (Select `id` from `RuleCondition` where `name` = 'C1_P_18501_PB_01_LOGIN_NORMAL');

SET @Sparda  = (Select `id` from `RuleCondition` where `name` = 'C1_P_SPB_sharedBIN_01_PASSWORD_NORMAL');

SET @LBBW  = (Select `id` from `RuleCondition` where `name` = 'C1_P_LBBW_01_PWD_OTP_UNIFIED');

DELETE FROM `Thresholds` where `fk_id_condition` in (@CoBaIn,@CoBaCo,@PostbankIn,@Sparda,@LBBW);

ALTER TABLE `Thresholds` AUTO_INCREMENT=2;