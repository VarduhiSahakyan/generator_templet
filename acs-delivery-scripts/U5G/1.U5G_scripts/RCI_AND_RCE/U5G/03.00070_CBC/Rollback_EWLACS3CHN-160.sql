USE `U5G_ACS_BO`;

SET @createdBy = 'A758582';
SET @issuerCode = '00070';

SET @profileSMS = (SELECT fk_id_customItemSetCurrent FROM `Profile` WHERE `name` = '00070_SMS_01');
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE id = @profileSMS);
SET @pageType = 'REFUSAL_PAGE';


DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetSMS
						 AND `pageTypes` = @pageType
						 AND `ordinal` IN (22, 23);