USE U5G_ACS_BO;

set @pageLayoutIdPassword = (select id from `CustomPageLayout` where `pageType` = 'EXT_PASSWORD_OTP_FORM_PAGE' and DESCRIPTION = 'Password OTP Form Page (Commerzbank AG)');

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
		float:left;
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
        clear: both;
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
    @media all and (min-width: 601px) and (max-width: 1199px) {
		div#optGblPage { font-size : 14px; }
        #displayLayout {display: none}
		#pageHeader {height: 90px}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 501px) and (max-width: 600px) {
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 80px}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 390px) and (max-width: 500px) {
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 70px}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 40px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 250px) and (max-width: 390px) {
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 65px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
	@media all and (min-width: 250px) and (max-width: 261px) {
        div.side-menu { font-size : 11px}
    }
	@media all and (max-width: 250px) {
		div#optGblPage { font-size : 12px; }
        div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
        side-menu div.text-center { font-size : 11px}
        .paragraph { font-size : 12px; text-align:center; }
        #pageHeader {height: 50px}
		#networkLogo {max-height: 25px; }
        #displayLayout {display: none}
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
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
 div#message-container.success {
			background-color: #E0700A;
			font-family: Arial, standard;
			font-size: 12px;
			color: #EAEAEA;
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
</div>'  where fk_id_layout = @pageLayoutIdPassword;



set @pageLayoutIdSMS = (select id from `CustomPageLayout` where `pageType` = 'OTP_FORM_PAGE' and DESCRIPTION = 'SMS OTP Form Page (Commerzbank AG)');

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
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
        float:left;
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
        clear:both;
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
    @media all and (min-width: 601px) and (max-width: 1199px) {
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 90px}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
        .leftColumn {margin-top: 10px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        #reOPT {margin-bottom: 10px;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 501px) and (max-width: 600px) {
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 70px}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
        .leftColumn {margin-top: 10px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        #reOPT {margin-bottom: 10px;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 390px) and (max-width: 500px) {
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 70px}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 40px; }
        .leftColumn {margin-top: 10px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        #reOPT {margin-bottom: 10px;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 250px) and (max-width: 390px) {
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 65px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        .leftColumn {margin-top: 10px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        #reOPT {margin-bottom: 10px;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
	@media all and (min-width: 250px) and (max-width: 261px) {
        div.side-menu { font-size : 11px}
    }
	@media all and (max-width: 250px) {
		div#optGblPage { font-size : 12px; }
        .paragraph { font-size : 12px; text-align:center; }
        div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
        side-menu div.text-center { font-size : 11px}
        #pageHeader {height: 50px}
		#networkLogo {max-height: 25px; }
        #displayLayout {display: none}
        .leftColumn {margin-top: 10px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        #reOPT {margin-bottom: 10px;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
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
		<div class="help-link">
				<help help-label="''network_means_HELP_PAGE_1''" id="helpButton" class="helpButtonClass"></help>
				<span class="fa fa-angle-right"></span>
		</div>
	</div>
</div>' where fk_id_layout = @pageLayoutIdSMS;



set @pageLayoutIdPhotoTAN = (select id from `CustomPageLayout` where `pageType` = 'PHOTO_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'PhotoTAN OTP Form Page (Commerzbank AG)');

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
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
        float:left;
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
		margin-right:0;
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
        clear: both;
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
    @media all and (min-width: 601px) and (max-width: 1199px) {
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size : 14px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 70px}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .externalImage {margin:0px; padding:0px; max-height: 100px; max-width:100%;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 501px) and (max-width: 600px) {
		div#optGblPage { font-size : 12px;}
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 50px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .externalImage {margin:0px; padding:0px; max-height: 80px; max-width:100%;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%; padding-top: 8px;}
    }
    @media all and (min-width: 390px) and (max-width: 500px) {
		div#optGblPage { font-size : 12px;}
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 50px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .externalImage {margin:0px; padding:0px; max-height: 80px; max-width:100%;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%; padding-top: 8px;}
    }
    @media all and (min-width: 250px) and (max-width: 390px) {
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size : 12px; text-align:center; }
        #displayLayout {display: none}
		#pageHeader {height: 50px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {margin-top : 10px; width:100%; margin-left:0px; padding:0}
        .externalImage {margin:0px; padding:0px; max-height: 80px;max-width:100%;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%; padding-top: 8px;}
    }
	@media all and (min-width: 250px) and (max-width: 261px) {
        div.side-menu { font-size : 11px}
    }
	@media all and (max-width: 250px) {
        .paragraph { font-size : 11px; text-align:center; }
        div.side-menu div.menu-title { font-size : 11px; display:block; text-align:center; }
        side-menu div.text-center { font-size : 10px}
        #pageHeader {height: 50px}
		#networkLogo {max-height: 25px; }
        #displayLayout {display: none}
        .leftColumn {margin-top: 5px; width : 100%; float : none}
        .rightColumn {width:100%; margin-top : 10px; margin-left:0px; padding:0}
        .externalImage {margin:0px; padding:0px; max-height: 80px;max-width:100%;}
        .validateButton {margin-bottom: 5px;}
        #footer { width:100%; margin-left:0%;}
        #footer .cancel-link {margin-left: 10px;}
        #footer .help-link {margin-right: 10px;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
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
</div>' where fk_id_layout = @pageLayoutIdPhotoTAN;



set @pageLayoutIdPolling = (select id from `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'Polling Page (Commerzbank AG)');

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
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
        float:left;
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
        clear:both;
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
    @media all and (min-width: 601px) and (max-width: 1199px) {
        div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size: 14px; }
		#pageHeader {height: 80px}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
        span#message {font-size: 14px !important; padding-left: 0}
        #displayLayout {display: none}
		.leftColumn {margin-top: 5px; width: 100%; float: none}
        .rightColumn {margin-top: 10px; width:100%; margin-left:0px; padding:0}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 501px) and (max-width: 600px) {
        div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size: 14px; }
		#pageHeader {height: 65px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        span#message {font-size: 14px !important; padding-left: 0}
        #displayLayout {display: none}
		.leftColumn {margin-top: 5px; width: 100%; float: none}
        .rightColumn {margin-top: 10px; width:100%; margin-left:0px; padding:0}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 390px) and (max-width: 500px) {
        div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { font-size : 14px; display:block; text-align:center; }
		.paragraph { font-size: 14px; }
		#pageHeader {height: 65px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        span#message {font-size: 14px !important; padding-left: 0}
        #displayLayout {display: none}
		.leftColumn {margin-top: 5px; width: 100%; float: none}
        .rightColumn {margin-top: 10px; width:100%; margin-left:0px; padding:0}
        #footer { width:100%; margin-left:0%;}
    }
    @media all and (min-width: 250px) and (max-width: 390px) {
        div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { font-size : 12px; display:block; text-align:center; }
		.paragraph { font-size: 12px; }
		#pageHeader {height: 65px}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
        span#message {font-size: 12px !important; padding-left: 40px;}
        #displayLayout {display: none}
		.leftColumn {margin-top: 5px; width: 100%; float: none}
        .rightColumn {margin-top: 10px; width:100%; margin-left:0px; padding:0}
        #footer { width:100%; margin-left:0%;}
    }
	@media all and (max-width: 250px) {
        div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { font-size : 10px; display:block; text-align:center; }
		.paragraph { font-size: 10px; }
        #pageHeader {height: 50px}
        #networkLogo {max-height: 25px; }
        span#message {font-size: 10px !important; padding-left: 25px;}
        #displayLayout {display: none}
		.leftColumn {margin-top: 5px; width: 100%; float: none}
        .rightColumn {margin-top: 10px; width:100%; margin-left:0px; padding:0}
        #footer { width:100%; margin-left:0%;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
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
</div>' where fk_id_layout = @pageLayoutIdPolling;