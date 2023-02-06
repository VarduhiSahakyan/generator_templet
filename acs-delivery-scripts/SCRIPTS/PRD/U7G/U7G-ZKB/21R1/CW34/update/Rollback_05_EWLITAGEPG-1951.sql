USE `U7G_ACS_BO`;

SET @ZKBBankUB = 'ZKB';

SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @ZKBBankUB, '_SMS_EXT'));
SET @pageType = 'APP_VIEW';


SET @textValue = 'Activation de paiement par SMS';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 151 AND pageTypes = @pageType AND locale = 'en' AND fk_id_customItemSet = @customItemSetId;


SET @textValue = 'Nous vous avons envoyé un code d''activation pour la confirmation du paiement. Si c''est bien vous qui avez ordonné le paiement, confirmez-le en saisissant ce code. \n\n Par l''activation, vous payez au commerçant @merchantName le montant de @amount le @formattedDate.';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 152 AND pageTypes = @pageType AND locale = 'en' AND fk_id_customItemSet = @customItemSetId;

SET @textValue = 'Veuillez contacter Zürcher Kantonalbank pour plus de support.';

UPDATE CustomItem SET value = @textValue WHERE ordinal = 157 AND pageTypes = @pageType AND locale = 'en' AND fk_id_customItemSet = @customItemSetId;
