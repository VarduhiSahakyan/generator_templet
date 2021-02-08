USE `U5G_ACS_BO`;


SET @updateState = 'PUSHED_TO_CONFIG';

SET @authentMean ='_REFUSAL_';

SET @pageTypes = 'REFUSAL_PAGE';
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_COZ_1_REFUSAL');

SET @ordinalMessage = 201;
SET @ordinalRefusalMessage = 23;


DELETE FROM `CustomItem` WHERE  ordinal = @ordinalMessage AND fk_id_customItemSet = @customItemSetRefusal;

UPDATE `CustomItem` SET `value`='Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.' WHERE  fk_id_customItemSet IN (@customItemSetRefusal) AND `ordinal` = @ordinalRefusalMessage;


SET @customPageLayoutRefusal = (SELECT id FROM `CustomPageLayout` WHERE `description` = 'Refusal Page (Commerzbank AG)');

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#footer #cancelButton button span:before {
		content:'';
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
	#i18n-container {
		width:100%;
		clear:both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear:both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color:#FFFFFF!important;
		border-radius: 5px !important;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 82px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 96px;
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
		width: 20%;
		float: right;
		text-align: right;
	}
	.leftColumn {
		width:65%;
		display:block;
		float:left;
		padding:1em;
	}
	.rightColumn {
		width: 84%;
		margin-top: 15%;
		display: block;
		text-align: left;
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
		text-align: start;
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
		display:flex;
		padding-left:9%;
		text-align:left;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px; }
		#networkLogo { max-height : 62px;  max-width:100%; padding-top: 25px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top:20%; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
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
			<side-menu menu-title="''Zahlungsdetails''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer"></div>
</div>' WHERE `fk_id_layout` = @customPageLayoutRefusal;