USE `U5G_ACS_BO`;


SET @pageLayoutId_Banner = (select id from `CustomPageLayout` where `pageType` = 'MESSAGE_BANNER' and DESCRIPTION = 'Message Banner (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_301_FONT_TITLE''"
			 font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_302_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_302_FONT_TITLE''"
			 font-key="''network_means_pageType_302_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_303_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_303_FONT_TITLE''"
			 font-key="''network_means_pageType_303_FONT_DATA''"></custom-font>

<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''''truetype'''');
		font-weight: normal;
		font-style: normal;
	}
	#message-container {
		position: relative;
	}
	div#message-container {
		padding-top: 5px;
	}
	div#message-container.info {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #403f3d;
	}
	div#message-container.success {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #7f9c90;
	}
	div#message-container.error {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #ab7270;
	}
	div#message-container.warn {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #403f3d;
	}
	div#message-content {
		text-align: center;
		background-color: inherit;
		padding-bottom: 5px;
	}
	#message {
		text-align: center;
	}
	span#message {
		font-family: "BNPPSansExpanded";
		font-size: 20px;
		font-weight: normal;
		text-align: center;
		width: 100%;
		padding-left: 25px;
		padding: 0px;
	}
	custom-text#headingTxt {
		font-family: "BNPPSansExpandedLight";
		padding-left: 8px;
		display: grid;
		font-weight: bold;
		font-size: 35px;
		text-align: center;
		text-transform: uppercase;
	}
	div#message-controls {
		padding-top: 5px;
	}
	#return-button-row button {
		font-weight: normal;
		color: white;
		font-size: 15px;
		font-family: BNPPSans;
		text-align: center;
		background-color: #5b7f95;
	}
	#close-button-row button {
		font-weight: normal;
		color: white;
		font-size: 15px;
		font-family: BNPPSans;
		text-align: center;
		background-color: #5b7f95;
	}
	div.message-button {
		font-family: OpenSansRegular;
		font-size: 15px;
		padding-top: 0px;
		padding-left: 25px;
	}
	button span.fa {
		padding-right: 7px;
		display: none;
	}
	.btn {
		border-radius: 0px;
	}
</style>
<div id="messageBanner">
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>' WHERE fk_id_layout = @pageLayoutId_Banner;



SET @pageLayoutId = (select id from `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'Polling Page (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_301_FONT_TITLE''"
			 font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_304_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_304_FONT_TITLE''"
			 font-key="''network_means_pageType_304_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_305_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_305_FONT_TITLE''"
			 font-key="''network_means_pageType_305_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_306_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_306_FONT_TITLE''"
			 font-key="''network_means_pageType_306_FONT_DATA''"></custom-font>

<div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false">
		</div>
	</div>
	<div id="content">
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
			<h2>
				<custom-text custom-text-key="''network_means_pageType_1''" id="title"></custom-text>
			</h2>
			<div class="transactiondetails">
				<side-menu></side-menu>
			</div>
			<br></br>
			<br></br>
			<p></p>
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
	</div>
<div id="form-controls">
		<div class="row">
			<div class="back-link">
				<span class="fa fa-angle-left"></span>
				<cancel-button cn-label="''network_means_pageType_11''" id="cancelButton" ></cancel-button>
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
</div>
<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	.mobileapp {
		text-align: center;
	}
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#header {
		height: 100px;
		position: relative;
	}
	#main-container #networkLogo {
		max-height: 33px;
		max-width: 100%;
	}
	#main-container #issuerLogo {
		max-height: 72px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#mobileAppLogo {
		position: relative;
	}
	#schemeLogo {
		width: 100px;
		height: 100px;
		position: absolute;
		right: 0px;
		top: 1em;
		padding-right: 1em;
	}
	div#contentHeader {
		background-color: #f7f7f7;
	}
	div#transactionDetails {
		background-color: #f7f7f7;
	}
	custom-text#title {
		font-weight: bold;
		font-size: 25px;
		font-family: BNPPSans;
		color: #403f3d;
	}
	#content {
		text-align: left;
		color: #403f3d;
		background-color: #f7f7f7;
	}
	#content h2 {
		font-family: BNPPSansLight;
		font-size: 25px;
		line-height: 1.2;
		font-weight: normal;
		margin-bottom: 0.25em;
		margin-top: 0.25em;
		color: #403f3d;
		padding-top: 7px;
	}
	.btn {
		border-radius: 0px;
        text-align: left;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		font-family: BNPPSans;
	}
	.side-menu .text-left, .side-menu .text-right {
		font-family: BNPPSans;
		padding-right: 5px;
		padding-left: 5px;
		font-size: 15px;
		color: #403f3d;
	}
	.menu-elements {
		color: #403f3d;
	}
	div#form-controls {
		background-color: #f7f7f7;
	}
	#main-container #footer {
		width: 100%;
		background-color: #d1d1d1;
		clear: both;
		background-image: none;
		height: auto;
		color: #403f3d;
	}
	#main-container #footer:after {
		content: '''';
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 12px;
	}
	#main-container #footer .small {
		font-size: 0.8em;
		font-weight: normal;
	}
	#main-container #footer .bold {
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
	#main-container #footer #copyright {
		width: 100%;
		border-top: 1px solid #6b6b6b;
		padding-top: 0.5em;
		padding-bottom: 1em;
		display: flex;
		flex-direction: row;
	}
	#main-container #footer #copyright div:nth-child(1) {
		order: 1;
		text-align: left;
		width: 50%;
		padding-left: 12px;
	}
	#main-container #footer #copyright div:nth-child(2) {
		order: 2;
		text-align: right;
		width: 50%;
		padding-right: 12px;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	p {
		margin-bottom: 10px;
	}
	#main-container #footer .small-font {
		font-size: 0.75em;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto
	}
	input {
		border: 1px solid #d1d1d1;
		color: #464646;
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner-innerContainer {
		padding: 20px;
	}
	#messageBanner {
		width: 100%;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		margin-bottom: 10px;
		background-color: #f5f5f5;
		padding: 5px;
		box-sizing: border-box;
	}
	.error {
		color: #d00;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#main-container .row button {
		font-family: BNPPSans;
		font-size: 15px;
		height: 38px;
		background: linear-gradient(#4dbed3, #007ea5);
		box-shadow: none;
		border: 0px;
		color: #000;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	#switchId button span.fa {
		display: none;
	}
	#switchId button span.fa-check-square {
		display: none;
	}
	#cancelButton button span.fa {
		display: none;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .row .back-link {
		text-align: left;
		float: left;
	}
	#main-container .row .back-link button {
		border-style: none;
		background: none;
		padding: 0px;
		background-color: #f7f7f7;
		color: #06c2d4;
	}
	#main-container .row .back-link span {
		text-align: left;
		color: #749bb3;
	}
	#main-container .row .back-link span.fa-ban {
		display: none;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		color: white;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 2px;
		background-color: #5b7f95;
	}
	#main-container #helpButton .fa-info {
		display: none;
	}
	.help-link {
		width: 30%;
		order: 2;
		text-align: right
	}
	.contact {
		width: 70%;
		order: 1;
		font-weight: bold;
	}
	@media (max-width: 560px) {
		#main-container {width: auto;}
		body {font-size: 14px;}
		#header {height: 65px;}
		#schemeLogo {margin-top: 1em;width: 70px;height: 70px;}
		.row {width: auto;clear: none;}
		.row .back-link {float: none;text-align: center;padding-top: 0.5em;}
		.row button {width: 90%;}
		#main-container #footer {width: 100%;background-image: none;background-color: #f5f5f5;clear: both;height: unset;}
		#main-container #footer .help-area {display: flex;flex-direction: column;padding: 16px;text-align: center;}
		.help-link {width: 100%;order: 2;text-align: center;padding-top: 1em;}
		.contact {width: 100%;order: 1;}
		#main-container #footer .small-font {font-size: 0.75em;}
	}
</style>' WHERE fk_id_layout = @pageLayoutId;




SET @pageLayoutId_Failure = (select id from `CustomPageLayout` where `pageType` = 'FAILURE_PAGE' and DESCRIPTION = 'Failure Page (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_301_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_301_FONT_TITLE''''"
			 font-key="''''network_means_pageType_301_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_304_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_304_FONT_TITLE''''"
			 font-key="''''network_means_pageType_304_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_305_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_305_FONT_TITLE''''"
			 font-key="''''network_means_pageType_305_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_306_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_306_FONT_TITLE''''"
			 font-key="''''network_means_pageType_306_FONT_DATA''''"></custom-font>

<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container #issuerLogo {
		max-height: 72px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container #networkLogo {
		max-height: 33px;
		max-width: 100%;
	}
	#main-container #pageHeader {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		height: 76px;
		padding-bottom: 4px;
		margin-top: 8px;
		margin-bottom: 0px;
		border-bottom: 1px solid #dcdcdc;
	}
	#main-container #pageHeaderLeft {
		text-align: left;
	}
	#main-container #pageHeaderRight {
		text-align: right;
	}
	#main-container #centerPieceLayout {
		padding: 5px 10px 0px;
		min-height: 200px;
	}
	div#leftMenuLayout {
		background-color: #f7f7f7;
	}
	#main-container #content #contentHeader custom-text.ng-isolate-scope {
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 100px;
	}
	custom-text#headingTxt {
        font-size: 22px !important;
    }
	.btn {
		border-radius: 0px;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		font-family: BNPPSans;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-size: 15px;
		font-family: BNPPSans;
		color: #403f3d;
	}
	#main-container #content {
		text-align: left;
		background-color: #f7f7f7;
	}
	#main-container #content h2 {
		font-size: 1.25em;
		line-height: 0.8;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container #content #paragraph1 {
		font-family: BNPPSans;
		font-size: 25px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
	}
	#main-container #content contentHeaderLeft {
		font-size: 1.25em;
		margin-bottom: 0.25em;
		margin-top: 0.25em;
	}
	#main-container .paragraph {
		display: block;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .help-link {
		width: 30%;
		order: 2;
		text-align: right;
	}
	#main-container .contact {
		width: 70%;
		order: 1;
		font-weight: bold;
	}
	#main-container div#footer {
		background-image: none;
		height: 100%;
	}
	#main-container #footer {
		width: 100%;
		background-color: #f7f7f7;
		border-radius: 1em;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 12px;
	}
	#main-container #footer .small {
		font-size: 0.8em;
		font-weight: normal;
	}
	#main-container #footer .bold {
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
	#main-container #footer #copyright {
		width: 100%;
		border-top: 1px solid #6b6b6b;
		padding-top: 0.5em;
		padding-bottom: 1em;
		display: flex;
		flex-direction: row;
	}
	#main-container #footer #copyright custom-text.ng-isolate-scope {
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #footer #copyright div:nth-child(1) {
		order: 1;
		text-align: left;
		width: 50%;
		padding-left: 12px;
	}
	#main-container #footer #copyright div:nth-child(2) {
		order: 2;
		text-align: right;
		width: 50%;
		padding-right: 12px;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	#main-container #footer .contact custom-text.ng-isolate-scope {
		text-align: center;
		color: #403f3d;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		font-weight: normal;
		text-align: center;
		color: white;
		background-color: #5b7f95;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton .fa-info {
		display: none;
	}
	#main-container .col-lg-4 {
		width: 100%;
	}
	#main-container .col-md-4 {
		width: 100%;
	}
	#main-container .col-sm-4 {
		width: 100%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#main-container .halfdivsRight {
		width: 50%;
		float: right;
	}
	#main-container .halfdivsLeft {
		width: 50%;
		float: left;
	}
</style>
<div id="main-container" ng-style="style" class="ng-scope">
		<div id="headerLayout">
			<div id="pageHeader" >
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
		<div id="mainLayout" class="row">
			<div id="content">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
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
	</div>' WHERE fk_id_layout = @pageLayoutId_Failure;
