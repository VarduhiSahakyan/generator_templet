USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @BankB = 'Spardabank';

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Chiptan OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	div#displayLayout {
		background-color: #008991;
		display: none;
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
	#valButton button.btn.disabled {
		opacity:1;
	}
	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
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
		flex: 1 1 35%;
	}
	#otpForm {
		flex: 1 1 42.5%;
		text-align:left;
		padding-left: 5px;
	}
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 6px;
		padding-bottom:12px;
		display:block;
		text-align:center;
	}
	@media all and (max-width: 1610px) {
		 #tanLabel { flex: 1 1 32%; }
		.paragraph{ text-align: center; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.paragraph{ text-align: center;}
		#tanLabel { flex: 1 1 26%; }
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		div#optGblPage { font-size : 14px; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		 #tanLabel { flex: 1 1 23%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px;}
		#otp-form input { width:100%;}
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
		#tanLabel { flex: 1 1 14%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 600px) and (min-width: 500px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		#issuerLogo {max-height: 45px; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		 #tanLabel { flex: 1 1 10%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 500px) and (min-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		#issuerLogo {max-height: 45px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		#tanLabel { flex: 1 1 3%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
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
		#tanLabel { flex: 1 1 1%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		div#displayLayout { display: none; }
		div#chiptanContainer {margin-left: 30px; }
		#tanLabel { flex: 1 1 0%; }
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
		div#chiptanContainer {margin-left: 0px; }
		#tanLabel { flex: 0.5 1 0%; }
		#otp-form { width: 165px; }
		#otp-form input { width:100%; }
		div#footer { height: 45px; display: block;}
		button span.fa { padding-right: 0px;}
		#helpButton button { margin-left: auto; }
		#valButton button { display: inline;}
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
			manual-link-label1="''network_means_pageType_6''"
			manual-link-label2="''network_means_pageType_7''"
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
	<div id="footer">
		<div ng-style="style" class="style">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	#valButton button.btn.disabled {
		opacity:0.65;
	}
	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}
	#valButton button.btn[disabled] {
		opacity:1;
	}
	#valButton button div {
		display:inline;
	}
	#valButton button {
		display: inline-block;
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
	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
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
	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
		margin-top: 0px;
		padding-left: 3px;
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
	#phNumber {
		margin-left: 7px;
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
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > label:nth-child(1) > custom-text:nth-child(1) > span:nth-child(1) {
		display:none;
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(2) {
		display:none;
	}
	#sideLayout {
		margin-left: 677px;
		margin-top: -30px;
	}
	@media all and (max-width: 1610px) {
		.paragraph{ text-align: center; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.paragraph{ text-align: center;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px; }
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		div#optGblPage { font-size : 14px; }
		.paragraph { font-size : 14px; text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px;}
		#otp-form input { width:100%;}
		div#green-banner { height: 0px !important; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 700px) and (min-width: 600px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		.paragraph { font-size : 14px; text-align: center;}
		#pageHeader { height: 85px; }
		#issuerLogo { max-height: 50px; }
		#networkLogo { max-height: 50px; }
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 480px)  {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		#pageHeader { height: 70px; }
		#issuerLogo { max-height: 40px; }
		#networkLogo { max-height: 40px; }
		.bottomColumn { display:block; float:none; width:100%; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		 #otp-form { width: 150px;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		div#displayLayout { display: none; }
	}
	 @media all and (max-width: 300px) {
		#issuerLogo { max-height: 28px;}
		#otp-form { width: 132px;}
	}
	@media all and (max-width: 251px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 10px; }
		#pageHeader { height: 60px; }
		#issuerLogoDiv {padding-left: 6px !important;}
		#networkLogoDiv {padding-right: 6px !important;}
		#issuerLogo {max-height: 22px; max-width: 100px;}
		#networkLogo {max-width: 100px;}
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 3%;}
		.paragraph { font-size : 10px; text-align: center;}
		#otp-form input { width:100%; }
		#otp-form { width: 115px;}
		.tooltips span { width: 110px;}
		div#footer { height: 45px; display: block;}
		button span.fa { padding-right: 0px;}
		#helpButton button { margin-left: auto; }
		#valButton button { display: inline; }
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
	<div id="displayLayout" class="row">
		<div id="grey-banner"></div>
	</div>
	<message-banner  close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
		<div class="tanContainer">
			<div id = "tanLabel">
				<div>
					<custom-text custom-text-key="''network_means_pageType_104''"></custom-text>
				</div>
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div id = "otpForm" >
				<div id = "phNumber">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<otp-form></otp-form>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 6px;
		padding-bottom: 12px;
		display:block;
		text-align: center;
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
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		div#displayLayout { display: none; }
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

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_4''" id="paragraph4"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
	</div>
	<div id="footer"> </div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	div#displayLayout {
		display: none;
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
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 6px;
		padding-bottom: 12px;
		display:block;
		text-align: center;
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
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		div#displayLayout { display: none; }
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
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
	</div>
	<div id="footer"></div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 8px;
		padding-bottom: 6px;
		display:block;
		text-align:center;
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
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		div#displayLayout { display: none; }
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
	<message-banner  close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<means-choice-menu></means-choice-menu>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="additionalMenuContainer">
			<div id = "additionalMenuLabel">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div id = "additionalMenuValue" >
				<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		</div>
	</div>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Choice Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	#valButton button.btn.disabled {
		opacity:1;
	}
	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
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
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 6px;
		padding-bottom: 12px;
		display:block;
		text-align:center;
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
		#otp-form{ display:block; width:200px; margin-left: 7px;}
		#otp-form input { width:100%;}
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 35px; }
		div#displayLayout { display: none; }
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
		#otp-form input { width:100%; }
		div#footer { height: 45px; display: block;}
		button span.fa { padding-right: 0px;}
		#helpButton button { margin-left: auto; }
		#valButton button { display: inline;}
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

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
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
		<div class="deviceSelect">
			<device-select devices="deviceSelectValues" select-box-style-enabled="true"></device-select>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Password OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	#valButton button.btn.disabled {
		opacity:0.65;
	}
	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}
	#valButton button.btn[disabled] {
		opacity:1;
	}
	#valButton button div {
		display:inline;
	}
	#valButton button {
		display: inline-block;
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
	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
		margin-top: 0px;
		padding-left: 3px;
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
	#phNumber {
		margin-left: 7px;
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
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > label:nth-child(1) > custom-text:nth-child(1) > span:nth-child(1) {
		display:none;
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(2) {
		display:none;
	}
	#sideLayout {
		margin-left: 677px;
		margin-top: -30px;
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
		#otp-form{ display:block; width:200px; margin-left: 7px;}
		#otp-form input { width:100%;}
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
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
		#otp-form{ display:block; width:200px; margin-left: 7px; }
		#otp-form input { width:100%;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		side-menu div.text-center { padding-bottom: 2%;}
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		#otp-form { width: 160px;}
		div#displayLayout { display: none; }
	}
	@media all and (max-width: 300px) {
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 35px; }
		#otp-form { width: 132px;}
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
		#otp-form { width: 115px;}
		#otp-form input { width:100%; }
		div#footer { height: 45px; display: block;}
		button span.fa { padding-right: 0px;}
		#helpButton button { margin-left: auto; }
		#valButton button { display: inline; }
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
	<div id="displayLayout" class="row">
		<div id="grey-banner"></div>
	</div>
	<message-banner  close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
		<div class="tanContainer">
			<div id = "tanLabel">
				<div>
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
			</div>
			<div id = "otpForm" >
				<div id = "phNumber">
					<custom-text custom-text-key="''network_means_pageType_5''"></custom-text>
				</div>
				<pwd-form></pwd-form>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

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
		.meansSelectValue { flex:1 0 50%;  padding-left: 15%;}
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
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '
<div id="messageBanner">
	<span id="info-icon" class="fa fa-info-circle"></span>
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>
	<style>
		span#info-icon {
			position:absolute;
			top:15px;
			left:15px;
			float:none;
		}
		@media all and (max-width: 480px) {
			span#info-icon {
				position: absolute;
				font-size: 3em;
				top: 1px;
				left: 5px;
				display: inline-block;
			}
			.spinner {
				padding-top:10px;
				padding-bottom:10px;
			}
			#headingTxt { font-size:14px; }
			#message { font-size:12px; }
			span#headingTxt { font-size:14px; }
			span#message { font-size:12px; }
		}
		@media all and (max-width: 347px) {
			span#info-icon { font-size: 2em; }
			span#headingTxt { font-size:14px; }
			span#message { font-size:12px; }
		}
		@media all and (max-width: 309px) {
			span#headingTxt { font-size:12px; }
			span#message { font-size:10px; }
		}
		@media all and (max-width: 251px) {
			span#headingTxt { font-size:10px; }
			span#message { font-size:8px; }
		}
		.spinner {
			position: relative;
			display:block;
			padding-top:15px;
			padding-bottom:15px;
		}
		div#message-container.info {
			background-color:#002395;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.success {
			background-color:#04BD07;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.error {
			background-color:#DB1818;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.warn {
			background-color:#E0700A;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		#headingTxt {
			font-family: Arial,bold;
			color: #FFFFFF;
			font-size:14px;
			width : 70%;
			margin : auto;
			display : block;
			text-align:center;
			padding:4px 1px 1px 1px;
		}
		#message {
			font-family: Arial,bold;
			color: #FFFFFF; font-size:14px;
			text-align:center;
		}
		span#message {
			font-size:14px;
		}
		#message-container {
			position:relative;
		}
		#optGblPage message-banner div#message-container {
			width:100% ;
			box-shadow: none ;
			-webkit-box-shadow:none;
			position: relative;
		}
		div.message-button {
			padding-top: 0px;
		}
		div#message-content {
			text-align: center;
			background-color: inherit;
			padding-bottom: 5px;
		}
	</style>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
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
	#helpCloseButton {
		flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;
	}
	#helpCloseButton button {
		display: inline-flex;
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
	#helpCloseButton button:hover {
		background-color: #FFA500
	}
	#helpCloseButton button:active {
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
		text-align: left;
		margin-top: -2px;
		margin-bottom: 5px;
	}
	.topColumn {
		padding:0.5em;
	}
	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}
	#footer {
		height: 45px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top: 3px;
		padding-bottom: 6px;
		display: inline-table;
		text-align: center;
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
	}
	@media all and (max-width: 700px) and (min-width: 600px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		.paragraph { font-size : 14px; text-align: center;}
		#pageHeader {height: 85px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
	}
	@media all and (max-width: 600px) and (min-width: 500px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		#issuerLogo {max-height: 45px; }
		.paragraph { font-size : 14px; text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		#issuerLogo {max-height: 45px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
	}
	@media all and (max-width: 480px)  {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		.paragraph { font-size : 14px; text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 40px; }
		#networkLogo {max-height: 40px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		.paragraph { font-size : 12px; text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
	}
	@media all and (max-width: 251px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 10px; }
		#pageHeader {height: 60px;}
		#issuerLogoDiv {padding-left: 6px !important;}
		#networkLogoDiv {padding-right: 6px !important;}
		#issuerLogo {max-height: 22px; max-width: 80px;}
		#networkLogo {max-width: 80px;}
		.paragraph { font-size : 10px; text-align: center;}
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

		<div class="contentRow">
			 <div class="topColumn">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_HELP_PAGE_1''" id="paragraph1"></custom-text>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph2"></custom-text>
				</div>
			   <div class="paragraph">
					<custom-text custom-text-key="''network_means_HELP_PAGE_3''" id="paragraph3"></custom-text>
				</div>
			</div>
		</div>
		<div id="footer">
			<div ng-style="style" class="style">
				<help-close-button id="helpCloseButton" help-close-label="''network_means_HELP_PAGE_174''" ></help-close-button>
			</div>
		</div>
	</div>' WHERE `fk_id_layout` = @id_layout;





