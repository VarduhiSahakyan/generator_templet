USE U5G_ACS_BO;


SET @pollingPageType = 'POLLING_PAGE';
SET @pageLayoutIdPolling = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'Polling Page (Consorsbank)' AND `pageType` = @pollingPageType);

UPDATE `CustomComponent`
SET `value` = '
	<div id="main-container">
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
		<div id="content">
			<message-banner></message-banner>
			<h2>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h2>
			<div class="transactiondetails">
				<side-menu></side-menu>
			</div>
			<div id="newLine">
				<br></br>
				<br></br>
				<p></p>
			</div>
			<h2>
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph1"></custom-text>
			</h2>
			<span>
				<custom-text custom-text-key="''network_means_pageType_4''" id="paragraph1"></custom-text>
			</span>
			<p></p>
			<div class="mobileapp">
			<custom-image id="mobileAppLogo" alt-key="''network_means_pageType_3_IMAGE_ALT''" image-key="''network_means_pageType_3_IMAGE_DATA''" straight-mode="false">
			</div>
			<means-choice-menu></means-choice-menu>
			<div id="form-controls">
				<div class="row">
					<div class="back-link">
						<span class="fa fa-angle-left"></span>
						<cancel-button cn-label="''network_means_pageType_11''" id="cancelButton" ></cancel-button>
					</div>
				</div>
			</div>
		</div>
		<div id="footer">
			<div class="help-area">
				<div class="help-link">
					 <help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
					<span class="fa fa-angle-right"></span>
				</div>
				<div class="contact">
					<div class="line bottom-margin">
						<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
					</div>
					<div class="line small bold">
						<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
					</div>
					<div class="line small grey">
						<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
					</div>
				</div>
			</div>
			<div id="copyright" class="extra-small">
				<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
				<div><span><custom-text custom-text-key="''network_means_pageType_44''"></custom-text></span></div>
			</div>
		</div>
	<style>
	/* Switchpoints: 780, */
		:root {
			font-family: proximaLight, Times;
			padding:0px;
			margin:0px;
		}
		.mobileapp{
			text-align: center;
		}
		#main-container {
			width:480px;
			max-width:480px;
			margin-left:auto;
			margin-right:auto;
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


		#content {
			text-align:center;
		}
		#content h2 {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:8px;
		}
		#main-container	  #footer {
			margin-top: 5px;
			width:100%;
			background-color:#d1d1d1;
			clear:both;
			background-image:none;
			height: auto;
		}
		#main-container	  #footer:after {
			content: "''";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container	  #footer .extra-small {
			font-size:0.7em;
		}
		#main-container	  #footer .small {
			font-size:0.8em;
		}
		#main-container	  #footer .bold {
			font-weight: bold;
		}
		#main-container	 #footer .grey {
			color: #6b6b6b;
		}
		#main-container	  #footer .bottom-margin {
			margin-bottom:10px;
		}
		#main-container	  #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
		#main-container	  #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container	  #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container	 #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
		p {
			margin-bottom:10px;
		}
		#main-container #footer .small-font {
			font-size:0.75em;
		}
		.splashtext {
			width:80%;
			margin-left:auto;
			margin-right:auto
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			padding: 7px 10px 5px;
			height: 20px;
			box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
		}
		.spinner-container {
			display:block;
			width:100%;
		}
		#messageBanner-innerContainer {
			padding:20px;
		}
		#messageBanner {
			width:100%;
			margin-left: 0px;
			margin-right: 0px;
			background-color:#F5F5F5;
			box-sizing:border-box;
		}
		.error {
			color:#D00;
		}
		#messageBanner p {
			margin-top:0.25em;
			margin-bottom:0.25em;
		}
		#messageBanner h3 {
			margin-top:0.25em;
			margin-bottom:0.25em;
		}
		#main-container .row button {
			font-size: 16px;
			height: 38px;
			border-radius: 6px;
			background: linear-gradient(#4dbed3,#007ea5);
			box-shadow:none;
			border:0px;
			color:#FFF;
		}
		#main-container .row button:hover:enabled {
			background: linear-gradient(#2fa8be,#005772);
		}
		#switchId button span.fa {
			display:none;
		}
		#switchId button span.fa-check-square {
			display:none;
		}
		#cancelButton button span.fa {
			display:none;
		}
		.transactiondetails ul {
			list-style-type: none;
			padding-left: 0px;
		}
		.transactiondetails ul li {
			width:100%;
			text-align: left;
		}
		.transactiondetails ul li label {
			display:block;
			float:left;
			width:180px;
			text-align: right;
			font-size:14px;
			color: #909090;
			margin-right:0.5em;
		}
		.transactiondetails ul li span.value {
			clear:both;
			text-align: left;
			margin-left:0.5em;
		}
		a {
			color:#000;
			text-decoration:none;
		}
		a:hover {
			color:#000;
			border-bottom:1px dotted black;
		}
		#main-container .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container .row .left span {
			margin-right:0.5em
		}
		#main-container .row .back-link {
			text-align:left;
			float:left;
		}
		#main-container	  .row .back-link button {
			border-style:none;
			background:none;
			padding:0px;
			color:#06c2d4;
		}
		#main-container .row .back-link span {
			text-align:left;
		}
		#main-container	  .row .back-link span.fa-ban {
			display:none;
		}
		#main-container .row .submit-btn {
			text-align:right;
			float:right;
		}
		.mtan-input {
			padding-top:25px;
			padding-bottom:10px;
		}
		.resendTan {
			display: block;
			margin-left:196px;
			margin-top: 10px;
			margin-bottom: 25px;
		}
		.input-label {
			display:flex;
			flex-direction: row;
			align-items: center;
		}
		.resendTan a {
			color:#06c2d4;
		}
		.mtan-label {
			text-align:right;
			flex: 0 0 180px
		}
		.btn {
			border-radius: 0px;
			text-align: left;
		}
		#main-container #footer .help-area {
			display:flex;
			flex-direction: row;
			padding:16px;
		}
		#main-container #helpButton	 button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #helpButton	 button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton .fa-info {
			display:none;
		}
		.help-link {
			width:30%;
			order:2;
			text-align:right
		}
		.contact {
			width:70%;
			order:1;
		}
		#otp-error-message {
			margin-top: 10px;
			position: relative;
			background-color: #F5F5F5;
			text-align: center;
			width:300px;
			margin-left:56px;
			padding:12px;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #F5F5F5;
			border-top: 0;
			margin-left: 166px;
			margin-top: -10px;
		}
		#otp-error-message p {
			color:#D00;
		}
		@media (max-width: 560px) {
			#main-container { width:auto; }
			body{ font-size:14px; }
			#header { height:65px; }
			transactiondetails ul li { text-align:left; }
			transactiondetails ul li label { display:block; float:left; width:50%; text-align: right; font-size:14px; color: #909090; margin-right:0.5em; }
			.transactiondetails ul li span.value { clear:both; text-align: left; margin-left:0.5em; }
			.row { width:auto; clear:none; }
			.row .back-link { float:none; text-align:center; padding-top:0.5em; }
			.row .submit-btn { float:none; text-align:center; padding-bottom:0.5em; }
			.row button { width:90%; }
			.mtan-input { display: flex; flex-direction: column; width:100%; padding-bottom:1em; padding-top:1em; }
			.resendTan { margin-left: 0px; flex-grow: 2; text-align: center; }
			.resendTan a { color:#06c2d4; margin-left: 90px; padding-left: 16px; }
			.mtan-label { flex: 0 0 90px; }
			.input-label { justify-content: center; }
			#main-container #footer { width:100%; background-image:none; background-color:#F5F5F5; clear:both; height:unset; }
			#main-container #footer .help-area { display:flex; flex-direction: column; padding:16px; text-align:center; }
			.help-link { width:100%; order:2; text-align:center; padding-top:1em; }
			.contact { width:100%; order:1; }
			#main-container #footer .small-font { font-size:0.75em; }
			#otp-error-message { margin-top:0px; position: relative; background-color: #F5F5F5; text-align:center; width:100%; margin-left:0px; margin-bottom:16px; box-sizing:border-box; }
			#otp-error-message:after { content: ''''; position: absolute; top: 0; left: 0px; width: 0; height: 0; border: 10px solid transparent; border-bottom-color: #F5F5F5; border-top: 0; margin-left: 50%; margin-top: -10px; }
		}
		@media all and (max-width: 601px) {
			.btn{white-space: nowrap;}
			.message {padding: 5px;padding-bottom: 0px;}
			.spinner{margin-bottom: 30px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 14px;}
			.row button { width:95%; }
			#issuerLogo { max-height: 50px; }
			#networkLogo { max-height: 50px; }
		}

		@media all and (max-width: 501px) {
			.btn{white-space: nowrap;}
			.message {padding: 0px;padding-bottom: 0px;}
			.spinner{margin-bottom: 30px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 14px;}
			.row button { width:95%; }
		}
		@media all and (max-width: 480px) {
			span#info-icon {display: inline;}
		}
		@media all and (max-width: 391px){
			.btn{white-space: nowrap;}
			.message {margin-left: 0px;padding: 0px;padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#newLine {display: none;}
			.row button { width:95%; }
			#messageBanner {margin-top:0px;margin-bottom:0px;}
			#pageHeader { height: 70px; }
			#networkLogo { max-height: 35px;}
			#issuerLogo { max-height: 35px;}
			span#info-icon {display: none;}
		}

		@media all and (max-width: 251px) {
			.btn{white-space: inherit;}
			.message {margin-left: 0px;padding: 0px;padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: left;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#main-container .row .back-link button {font-size: 12px;}
			#main-container #helpButton button span {font-size: 12px;}
			#main-container .help-link {width: 100%;text-align: center;}
			message-banner #spinner-row{height: 50px;}
			#main-container #message-container {width: 100%; }
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#newLine {display: none;}
			#pageHeader { height: 60px; }
			#issuerLogo { max-height: 30px; }
			#networkLogo { max-height: 30px; }
			span#info-icon {display: none;}
		}
	 </style>
	'
where fk_id_layout = @pageLayoutIdPolling;

SET @passwordPageType = 'EXT_PASSWORD_OTP_FORM_PAGE';
SET @pageLayoutIdPassword = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'EXT Password OTP Form Page for(Consorsbank)' AND `pageType` = @passwordPageType);

UPDATE `CustomComponent`
SET `value` = '
	<div id="main-container" class="" ng-style="style" class="ng-scope">
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
		<div id="content">
			<message-banner></message-banner>
			<div id="contentHeader">
				<h2><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h2>
			</div>
			<div  id="transactionDetails">
					<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					<span class="clear"></span>
			</div>
			<div id="contentMain">
				<h2><custom-text custom-text-key="''network_means_pageType_3''"></custom-text></h2>
				<custom-text custom-text-key="''network_means_pageType_11''" id="paragraph1"></custom-text>
				<div id="otp-input">
					<custom-text custom-text-key="''network_means_pageType_55''"></custom-text>
					<pwd-form hide-input="true"></pwd-form>
				</div>
				<div class="flex-right">
					<div id="val-button-container">
						<val-button id="validateButton" val-label="''network_means_pageType_18''"></val-button>
					</div>
				</div>
			</div>
			<div id="form-controls">
				<div class="row">
					<div class="back-link">
						<span class="fa fa-angle-left"></span><cancel-button cn-label="''network_means_pageType_4''"></cancel-button>
				   </div>
				</div>
			</div>
		</div>
		<div id="footer">
			<div class="help-area">
				<div class="help-link">
					<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
					<span class="fa fa-angle-right"></span>
				</div>
				<div class="contact">
					<div class="line bottom-margin">
						<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
					</div>
					<div class="line small bold">
						<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
					</div>
					<div class="line small grey">
						<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
					</div>
				</div>
			</div>
			<div id="copyright" class="extra-small">
				<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
				<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
			</div>
		</div>
	</div>
	<style>
		#main-container {
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			padding: 7px 10px 5px;
			height: 20px;
			box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
		}

		#main-container .clear {
			clear:both;
			display:block;
		}
		#main-container #content #contentMain {
			margin-top:1em;
			background-color: #f7f7f7;
			border-radius:1em;
			padding:1em;
			display: flex;
			flex-direction:column;
		}
		#main-container #content #contentMain .flex-right{
			align-self: center;
		}
		#main-container	  #content {
			text-align:center;
		}
		#main-container #content h2 {
			font-size: 1.25em;
			margin-top: 8px;
			margin-bottom: 0.25em;
		}
		#main-container .menu-title {
			display:none;
		}
		#main-container #resend button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #resend button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton	 button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #helpButton	 button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton .fa-info {
			display:none;
		}
		#main-container #otp-input {
			display: flex;
			flex-direction: row;
			justify-content: center;
			margin-top: 10px;
			align-self: center;
		}
		#main-container	  .help-link {
			width: 30%;
			order: 2;
			text-align: right;
		}
		#main-container	  .contact {
			width: 70%;
			order: 1;
		}
		#main-container	  .resendTan {
			display:block;
			margin-left:196px;
			margin-top:10px;
			margin-bottom: 25px;
		}
		#main-container	  .input-label {
			display:flex;
			flex-direction: row;
			align-items: center;
		}
		#main-container	  .otp-input input {
			margin-left:16px;
		}
		#main-container	  #otp-input span {
			padding-right:10px;
		}
		#main-container	  #otp-input input:focus {
			outline:none;
		}
		#main-container	  div#footer {
			background-image:none;
			height:100%;
		}
		#main-container	  #footer {
			width:100%;
			background-color: #f7f7f7;
			border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
		#main-container	  #footer:after {
			content: "";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container	  #footer .extra-small {
			font-size:0.7em;
		}
		#main-container	  #footer .small {
			font-size:0.8em;
		}
		#main-container	  #footer .bold {
			font-weight: bold;
		}
		#main-container	 #footer .grey {
			color: #6b6b6b;
		}
		#main-container	  #footer .bottom-margin {
			margin-bottom:10px;
		}
		#main-container	  #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
		#main-container	  #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container	  #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container	 #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
		#main-container	  .col-lg-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-md-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-sm-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-xs-12 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
		#main-container	  .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container	  .row .left span {
			margin-right:0.5em
		}
		#main-container	  .row .back-link {
			text-align:left;
			float:left;
		}
		#main-container	  .row .back-link button {
			border-style:none;
			padding:0px;
			color:#06c2d4;
		}
		#main-container	  .row .back-link span {
			text-align:left;
			margin-left:0.5em;
		}
		#main-container	  .row .back-link span.fa-ban {
			display:none;
		}
		#main-container	  .row .submit-btn {
			text-align:right;
			float:right;
		}
		#main-container #val-button-container {
			margin-top:10px;
			margin-bottom:10px;
		}
		#main-container #validateButton button {
			font-size: 16px;
			height: 30px;
			line-height:1.0;
			border-radius: 6px;
			background: linear-gradient(#4dbed3,#007ea5);
			box-shadow: none;
			border: 0px;
			color: #FFF;
			width:163px;
		}
		#main-container	 #validateButton span.fa-check-square{
			display:none;
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

		@media all and (max-width: 601px) {
			.btn{white-space: nowrap;}
			.message {margin-left: 80px;
			padding: 5px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 30px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;padding-top: 0px;}
			body {font-size: 14px;}
			#messageBanner {margin-top:10px;margin-bottom:10px;}
			#main-container {width:auto;}
			#main-container #otp-input {display: flex;}
			main-container	 .row .back-link button{width: 100%;}
			#main-container #footer .help-area {display: flex;}

			#pageHeader { height: 85px; }
			#issuerLogo { max-height: 50px; }
			#networkLogo { max-height: 50px; }
		}
		@media all and (max-width: 501px) {
			.btn{white-space: nowrap;}
			.message {margin-left: 80px;
			padding: 5px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 30px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 14px;}
			#messageBanner {margin-top:10px;margin-bottom:10px;}
			#main-container {width:auto;}
			#main-container #otp-input {display: flex;}
			main-container	.row .back-link button{width: 100%;}
			#main-container #footer .help-area {display: flex;}

			#pageHeader { height: 70px; }
			#issuerLogo { max-height: 40px; }
			#networkLogo { max-height: 40px; }
		}
			@media all and (max-width: 480px) {
			span#info-icon {display: inline;}
		}
		@media all and (max-width: 391px){
			.btn{white-space: nowrap;}
			.message {margin-left: 20px;
			padding: 0px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#newLine {display: none;}
			.row button { width:95%; }
			#messageBanner {margin-top:0px;margin-bottom:0px;}
			#pageHeader { height: 70px; }
			#networkLogo { max-height: 35px;}
			#issuerLogo { max-height: 35px;}
			span#info-icon {display: none;}
		}

		@media all and (max-width: 251px) {
			.btn{white-space: inherit;}
			.message {margin-left: 0px;
			padding: 0px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: left;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#main-container .row .back-link button {font-size: 12px;}
			#main-container #helpButton button span {font-size: 12px;}
			#main-container .help-link {width: 100%;text-align: center;}
			message-banner #spinner-row{height: 50px;}
			#main-container #message-container {width: 100%; }
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#newLine {display: none;}
			#pageHeader { height: 60px; }
			#issuerLogo { max-height: 30px; }
			#networkLogo { max-height: 30px; }
			span#info-icon {display: none;}
		}
	</style>
' where fk_id_layout = @pageLayoutIdPassword;


SET @otpFormPageType = 'OTP_FORM_PAGE';
SET @pageLayoutIdOtpForm = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'OTP Form Page (Consorsbank)' AND `pageType` = @otpFormPageType);

UPDATE `CustomComponent`
SET `value` = '
	<div id="main-container" class="" ng-style="style" class="ng-scope">
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
		<div id="content">
			<message-banner></message-banner>
			<div id="contentHeader">
				<h2><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h2>
			</div>
			<div  id="transactionDetails">
					<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					<span class="clear"></span>
			</div>
			<div id="contentMain">
				<h2><custom-text custom-text-key="''network_means_pageType_3''"></custom-text></h2>
				<custom-text custom-text-key="''network_means_pageType_11''" id="paragraph1"></custom-text>
				<div class="flex-right">
					<re-send-otp id="resend" rso-Label="''network_means_pageType_19''"></re-send-otp>
				</div>
				<div id="otp-input">
					<custom-text custom-text-key="''network_means_pageType_53''"></custom-text>
					<otp-form ></otp-form>
				</div>
				<div class="flex-right">
					<div id="val-button-container">
						<val-button id="validateButton" val-label="''network_means_pageType_18''"></val-button>
					</div>
				</div>
			</div>
			<div id="form-controls">
				<div class="row">
					<div class="submit-btn">

					</div>
					<div class="back-link">
						<span class="fa fa-angle-left"></span><cancel-button cn-label="''network_means_pageType_4''"></cancel-button>
				   </div>
				</div>
			</div>
		</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
						<span class="fa fa-angle-right"></span>
					</div>
					<div class="contact">
						<div class="line bottom-margin">
							<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
						</div>
						<div class="line small bold">
							<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
						</div>
						<div class="line small grey">
							<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
						</div>
					</div>
				</div>
				<div id="copyright" class="extra-small">
					<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
					<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
				</div>
			</div>
		</div>
	</div>
	<style>
		#main-container {
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			padding: 7px 10px 5px;
			width: 120px;
			height: 20px;
			box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
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


		#main-container .clear {
			clear:both;
			display:block;
		}
		#main-container #content #contentMain {
			margin-top:1em;
			background-color: #f7f7f7;
			border-radius:1em;
			padding:1em;
			display: flex;
			flex-direction:column;
		}
		#main-container #content #contentMain .flex-right{
			align-self: center;
			margin-top: 10px;
		}
		#main-container	  #content {
			text-align: center;
			margin-top: 10px;
		}
		#main-container #content h2 {
			font-size: 1.25em;
			margin-top: 8px;
			margin-bottom: 0.25em;
		}
		#main-container .menu-title {
			display:none;
		}
		#main-container #resend button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #resend button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton	 button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #helpButton	 button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton .fa-info {
			display:none;
		}
		#main-container #otp-input {
			display: flex;
			flex-direction: row;
			justify-content: center;
			margin-top: 10px;
			align-self: center;
		}
		#main-container	  .help-link {
			width: 30%;
			order: 2;
			text-align: right;
		}
		#main-container	  .contact {
			width: 70%;
			order: 1;
		}
		#main-container	  .resendTan {
			display:block;
			margin-left:196px;
			margin-top:10px;
			margin-bottom: 25px;
		}
		#main-container	  .input-label {
			display:flex;
			flex-direction: row;
			align-items: center;
		}
		#main-container	  .otp-input input {
			margin-left:16px;
		}
		#main-container	  #otp-input span {
			padding-right:10px;
		}
		#main-container	  #otp-input input:focus {
			outline:none;
		}
		#main-container	  div#footer {
			background-image:none;
			height:100%;
		}
		#main-container	  #footer {
			width:100%;
			background-color: #f7f7f7;
			border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
		#main-container	  #footer:after {
			content: "";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container	  #footer .extra-small {
			font-size:0.7em;
		}
		#main-container	  #footer .small {
			font-size:0.8em;
		}
		#main-container	  #footer .bold {
			font-weight: bold;
		}
		#main-container	 #footer .grey {
			color: #6b6b6b;
		}
		#main-container	  #footer .bottom-margin {
			margin-bottom:10px;
		}
		#main-container	  #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
		#main-container	  #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container	  #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container	 #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
		#main-container	  .col-lg-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-md-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-sm-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-xs-12 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
		#main-container	  .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container	  .row .left span {
			margin-right:0.5em
		}
		#main-container	  .row .back-link {
			text-align:left;
			float:left;
		}

		#main-container	  .row .back-link button {
			border-style:none;
			padding:0px;
			color:#06c2d4;
		}
		#main-container	  .row .back-link span {
			text-align:left;
			margin-left:0.5em;
		}

		#main-container	  .row .back-link span.fa-ban {
			display:none;
		}

		#main-container	  .row .submit-btn {
			text-align:right;
			float:right;
		}
		#main-container #val-button-container {
			margin-top:10px;
			margin-bottom:10px;
		}
		#main-container #validateButton button {
			font-size: 16px;
			height: 30px;
			line-height:1.0;
			border-radius: 6px;
			background: linear-gradient(#4dbed3,#007ea5);
			box-shadow: none;
			border: 0px;
			color: #FFF;
			width:163px;
		}
		#main-container	  #validateButton span.fa-check-square{
			display:none;
		}
		@media all and (max-width: 601px) {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			#otp-form{ display:block; width:120px; margin-left:auto; margin-right:auto; }
			#otp-form input { width: 120px;; }
			div#otp-fields { width:80%; }
			#validateButton { display:block; width:150px; margin-left:auto; margin-right:auto; }
			#validateButton button { width:100%; }
			#main-container #content #contentMain .flex-right{align-self: center;margin-top: 10px;}
			#main-container #otp-input {margin-top: 10px;align-self: center;}

			#pageHeader { height: 85px; }
			#issuerLogo { max-height: 50px; }
			#networkLogo { max-height: 50px; }
		}
		@media all and (max-width: 501px) {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			#otp-form{ display:block; width:120px; margin-left:auto; margin-right:auto; }
			#otp-form input { width: 120px;; }
			div#otp-fields { width:80%; }
			#validateButton { display:block; width:150px; margin-left:auto; margin-right:auto; }
			#validateButton button { width:100%; }
			#main-container #content #contentMain .flex-right{align-self: center;margin-top: 10px;}
			#main-container #otp-input {margin-top: 10px;align-self: center;}

			#pageHeader { height: 70px; }
			#issuerLogo { max-height: 40px; }
			#networkLogo { max-height: 40px; }
		}
			@media all and (max-width: 480px) {
			span#info-icon {display: inline;}
		}
		@media all and (max-width: 391px){
			.btn{white-space: nowrap;}
			.message {margin-left: 20px;
			padding: 0px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#newLine {display: none;}
			.row button { width:95%; }
			#messageBanner {margin-top:0px;margin-bottom:0px;}
			#pageHeader { height: 70px; }
			#networkLogo { max-height: 35px;}
			#issuerLogo { max-height: 35px;}
			span#info-icon {display: none;}
		}

		@media all and (max-width: 251px) {
			.btn{white-space: inherit;}
			.message {margin-left: 0px;
			padding: 0px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: left;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#main-container .row .back-link button {font-size: 12px;}
			#main-container #helpButton button span {font-size: 12px;}
			#main-container .help-link {width: 100%;text-align: center;}
			message-banner #spinner-row{height: 50px;}
			#main-container #message-container {width: 100%; }
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#newLine {display: none;}
			#pageHeader { height: 60px; }
			#issuerLogo { max-height: 30px; }
			#networkLogo { max-height: 30px; }
			span#info-icon {display: none;}
		}
		</style>
' where fk_id_layout = @pageLayoutIdOtpForm;

SET @photoTanPageType = 'PHOTO_TAN_OTP_FORM_PAGE';
SET @pageLayoutIdPhotoTan = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'Photo Tan Page (Consorsbank)' AND `pageType` = @photoTanPageType);

UPDATE `CustomComponent`
SET `value` = '
<div id="main-container">
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
	<div id="content">
		<message-banner></message-banner>
			<div id="contentHeader">
                <h2>
                    <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
                </h2>
			</div>

			<div id="transactionDetails">
				<side-menu></side-menu>
			</div>
			<span class="clear"></span>

			<div id="contentMain">
                <h2>
                    <custom-text custom-text-key="''network_means_pageType_3''" id="paragraph1"></custom-text>
                </h2>

            <div id="qrcontrols">
				<div id="form-input">
					<div><custom-text custom-text-key="''network_means_pageType_11''" id="paragraph1"></custom-text></div>
                        <div id="otp-input">
                            <custom-text custom-text-key="''network_means_pageType_18''" id="paragraph1"></custom-text>
                            <otp-form></otp-form>
                        </div>
                            <div id="val-button-container"><val-button id="validateButton" val-label="''network_means_pageType_19''"></val-button></div>
                </div>
				<div id="qr-display">
					<external-image></external-image>
				</div>

                </div>
            </div>

		<div id="form-controls">
			<div id="form-controls-container">
                    <div class="back-link">
                        <span class="fa fa-angle-left"></span>
                        <cancel-button cn-label="''network_means_pageType_55''" id="cancelButton" ></cancel-button>
                    </div>
			</div>
		</div>

		div id="footer">
			<div class="help-area">
				<div class="help-link">
					<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
					<span class="fa fa-angle-right"></span>

				</div>
                    <div class="contact">
                            <div class="line bottom-margin">
                                <custom-text custom-text-key="''network_means_pageType_6''"></custom-text>

				</div>
            <div class="line small bold">

					<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
                    </div>
						<div class="line small grey">
                                <div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
						</div>
                    </div>
				</div>
			<div id="copyright" class="extra-small">
				<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
				<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
			</div>
		</div>
</div>
<style>
  /* Switchpoints: 780, */
    :root {
        font-family: proximaLight, Times;
        padding:0px;
        margin:0px;
    }
    #main-container {
        width:760px;
        margin-left:auto;
        margin-right:auto;
        padding-left:10px;
        padding-right:10px;
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

	#main-container	#content {
		text-align:left;
	}
	#main-container .leftMenuLayout {
		clear:both
	}
	#main-container	#content #contentHeader {
		margin-bottom:0.25em;
		margin-top:0.25em;
	}

	#main-container	#content  #transactionDetails {
		margin-bottom: 1em;
		width: 100%;
	}

	#main-container .clear {
		clear:both;
		display:block;
	}

	#main-container #content #contentMain {
		margin-top:1em;
		background-color: #f7f7f7;
		border-radius:0.25em;
		padding:1em;
	}

	#main-container #qrcontrols {
		display:flex;
		flex-direction:row;
	}

	#main-container #form-input {
		align-items: start;
		display: flex;
		flex-direction: column;
	}

	#main-container #otp-input {
		display: flex;
		flex-direction: row;
		justify-content: flex-end;
		margin-top: 10px;
		align-self: flex-end;
	}

	#main-container #otp-form {
		margin-left:10px;
	}

	#main-container #qr-display {
		display:flex;
		justify-content:center;
	}


    #content {
        text-align:left;
    }
    #content h2 {
        font-size:1.25em;
		margin-top:0px;
		margin-bottom:0.25em;
    }

	#main-container	#footer {
		width:100%;
		background-color: #f7f7f7;
		margin-top:1em;
		border-radius: 1em;
		background-image:none;
		height: auto;
	}
	#main-container	#footer:after {
		content: "";
		height:100%;
		display: table;
		padding-bottom: 0.5em;
	}
	#main-container	  #footer .extra-small {
		font-size:0.7em;
	}
	#main-container	  #footer .small {
		font-size:0.8em;
	}
	#main-container	  #footer .bold {
		font-weight: bold;
	}

	#main-container	 #footer .grey {
        color: #6b6b6b;
	}

	#main-container	  #footer .bottom-margin {
        margin-bottom:10px;
	}
	#main-container	  #footer #copyright {
		width:100%;
		border-top : 1px solid #6b6b6b;
		padding-top:0.5em;
		padding-bottom:1em;
		display:flex;
		flex-direction: row;
	}
	#main-container	 #footer #copyright div:nth-child(1) {
		order:1;
		text-align:left;
		width:50%;
		padding-left:12px;
	}
	#main-container	 #footer #copyright div:nth-child(2) {
		order:2;
		text-align: right;
		width:50%;
		padding-right:12px;
	}
	#main-container	#footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}

	#main-container #helpButton	 button span{
		color:#06c2d4;
		background-color: #f7f7f7;
	}

	#main-container #helpButton	 button {
		border-style: none;
		padding:0px
	}

	#main-container #helpButton .fa-info {
		display:none;
	}

	#main-container .externalImage {
		padding: 1em;
		width:100%;
		min-width:268px;
		margin-left:auto;
		margin-right:auto;
	}
	p {
		margin-bottom:10px;
    }
	.splashtext {
		width:80%;
		margin-left:auto;
		margin-right:auto
    }
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
    }
	#main-container .row button {
		font-size: 16px;
		height: 38px;
		border-radius: 6px;
		background: linear-gradient(#4dbed3,#007ea5);
		box-shadow:none;
		border:0px;
		color:#FFF;
    }
	#main-container .row button:hover:enabled {
		background: linear-gradient(#2fa8be,#005772);
    }

	a {
		color:#000;
		text-decoration:none;
    }
	a:hover {
		color:#000;
		border-bottom:1px dotted black;
    }
	#main-container .row .left {
		float:left;
		width:180px;
		text-align:right;
    }

	#main-container .row .left span {
		margin-right:0.5em
    }

	#main-container #form-controls-container {
		display:flex;
		justify-content: space-between;
	}

	#form-controls {
	}

    #main-container	 #form-controls .back-link button:hover {
        background: linear-gradient(#2fa8be,#005772);
    }

	#main-container #form-controls .back-link {
		text-align:left;
    }

    #main-container	 #form-controls .back-link button {
		border-style:none;
		background:none;
		padding:0px;
		color:#06c2d4;
	}
	#main-container #form-controls .back-link span {
		text-align:left;
		margin-left:0.5em;
    }
    #main-container	 #form-controls .back-link span.fa-ban {
		display:none;
	}

	#main-container #form-controls .submit-btn {
		text-align:right;
    }

	.mtan-input {
		padding-top:25px;
		padding-bottom:10px;
    }
	.resendTan {
		display: block;
		margin-left:196px;
		margin-top: 10px;
		margin-bottom: 25px;
    }
	.input-label {
		display:flex;
		flex-direction: row;
		align-items: center;
    }
	.resendTan a {
		color:#06c2d4;
    }
	.mtan-label {
		text-align:right;
		flex: 0 0 180px
    }
	.otp-field input {
		margin-left:16px;
    }
	.otp-field input:focus {
		outline:none;
    }

	.help-link {
		width:30%;
		order:2;
		text-align:right
    }
	.contact {
		width:70%;
		order:1;
    }
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #F5F5F5;
		text-align: center;
		width:300px;
		margin-left:56px;
		padding:12px;
    }
	#otp-error-message:after {
		content: '';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
    }
	#otp-error-message p {
			color:#D00;
	}

	#main-container #validateButton {
		margin-top:10px;
		margin-bottom:10px;
	}

	#main-container #validateButton button {
		font-size: 16px;
		height: 30px;
		line-height:1.0;
		border-radius: 6px;
		background: linear-gradient(#4dbed3,#007ea5);
		box-shadow: none;
		border: 0px;
		color: #FFF;
		width:163px;
	}

	#main-container	  #validateButton span.fa-check-square{
		display:none;
	}


	#main-container #val-button-container {
		align-self: flex-end;
		margin-top: 10px;
		margin-bottom: 10px;
	}

	@media (max-width: 760px) {
        #main-container {width:auto;}
        body {font-size:14px;}
        #schemeLogo {margin-top:1em;width:70px;height:70px;}
        .transactiondetails ul li {text-align:left;}
        .transactiondetails ul li label {display:block;float:left;width:50%;text-align: right;font-size:14px;color: #909090;margin-right:0.5em;}
        .transactiondetails ul li span.value {clear:both;text-align: left;margin-left:0.5em;}
        .row {width:auto;clear:none;}
        .row .back-link {float:none;text-align:center;padding-top:0.5em;}
        .row .submit-btn {float:none;text-align:center;padding-bottom:0.5em;}
        .row button {width:100%;}
        .mtan-input {display: flex;flex-direction: column;width:100%;padding-bottom:1em;padding-top:1em;}
        .resendTan {margin-left: 0px;flex-grow: 2;text-align: center;}
        .resendTan a {color:#06c2d4;margin-left: 90px;padding-left: 16px;}
        .mtan-label {flex: 0 0 90px;}
        .input-label {justify-content: center;}
        .otp-field {display:inline;}
        .otp-field input {}
        #main-container #footer {width:100%;background-image:none;background-color:#F5F5F5;height:unset;}
        #main-container #footer .help-area {display:flex;flex-direction: column;padding:16px;text-align:center;}
        #main-container #helpButton	 button span{color:#06c2d4;background-color: #f7f7f7;}
        #main-container #helpButton	 button {border-style: none;padding:0px}
        #main-container #helpButton .fa-info {display:none;}
        .help-link {width:100%;order:2;text-align:center;padding-top:1em;}
        .contact {width:100%;order:1;}
        #main-container #footer .small-font {font-size:0.75em;}
        #otp-error-message {margin-top:0px;position: relative;background-color: #F5F5F5;text-align:center;width:100%;margin-left:0px;margin-bottom:16px;box-sizing:border-box;}
        #otp-error-message:after {content: '';position: absolute;top: 0;left: 0px;width: 0;height: 0;border: 10px solid transparent;border-bottom-color: #F5F5F5;border-top: 0;margin-left: 50%;margin-top: -10px;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
        #main-container .externalImage {width:100%;min-width:200px;}

    }

    @media all and (max-width: 601px) {
		span#info-icon {display: inline;}
		#main-container .externalImage {width:100%;min-width:180px;}
		#helpButton #help-container #helpContent #helpCloseButton button {text-align: center;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
        #main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
		#networkLogo { max-height: 65px;}
		#issuerLogo { max-height: 65px;}
        #main-container #otp-input {display: inherit;}
        #main-container #form-input {display: initial;}
	}

    media (max-width: 560px) {
		#main-container { width:auto; }
		body{ font-size:14px; }
		#header { height:65px; }
		transactiondetails ul li { text-align:left; }
		transactiondetails ul li label { display:block; float:left; width:50%; text-align: right; font-size:14px; color: #909090; margin-right:0.5em; }
		.transactiondetails ul li span.value { clear:both; text-align: left; margin-left:0.5em; }
		.row { width:auto; clear:none; }
		.row .back-link { float:none; text-align:center; padding-top:0.5em; }
		.row .submit-btn { float:none; text-align:center; padding-bottom:0.5em; }
		.row button { width:90%; }
		.mtan-input { display: flex; flex-direction: column; width:100%; padding-bottom:1em; padding-top:1em; }
		.resendTan { margin-left: 0px; flex-grow: 2; text-align: center; }
		.resendTan a { color:#06c2d4; margin-left: 90px; padding-left: 16px; }
		.mtan-label { flex: 0 0 90px; }
		.input-label { justify-content: center; }
		#main-container #footer { width:100%; background-image:none; background-color:#F5F5F5; clear:both; height:unset; }
		#main-container #footer .help-area { display:flex; flex-direction: column; padding:16px; text-align:center; }
		.help-link { width:100%; order:2; text-align:center; padding-top:1em; }
		.contact { width:100%; order:1; }
		#main-container #footer .small-font { font-size:0.75em; }
		#otp-error-message { margin-top:0px; position: relative; background-color: #F5F5F5; text-align:center; width:100%; margin-left:0px; margin-bottom:16px; box-sizing:border-box; }
		#otp-error-message:after { content: ''''; position: absolute; top: 0; left: 0px; width: 0; height: 0; border: 10px solid transparent; border-bottom-color: #F5F5F5; border-top: 0; margin-left: 50%; margin-top: -10px; }
		#helpButton #help-container #helpContent #helpCloseButton button {text-align: center;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
        #main-container .externalImage {width:100%;min-width:160px;max-width: 160px;}
        #main-container #otp-input {display: inherit;}
        #main-container #form-input {display: initial;}
		#networkLogo { max-height: 55px;}
		#issuerLogo { max-height: 55px;}
	}

	@media all and (max-width: 501px) {
		span#info-icon {display: inline;}
		#main-container .externalImage {width:100%;min-width:150px;max-width: 150px;}
		#helpButton #help-container #helpContent #helpCloseButton button {text-align: center;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
        #main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
        #main-container #otp-input {display: inherit;}
        #main-container #form-input {display: initial;}
		#networkLogo { max-height: 50px;}
		#issuerLogo { max-height: 50px;}
	}
	@media all and (max-width: 480px) {
		span#info-icon {display: inline;}
		#main-container .externalImage {width:100%;min-width:150px;max-width: 150px;}
		#helpButton #help-container #helpContent #helpCloseButton button {text-align: center;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
        #main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
        #main-container #otp-input {display: inherit;}
        #main-container #form-input {display: initial;}
		#networkLogo { max-height: 45px;}
		#issuerLogo { max-height: 45px;}
	}
	@media all and (max-width: 391px){
		.btn{white-space: nowrap;}
		.message {margin-left: 0px;padding: 0px;padding-bottom: 0px;}
		.spinner{margin-bottom: 20px;}
		#content {text-align: center;}
		div#message-content{padding-bottom: 0px;padding-top: 0px;}
		div#message-controls {padding-top: 0px;}
		body {font-size: 12px;}
		#newLine {display: none;}
		.row button { width:95%; }
		#messageBanner {margin-top:0px;margin-bottom:0px;}
		#pageHeader { height: 70px; }
		#networkLogo { max-height: 35px;}
		#issuerLogo { max-height: 35px;}
		span#info-icon {display: none;}
		#main-container .externalImage {width:100%;min-width:120px;max-width: 120px;}
		#helpButton #help-container #helpContent #helpCloseButton button {text-align: center;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
        #main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
        #main-container #otp-input {display: inherit;}
        #main-container #form-input {display: initial;}
	}

	@media all and (max-width: 251px) {
		.btn{white-space: inherit;}
		.message {margin-left: 0px;padding: 0px;padding-bottom: 0px;}
		.spinner{margin-bottom: 20px;}
		#content {text-align: left;}
		div#message-content{padding-bottom: 0px;padding-top: 0px;}
		div#message-controls {padding-top: 0px;}
		body {font-size: 12px;}
		#main-container .row .back-link button {font-size: 12px;}
		#main-container #helpButton button span {font-size: 12px;}
		#main-container .help-link {width: 100%;text-align: center;}
		message-banner #spinner-row{height: 50px;}
		#main-container #message-container {width: 100%; }
		#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
		#newLine {display: none;}
		#pageHeader { height: 60px; }
		#issuerLogo { max-height: 30px; }
		#networkLogo { max-height: 30px; }
		span#info-icon {display: none;}
		#main-container .externalImage {width:100%;min-width:100px;max-width:100px;}
		#helpButton #help-container #helpContent #helpCloseButton button {text-align: center;}
        #main-container #qrcontrols {display:flex;flex-direction:column;}
	}
</style>
' where fk_id_layout = @pageLayoutIdPhotoTan;

SET @failurePageType = 'FAILURE_PAGE';
SET @pageLayoutIdFailure = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'Failure Page (Consorsbank)' AND `pageType` = @failurePageType);

UPDATE `CustomComponent`
SET `value` = '
	<div id="main-container" ng-style="style" class="ng-scope">
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
		<hamburger hamburger-text-key="''network_means_pageType_1''" ></hamburger>
		<message-banner></message-banner>
		<div id="mainLayout" class="row">
			<div id="content">
				<div id="contentHeaderLeft">
					<div class="paragraph">
						<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
					</div>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
			</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
						<span class="fa fa-angle-right"></span>
					</div>
					<div class="contact">
						<div class="line bottom-margin">
							<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>

						</div>
						<div class="line small bold">

							<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
						</div>
						<div class="line small">
							<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
						</div>
					</div>
				</div>
				<div id="copyright" class="extra-small">
					<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
					<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
				</div>
			</div>
		</div>
	</div>
	<style>
		:root {
			 font-family: proximaLight, Times;
			 padding:0px;
			 margin:0px;
		}
		#main-container {
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
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
		#main-container	  #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container	  #content {
			text-align:center;
		}
		#main-container	  #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:1em;
		}
		#main-container	  .paragraph {
			display: block;
			margin-block-start: 1em;
			margin-block-end: 1em;
			margin-inline-start: 0px;
			margin-inline-end: 0px;
			margin-bottom: 10px;
		}
		#main-container .menu-title {
			display:none;
		}
		#main-container	  .help-link {
			width: 30%;
			order: 2;
			text-align: right;
		}
		#main-container	  .contact {
			width: 70%;
			order: 1;
		}
		#main-container	  .mtan-label {
			text-align:right;
			flex: 0 0 180px
		}
		#main-container	  div#footer {
			background-image:none;
			height:100%;
		}
		#main-container	  #footer {
			width:100%;
			background-color: #f7f7f7;
			border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
		#main-container	  #footer:after {
			content: "";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container	  #footer .extra-small {
			font-size:0.7em;
		}
		#main-container	  #footer .small {
			font-size:0.8em;
		}
		#main-container	  #footer .bold {
			font-weight: bold;
		}
		#main-container	 #footer .grey {
			color: #6b6b6b;
		}
		#main-container	  #footer .bottom-margin {
			margin-bottom:10px;
		}
		#main-container	  #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
		#main-container	  #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container	  #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container	 #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
		#main-container #helpButton	 button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #helpButton	 button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton .fa-info {
			display:none;
		}
		#main-container	  .col-lg-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-md-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-sm-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-xs-12 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
		#main-container	  .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container	  .row .left span {
			margin-right:0.5em
		}
		#main-container	  .row .back-link {
			text-align:left;
			float:left;
		}

		#main-container	  .row .back-link button {
			border-style:none;
			padding:0px;
			color:#06c2d4;
		}
		#main-container	  .row .back-link span {
			text-align:left;
			margin-left:0.5em;
		}
		#main-container	  .row .back-link span.fa-ban {
			display:none;
		}
		#main-container	  .row .submit-btn {
			text-align:right;
			float:right;
		}
		#main-container .halfdivsRight {
			width:50%;
			float: right;
		}
		#main-container	 .halfdivsLeft{
			width:50%;
			float: left;
		}
		@media all and (max-width: 601px) {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			#main-container #content #contentMain .flex-right{align-self: center;margin-top: 10px;}
			#main-container .externalImage {width:100%;min-width:100px;}
			#pageHeader { height: 85px; }
			#issuerLogo { max-height: 50px; }
			#networkLogo { max-height: 50px; }
		}
		@media all and (max-width: 501px) {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			#main-container #content #contentMain .flex-right{align-self: center;margin-top: 10px;}
			#main-container .externalImage {width:100%;min-width:100px;}
			#pageHeader { height: 70px; }
			#issuerLogo { max-height: 40px; }
			#networkLogo { max-height: 40px; }
		}
		@media all and (max-width: 480px) {
			span#info-icon {display: inline;}
		}
		@media all and (max-width: 391px) {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			.row {font-size: 11px}
			#pageHeader { height: 70px; }
			#networkLogo { max-height: 35px;}
			#issuerLogo { max-height: 35px;}
			span#info-icon {display: none;}
		}
		@media all and (max-width: 251px) {
			.btn{white-space: inherit;}
			.message {margin-left: 0px;
			padding: 0px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: left;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#main-container .col-sm-4 {padding: 0px; }
			#main-container #footer .small {font-size: 1em}
			#main-container .contact {width:100%;}
			.row {font-size: 10px}
			#main-container #footer .help-area {display: block;}
			#main-container .help-link {width: 100%;text-align: left;}
			#main-container .menu-elements { width: auto; }
			.break-word.ng-scope {width: 100%; display: inline-flex;}
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#main-container #message-container {width: 100%; }
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#pageHeader { height: 60px; }
			#issuerLogo { max-height: 30px; }
			#networkLogo { max-height: 30px; }
			span#info-icon {display: none;}
		}
	</style>
' where fk_id_layout = @pageLayoutIdFailure;


SET @refusalPageType = 'REFUSAL_PAGE';
SET @pageLayoutIdRefusal = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'Refusal Page (Consorsbank)' AND `pageType` = @refusalPageType);

UPDATE `CustomComponent`
SET `value` = '
	<div id="main-container" ng-style="style" class="ng-scope">
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
		<hamburger hamburger-text-key="''network_means_pageType_1''" ></hamburger>
		<message-banner></message-banner>
		<div id="mainLayout" class="row">
			<div id="content">
				<div id="contentHeaderLeft">
					<div class="paragraph">
						<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
					</div>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
			</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
						<span class="fa fa-angle-right"></span>
					</div>
					<div class="contact">
						<div class="line bottom-margin">
							<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
						</div>
						<div class="line small bold">
							<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
						</div>
						<div class="line small">
							<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
						</div>
					</div>
				</div>
				<div id="copyright" class="extra-small">
					<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
					<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
				</div>
			</div>
		</div>
	</div>
	<style>
		:root {
			 font-family: proximaLight, Times;
			 padding:0px;
			 margin:0px;
		}
		#main-container {
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
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
		#main-container	  #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container	  #content {
			text-align:center;
		}
		#main-container	  #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:1em;
		}
		#main-container	  .paragraph {
			display: block;
			margin-block-start: 1em;
			margin-block-end: 1em;
			margin-inline-start: 0px;
			margin-inline-end: 0px;
			margin-bottom: 10px;
		}
		#main-container .menu-title {
			display:none;
		}
		#main-container	  .help-link {
			width: 30%;
			order: 2;
			text-align: right;
		}
		#main-container	  .contact {
			width: 70%;
			order: 1;
		}
		#main-container	  .mtan-label {
			text-align:right;
			flex: 0 0 180px
		}
		#main-container	  div#footer {
			background-image:none;
			height:100%;
		}
		#main-container	  #footer {
			width:100%;
			background-color: #f7f7f7;
			border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
		#main-container	  #footer:after {
			content: "";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container	  #footer .extra-small {
			font-size:0.7em;
		}
		#main-container	  #footer .small {
			font-size:0.8em;
		}
		#main-container	  #footer .bold {
			font-weight: bold;
		}
		#main-container	 #footer .grey {
			color: #6b6b6b;
		}
		#main-container	  #footer .bottom-margin {
			margin-bottom:10px;
		}
		#main-container	  #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
		#main-container	  #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container	  #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container	 #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
		#main-container #helpButton	 button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #helpButton	 button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton .fa-info {
			display:none;
		}
		#main-container	  .col-lg-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-md-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-sm-4 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  .col-xs-12 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container	  message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
		#main-container	  .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container	  .row .left span {
			margin-right:0.5em
		}
		#main-container	  .row .back-link {
			text-align:left;
			float:left;
		}
		#main-container	  .row .back-link button {
			border-style:none;
			padding:0px;
			color:#06c2d4;
		}
		#main-container	  .row .back-link span {
			text-align:left;
			margin-left:0.5em;
		}
		#main-container	  .row .back-link span.fa-ban {
			display:none;
		}
		#main-container	  .row .submit-btn {
			text-align:right;
			float:right;
		}
		#main-container .halfdivsRight {
			width:50%;
			float: right;
		}
		#main-container	 .halfdivsLeft{
			width:50%;
			float: left;
		}
		@media all and (max-width: 601px)
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			#main-container #content #contentMain .flex-right{align-self: center;margin-top: 10px;}
			#main-container .externalImage {width:100%;min-width:100px;}
			.row {font-size: 15px}
			#pageHeader { height: 85px; }
			#issuerLogo { max-height: 50px; }
			#networkLogo { max-height: 50px; }
		}
		@media all and (max-width: 501px) {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			.row {font-size: 15px}
			#pageHeader { height: 70px; }
			#issuerLogo { max-height: 40px; }
			#networkLogo { max-height: 40px; }
		}
		@media all and (max-width: 480px) {
			span#info-icon {display: inline;}
		}
		@media all and (max-width: 391px)  {
			h1 { font-size:18px; }
			#optGblPage	 { font-size:14px;}
			.paragraph { text-align: center; margin-top: 50px; margin-bottom: 10px;}
			.leftColumn { display:block; float:none; width:100%; }
			.rightColumn { display:block; float:none; width:100%; margin-left:0px; text-align:center; }
			div.side-menu div.menu-title { padding-left:0px; text-align:center; }
			side-menu div.text-center { text-align:center; }
			.row {font-size: 11px}
			#main-container	 #issuerLogo { max-height: 52px; margin-top: 5px}
			#pageHeader { height: 70px; }
			#networkLogo { max-height: 35px;}
			#issuerLogo { max-height: 35px;}
			span#info-icon {display: none;}
		}
		@media all and (max-width: 251px) {
			.btn{white-space: inherit;}
			.message {margin-left: 0px;
			padding: 0px;
			padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: left;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#main-container .col-sm-4 {padding: 0px; }
			#main-container #footer .small {font-size: 1em}
			#main-container .contact {width:100%;}
			.row {font-size: 10px}
			#main-container #footer .help-area {display: block;}
			#main-container .help-link {width: 100%;text-align: left;}
			#main-container .menu-elements { width: auto; }
			.break-word.ng-scope {width: 100%; display: inline-flex;}
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#main-container #message-container {width: 100%; }
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#pageHeader { height: 60px; }
			#issuerLogo { max-height: 30px; }
			#networkLogo { max-height: 30px; }
			span#info-icon {display: none;}
		}
	</style>
' where fk_id_layout = @pageLayoutIdRefusal;


SET @helpPageType = 'HELP_PAGE';
SET @pageLayoutIdHelp = (SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = 'Help Page (Consorsbank)' AND `pageType` = @helpPageType);

UPDATE `CustomComponent`
SET `value` = '

	 <div class="container-fluid">
		 <div>
			 <div id="helpContent">
				 <div class="paragraph">
					 <custom-text custom-text-key="''network_means_HELP_PAGE_1''" id="paragraph1">
					 </custom-text>
				 </div>
				 <div class="paragraph">
					 <custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph2">
					 </custom-text>
				 </div>
				 <div class="paragraph">
					 <custom-text custom-text-key="''network_means_HELP_PAGE_3''" id="paragraph3">
					 </custom-text>
				 </div>
				 <div class="paragraph">
					 <custom-text custom-text-key="''network_means_HELP_PAGE_4''" id="paragraph4">
					 </custom-text>
				 </div>
				 <div class="paragraph">
					 <custom-text custom-text-key="''network_means_HELP_PAGE_5''" id="paragraph4">
					 </custom-text>
				 </div>
				 <div class="paragraph">
					<help-close-button help-close-label="''network_means_HELP_PAGE_11''" id="helpCloseButton"></help-close-button>
				 </div>
			 </div>
		 </div>
	 </div>

	 <style>

		#help-container {
			overflow:visible;
		}

		 #helpContent {
			 padding: 5px 10px 0px;
			 min-height: 200px;
			 text-align: justify;
		 }

		 #helpContent #helpCloseButton div {
			display: inline;
		}

		#helpButton #help-container #helpContent #helpCloseButton button{
			font-size: 16px;
			height: 30px;
			line-height: 1.0;
			border-radius: 6px;
			background: linear-gradient(#4dbed3,#007ea5);
			box-shadow: none;
			border: 0px;
			color: #FFF;
			width: 163px;
			text-align: center;
		}

		#helpButton #help-container #helpContent #helpCloseButton button span{

			color:#FFF;
			background:inherit;
		}

		#helpButton	 #help-container #helpContent #helpCloseButton span.fa-times {
			display: none;
		}

		 .paragraph {
			 margin: 0px 0px 10px;
			 text-align: justify;
		 }
	 </style>

' where fk_id_layout = @pageLayoutIdHelp;