USE U7G_ACS_BO;

SET @BankUB = 'UBS';
SET @createdBy = 'A758582';

SET @customItemSetMissingRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';

SET @locale = 'de';
SET @text = 'Karte gesperrt';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Bitte loggen Sie sich ins UBS E-Banking oder Mobile Banking ein, um online Einkaufen aus- und wieder einzuschalten.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;

SET @locale = 'en';
SET @text = 'Card blocked';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Please log in to UBS E-Banking or Mobile Banking to deactivate and reactivate online purchasing.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @locale = 'fr';
SET @text = 'Carte bloquée';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Connectez-vous sur l’UBS E-Banking ou le Mobile Banking pour désactiver et réactiver le paiement en ligne.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @locale = 'it';
SET @text = 'Carta bloccata';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Effettui il login nell''E-Banking o nel Mobile Banking per disattivare e riattivare gli acquisti online.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;