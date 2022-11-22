USE U5G_ACS_BO;


SET @pageType = 'EXT_PASSWORD_OTP_FORM_PAGE';
SET @pageLayoutIdSMS = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'Password OTP Form Page (Commerzbank AG)' AND `pageType` = @pageType);

UPDATE `CustomComponent`
SET `value` = '

<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
		overflow:auto;
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderCenter {
		width: 30%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 30%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width: 100%;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: center;
		font-family: Arial,bold;
		color: #333333;
		font-size:18px;
	}
	.leftColumn {
		width:38%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:60%;
		margin-left:38%;
		display:block;
		text-align:center;
		padding:20px 10px 20px;
		padding-left: 1em;
		border: 1px solid;
		background-color: #EAEAEA;
		border-color: #C1C1C1;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
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
	#otp-form {
		display:inline-block;
		padding-top:0px;
		padding-bottom: 10px;
	}
	#otp-form input {
		box-sizing:content-box;
		padding: 0px 0px 0px;
		background-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
		font-family: Arial,bold;
		color: #333333;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 25px;
		width: 220px;
	}
	#otp-form input:disabled {
		color: #bebebe!important;
		background-color: #dcdcdc!important;
		border-color: rgba(0,0,0,.05)!important;
		box-shadow: none!important;
	}
	#otp-form input:focus {
		border-color:#FF6A10 !important;
		outline-color: #FF6A10;
	}
	div#otp-fields-container {
		width:70%;
		text-align:center;
		margin-top:10px;
		margin-bottom:10px;
	}
	div#otp-fields {
		display:inline-flex;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	.validateButton{
		text-align: center;
	}
	#validateButton button {
		font-family: Arial;
		font-style: normal;
		color: #333333;
		border-color: #FFCC33;
		background-color: #FFCC33;
	}
	#validateButton button:active {
		font-family: Arial;
		font-style: normal;
		color: #333333;
		border-color: #FFCC33;
		background-color: #FFCC33;
	}
	#validateButton button:disabled {
		font-family: Arial;
		font-style: normal;
		color: #FFFFFF;
		border-color: #858585;
		background-color: #858585;
	}
	#validateButton button:hover {
		font-family: Arial;
		font-style: normal;
		color: #000000;
		border-color: #FFCC33;
		background: #FFCC33;
	}
	#validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:60%;
		margin-left:38%;
		background-color: #FFFFFF;
	}
	#footer .cancel-link {
		float: left;
		margin-left: 20px;
		background-color: #FFFFFF;
		border-style: solid;
		border-width: 1px;
		border-color:transparent;
		padding: 2px;
	}
	#cancelButton button {
		background-color: #FFFFFF;
		border-style: none;
		outline:none;
		padding:0px;
	}
	#cancelButton button span{
		font-family: Arial;
		font-style: normal;
		color: #333333;
		border-color: #333333;
		background-color: #FFFFFF;
	}
	#cancelButton button:disabled {
		font-family: Arial;
		font-style: normal;
		color: #858585;
		border-color: #FFFFFF;
		background-color: #FFFFFF;
	}
	#footer .cancel-link:hover {
		border-style: solid;
		border-width: 1px;
		border-radius: 5px;
		color: #000000;
		border-color: #000000;
		background: #FFFFFF;
		padding: 2px;
	}
	#cancelButton .fa-ban {
		display: none;
	}
	#footer .help-link {
		float: right;
		margin-right: 20px;
		background-color: #FFFFFF;
		border-style: solid;
		border-width: 1px;
		border-color:transparent;
		padding: 2px;
	}
	#helpButton button {
		background-color: #FFFFFF;
		border-style: none;
		outline:none;
		padding:0px;
	}
	#helpButton	 button span{
		font-family: Arial;
		font-style: normal;
		color: #333333;
		border-color: #333333;
		background-color: #FFFFFF;
	}
	#footer .help-link:hover {
		border-style: solid;
		border-width: 1px;
		border-radius: 5px;
		color: #000000;
		border-color: #000000;
		background: #FFFFFF;
		padding: 2px;
	}
	#helpButton .fa-info {
		display:none;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -45px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { margin-left:0px; margin-top: 110px; display:block; float:none; width:100%; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 130px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; width:100%;margin-left:0%;}
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		#pageHeader {height: 60px;}
		#footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; text-align:center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div#otp-fields {display:inherit;}
		#footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; text-align:center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div#otp-fields {display:inherit;}
		#footer { width:100%; margin-left:0%;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
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
			<side-menu menu-title="''network_means_pageType_2''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div x-ms-format-detection="none" id="otp-fields">
				<pwd-form></pwd-form>
			</div>
			<div ng-style="style" class="style validateButton">
				<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
			</div>
		</div>
	</div>
	<div id="footer">
		<div class="cancel-link">
				<span class="fa fa-angle-left"></span>
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		</div>
		<div class="help-link">
				<help help-label="''network_means_HELP_PAGE_1''" id="helpButton" class="helpButtonClass"></help>
				<span class="fa fa-angle-right"></span>
		</div>
	</div>
</div>' where fk_id_layout = @pageLayoutIdSMS;