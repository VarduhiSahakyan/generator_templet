USE `H0G_RBA`;

SET @ruleSetId = (SELECT `id` FROM `RULE_SET` WHERE `issuer` = 18500 AND `location` = 'EEA');
SET @ruleId = (SELECT `id` FROM `RULE` WHERE `rule_set_id` = @ruleSetId AND `name` = 'TRN_MAX_LOW_VALUE');

SET @ruleConditionId_AMOUNT_MAX = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @ruleId AND `name` = 'C0_FRICTIONLESS_AMOUNT_MAX');
SET @ruleConditionId_SCORE_LOW = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @ruleId AND `name` = 'C0_SCORE_LOW');

UPDATE `OPERAND` SET `condition_id` = @ruleConditionId_SCORE_LOW WHERE `condition_id` = @ruleConditionId_AMOUNT_MAX AND
                                                                        `name` = 'THRESHOLD_SCORE';