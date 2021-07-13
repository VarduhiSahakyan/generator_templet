USE `U7G_ACS_BO`;

SET @ZKBBankUB = 'ZKB';

SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @ZKBBankUB, '_SMS_EXT'));
SET @pageType = 'APP_VIEW';


SET @textValue = 'Payment approval via SMS';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 151 AND pageTypes = @pageType AND locale = 'en' AND fk_id_customItemSet = @customItemSetId;


SET @textValue = 'We have sent you an approval code for confirmation of the payment. If the payment has been made by you, please confirm this by entering this code. \n\n With the approval you pay the merchant @merchantName the amount of @amount on @formattedDate.';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 152 AND pageTypes = @pageType AND locale = 'en' AND fk_id_customItemSet = @customItemSetId;

SET @textValue = 'Please contact Zürcher Kantonalbank for additional support.';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 157 AND pageTypes = @pageType AND locale = 'en' AND fk_id_customItemSet = @customItemSetId;
