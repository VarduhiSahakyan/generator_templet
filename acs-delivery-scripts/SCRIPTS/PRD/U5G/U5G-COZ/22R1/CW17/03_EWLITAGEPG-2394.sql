USE U5G_ACS_BO;

SET @pageType = 'REFUSAL_PAGE';
SET @subissuerId = (SELECT id from SubIssuer WHERE code = 19440);
SET @defaultRefusalID = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_COZ_MISSING_AUTHENT_REFUSAL' and fk_id_subIssuer = @subissuerId);


SET @textValue = 'Bitte aktivieren Sie Ihre Kreditkarte im Commerzbank Online Banking unter „Karte verwalten“ oder rufen Sie uns unter der Nr. 069 / 5 8000 8000 an.';

UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @defaultRefusalID AND pageTypes = @pageType AND ordinal = 201;


SET @polingPageLayoutDesc = 'INFO Refusal Page (Commerzbank AG)';
SET @polingFormPageType = 'INFO_REFUSAL_PAGE';

SET @polingFormPage = (SELECT id
                       FROM `CustomPageLayout`
                       WHERE `pageType` = @polingFormPageType
                         AND DESCRIPTION = @polingPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '

<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
		overflow:auto;
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	div#message-container.info {
		background-color:#DB1818 !important;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
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
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		height: 100%;
		display: inline-flex;
		float: left;
	}
	#pageHeaderRight {
		width: 50%;
		height: 100%;
		display: inline-flex;
	}
	div#networkLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: right;
		align-self: center;
		padding-right: 16px;
	}
	div#issuerLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: left;
		align-self: center;
		padding-left: 16px;
	}
	#issuerLogo {
		max-height: 65px;
		max-width: 100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width: 100%;
	}
	.leftColumn {
		width:65%;
		display:block;
		float:left;
		padding:1em;
	}
	.rightColumn {
		width: 100%;
		margin-top: 10%;
		display: block;
		text-align: center;
		padding: 10px 62px 10px;
		border: 1px solid;
		background-color: #EAEAEA;
		border-color: #C1C1C1;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		padding-top:1em;
		clear:both;
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
	div#displayLayout {
		display: none;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align: center; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align: center; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align: center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align: center; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 105px; text-align: center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
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
		.paragraph { font-size : 12px; text-align: center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 90px; text-align: center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; text-align: center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; text-align: center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<div id="issuerLogoDiv">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>

	<alternative-display attribute="''externalWSResponse''" value="''UNKNOWN_USER''"
		enabled="''unknownUser''"
		disabled="''defaultContent''"
		default-fallback="''defaultContent''">
   </alternative-display>

	<alternative-display attribute="''externalWSResponse''" value="''BLOCKED_USER''"
		enabled="''unknownUser''"
		disabled="''defaultContent''"
		default-fallback="''defaultContent''">
   </alternative-display>

	<alternative-display attribute="''externalWSResponse''" value="''TECHNICAL_ERROR''"
		enabled="''technicalError''"
		disabled="''defaultContent''"
		default-fallback="''defaultContent''">
   </alternative-display>

   <!-- Display - REFUSAL_CAUSE : UNKNOWN_USER -->

   <div class="unknownUser" style="display: none;">
	<message-banner display-type="''1''"
		heading-attr="''network_means_pageType_22''"
		message-attr="''network_means_pageType_201''"
		close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"
		show=true >
	</message-banner>
   </div>

   <div class="technicalError" style="display: none;">
	<message-banner display-type="''1''"
		heading-attr="''network_means_pageType_32''"
		message-attr="''network_means_pageType_33''"
		close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"
		show=true >
	</message-banner>
   </div>

   <div class="defaultContent" style="display: none;">
	<message-banner display-type="''1''"
		heading-attr="''network_means_pageType_22''"
		message-attr="''network_means_pageType_23''"
		close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"
		show=true >
	</message-banner>
   </div>

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
			<side-menu menu-title="''<b>Zahlungsdetails</b>''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer"></div>
</div>' WHERE fk_id_layout = @polingFormPage;

