USE `H0G_RBA`;

# ------------------------------------------------------------------ 19450 ------------------------------------------

SET @comerzCobrandsId = (SELECT `id` FROM `RULE_SET` WHERE `issuer` = 19450 AND  NOT (transaction_type <=> 'PROT_2X_3DS')) ;
SET @comerzCobrandsMaxLowId = (SELECT `id` FROM `RULE` WHERE `rule_set_id` = @comerzCobrandsId  AND `name` = 'TRN_MAX_LOW_VALUE');
SET @comerzCobrandsSumLowId = (SELECT `id` FROM `RULE` WHERE `rule_set_id` = @comerzCobrandsId  AND `name` = 'TRN_SUM_LOW_VALUE');

SET @comerzCobrandsRuleConditionId_AMOUNT_MAX = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzCobrandsMaxLowId AND `name` = 'C0_FRICTIONLESS_AMOUNT_MAX');
SET @comerzCobrandsRuleConditionId_AMOUNT_SUM = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzCobrandsSumLowId AND `name` = 'C0_FRICTIONLESS_AMOUNT_SUM');

INSERT INTO RULE_CONDITION (rule_id, name  ,created_time, updated_time, deleted_time) VALUE  (@comerzCobrandsMaxLowId, 'C0_SCORE_LOW' , NOW(), NULL, NULL );
INSERT INTO RULE_CONDITION (rule_id, name  ,created_time, updated_time, deleted_time) VALUE  (@comerzCobrandsSumLowId, 'C0_SCORE_LOW' , NOW(), NULL, NULL );

SET @comerzCobrandsRuleConditionId_SCORE_LOW = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzCobrandsMaxLowId AND `name` = 'C0_SCORE_LOW');
SET @comerzCobrandsRuleConditionId_SCORE_SUM_LOW = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzCobrandsSumLowId AND `name` = 'C0_SCORE_LOW');

UPDATE `OPERAND` SET `condition_id` = @comerzCobrandsRuleConditionId_SCORE_LOW WHERE `condition_id` = @comerzCobrandsRuleConditionId_AMOUNT_MAX AND `name` = 'THRESHOLD_SCORE';

UPDATE `OPERAND` SET `condition_id` = @comerzCobrandsRuleConditionId_SCORE_SUM_LOW WHERE `condition_id` = @comerzCobrandsRuleConditionId_AMOUNT_SUM AND `name` = 'THRESHOLD_SCORE';

# ------------------------------------------------------------------ 19440 ------------------------------------------

SET @comerzAgId = (SELECT `id` FROM `RULE_SET` WHERE `issuer` = 19440 AND  NOT (transaction_type <=> 'PROT_2X_3DS')) ;
SET @comerzAgMaxLowId = (SELECT `id` FROM `RULE` WHERE `rule_set_id` = @comerzAgId  AND `name` = 'TRN_MAX_LOW_VALUE');
SET @comerzAgSumLowId = (SELECT `id` FROM `RULE` WHERE `rule_set_id` = @comerzAgId  AND `name` = 'TRN_SUM_LOW_VALUE');

SET @comerzAgRuleConditionId_AMOUNT_MAX = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzAgMaxLowId AND `name` = 'C0_FRICTIONLESS_AMOUNT_MAX');
SET @comerzAgRuleConditionId_AMOUNT_SUM = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzAgSumLowId AND `name` = 'C0_FRICTIONLESS_AMOUNT_SUM');

INSERT INTO RULE_CONDITION (rule_id, name  ,created_time, updated_time, deleted_time) VALUE  (@comerzAgMaxLowId, 'C0_SCORE_LOW' , NOW(), NULL, NULL );
INSERT INTO RULE_CONDITION (rule_id, name  ,created_time, updated_time, deleted_time) VALUE  (@comerzAgSumLowId, 'C0_SCORE_LOW' , NOW(), NULL, NULL );

SET @comerzAgRuleConditionId_SCORE_LOW = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzAgMaxLowId AND `name` = 'C0_SCORE_LOW');
SET @comerzAgRuleConditionId_SCORE_SUM_LOW = (SELECT `id` FROM `RULE_CONDITION` WHERE `rule_id` = @comerzAgSumLowId AND `name` = 'C0_SCORE_LOW');

UPDATE `OPERAND` SET `condition_id` = @comerzAgRuleConditionId_SCORE_LOW WHERE `condition_id` = @comerzAgRuleConditionId_AMOUNT_MAX AND `name` = 'THRESHOLD_SCORE';

UPDATE `OPERAND` SET `condition_id` = @comerzAgRuleConditionId_SCORE_SUM_LOW WHERE `condition_id` = @comerzAgRuleConditionId_AMOUNT_SUM AND `name` = 'THRESHOLD_SCORE';

