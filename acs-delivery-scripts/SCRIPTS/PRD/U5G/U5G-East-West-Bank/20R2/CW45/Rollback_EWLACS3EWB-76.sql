
USE `U5G_ACS_BO`;

SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_EWB_SMS');

UPDATE `CustomItem` SET VALUE = 'An OTP will be sent to the mobile number of the principal cardholder to validate the EWB transaction. If you are a supplementary holder, please call EWB at +6328881700 to enable receipt of your OTP. Subject to security PID.' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 157 and pageTypes = 'APP_VIEW' and DTYPE ='T';