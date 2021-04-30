USE U5G_ACS_BO;

SET @createdBy ='A709391';
SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

/* Elements for the profile DEFAULT_REFUSAL : */
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_1_REFUSAL');

SET @ordinal = 23;
update CustomItem set value = 'Bitte registrieren Sie Ihre Kreditkarte für das sichere Einkaufen auf der folgenden Internetseite: <b>www.commerzbank.de/sicher-einkaufen > Jetzt registrieren</b>'
where fk_id_customItemSet = @customItemSetREFUSAL and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 1;
SET @itemNameVisa = 'VISA_REFUSAL_REFUSAL_PAGE_1';
SET @itemNameMaster = 'MASTERCARD_REFUSAL_REFUSAL_PAGE_1';
update CustomItem set value = '<b>Infos zum sicheren Einkaufen im Internet finden Sie ebenfalls unter www.commerzbank.de/sicher-einkaufen</b>'
where fk_id_customItemSet = @customItemSetREFUSAL and ordinal = @ordinal and name in (@itemNameVisa, @itemNameMaster);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetREFUSAL);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetREFUSAL);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetREFUSAL);

/* Elements for the profile PASSWORD : */

SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean = 'PASSWORD';
SET @customItemSetPASSWORD = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_PASSWORD');

SET @ordinal = 1;
update CustomItem set value = '<b>Bitte geben Sie zunächst Ihr 3-D Secure Passwort ein.</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 2;
update CustomItem set value = '<b>Details</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 13;
update CustomItem set value = 'Bitte warten Sie einige Sekunden. Ihre Eingabe wird geprüft. '
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = '<b>Authentifizierung erfolgreich -</b>'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet. Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 42;
update CustomItem set value = 'Weiter'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetPASSWORD  and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetPASSWORD);

/* Elements for the FAILURE page, for Password Profile */

SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 17;
update CustomItem set value = 'Der Auftrag konnte nicht ausgeführt werden. Bitte versuchen Sie es später erneut. '
where fk_id_customItemSet = @customItemSetPASSWORD and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPASSWORD);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihre Zahlung konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetPASSWORD);


/* Elements for the profile SMS : */

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COB_SMS');

SET @currentAuthentMean = 'OTP_SMS';
SET @currentPageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
update CustomItem set value = '<b>Zur Freigabe bitte die mobileTAN eingeben, die Sie per SMS erhalten haben.</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 2;
update CustomItem set value = '<b>Bitte bestätigen Sie folgenden Auftrag</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 26;
update CustomItem set value = '<b>Authentifizierung erfolgreich -</b>'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 27;
update CustomItem set value = 'Sie werden automatisch zum Händler weitergeleitet. Bitte lassen Sie das Browserfenster geöffnet!'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetSMS);

SET @ordinal = 28;
update CustomItem set value = 'Ungültige Eingabe'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 29;
update CustomItem set value = 'Sie haben  ein ungültiges 3-D Secure Passwort  oder eine ungültige mobileTAN eingegeben. Bitte versuchen Sie es erneut. Anzahl verbleibender Versuche: @trialsLeft'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', @MaestroVID, NULL, @customItemSetSMS);

SET @ordinal = 31;
update CustomItem set value = 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Transaktion abgebrochen. Starten Sie den Vorgang erneut, wenn Sie die Transaktion durchführen möchten.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

SET @ordinal = 33;
update CustomItem set value = 'Ein technischer Fehler ist aufgetreten, Ihr Auftrag konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.'
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

/* Elements for the FAILURE page, for SMS Profile */

SET @currentPageType = 'FAILURE_PAGE';

SET @ordinal = 17;
update CustomItem set value = 'Der Auftrag konnte nicht ausgeführt werden. Bitte versuchen Sie es später erneut. '
where fk_id_customItemSet = @customItemSetSMS and pageTypes = @currentPageType and ordinal = @ordinal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihre Zahlung konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Händler', @MaestroVID, NULL, @customItemSetSMS);


set @customPageLayoutDesc = 'Failure Page (Commerzbank Cobrands)';
set @pageType = 'FAILURE_PAGE';

set @idPage = (select id
                      from `CustomPageLayout`
                      where `pageType` = @pageType
                        and DESCRIPTION = @customPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
		overflow:auto;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		clear:both;
		width:100%;
		background-color:#FFFFFF;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 64px;
		max-width:100%;
		padding-right: 16px;
		padding-bottom: 10px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.leftColumn {
		width:65%;
		display:block;
		float:left;
		padding:1em;
	}
	.rightColumn {
		width:60%;
		margin-left:30%;
		display:block;
		text-align:left;
		padding:20px 10px;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
		padding-top:1em;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		display:block;
		text-align:center;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:60px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''<b>Details</b>''"></side-menu>
		</div>
		<div class="rightColumn"> </div>
	</div>
	<div id="footer"> </div>
</div>'
WHERE `fk_id_layout` = @idPage;