USE `U5G_ACS_BO`;

SET @idSubIssuer = (SELECT s.`id` FROM `SubIssuer` s where s.`code`="20000");

DELETE FROM TransactionValue WHERE reversed=1 AND transactionValueType='DEVICE_CHANNEL' AND value="02" AND fk_id_condition IN (SELECT rc.id FROM RuleCondition rc WHERE rc.fk_id_rule IN (SELECT r.id FROM Rule r WHERE r.fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND r.name NOT IN ("REFUSAL_FRAUD", "DEFAULT_REFUSAL", "OPENID_NORMAL")));

UPDATE Rule SET orderRule = '2' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "OTP_SMS_CHOICE";
UPDATE Rule SET orderRule = '3' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "MOBILE_APP_CHOICE";
UPDATE Rule SET orderRule = '4' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "TUPAS_CHOICE";
UPDATE Rule SET orderRule = '5' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "OPENID_CHOICE";
UPDATE Rule SET orderRule = '6' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "UNDEFINED_NORMAL";
UPDATE Rule SET orderRule = '7' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "UNDEFINED_NORMAL_05";
UPDATE Rule SET orderRule = '8' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "UNDEFINED_NORMAL_04";
UPDATE Rule SET orderRule = '9' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "UNDEFINED_NORMAL_02";
UPDATE Rule SET orderRule = '10' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "UNDEFINED_NORMAL_03";
UPDATE Rule SET orderRule = '11' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "MOBILE_APP_NORMAL";
UPDATE Rule SET orderRule = '12' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "OPENID_NORMAL";
UPDATE Rule SET orderRule = '13' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "TUPAS_NORMAL";
UPDATE Rule SET orderRule = '14' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "OTP_SMS_FALLBACK";
UPDATE Rule SET orderRule = '15' WHERE fk_id_profile IN (SELECT p.`id` FROM `Profile` p where p.`fk_id_subIssuer`=@idSubIssuer) AND name = "DEFAULT_REFUSAL";
