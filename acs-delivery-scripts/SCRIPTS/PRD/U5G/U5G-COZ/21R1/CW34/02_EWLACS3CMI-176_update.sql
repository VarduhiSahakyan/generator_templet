USE U5G_ACS_BO;

#COZ
SET @pageLayoutIdPassword = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'EXT_PASSWORD_OTP_FORM_PAGE' AND DESCRIPTION = 'Password OTP Form Page (Commerzbank AG)');

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
</div>' where fk_id_layout = @pageLayoutIdPassword;

SET @pageLayoutIdPhotoTan = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'PHOTO_TAN_OTP_FORM_PAGE' AND DESCRIPTION = 'PhotoTAN OTP Form Page (Commerzbank AG)');

UPDATE `CustomComponent`
SET `value` = '<style>

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
	.externalImage {
		margin-right:100px;
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
		display:inline-block;
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
	@media all and (max-width: 1610px) {
		.externalImage {margin-right:100px;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.externalImage {margin-right:60px;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -45px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:0px; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		.externalImage {margin:0px; padding:0px; max-height: 120px;max-width:100%;}
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { margin-left:0px; margin-top: 110px; display:block; float:none; width:100%; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:0px; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		.externalImage {margin:0px; padding:0px; max-height: 120px;max-width:100%;}
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 130px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:0px; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; width:100%;margin-left:0%;}
		#pageHeader { height: 70px; }
		.externalImage {margin:0px; padding:0px; max-height: 120px;max-width:100%;}
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		#pageHeader {height: 60px;}
		.externalImage {margin:0px; padding:0px; max-height: 100px;max-width:100%;}
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		.externalImage {margin:0px; padding:0px; max-height: 90px;max-width:100%;}
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		.externalImage {margin:0px; padding:0px; max-height: 80px;max-width:100%;}
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
			<external-image></external-image>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div x-ms-format-detection="none" id="otp-fields">
				<otp-form></otp-form>
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
</div>' where fk_id_layout = @pageLayoutIdPhotoTan;

SET @pageLayoutIdPushTan = (select id from `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'Polling Page (Commerzbank AG)');

UPDATE `CustomComponent`
SET `value` = '<style>

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
		display:inline-block;
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
		.paragraph { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -45px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields { width:100%; padding-right: 0px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields { width:100%; padding-right: 0px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 130px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields { width:100%;  padding-right: 0px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; width:100%; margin-left:0%;}
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		#pageHeader {height: 60px;}
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
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
</div>' where fk_id_layout = @pageLayoutIdPushTan ;

SET @pageLayoutIdSMS = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'OTP_FORM_PAGE' AND DESCRIPTION = 'SMS OTP Form Page (Commerzbank AG)');

UPDATE `CustomComponent`
SET `value` = '<style>
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
	#reSendOtp > button{
		background:none!important;
		color: #333333;
		border:none;
		padding:0!important;
		font: inherit;
		cursor: pointer;
		margin-left: 70px;
		font-family: Arial, standard;
		font-size: 12px;
	}
	#reSendOtp > button:disabled{
		background:none!important;
		color: #858585;
		border:none;
		padding:0!important;
		font: inherit;
		cursor: not-allowed;
		margin-left: 70px;
		font-family: Arial, standard;
		font-size: 12px;
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
	div#reOPT {
		text-align:center;
		color:#394344;
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
        margin-left:38%;
		width:60%;
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
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		div#reOPT { text-align:center; }
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
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		div#reOPT { text-align:center; }
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
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 105px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; width:100%;margin-left:0%;}
		#pageHeader { height: 70px; }
		div#reOPT { text-align:center; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 90px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		#pageHeader {height: 60px;}
		div#reOPT { text-align:center; }
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; text-align:center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div#otp-fields {display:inherit;}
		div#reOPT { text-align:center; }
        #footer { width:100%; margin-left:0%;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; text-align:center; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align:center; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div#otp-fields {display:inherit;}
		div#reOPT { text-align:center; }
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
				<otp-form></otp-form>
			</div>
			<div id="reOPT">
				<span class="fa fa-refresh fa-fw" style="margin-left: 0px; margin-right: -70px;"></span>
				<re-send-otp id="reSendOtp" iconclass="undefined" rso-label="''network_means_pageType_3''"></re-send-otp>
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
	</div>
</div>' where fk_id_layout = @pageLayoutIdSMS;


SET @pageLayoutITAN = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'I_TAN_OTP_FORM_PAGE' AND DESCRIPTION = 'ITAN OTP Form Page (Commerzbank AG)');

UPDATE `CustomComponent`
SET `value` = '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
		overflow:auto;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#validateButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:hover:enabled {
		border-color: #000000;
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#validateButton button:hover {
		border-color: #000000;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
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
		text-align: left;
		font-family: Arial,bold;
		color: #333333;
		font-size:18px;
	}
	.leftColumn {
		width:45%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:block;
		text-align:left;
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
		width: 150px;
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
		display:inline-block;
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
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -45px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:100px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields { width:100%; padding-right: 150px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:100px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields { width:100%; padding-right: 100px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 105px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:100px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields { width:100%;  padding-right: 0px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 90px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
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
			<side-menu menu-title="''network_means_pageType_2''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>

			<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>

			<div x-ms-format-detection="none" id="otp-fields">
				<otp-form></otp-form>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
		</div>
	</div>
</div>' where fk_id_layout = @pageLayoutITAN;


SET @pageLayoutInfoRefusal = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'INFO_REFUSAL_PAGE' AND DESCRIPTION = 'INFO Refusal Page (Commerzbank AG)');

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
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<alternative-display attribute="''externalWSResponse''" value="''UNKNOWN_USER''"
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
</div>' where fk_id_layout = @pageLayoutInfoRefusal;

SET @pageLayoutRefusal = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'REFUSAL_PAGE' AND DESCRIPTION = 'Refusal Page (Commerzbank AG)');

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
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner></message-banner>

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
</div>
' where fk_id_layout = @pageLayoutRefusal;


SET @pageLayoutFailure = (SELECT id FROM `CustomPageLayout` WHERE `pageType` = 'FAILURE_PAGE' AND DESCRIPTION = 'Failure Page (Commerzbank AG)');

UPDATE `CustomComponent`
SET `value` = '<style>
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
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
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
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
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
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
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
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size : 10px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { font-size : 8px; display:block; text-align:center; }
		.paragraph { font-size : 8px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
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
</div>' where fk_id_layout = @pageLayoutFailure;

