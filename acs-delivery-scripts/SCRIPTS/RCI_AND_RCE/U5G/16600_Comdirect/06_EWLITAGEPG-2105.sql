USE `U5G_ACS_BO`;


SET @polingPageLayoutDesc = 'Polling Page (Comdirect)';
SET @polingFormPageType = 'POLLING_PAGE';

SET @polingFormPage = (SELECT id
				FROM `CustomPageLayout`
				WHERE `pageType` = @polingFormPageType
				AND DESCRIPTION = @polingPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '

	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding: 0px;
			margin: 0px;
		}
		#main-container {
			width: 480px;
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
		}
		#main-container .btn {
			border-radius: 20px;
			border: 0px;
			height: 40px;
		}
		#pageHeader {
			width: 100%;
			height: 60px;
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
			max-height: 30px;
		}
		#networkLogo {
			max-height: 30px;
		}
		#main-container #content {
			text-align: center;
			display: flex;
			flex-direction: column;
		}
		#main-container #footer {
			display: flex;
			width: 100%;
			border-top: 1px solid #000;
			padding-top: 10px;
			justify-content: space-between;
			background-image: none;
		}
		#main-container #cancelButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
		}
		#main-container #helpButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
			width: 120px;
		}
		span.fa.fa-info {
			display: none;
		}
		.fa-ban {
			display: none;
		}
		#main-container #validateButton .btn-default {
			background-color: #fff500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border: 0px;
			border-radius: 20px;
			height: 40px;
			width: 120px;
			background-color: #fff500;
			margin-right: 10px;
			align-content: flex-end;
			text-align: center;
		}
		.fa-check-square {
			display: none
		}
		.fa-ban {
			display: none;
		}
		#cancelButton {
			background-color: #f4f4f4;
			border-radius: 20px;
			border: 0px;
			height: 40px;
			width: 120px;
			margin-left: 10px;
			align-content: flex-start;
			text-align: center;
		}
		.splashtext {
			width: 80%;
			margin-left: auto;
			margin-right: auto;
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			height: 20px;
			box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
		}
		#tan_input_ctrl {
			align-items: center;
		}
		.autharea {
			padding-top: 10px;
			padding-bottom: 10px;
		}
		span#tan-label {
			padding-right: 5px;
			padding-left: 5px;
			margin-left: 8.33333333%;
			width: 41.66666667%;
			text-align: right;
			float: left;
			font-weight: 700;
		}
		.otp-field {
			padding-right: 5px;
			padding-left: 5px;
			margin-right: 8.33333333%;
			width: 41.66666667%;
			text-align: left;
			float: left;
		}
		@media (max-width: 560px) {
			.transactiondetails ul li { text-align: left;}
			.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
			.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
			.otp-field { display: block;}
			.contact { width: 100%; order: 1; }
			#footer .small-font { font-size: 0.75em;}
		}
		@media all and (max-width: 480px) {
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #footer {text-align: center; display: block;}
			#main-container .btn {margin-left: 0px;}
			div#message-content {padding-bottom: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
		}
		@media all and (max-width: 391px) {
			#main-container {max-width:385px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 18px;}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 16px; width: 100%;}
			div#message-container #message {font-size: 12px; width: 100%;}
			#main-container #footer {text-align: center;}
			h3 {margin-top: 10px;}
			#main-container .btn {margin-left: 0px; width: 100px;}
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
		@media all and (max-width: 251px) {
			#main-container {max-width:245px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 14px}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 14px; width: 100%;}
			div#message-container #message {font-size: 11px; width: 100%;}
			div.message-button {padding-top: 0px;}
			#main-container .btn {height:30px;}
			h3 {font-size: 14px; text-align: center;}
			#main-container .btn {margin-left: 0px;}
			.autharea {text-align: center;}
			#pageHeader {height: 60px;}
			#issuerLogo { max-height: 20px; }
			#networkLogo { max-height: 20px; }
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#cancelButton {margin-left: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}

		}

	</style>
	<div id="main-container">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_170_IMAGE_ALT''" image-key="''network_means_pageType_170_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_171_IMAGE_ALT''" image-key="''network_means_pageType_171_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner back-button="''network_means_pageType_175''"></message-banner>
		<div id="content">
			<div class="transactiondetails">
				<h3>
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</h3>
				<side-menu></side-menu>
			</div>
			<div class="autharea">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
				</div>
				<div class="paragraphDescription">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
			</div>
		</div>
		<div id="footer">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
		</div>
	</div>
' WHERE fk_id_layout = @polingFormPage;


SET @refusalPageLayoutDesc = 'Refusal Page (Comdirect)';
SET @refusalFormPageType = 'REFUSAL_PAGE';

SET @refusalFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @refusalFormPageType
			AND DESCRIPTION = @refusalPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding:0px;
			margin:0px;
		}
		#main-container {
			width:480px;
			max-width:480px;
			margin-left:auto;
			margin-right:auto;
			padding-left:10px;
			padding-right:10px;
		}
		#main-container .btn {
			border-radius: 20px;
			border:0px;
			height:40px;
			margin-left:10px;
		}
		#pageHeader {
			width: 100%;
			height: 60px;
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
			max-height: 30px;
		}
		#networkLogo {
			max-height: 30px;
		}
		#main-container #content {
			text-align:left;
			display:flex;
			flex-direction: column;
		}
		#main-container #content .transactiondetails {
			border-top:1px solid black;
			border-bottom: 1px solid black;
		}
		#main-container #content .transactiondetails .h3, h3 {
			margin-left: 185px;
		}
		#main-container #content .transactiondetails ul {
			list-style-type: none;
			padding-left:0px;
		}
		#main-container #content .transactiondetails ul li {
			width:100%;
			text-align: left;
		}
		#main-container #content .transactiondetails ul li label {
			display:block;
			float:left;
			width:180px;
			text-align: right;
			font-size:14px;
			color: #909090;
			margin-right:0.5em;
		}
		#main-container #content .transactiondetails ul li span.value {
			clear:both;
			text-align: left;
			margin-left:0.5em;
		}
		#main-container #content div.autharea {
			display: flex;
			flex-direction: row;
		}
		#main-container #footer {
			display: flex;
			width:100%;
			border-top: 1px solid #000;
			padding-top:10px;
			justify-content: space-between;
			background-image:none;
		}
		#main-container #cancelButton .btn-default{
			background-color:#f4f4f4;
			align-content: flex-start;
		}
		#main-container #validateButton .btn-default {
			background-color:#FFF500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border:0px;
			border-radius: 20px;
			height:40px;
			width:120px;
			background-color:#FFF500;
			margin-right:10px;
			align-content: flex-end;
		}
		#cancelButton {
			background-color:#f4f4f4;
			border-radius: 20px;
			border:0px;
			height:40px;
			width:120px;
			margin-left:10px;
			align-content: flex-start;
		}
		.splashtext {
			width:80%;
			margin-left:auto;
			margin-right:auto;
		}
		.autharea {
			display:flex;
			flex-direction: row;
			align-items: center;
			padding-top:10px;
			padding-bottom:10px;
		}
		@media (max-width: 560px) {
			.transactiondetails ul li { text-align: left;}
			.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
			.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
			.contact { width: 100%; order: 1; }
			#footer .small-font { font-size: 0.75em;}
		}
		@media all and (max-width: 480px) {
			#main-container {max-width:480px; width:480px; padding-left:0px; padding-right:0px;}
			#main-container #footer {text-align: center; display: block;}
			#main-container .btn {margin-left: 0px;}
		}
		@media all and (max-width: 391px) {
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 18px;}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 16px; width: 100%;}
			div#message-container #message {font-size: 12px; width: 100%;}
			#main-container #footer {text-align: center;}
			h3 {margin-top: 10px;}
			#main-container .btn {margin-left: 0px; width: 100px;}
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
		@media all and (max-width: 251px) {
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 14px}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 14px; width: 100%;}
			div#message-container #message {font-size: 11px; width: 100%;}
			div.message-button {padding-top: 0px;}
			#main-container .btn {height:30px;}
			h3 {font-size: 14px; text-align: center;}
			#main-container .btn {margin-left: 0px;}
			.autharea {text-align: center;}
			#pageHeader {height: 60px;}
			#issuerLogo { max-height: 20px; }
			#networkLogo { max-height: 20px; }
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#cancelButton {margin-left: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
	</style>
	<div id="main-container">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_170_IMAGE_ALT''" image-key="''network_means_pageType_170_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_171_IMAGE_ALT''" image-key="''network_means_pageType_171_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner></message-banner>
		<div id="content">
			<div class="transactiondetails">
				<h3>
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</h3>
				<side-menu></side-menu>
			</div>
		</div>
		<div id="footer">
			<val-button id="validateButton"></val-button>
		</div>
	</div>
' WHERE fk_id_layout = @refusalFormPage;


SET @passwordPageLayoutDesc = 'Password OTP Form Page (Comdirect)';
SET @passwordFormPageType = 'EXT_PASSWORD_OTP_FORM_PAGE';

SET @passwordFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @passwordFormPageType
			AND DESCRIPTION = @passwordPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding: 0px;
			margin: 0px;
		}
		#main-container {
			width: 480px;
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
			padding-left: 10px;
			padding-right: 10px;
		}
		#main-container .btn {
			border-radius: 20px;
			border: 0px;
			height: 40px;
		}
		div#message-container.success {
			background-color: #E0700A !important;
		}
		#pageHeader {
			width: 100%;
			height: 60px;
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
			max-height: 30px;
		}
		#networkLogo {
			max-height: 30px;
		}
		#main-container #content {
			text-align: center;
			display: flex;
			flex-direction: column;
		}
		#main-container #footer {
			display: flex;
			width: 100%;
			border-top: 1px solid #000;
			padding-top: 10px;
			justify-content: space-between;
			background-image: none;
		}
		#main-container #cancelButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
		}
		#main-container #helpButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
			width: 120px;
		}
		span.fa.fa-info {
			display: none;
		}
		.fa-ban { display: none; }
		#main-container #validateButton .btn-default {
			background-color: #fff500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border: 0px;
			border-radius: 20px;
			height: 40px;
			width: 120px;
			background-color: #fff500;
			margin-right: 10px;
			align-content: flex-end;
			text-align: center;
		}
		.fa-check-square {display: none}
		.fa-ban { display: none; }
		#cancelButton {
			background-color: #f4f4f4;
			border-radius: 20px;
			border: 0px;
			height: 40px;
			width: 120px;
			margin-left: 10px;
			align-content: flex-start;
			text-align: center;
		}
		.splashtext {
			width: 80%;
			margin-left: auto;
			margin-right: auto;
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			height: 20px;
			box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
		}
		#tan_input_ctrl {
			align-items: center;
		}
		.autharea {
			padding-top: 10px;
			padding-bottom: 10px;
		}
		span#tan-label {
			padding-right: 5px;
			padding-left: 5px;
			width: 50%;
			text-align: center;
			font-weight: 700;
		}
		.otp-field {
			padding-right: 5px;
			padding-left: 5px;
			padding-top: 10px;
			text-align: center;
		}
		@media (max-width: 560px) {
			.transactiondetails ul li { text-align: left;}
			.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
			.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
			.otp-field { display: block;}
			.contact { width: 100%; order: 1; }
			#footer .small-font { font-size: 0.75em;}
		}
		@media all and (max-width: 480px) {
			#main-container {max-width:480px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #footer {text-align: center; display: block;}
			#main-container .btn {margin-left: 0px;}
			div#message-content {padding-bottom: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#main-container .btn { width: 100px;}
		}
		@media all and (max-width: 391px) {
			#main-container {max-width:385px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 18px;}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 16px; width: 100%;}
			div#message-container #message {font-size: 12px; width: 100%;}
			#main-container #footer {text-align: center;}
			h3 {margin-top: 10px;}
			#main-container .btn {margin-left: 0px;width: 100px;}
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
		@media all and (max-width: 251px) {
			#main-container {max-width:245px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 14px}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 14px; width: 100%;}
			div#message-container #message {font-size: 11px; width: 100%;}
			div.message-button {padding-top: 0px;}
			#main-container .btn {height:30px;}
			h3 {font-size: 14px; text-align: center;}
			#main-container .btn {margin-left: 0px;}
			.autharea {text-align: center;}
			#pageHeader {height: 60px;}
			#issuerLogo { max-height: 20px; }
			#networkLogo { max-height: 20px; }
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#cancelButton {margin-left: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
	</style>
	<div id="main-container">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner back-button="''network_means_pageType_175''"></message-banner>
		<div id="content">
			<div class="transactiondetails">
				<h3>
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph1"></custom-text>
				</h3>
				<side-menu></side-menu>
			</div>
			<div class="autharea">
					<div id="tan_input_ctrl">
						<span id="tan-label">
						  <custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
						</span>
						<div class="otp-field">
							<pwd-form></pwd-form>
						</div>
					</div>
			</div>
		</div>
		<div id="footer">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
			<val-button val-label="''network_means_pageType_42''" id="validateButton"></val-button>
		</div>
	</div>
' WHERE fk_id_layout = @passwordFormPage;

SET @photoTanPageLayoutDesc = 'OTP Phototan Form Page (Comdirect)';
SET @photoTanFormPageType = 'PHOTO_TAN_OTP_FORM_PAGE';

SET @photoTanFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @photoTanFormPageType
			AND DESCRIPTION = @photoTanPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding: 0px;
			margin: 0px;
		}
		#main-container {
			width: 480px;
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
		}
		#main-container .btn {
			border-radius: 20px;
			border: 0px;
			height: 40px;
		}
		#pageHeader {
			width: 100%;
			height: 60px;
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
			max-height: 30px;
		}
		#networkLogo {
			max-height: 30px;
		}
		#main-container #content {
			text-align: center;
			display: flex;
			flex-direction: column;
		}
		#main-container #footer {
			display: flex;
			width: 100%;
			border-top: 1px solid #000;
			padding-top: 10px;
			justify-content: space-between;
			background-image: none;
		}
		#main-container #cancelButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
		}
		#main-container #helpButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
			width: 120px;
		}
		span.fa.fa-info {
			display: none;
		}
		#main-container #validateButton .btn-default {
			background-color: #fff500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border: 0px;
			border-radius: 20px;
			height: 40px;
			width: 120px;
			background-color: #fff500;
			margin-right: 10px;
			align-content: flex-end;
			text-align: center;
		}
		.fa-ban { display: none; }
		.fa-check-square {
			display: none;
		}
		#cancelButton {
			background-color: #f4f4f4;
			border-radius: 20px;
			border: 0px;
			height: 40px;
			width: 120px;
			margin-left: 10px;
			align-content: flex-start;
			text-align: center;
		}
		.splashtext {
			width: 80%;
			margin-left: auto;
			margin-right: auto;
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			height: 20px;
			box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
		}
		#tan_input_ctrl {
			align-items: center;
		}
		.autharea {
			padding-top: 10px;
			padding-bottom: 10px;
		}
		external-image {
			margin-left: auto;
			margin-right: auto;
			display: block;
			width: 214px;
		}
		#phototan_ctrl {
			align-content: center;
		}
		span#tan-label {
			padding-right: 5px;
			padding-left: 5px;
			text-align: center;
			font-weight: 700;
		}
		.otp-field {
			padding-right: 5px;
			padding-left: 5px;
			padding-top: 10px;
			text-align: center;
		}
		@media (max-width: 560px) {
			.transactiondetails ul li { text-align: left;}
			.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
			.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
			.otp-field { display: block;}
			.contact { width: 100%; order: 1; }
			#footer .small-font { font-size: 0.75em;}
		}
		@media all and (max-width: 480px) {
			#main-container {max-width:480px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #footer {text-align: center; display: block;}
			#main-container .btn {margin-left: 0px;}
			div#message-content {padding-bottom: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
		}
		@media all and (max-width: 391px) {
			#main-container {max-width:385px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 18px;}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 16px; width: 100%;}
			div#message-container #message {font-size: 12px; width: 100%;}
			#main-container #footer {text-align: center;}
			h3 {margin-top: 10px;}
			#main-container .btn {margin-left: 0px;width: 100px;}
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			img {width: 120px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
		@media all and (max-width: 251px) {
			#main-container {max-width:245px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 14px}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 14px; width: 100%;}
			div#message-container #message {font-size: 11px; width: 100%;}
			div.message-button {padding-top: 0px;}
			#main-container .btn {height:30px;}
			h3 {font-size: 14px; text-align: center;}
			#main-container .btn {margin-left: 0px;}
			.autharea {text-align: center;}
			#pageHeader {height: 60px;}
			#issuerLogo { max-height: 20px; }
			#networkLogo { max-height: 20px; }
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#cancelButton {margin-left: 0px;}
			img {width: 100px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
	</style>
	<div id="main-container">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_170_IMAGE_ALT''" image-key="''network_means_pageType_170_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_171_IMAGE_ALT''" image-key="''network_means_pageType_171_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner back-button="''network_means_pageType_5''"></message-banner>
		<div id="content">
			<div class="transactiondetails">
				<h3>
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</h3>
				<side-menu></side-menu>
			</div>
			<div class="autharea">
					<div id="tan_input_ctrl">
					  <custom-text custom-text-key="''network_means_pageType_2''" id="tan-label"></custom-text>
					  <!-- output for photo tan -->
						<div class="otp-field">
								  <otp-form></otp-form>
						</div>
						</div>
						<external-image></external-image>
			</div>
		</div>
		<div id="footer">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
			<val-button val-label="''network_means_pageType_6''" id="validateButton"></val-button>
		</div>
	</div>
' WHERE fk_id_layout = @photoTanFormPage;

SET @OTPPageLayoutDesc = 'OTP Form Page (Comdirect)';
SET @OTPFormPageType = 'OTP_FORM_PAGE';

SET @OTPFormPageTypeId = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @OTPFormPageType
			AND DESCRIPTION = @OTPPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding: 0px;
			margin: 0px;
		}
		#main-container {
			width: 480px;
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
		}
		#main-container .btn {
			border-radius: 20px;
			border: 0px;
			height: 40px;
		}
		#pageHeader {
			width: 100%;
			height: 60px;
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
			max-height: 30px;
		}
		#networkLogo {
			max-height: 30px;
		}
		#main-container #content {
			text-align: center;
			display: flex;
			flex-direction: column;
		}
		#main-container #footer {
			display: flex;
			width: 100%;
			border-top: 1px solid #000;
			padding-top: 10px;
			justify-content: space-between;
			background-image: none;
		}
		#main-container #cancelButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
		}
		#main-container #helpButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
			width: 120px;
		}
		span.fa.fa-info {
			display: none;
		}
		.fa-ban { display: none; }
		#main-container #validateButton .btn-default {
			background-color: #fff500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border: 0px;
			border-radius: 20px;
			height: 40px;
			width: 120px;
			background-color: #fff500;
			margin-right: 10px;
			align-content: flex-end;
			text-align: center;
		}
		.fa-check-square {display: none}
		.fa-ban { display: none; }
		#cancelButton {
			background-color: #f4f4f4;
			border-radius: 20px;
			border: 0px;
			height: 40px;
			width: 120px;
			margin-left: 10px;
			align-content: flex-start;
			text-align: center;
		}
		.splashtext {
			width: 80%;
			margin-left: auto;
			margin-right: auto;
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			height: 20px;
			box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
		}
		#tan_input_ctrl {
			align-items: center;
		}
		.autharea {
			padding-top: 10px;
			padding-bottom: 10px;
		}
		span#tan-label {
			padding-right: 5px;
			padding-left: 5px;
			text-align: center;
			font-weight: 700;
		}
		.otp-field {
			padding-right: 5px;
			padding-left: 5px;
			padding-top: 10px;
			text-align: center;
		}
		@media (max-width: 560px) {
			.transactiondetails ul li { text-align: left;}
			.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
			.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
			.otp-field { display: block;}
			.contact { width: 100%; order: 1; }
			#footer .small-font { font-size: 0.75em;}
		}
		@media all and (max-width: 480px) {
			#main-container {max-width:480px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #footer {text-align: center; display: block;}
			#main-container .btn {margin-left: 0px;}
			div#message-content {padding-bottom: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
		}

		@media all and (max-width: 391px) {
			#main-container {max-width:385px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 18px;}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 16px; width: 100%;}
			div#message-container #message {font-size: 12px; width: 100%;}
			#main-container #footer {text-align: center;}
			h3 {margin-top: 10px;}
			#main-container .btn {margin-left: 0px;width: 100px;}
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
		@media all and (max-width: 251px) {
			#main-container {max-width:245px; padding-left:0px; padding-right:0px;}
			#main-container	 { padding-left: 0px; padding-right: 0px;}
			#main-container #header { position: inherit;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 14px}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 14px; width: 100%;}
			div#message-container #message {font-size: 11px; width: 100%;}
			div.message-button {padding-top: 0px;}
			#main-container .btn {height:30px;}
			h3 {font-size: 14px; text-align: center;}
			#main-container .btn {margin-left: 0px;}
			.autharea {text-align: center;}
			#pageHeader {height: 60px;}
			#issuerLogo { max-height: 20px; }
			#networkLogo { max-height: 20px; }
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#cancelButton {margin-left: 0px;}
			#main-container #helpButton .btn-default { width: 100px;}
		}
	</style>
	<div id="main-container">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_170_IMAGE_ALT''" image-key="''network_means_pageType_170_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_171_IMAGE_ALT''" image-key="''network_means_pageType_171_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner back-button="''network_means_pageType_5''"></message-banner>
		<div id="content">
			<div class="transactiondetails">
				<h3>
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</h3>
				<side-menu></side-menu>
			</div>
			<div class="autharea">
					<div id="tan_input_ctrl">
						<span id="tan-label">
						  <custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
						  <custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
						</span>
						<div class="otp-field">
								  <otp-form></otp-form>
						</div>
					</div>
			</div>
		</div>
		<div id="footer">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
			<val-button val-label="''network_means_pageType_6''" id="validateButton"></val-button>
		</div>
	</div>
' WHERE fk_id_layout = @OTPFormPageTypeId;



SET @failureLayoutDesc = 'Failure Page (Comdirect)';
SET @failurePageType = 'FAILURE_PAGE';

SET @failurePageTypeID = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @failurePageType
			AND DESCRIPTION = @failureLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding: 0px;
			margin: 0px;
		}
		#main-container {
			width: 480px;
			max-width: 480px;
			margin-left: auto;
			margin-right: auto;
		}
		#main-container .btn {
			border-radius: 20px;
			border: 0px;
			height: 40px;
			margin-left: 10px;
		}
		#pageHeader {
			width: 100%;
			height: 60px;
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
			max-height: 30px;
		}
		#networkLogo {
			max-height: 30px;
		}
		#main-container #content {
			text-align: left;
			display: flex;
			flex-direction: column;
		}
		#main-container #content .transactiondetails {
			border-top: 1px solid black;
			border-bottom: 1px solid black;
			padding-top: 10px;
			padding-bottom: 10px;
		}
		#main-container #content .transactiondetails h3 {
			margin-top: 10px;
			margin-bottom: 10px;
		}
		#main-container #content .transactiondetails ul {
			list-style-type: none;
			padding-left: 0px;
		}
		#main-container #content .transactiondetails ul li {
			width: 100%;
			text-align: left;
		}
		#main-container #content .transactiondetails ul li label {
			display: block;
			float: left;
			width: 180px;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		#main-container #content .transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		#main-container #content div.autharea {
			display: flex;
			flex-direction: column;
		}
		#main-container #footer {
			display: flex;
			width: 100%;
			border-top: 1px solid #000;
			padding-top: 10px;
			justify-content: space-between;
			background-image: none;
		}
		#main-container #cancelButton .btn-default {
			background-color: #f4f4f4;
			align-content: flex-start;
		}
		#main-container #validateButton .btn-default {
			background-color: #fff500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border: 0px;
			border-radius: 20px;
			height: 40px;
			width: 120px;
			background-color: #fff500;
			margin-right: 10px;
			align-content: flex-end;
		}
		@media (max-width: 560px) {
			.transactiondetails ul li { text-align: left;}
			.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
			.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
			.otp-field { display: block;}
			.contact { width: 100%; order: 1; }
			#footer .small-font { font-size: 0.75em;}
		}
		@media all and (max-width: 480px) {
			#main-container {max-width:480px; width:480px; padding-left:0px; padding-right:0px;}
			#main-container #footer {text-align: center; display: block;}
			#main-container .btn {margin-left: 0px;}
			div#message-content {padding-bottom: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
		}
		@media all and (max-width: 391px) {
			#main-container #header { position: inherit;}
			#main-container {max-width:385px; padding-left:0px; padding-right:0px;}
			div#message-container { width: 390px;}
			#main-container #content { width: 390px;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 18px;}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 16px; width: 100%;}
			div#message-container #message {font-size: 12px; width: 100%;}
			#main-container #footer {text-align: center;}
			h3 {margin-top: 10px;}
			#main-container .btn {margin-left: 0px;}
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
		}
		@media all and (max-width: 251px) {
			#main-container #header { position: inherit;}
			#main-container {max-width:385px; padding-left:0px; padding-right:0px;}
			div#message-container { width: 250px;}
			#main-container #content { width: 250px;}
			#footer .small-font { font-size: 0.75em;}
			#main-container #content .transactiondetails .h3, h3 {margin-left: 0px; text-align: center; font-size: 14px}
			#main-container #content .transactiondetails {margin-left: 0px; text-align: center; font-size: 9px}
			div#message-container #headingTxt {font-size: 14px; width: 100%;}
			div#message-container #message {font-size: 11px; width: 100%;}
			div.message-button {padding-top: 0px;}
			#main-container .btn {height:30px;}
			h3 {font-size: 14px; text-align: center;}
			#main-container .btn {margin-left: 0px;}
			.autharea {text-align: center;}
			#pageHeader {height: 60px;}
			#issuerLogo { max-height: 20px; }
			#networkLogo { max-height: 20px; }
			div#message-content {padding-bottom: 0px;}
			span#message {padding: 0px;}
			.spinner{padding-top: 0px; padding-bottom: 0px;}
			#cancelButton {margin-left: 0px;}
		}
	</style>
	<div id="main-container">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_170_IMAGE_ALT''" image-key="''network_means_pageType_170_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_171_IMAGE_ALT''" image-key="''network_means_pageType_171_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner></message-banner>
		<div id="content">
			<div class="transactiondetails">
				<h3>
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</h3>
				<side-menu></side-menu>
			</div>
		</div>
		<div id="footer">
			<val-button id="validateButton"></val-button>
		</div>
	</div>
' WHERE fk_id_layout = @failurePageTypeID;