USE U5G_ACS_BO;

SET @BankUB = 'LBBW';
SET @BankB = 'Landesbank Baden-Württemberg';

SET @activatedAuthMeans = '[ {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
} ]';

SET @availableAuthMeans = 'OTP_SMS|REFUSAL|MOBILE_APP|INFO';

SET @issuerCode = '19550';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);

update Issuer set availaibleAuthentMeans = @availableAuthMeans where id = @issuerId;

SET @subIssuerCode = '19550';
SET @subIssuerNameAndLabel = 'Landesbank Baden-Württemberg';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

update SubIssuer set authentMeans = @activatedAuthMeans where id = @subIssuerID;

SET @customPageLayoutPassword = (select id from CustomPageLayout where description = 'Password OTP Form Page for Landesbank Baden-Württemberg');

delete from CustomPageLayout_ProfileSet where customPageLayout_id = @customPageLayoutPassword;

delete from CustomComponent where  fk_id_layout = @customPageLayoutPassword;

delete from CustomPageLayout where id = @customPageLayoutPassword;

SET @ruleConditionPWD_OTP = (SELECT id FROM RuleCondition where name = 'C1_P_LBBW_01_PWD_OTP_UNIFIED');
SET @ruleConditionPassword = (SELECT id FROM RuleCondition where name = 'C1_P_LBBW_01_PASSWORD_UNIFIED');

delete from Condition_TransactionStatuses where id_condition = @ruleConditionPWD_OTP or id_condition = @ruleConditionPassword;
delete from Condition_MeansProcessStatuses where id_condition = @ruleConditionPWD_OTP or id_condition = @ruleConditionPassword;

SET @authentMeansPWD_OTP = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PWD_OTP');
SET @authentMeansPassword = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PASSWORD');
SET @authentMeansOTP_SMS = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                            WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                              AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                              AND (mps.`meansProcessStatusType` IN ('HUB_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE))
    and id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                    WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                      AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                                      AND (mps.`meansProcessStatusType` IN ('HUB_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                            WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                              AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                              AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                    WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                      AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                                      AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                            WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                              AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                              AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                        WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                          AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                                          AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                            WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                              AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                              AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                         WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                           AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                                           AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                          WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                            AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
                            AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                      WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                        AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
                                        AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                          WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                            AND mps.`fk_id_authentMean`= @authentMeansPassword
                            AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                  WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                    AND mps.`fk_id_authentMean`= @authentMeansPassword
                                    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                      WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                        AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                        AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                  WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                    AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                                    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                      WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                        AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
                        AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                  WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                    AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
                                    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                      WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                        AND mps.`fk_id_authentMean`= @authentMeansPassword
                        AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                  WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                    AND mps.`fk_id_authentMean`= @authentMeansPassword
                                    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE));

delete from Condition_MeansProcessStatuses
    where id_condition = (SELECT c.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                      WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                        AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                        AND (mps.`meansProcessStatusType` IN ('PARENT_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE))
    and  id_meansProcessStatuses = (SELECT mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
                                  WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_UNIFIED'
                                    AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
                                    AND (mps.`meansProcessStatusType` IN ('PARENT_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE));


delete from Thresholds where fk_id_condition = @ruleConditionPWD_OTP;

delete from RuleCondition where id = @ruleConditionPWD_OTP or id = @ruleConditionPassword;

SET @profilePasswordOTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PWD_OTP'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_UNIFIED_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_UNIFIED_01'));

SET @rulePassword = (SELECT id FROM Rule WHERE fk_id_profile = @profilePassword);
SET @rulePasswordOTP = (SELECT id FROM Rule WHERE fk_id_profile = @profilePasswordOTP);
SET @ruleSMS = (SELECT id FROM Rule WHERE fk_id_profile = @profileSMS);

update RuleCondition set name = 'C1_P_LBBW_01_OTP_SMS_NORMAL' where fk_id_rule = @ruleSMS;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_NORMAL'
  AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
  AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= 'C1_P_LBBW_01_OTP_SMS_NORMAL'
  AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

delete from ProfileSet_Rule where id_rule in (@rulePassword, @rulePasswordOTP);

delete from Rule where id in (@rulePassword, @rulePasswordOTP);
UPDATE Rule SET description = 'OTP_SMS_AVAILABLE_NORMAL',  name = 'OTP_SMS (NORMAL)' WHERE fk_id_profile = @profileSMS;

delete from Profile where name = 'LBBW_PWD_OTP' or name = 'LBBW_PASSWORD_UNIFIED_01';
update Profile set name = 'LBBW_SMS_01' where id = @profileSMS;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD_UNIFIED'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_OTP_SMS_UNIFIED'));

delete from CustomItem where fk_id_customItemSet = @customItemSetPassword;

delete from CustomItemSet where id = @customItemSetPassword;
update CustomItemSet set name = CONCAT('customitemset_', @BankUB, '_OTP_SMS') where id = @customItemSetSMS;
