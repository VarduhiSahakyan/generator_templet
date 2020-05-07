/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;

USE U7G_ACS_BO;
SET @BankB = 'UBS';
/*Templates are common for EWLACS3SWK-143, EWLACS3SWK-145, EWLACS3SWK-146*/
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @BankB, ')%') );
start transaction;

UPDATE CustomComponent SET value = '<style>
	#message-container {
		position: relative;
	}
	div#message-container {
		padding-top: 5px;
	}
	div#message-container.info {
		background-color: #dee2e9;
		font-family: FrutigerforUBSWeb;
		font-size: 12px;
		color: #e0b519;
	}
	div#message-container.success {
		background-color: #e5e6c5;
		font-family: FrutigerforUBSWeb;
		font-size: 12px;
		color: #e0b519;
	}
	div#message-container.error {
		background-color: #f7e1df;
		font-family: FrutigerforUBSWeb;
		font-size: 12px;
		color: #e0b519;
	}
	div#message-container.warn {
		background-color: #fff3d8;
		font-family: FrutigerforUBSWeb;
		font-size: 12px;
		color: #e0b519;
	}
	div#message-content {
		text-align: start;
		background-color: inherit;
		padding-bottom: 5px;
	}
	span#info-icon {
		font-size: 1em;
		top: 5px;
		left: 5px;
		float: left;
		margin-right: 5px;
	}
	#message {
		font-family: FrutigerforUBSWeb;
		color: #1c1c1c;
		font-size: 12px;
		line-height: 16px;
		text-align: start;
	}
	span#message {
		font-size: 12px;
		width: 100%;
		padding-left: 25px;
	}
	custom-text#headingTxt {
		padding-left: 8px;
		display: grid;
		font-weight: bold;
		color: #1c1c1c;
	}
	div#message-controls {
		padding-top: 5px;
	}
	div.message-button {
		padding-top: 0px;
		padding-left: 25px;
	}
	div#spinner-row .spinner div div {
		background: #e0b519 !important;
	}
	button span.fa {
		padding-right: 7px;
		display: none;
	}

</style>
<div id="messageBanner">
	<span id="info-icon" class="fa fa-exclamation-triangle"></span>
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
		margin-left: 3em;
	}
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt;
		font-size: 24px;
		color: #1c1c1c;
		line-height: 28px;
		padding-bottom: 24px;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .menu-elements {
		margin-right: 9%;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 32%;
		padding-right: 0px
	}
	#main-container .tooltips:hover span {
		margin-bottom: 10px;
	}
	#main-container .mtan-input {
		padding-bottom: 8px;
	}
	#main-container .input-label {
		flex-direction: row;
		align-items: center;
	}
	#main-container .mtan-label {
		text-align: left;
		flex: 0 0 180px;
		font-family: Frutiger55Roman, sans-serif;
		font-size: 12px;
		color: #646464;
		letter-spacing: 0;
		line-height: 16px
	}
	#main-container .otp-field input {
		font-size: 16px;
		color: #1c1c1c;
		background: #ffffff;
		margin-left: 0px;
		border: 1px solid #aaaaaa;
		width: 218px;
		height: 48px;
	}
	#main-container .otp-field input:focus {
		outline: none;
	}
	#main-container #resend button {
		border-style: none;
		padding: 0px
	}
	#main-container #resend button span {
		color: #007099;
	}
	#main-container .resendTan {
		font-size: 14px;
		line-height: 20px;
		display: block;
		margin-bottom: 16px;
		color: #007099;
	}
	#main-container .resendTan a {
		color: #007099;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .row .submit-btn {
		text-align: left;
		float: left;
	}
	#main-container #validateButton button {
		font-size: 14px;
		width: 104px;
		height: 38px;
		border-radius: 2px;
		background: #6a7d39;
		opacity: 1;
		box-shadow: none;
		border: 0px;
		color: #ffffff;
		margin-right: 8px;
	}
	#main-container #cancelButton button {
		font-size: 14px;
		width: 104px;
		height: 38px;
		border-radius: 2px;
		border: 1px solid #919191;
		box-shadow: none;
		background: #ffffff;
	}
	#main-container #validateButton span.fa-check-square {
		display: none;
	}
	#main-container #cancelButton span.fa-ban {
		display: none;
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container #validateButton button:disabled {
		font-size: 14px;
		width: 104px;
		height: 38px;
		border-radius: 2px;
		background: #6a7d39;
		box-shadow: none;
		border: 0px;
		color: #ffffff;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 0%; }
		#main-container .resendTan {width: 86%; text-align: center;}
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link {width: 70%;text-align: center;}
	}
	@media all and (max-width: 500px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {margin-right: 9%;}
		#main-container #contentBottom { padding-left: 6%; }
		#main-container .otp-field input { width: 218px; }
		#main-container .resendTan {width: 82%; text-align: center;}
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 61%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {margin-right: 0%;}
		#main-container #contentBottom { padding-left: 28%;}
		#main-container .otp-field input { width: 218px; }
		#main-container .resendTan {width: 72%; text-align: center;}
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 36%;text-align: center;}
	}
	@media all and (max-width: 250px) {
        #main-container {padding-left: 16px; }
        #main-container #pageHeader {padding-left: 0px; }
        #main-container #pageHeaderLeft {padding-left: 0px; }
        #main-container #pageHeaderRight {padding-right: 0px; }
        #main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
		#main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements {margin-right: 0px;}
        .break-word.ng-scope {width: 100%; display: inline-table;}
        #main-container .col-sm-5 {width: auto; display: inline-table;}
        #main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container #contentBottom { padding-left: 0%; }
		#main-container .otp-field input { width: 218px; }
		#main-container .resendTan {width: 72%; text-align: left;}
		#main-container .row .submit-btn { text-align: left; float: none;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 29%;text-align: left;}
	}

</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div id="contentHeaderLeft">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</h3>
		</div>
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div class="mtan-input">
				<div class="input-label">
					<div class="otp-field">
						<otp-form></otp-form>
					</div>
				</div>
			</div>

			<div class="resendTan">
				<span class="fa fa-angle-right"></span>
				<re-send-otp id="resend" rso-Label="''network_means_pageType_19''"></re-send-otp>
			</div>

			<div id="form-controls">
				<div class="row">
					<div class="submit-btn">
						<val-button id="validateButton" val-label="''network_means_pageType_42''"></val-button>
						<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
					</div>
				</div>
			</div>

			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
		margin-left: 3em;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		margin-top: 10px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 35%;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link { width: 66%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 15%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 56%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 33%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container {padding-left: 16px; }
        #main-container #pageHeader {padding-left: 0px; }
        #main-container #pageHeaderLeft {padding-left: 0px; }
        #main-container #pageHeaderRight {padding-right: 0px; }
        #main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
        #main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements {margin-right: 0px;}
        .break-word.ng-scope {width: 100%; display: inline-table;}
        #main-container .col-sm-5 {width: auto; display: inline-table;}
        #main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container #contentBottom { padding-left: 0%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 29%;text-align: left;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
		margin-left: 3em;
	}
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt;
		font-size: 24px;
		color: #1c1c1c;
		line-height: 28px;
		padding-bottom: 24px;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .menu-elements {
		padding-right: 10%;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 32%;
	}
	#main-container #link-text {
		font-size: 12px;
		display: inline-block;
		margin-top: 5px;
		position: relative;
		text-align: left;
		width: 218px;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container #return-button-row-2 button {
		font-family: FrutigerforUBSWeb;
		font-size: 16px;
		border-radius: 0px;
		margin-top: 8px;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 3%; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link { width: 69%;text-align: center;}
	}
	@media all and (max-width: 500px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {padding-right: 10%;}
		#main-container #contentBottom { padding-left: 10%; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 59%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {padding-right: 0%;}
		#main-container #contentBottom { padding-left: 30%;}
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 33%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container {padding-left: 16px; }
        #main-container #pageHeader {padding-left: 0px; }
        #main-container #pageHeaderLeft {padding-left: 0px; }
        #main-container #pageHeaderRight {padding-right: 0px; }
        #main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
        #main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements {margin-right: 0px;}
        .break-word.ng-scope {width: 100%; display: inline-table;}
        #main-container .col-sm-5 {width: auto; display: inline-table;}
        #main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container #contentBottom { padding-left: 0%; }
		#main-container #link-text { text-align: left; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 29%;text-align: left;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div id="contentHeaderLeft">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</h3>
		</div>
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="link-text">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
				<div id="return-button-row-2">
					<button class="btn btn-default" ng-click="returnButtonAction()">
						<custom-text custom-text-key="''network_means_pageType_40''" class="ng-isolate-scope"></custom-text>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
		margin-left: 3em;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		margin-top: 10px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 35%;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link { width: 69%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 16%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 59%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 30%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container {padding-left: 16px; }
        #main-container #pageHeader {padding-left: 0px; }
        #main-container #pageHeaderLeft {padding-left: 0px; }
        #main-container #pageHeaderRight {padding-right: 0px; }
        #main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
        #main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements {margin-right: 0px;}
        .break-word.ng-scope {width: 100%; display: inline-table;}
        #main-container .col-sm-5 {width: auto; display: inline-table;}
        #main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container #contentBottom { padding-left: 0%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 29%;text-align: left;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
		margin-left: 3em;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		margin-top: 10px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .menu-elements {
		padding-right: 10%;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 32%;
	}
	span#info-icon {
		font-size: 1em;
		top: 5px;
		left: 5px;
		float: left;
		margin-right: 5px;
	}
	div.message-button {
		display: none;
	}
	div#spinner-row .spinner div div {
		background: #e0b519 !important;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link { width: 66%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 15%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 56%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 33%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container {padding-left: 16px; }
        #main-container #pageHeader {padding-left: 0px; }
        #main-container #pageHeaderLeft {padding-left: 0px; }
        #main-container #pageHeaderRight {padding-right: 0px; }
        #main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
        #main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px; padding-right: 0px;}
		#main-container .menu-elements {margin-right: 0px;}
        .break-word.ng-scope {width: 100%; display: inline-table;}
        #main-container .col-sm-5 {width: auto; display: inline-table;}
        #main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container #contentBottom { padding-left: 0%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 29%;text-align: left;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true></message-banner>
	<div id="content">
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

set @BankUB = 'UBS';
set @createdBy = 'A707825';

SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @authentMeanMobile = 'MOBILE_APP_EXT';
SET @authentMeanSMS = 'OTP_SMS_EXT_MESSAGE';
SET @authentMeanRefusal = 'REFUSAL';

SET @pageTypePolling = 'POLLING_PAGE';
SET @pageTypeOTP = 'OTP_FORM_PAGE';
SET @pageTypeFailure = 'FAILURE_PAGE';
SET @pageTypeRefusal = 'REFUSAL_PAGE';

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));


/*===================================================================104=============================================================================*/
set @ordinal = 104;
update CustomItem set value = 'Mobilnr.'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and pageTypes = 'ALL' and locale = 'de' and DTYPE = 'T';

update CustomItem set value = 'Mobile no.'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and pageTypes = 'ALL' and locale = 'en' and DTYPE = 'T';

update CustomItem set value = 'N° de portable'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and pageTypes = 'ALL' and locale = 'fr' and DTYPE = 'T';

update CustomItem set value = 'Numero di cellulare'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and pageTypes = 'ALL' and locale = 'it' and DTYPE = 'T';

/*===================================================================28=============================================================================*/
set @ordinal = 28;
update CustomItem set value = 'Ungültiger Code'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'de' and DTYPE = 'T';

update CustomItem set value = 'Invalid code'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'en' and DTYPE = 'T';

update CustomItem set value = 'Code non valide'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'fr' and DTYPE = 'T';

update CustomItem set value = 'Codice non valido'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'it' and DTYPE = 'T';

/*===================================================================29=============================================================================*/
set @ordinal = 29;
update CustomItem set value = 'Bitte versuchen Sie es erneut.'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'de' and DTYPE = 'T';

update CustomItem set value = 'Please try again.'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'en' and DTYPE = 'T';

update CustomItem set value = 'Veuillez réessayer.'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'fr' and DTYPE = 'T';

update CustomItem set value = 'Si prega di riprovare.'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'it' and DTYPE = 'T';

/*===================================================================16=============================================================================*/
set @ordinal = 16;
update CustomItem set value = 'Karte gesperrt'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'de' and DTYPE = 'T'and pageTypes = @pageTypeFailure;

update CustomItem set value = 'Card blocked'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'en' and DTYPE = 'T'and pageTypes = @pageTypeFailure;

update CustomItem set value = 'Carte bloquée'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'fr' and DTYPE = 'T'and pageTypes = @pageTypeFailure;

update CustomItem set value = 'Carta bloccata'
where fk_id_customItemSet = @customItemSetSMS
	and ordinal = @ordinal and locale = 'it' and DTYPE = 'T' and pageTypes = @pageTypeFailure;

/*===================================================================2,23=============================================================================*/
set @ordinal_2 = 2;
set @ordinal_23 = 23;

update CustomItem set value = 'Bitte loggen Sie sich ins UBS E-Banking oder Mobile Banking ein, um online Einkaufen aus- und wieder einzuschalten.'
where ordinal in (@ordinal_2, @ordinal_23)
	and fk_id_customItemSet = @customItemSetSMS
	and pageTypes in (@pageTypeFailure,  @pageTypeRefusal)
	and locale = 'de';

update CustomItem set value = 'Please log in to UBS E-Banking or Mobile Banking to deactivate and reactivate online purchasing.'
where ordinal in (@ordinal_2, @ordinal_23)
	and fk_id_customItemSet = @customItemSetSMS
	and pageTypes in (@pageTypeFailure, @pageTypeRefusal)
	and locale = 'en';

update CustomItem set value = 'Connectez-vous sur l’UBS E-Banking ou le Mobile Banking pour désactiver et réactiver le paiement en ligne.'
where ordinal in (@ordinal_2, @ordinal_23)
	and fk_id_customItemSet = @customItemSetSMS
	and pageTypes in (@pageTypeFailure, @pageTypeRefusal)
	and locale = 'fr';

update CustomItem set value = 'Effettui il login nell''E-Banking o nel Mobile Banking per disattivare e riattivare gli acquisti online.'
where ordinal in (@ordinal_2, @ordinal_23)
	and fk_id_customItemSet = @customItemSetSMS
	and pageTypes in (@pageTypeFailure, @pageTypeRefusal)
	and locale = 'it';

/*===================================================================banner_text=============================================================================*/
set @txt_back_to_shop_DE = 'Zurück zum Shop';
set @txt_back_to_shop_EN = 'Back to shop';
set @txt_back_to_shop_FR = 'Retour à la boutique';
set @txt_back_to_shop_IT = 'Tornare al negozio';

set @txt_close_DE = 'Schliessen';
set @txt_close_EN = 'Close';
set @txt_close_FR = 'Fermer';
set @txt_close_IT = 'Chiudere';

set @pageTypeALL = 'ALL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'de', 174, @pageTypeALL, @txt_close_DE, @MaestroVID, NULL, @customItemSetMOBILEAPP),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'en', 174, @pageTypeALL, @txt_close_EN, @MaestroVID, NULL, @customItemSetMOBILEAPP),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'fr', 174, @pageTypeALL, @txt_close_FR, @MaestroVID, NULL, @customItemSetMOBILEAPP),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'it', 174, @pageTypeALL, @txt_close_IT, @MaestroVID, NULL, @customItemSetMOBILEAPP),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'de', 174, @pageTypeALL, @txt_close_DE, @MaestroVID, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'en', 174, @pageTypeALL, @txt_close_EN, @MaestroVID, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'fr', 174, @pageTypeALL, @txt_close_FR, @MaestroVID, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'it', 174, @pageTypeALL, @txt_close_IT, @MaestroVID, NULL, @customItemSetSMS),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'de', 174, @pageTypeALL, @txt_close_DE, @MaestroVID, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'en', 174, @pageTypeALL, @txt_close_EN, @MaestroVID, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'fr', 174, @pageTypeALL, @txt_close_FR, @MaestroVID, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'it', 174, @pageTypeALL, @txt_close_IT, @MaestroVID, NULL, @customItemSetRefusal),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'de', 174, @pageTypeALL, @txt_close_DE, @MaestroVID, NULL, @customItemSetINFORefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'en', 174, @pageTypeALL, @txt_close_EN, @MaestroVID, NULL, @customItemSetINFORefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'fr', 174, @pageTypeALL, @txt_close_FR, @MaestroVID, NULL, @customItemSetINFORefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_174'), 'PUSHED_TO_CONFIG',
	 'it', 174, @pageTypeALL, @txt_close_IT, @MaestroVID, NULL, @customItemSetINFORefusal),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'de', 175, @pageTypeALL, @txt_back_to_shop_DE, @MaestroVID, NULL, @customItemSetMOBILEAPP),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'en', 175, @pageTypeALL, @txt_back_to_shop_EN, @MaestroVID, NULL, @customItemSetMOBILEAPP),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'fr', 175, @pageTypeALL, @txt_back_to_shop_FR, @MaestroVID, NULL, @customItemSetMOBILEAPP),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanMobile, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'it', 175, @pageTypeALL, @txt_back_to_shop_IT, @MaestroVID, NULL, @customItemSetMOBILEAPP),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'de', 175, @pageTypeALL, @txt_back_to_shop_DE, @MaestroVID, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'en', 175, @pageTypeALL, @txt_back_to_shop_EN, @MaestroVID, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'fr', 175, @pageTypeALL, @txt_back_to_shop_FR, @MaestroVID, NULL, @customItemSetSMS),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanSMS, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'it', 175, @pageTypeALL, @txt_back_to_shop_IT, @MaestroVID, NULL, @customItemSetSMS),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'de', 175, @pageTypeALL, @txt_back_to_shop_DE, @MaestroVID, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'en', 175, @pageTypeALL, @txt_back_to_shop_EN, @MaestroVID, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'fr', 175, @pageTypeALL, @txt_back_to_shop_FR, @MaestroVID, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'it', 175, @pageTypeALL, @txt_back_to_shop_IT, @MaestroVID, NULL, @customItemSetRefusal),

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'de', 175, @pageTypeALL, @txt_back_to_shop_DE, @MaestroVID, NULL, @customItemSetINFORefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'en', 175, @pageTypeALL, @txt_back_to_shop_EN, @MaestroVID, NULL, @customItemSetINFORefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'fr', 175, @pageTypeALL, @txt_back_to_shop_FR, @MaestroVID, NULL, @customItemSetINFORefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName, '_', @authentMeanRefusal, '_', @pageTypeALL, '_175'), 'PUSHED_TO_CONFIG',
	 'it', 175, @pageTypeALL, @txt_back_to_shop_IT, @MaestroVID, NULL, @customItemSetINFORefusal);



/*EWLACS3SWK-146*/

/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES ('InitPhase', NOW(), 'The Visa logo small', NULL, NULL, 'VISA_LOGO_SMALL', 'PUSHED_TO_CONFIG', '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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

SET @idImageVisaScheme = (SELECT id FROM `Image` im WHERE im.name LIKE '%VISA_LOGO_SMALL%');

UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetRefusal ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetMOBILEAPP ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetINFORefusal ;

commit;