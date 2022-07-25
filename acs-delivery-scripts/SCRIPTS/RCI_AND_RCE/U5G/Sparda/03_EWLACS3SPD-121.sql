USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @BankB = 'Spardabank';

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Means Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#switch-means-mobile_app_ext-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-otp_sms_ext_message-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-chip_tan-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
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
	.text-center {
		text-align: center;
	}
	.text-right,.text-left {
		text-align: unset;
	}
	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
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
	#i18n-container {
		width: 100%;
		clear: both;
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
	}
	#networkLogo {
		max-height: 65px;
	}
	.paragraph {
		text-align: center;
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
	.meansSelect {
		display:inline-table;
		flex-direction:row;
	}
	.meansSelectLabel {
		flex:1 1 50%;
		text-align:center;
	}
	.meansSelectValue {
		flex:1 1 50%;
		text-align:left;
		padding-left:5px;
		padding-top: 5px;
		display:flex;
	}
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 6px;
		padding-bottom: 12px;
		display:block;
		text-align:center;
		justify-content:center;
	}
	@media all and (max-width: 1610px) {
		.paragraph{ text-align: center; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.paragraph{ text-align: center;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		div#optGblPage { font-size : 14px; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		div#green-banner { height: 0px !important; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 700px) and (min-width: 600px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		.paragraph { font-size : 14px; text-align: center;}
		#pageHeader {height: 85px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		div#displayLayout { display: none; }
		.text-center { text-align: left;}
		#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 5px;}
		#optGblPage #selection-group switch-means-button:nth-child(2) button { margin-right: 5px;}
		#switch-means-otp_sms_ext_message-img {width: 50px; height: 50px;}
		#switch-means-chip_tan-img {width: 50px; height: 50px;}
		#switch-means-mobile_app_ext-img {width: 50px; height: 50px;}
	}
	@media all and (max-width: 600px) and (min-width: 500px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		#issuerLogo {max-height: 45px; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		div#displayLayout { display: none; }
		div#selection-group { margin: 0px;}
		.text-center { text-align: left;}
		.meansSelectLabel { flex: 1 0 50%;}
		.meansSelectValue { flex:1 1 57%;}
		#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 5px;}
		#optGblPage #selection-group switch-means-button:nth-child(2) button { margin-right: 5px;}
		#switch-means-otp_sms_ext_message-img {width: 50px; height: 50px;}
		#switch-means-chip_tan-img {width: 50px; height: 50px;}
		#switch-means-mobile_app_ext-img {width: 50px; height: 50px;}
	}
	@media all and (max-width: 500px) and (min-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		#issuerLogo {max-height: 45px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
		#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 5px;}
		#optGblPage #selection-group switch-means-button:nth-child(2) button { margin-right: 5px;}
		#switch-means-otp_sms_ext_message-img {width: 50px; height: 50px;}
		#switch-means-chip_tan-img {width: 50px; height: 50px;}
		#switch-means-mobile_app_ext-img {width: 50px; height: 50px;}

	}
	@media all and (max-width: 480px)  {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 40px; }
		#networkLogo {max-height: 40px; }
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
		#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 5px;}
		#optGblPage #selection-group switch-means-button:nth-child(2) button { margin-right: 5px;}
		#switch-means-otp_sms_ext_message-img {width: 50px; height: 50px;}
		#switch-means-chip_tan-img {width: 50px; height: 50px;}
		#switch-means-mobile_app_ext-img {width: 50px; height: 50px;}
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		div#displayLayout { display: none; }
		div#selection-group {margin: -1px;}
		.meansSelectLabel { flex: 1 0 50%;}
		.meansSelectValue { flex:1 0 55%;}
		#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 5px;}
		#optGblPage #selection-group switch-means-button:nth-child(2) button { margin-right: 5px;}
		#switch-means-otp_sms_ext_message-img {width: 28px; height: 28px;}
		#switch-means-chip_tan-img {width: 34px; height: 28px;}
		#switch-means-mobile_app_ext-img {width: 30px; height: 30px;}
		.btn { margin-bottom: 3px;}
		div#footer { height: 45px; }
	}
	@media all and (max-width: 347px) {
		#issuerLogo {max-height: 22px; }
	}
	@media all and (max-width: 251px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 10px; }
		#pageHeader {height: 60px;}
		#issuerLogoDiv {padding-left: 6px !important;}
		#networkLogoDiv {padding-right: 6px !important;}
		#issuerLogo {max-height: 22px; max-width: 100px;}
		#networkLogo {max-width: 100px;}
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 3%;}
		.paragraph { font-size : 10px; text-align: center;}
		.btn {padding: 6px 4px;}
		.meansSelectValue { flex:1 0 50%;  padding-left: 0%;}
		#switchMeansButtonId span.custom-text.ng-binding { font-size: 10px;}
		#optGblPage #selection-group switch-means-button:nth-child(1) button {width: 65px;}
		#optGblPage #selection-group switch-means-button:nth-child(2) button {width: 65px;}
		button#switchMeansButtonId-mobile_app_ext {width: 65px;}
		#switch-means-otp_sms_ext_message-img {margin-left: 7px;}
		#switch-means-chip_tan-img {margin-left: 6px;}
		#switch-means-mobile_app_ext-img {margin-left: 8px;}
		div#footer { height: 50px; }
		#helpButton button { margin-left: auto; }
		.side-menu .text-left, .side-menu .text-right { padding-left: 0px;}
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
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
		<div class="meansSelect">
			<div class = "meansSelectLabel">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div class = "meansSelectValue">
				<div id="meanchoice">
					<means-select means-choices="meansChoices"></means-select>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;







