USE U7G_ACS_BO;
SET @BankUB = 'SQB';

SET @ruleConditionId = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_NORMAL'));
/*!40000 ALTER TABLE `Thresholds` DISABLE KEYS */;
INSERT INTO `Thresholds` (`isAmountThreshold`, `reversed`, `thresholdType`, `value`, `fk_id_condition`) VALUES
(FALSE, FALSE, 'UNDER_TRIAL_NUMBER_THRESHOLD', 3, @ruleConditionId);
/*!40000 ALTER TABLE `Thresholds` ENABLE KEYS */;