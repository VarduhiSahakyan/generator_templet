USE `U5G_ACS_BO`;

SET @currentPageType = 'HELP_PAGE';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_EWB_SMS');


UPDATE CustomItem SET VALUE = 'EastWest has chosen the solution Visa Secure, the security program of Visa, designed to enhance the security of your internet purchases. Intended for Visa cardholders, it protects against possible fraudulent use of your credit card in online shops that display the Visa Secure logo.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 1 and DTYPE='T';

UPDATE CustomItem SET VALUE = 'Your purchases on a Visa Secure site will from now on be validated by entering a one-time password that will be sent to the cardholder via SMS to the mobile number on record.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 2 and DTYPE='T';




SET @username = 'W100851';
SET @customItemSetREFUSAL = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_EWB_1_REFUSAL');
SET @pageType_HELP_PAGE = 'HELP_PAGE';
SET @textName = 'VISA_REFUSAL_HELP_PAGE_1' ;

SET @text = 'EastWest has chosen the solution VISA Secure, the security program of Visa, designed to enhance the security of your internet purchases. Intended for Visa cardholders, it protects against possible fraudulent use of your credit card in online shops that display the VISA Secure logo.';
UPDATE `CustomItem` SET `value` = @text
					WHERE `name` = @textName
					AND `fk_id_network` = 1
					AND `pageTypes` = @pageType_HELP_PAGE
					AND `fk_id_customItemSet` = @customItemSetREFUSAL;


SET @username = 'W100851';
SET @customItemSetREFUSAL = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_EWB_1_REFUSAL');
SET @pageType_HELP_PAGE = 'HELP_PAGE';
SET @textName = 'VISA_REFUSAL_HELP_PAGE_2' ;

SET @text = 'Your purchases on a Visa Secure site will from now on be validated by entering a one-time password that will be sent to the cardholder via SMS to the mobile number on record.';
UPDATE `CustomItem` SET `value` = @text
					WHERE `name` = @textName
					AND `fk_id_network` = 1
					AND `pageTypes` = @pageType_HELP_PAGE
					AND `fk_id_customItemSet` = @customItemSetREFUSAL;


SET @username = 'W100851';
SET @customItemSetEWB_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_EWB_SMS');
SET @pageType_HELP_PAGE = 'HELP_PAGE';
SET @textName = 'VISA_OTP_SMS_HELP_PAGE_1' ;
SET @text = 'EastWest has chosen the solution VISA Secure, the security program of Visa, designed to enhance the security of your internet purchases. Intended for Visa cardholders, it protects against possible fraudulent use of your credit card in online shops that display the VISA Secure logo.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `name` = @textName
					AND `fk_id_network` = 1
					AND `pageTypes` = @pageType_HELP_PAGE
					AND `fk_id_customItemSet` = @customItemSetEWB_SMS;
