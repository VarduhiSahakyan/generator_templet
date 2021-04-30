USE U5G_ACS_BO;

SET @locale = 'en';
SET @username = 'A758582';
SET @customItemSetId_Normal = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_OPENID_NORMAL_01');
SET @customItemSetId_Choice = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_OPENID_CHOICE_01');
SET @pageType_custom = 'CUSTOM_PAGE';
SET @pageType_callback = 'CALLBACK_PAGE';

SET @ordinal = 1;
SET @text = 'Authenticate with key code list';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` IN (@pageType_custom, @pageType_callback)
					AND `fk_id_customItemSet`  IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @ordinal = 2;
SET @text = 'Continue to authentication. After successful authentication, you can return to the webshop from the service.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` = @pageType_custom
					AND `fk_id_customItemSet`  IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @locale = 'fi';
SET @ordinal = 1;
SET @text = 'Tunnistaudu avainlukulistalla';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` IN (@pageType_custom, @pageType_callback)
					AND `fk_id_customItemSet`  IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @ordinal = 2;
SET @text = 'Jatka tunnistautumiseen. Onnistuneen tunnistautumisen jälkeen pääset palvelun kautta takaisin verkkokauppaan.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` = @pageType_custom
					AND `fk_id_customItemSet`  IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @locale = 'se';
SET @ordinal = 1;
SET @text = 'Identifiera dig med nyckeltalslista';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` IN (@pageType_custom, @pageType_callback)
					AND `fk_id_customItemSet`  IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @ordinal = 2;
SET @text = 'Fortsätt till identifiering. När identifieringen har lyckats kommer du via tjänsten tillbaka till nätbutiken.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` = @pageType_custom
					AND `fk_id_customItemSet`  IN (@customItemSetId_Normal,@customItemSetId_Choice);