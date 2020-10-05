USE `U5G_ACS_BO`;

SET @currentPageType = 'HELP_PAGE';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_EWB_SMS');


UPDATE CustomItem SET VALUE = 'EastWest has chosen the solution VISA Secure, the security program of Visa, designed to enhance the security of your internet purchases. Intended for Visa cardholders, it protects against possible fraudulent use of your credit card in online shops that display the Verified by Visa logo.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 1 and DTYPE='T';

UPDATE CustomItem SET VALUE = 'Your purchases on a VISA Secure site will from now on be validated by entering a one-time password that will be sent to the cardholder via SMS to the mobile number on record.' WHERE pageTypes = @currentPageType AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 2 and DTYPE='T';