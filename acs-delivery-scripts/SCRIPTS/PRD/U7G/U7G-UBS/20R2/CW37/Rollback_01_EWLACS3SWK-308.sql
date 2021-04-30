use U7G_ACS_BO;
set @BankB = 'UBS';

set @layoutId = (select id
				 from `CustomPageLayout`
				 where `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%'));

update CustomComponent
set value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb, sans-serif;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 16px;
	}
	#main-container #headerLayout {
		padding-right: 16px;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
		padding-right: 0px;
		padding-left: 0px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
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
	message-banner.ng-isolate-scope {
		padding-right: 16px;
	}
	#main-container #content {
		text-align: left;
	}
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt, sans-serif;
		font-size: 24px;
		color: #1c1c1c;
		line-height: 28px;
		margin-bottom: 24px;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: FrutigerforUBSWeb, sans-serif;
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
		width: 50%;
		white-space: nowrap;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		padding: 0px;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		padding-left: 8px;
	}
	#main-container #contentFooter {
		width: 100%;
		display: flex;
		padding-top: 8px;
	}
	#main-container #empty {
		width: 19%;
		float: left;
	}
	#main-container #contentBottom {
		padding-left: 0%;
		padding-right: 0px;
		width: 468px;
		float: right;
	}
	#main-container .code-otp {
		display: inline-flex;
		padding-left: 9%;
	}
	#main-container .tooltips:hover span {
		margin-bottom: 10px;
	}
	#main-container .input-label {
		flex-direction: row;
		align-items: center;
		padding-left: 10px;
	}
	#main-container .mtan-label {
		text-align: left;
		flex: 0 0 180px;
		font-family: FrutigerforUBSWeb, sans-serif;
		font-size: 12px;
		color: #646464;
		letter-spacing: 0;
		line-height: 16px;
	}
	#main-container .otp-field input {
		font-size: 16px;
		color: #1c1c1c;
		background: #ffffff;
		margin-left: 0px;
		border: 1px solid #aaaaaa;
		width: 166px;
		height: 32px;
	}
	#main-container .code {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 10px;
		margin-top: 10px;
		height: 20px;
		width: 48px;
		float: right;
		display: flex;
	}
	#main-container .code #menu-separator {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-weight: 700;
		color: #333333;
		font-size: 16px;
		padding-left: 3px;
	}
	#main-container .otp-field input:hover {
		border: 2px solid #aaaaaa;
	}
	#main-container .otp-field input:focus {
		outline: none;
		border: 2px solid #009bd2;
	}
	#main-container #resend button {
		border-style: none;
		padding: 0px
	}
	#main-container #resend button span {
		color: #007099;
	}
	#main-container .resendTan {
		font-family: FrutigerforUBSWeb, sans-serif;
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
		margin-bottom: 0px;
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
		#main-container .code-otp {width: 82%; padding-left: 0%;}
		#main-container .code {width: 20.5%; display: flex; justify-content: flex-end;}
		#main-container #empty { width: 19%;}
		#main-container #contentBottom { width: 468px;; padding-left: 0%;}
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 500px) {
		#main-container .menu-elements { width: 60%; }
		#main-container .code {width: 24.6%; display: flex; justify-content: flex-end;}
		#main-container .code-otp { width: 82%; padding-left: 0%;}
		#main-container #empty { width: 22%;}
		#main-container #contentBottom { width: 368px; }
		#main-container .otp-field input { width: 166px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 390px) {
		#main-container .menu-elements { width: 78%; }
		#main-container .code {width: 32%; display: flex; justify-content: flex-end;}
		#main-container .code-otp { width: 82%; padding-left: 0%;}
		#main-container #empty { width: 23%;}
		#main-container #contentBottom { width: 285px; padding-left: 6%;}
		#main-container .otp-field input { width: 166px; }
		#main-container .row .submit-btn { display: flex; }
		span#info-icon {position: relative; font-size: 0.8em;top: 7px;left: 5px; float: left; margin-right: 7px;}
	}
	@media all and (max-width: 250px) {
		#main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
		#main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements { width: auto; }
		.break-word.ng-scope {width: 100%; display: inline-flex;}
		#main-container .col-sm-5 {width: auto; display: inline-table;}
		#main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container .col-sm-4 { margin-bottom: 0px; }
		#main-container .code {width: 46%; display: flex; justify-content: flex-start;}
		#main-container .code-otp { padding-left: 0%;}
		#main-container #empty { display: none;}
		#main-container #contentBottom { width: 218px; padding-left: 0%; }
		#main-container .otp-field input { width: 166px; }
		#main-container .row .submit-btn { display: flex; }
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
		<div class="code-otp">
			<div class="code">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				<label id = "menu-separator">:</label>
			</div>
			<div class="mtan-input">
				<div class="input-label">
					<div class="otp-field">
						<otp-form></otp-form>
					</div>
				</div>
			</div>
		</div class="code-otp">
	<div id="contentFooter">
		<div id="empty"> </div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
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
	</div>
</div>' where fk_id_layout = @layoutId;