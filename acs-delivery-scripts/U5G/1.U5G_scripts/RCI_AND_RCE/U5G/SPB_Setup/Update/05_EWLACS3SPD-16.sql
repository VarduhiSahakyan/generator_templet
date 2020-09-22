USE `U5G_ACS_BO`;

SET @subIssuerCode = 16950;
SET @subIssuerId = (SELECT id FROM SubIssuer WHERE code = @subIssuerCode);

SET @customItemSetChipTan_name = 'customitemset_SPB_sharedBIN_CHIP_TAN';
SET @customItemSetChipTan_id = (SELECT id FROM CustomItemSet where fk_id_subIssuer = @subIssuerId AND name = @customItemSetChipTan_name);

SET @customItemSetChipTanChoice_name = 'customitemset_SPB_sharedBIN_CHIP_TAN_CHOICE';
SET @customItemSetChipTanChoice_id = (SELECT id FROM CustomItemSet where fk_id_subIssuer = @subIssuerId AND name = @customItemSetChipTanChoice_name);


INSERT INTO CustomItem
(`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES ('T', 'A709391', NOW(), NULL, NULL, NULL, 'VISA_CHIP_TAN_OTP_FORM_PAGE_9', 'PUSHED_TO_CONFIG', 'de', '9', 'OTP_FORM_PAGE', '<ol><li>Drücken Sie die Taste "TAN", Sodass im Display "Start-Code" erscheint.</li><li>Geben Sie den Start-Code 267160 ein.</li><li>Drücken Siedie Taste "OK".</li><li>Geben Sie den geforderten Daten in den TAN-Generator ein und bestatigen Sie di ese mit "OK".</li></ol>', NULL, NULL, NULL, NULL, NULL, NULL, @customItemSetChipTan_id);

INSERT INTO CustomItem
(`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `backgroundColor`, `borderStyle`, `textColor`, `fk_id_network`, `fk_id_image`, `fk_id_font`, `fk_id_customItemSet`)
VALUES ('T', 'A709391', NOW(), NULL, NULL, NULL, 'VISA_CHIP_TAN_OTP_FORM_PAGE_9', 'PUSHED_TO_CONFIG', 'de', '9', 'OTP_FORM_PAGE', '<ol><li>Drücken Sie die Taste "TAN", Sodass im Display "Start-Code" erscheint.</li><li>Geben Sie den Start-Code 267160 ein.</li><li>Drücken Siedie Taste "OK".</li><li>Geben Sie den geforderten Daten in den TAN-Generator ein und bestatigen Sie di ese mit "OK".</li></ol>', NULL, NULL, NULL, NULL, NULL, NULL, @customItemSetChipTanChoice_id);



SET @bankName = 'Spardabank';
SET @pageDescription = CONCAT('Chiptan OTP Form Page (', @bankName ,')');
SET @pageType = 'CHIP_TAN_OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType and `description` = @pageDescription);

UPDATE `CustomComponent` SET `value` = '

<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		padding-left: 52.5em;
		padding-right: 0.5em;
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {

	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		flex: 1 1 50%;
		padding-left:0.5em;
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {

		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	#optGblPage > div.contentRow > div.bottomColumn > side-menu > div > div.menu-elements > div:nth-child(5) {
	  display:none;
	}
	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:flex;
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

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
	  <div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="display-challenge">
			<chiptan speed-label="''network_means_pageType_4''"
					 zoom-label="''network_means_pageType_5''"
					 manual-link-label="''network_means_pageType_7''"
					 manual-text="''network_means_pageType_6''"
					 manual-description="''network_means_pageType_9''">
			</chiptan>
		</div>
		<div class="tanContainer">
				<div id = "tanLabel">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<div id = "otpForm" >
					<otp-form></otp-form>
				</div>
		</div>
	</div>
	<div  id="footerDiv">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button cn-label="''network_means_pageType_42''" id="validateButton" ></val-button>
	</div>
</div>'  WHERE `fk_id_layout` = @layoutId;