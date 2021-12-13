USE H0G_RBA;

SET @createdBy = 'A758582';

SET @issuerCode = '16600';
SET @location = 'EEA';

SET @ruleSetId = (SELECT id FROM RULE_SET WHERE issuer = @issuerCode AND location = @location);
SET @ruleId_max = (SELECT id FROM RULE WHERE rule_set_id = @ruleSetId AND name = 'TRN_MAX_LOW_VALUE');
SET @ruleId_sum = (SELECT id FROM RULE WHERE rule_set_id = @ruleSetId AND name = 'TRN_SUM_LOW_VALUE');
SET @conditionId_max1 = (SELECT id FROM RULE_CONDITION WHERE rule_id = @ruleId_max AND name = 'C0_FRICTIONLESS_AMOUNT_MAX');
SET @conditionId_max2 = (SELECT id FROM RULE_CONDITION WHERE rule_id = @ruleId_max AND name = 'C0_SCORE_LOW');
SET @conditionId_sum1 = (SELECT id FROM RULE_CONDITION WHERE rule_id = @ruleId_sum AND name = 'C0_FRICTIONLESS_AMOUNT_SUM');
SET @conditionId_sum2 = (SELECT id FROM RULE_CONDITION WHERE rule_id = @ruleId_sum AND name = 'C0_SCORE_LOW');


UPDATE OPERAND SET condition_id = @conditionId_max1 WHERE condition_id = @conditionId_max2;
UPDATE OPERAND SET condition_id = @conditionId_sum1 WHERE condition_id = @conditionId_sum2;


DELETE FROM RULE_CONDITION WHERE rule_id = @ruleId_max AND name = 'C0_SCORE_LOW';
DELETE FROM RULE_CONDITION WHERE rule_id = @ruleId_sum AND name = 'C0_SCORE_LOW';