USE U7G_ACS_BO;

SET @BankUB = 'UBS';
SET @createdBy = 'A758582';

SET @customItemSetMissingRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';

SET @locale = 'de';
SET @text = 'Online Einkaufen ist für diese Karte nicht aktiviert';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Bitte loggen Sie sich ins UBS E-Banking oder Mobile Banking ein, um online Einkaufen einzuschalten.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;

SET @locale = 'en';
SET @text = 'Online shopping has not been activated for this card';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Please log in to UBS E-Banking or Mobile Banking to activate online purchases.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @locale = 'fr';
SET @text = 'L’achat en ligne avec cette carte n''est pas activé.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Connectez-vous sur l’UBS E-Banking ou le Mobile Banking pour activer le paiement en ligne.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @locale = 'it';
SET @text = 'I pagamenti online con questa carta non sono attivi';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 22
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;
SET @text = 'Effettui il login nell''E-Banking o nel Mobile Banking per attivare gli acquisti online.';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 23
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetMissingRefusal;