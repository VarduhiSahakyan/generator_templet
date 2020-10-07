USE U5G_ACS_BO;

SET @locale = 'en';
SET @username = 'A758582';
SET @customItemSetId_Normal = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_OPENID_NORMAL_01');
SET @customItemSetId_Choice = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_20000_OPENID_CHOICE_01');
SET @pageType_custom = 'CUSTOM_PAGE';
SET @pageType_callback = 'CALLBACK_PAGE';

SET @ordinal = 1;
SET @text = 'Confirm Payment';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` IN (@pageType_custom, @pageType_callback)
					AND `fk_id_customItemSet` IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @ordinal = 2;
SET @text = 'In case of problems, call OP customer service at 0100 0500 (local network charge/mobile charge).';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` = @pageType_custom
					AND `fk_id_customItemSet` IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @locale = 'fi';
SET @ordinal = 1;
SET @text = 'Vahvista maksu';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` IN (@pageType_custom, @pageType_callback)
					AND `fk_id_customItemSet` IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @ordinal = 2;
SET @text = 'Ongelmatilanteissa ota yhteyttä OP:n asiakaspalveluun p. 0100 0500 (pvm/mpm).';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes`  = @pageType_custom
					AND `fk_id_customItemSet` IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @locale = 'se';
SET @ordinal = 1;
SET @text = 'Bekräfta betalning';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes` IN (@pageType_custom, @pageType_callback)
					AND `fk_id_customItemSet` IN (@customItemSetId_Normal,@customItemSetId_Choice);

SET @ordinal = 2;
SET @text = 'Vid problem kontakta vid behov OP kundtjänsten 0100 0500 (lna/msa).';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND `ordinal` = @ordinal
					AND `pageTypes`  = @pageType_custom
					AND `fk_id_customItemSet` IN (@customItemSetId_Normal,@customItemSetId_Choice);