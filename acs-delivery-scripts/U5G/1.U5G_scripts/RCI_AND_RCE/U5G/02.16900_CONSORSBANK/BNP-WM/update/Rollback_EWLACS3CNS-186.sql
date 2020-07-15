USE U5G_ACS_BO;

set @subIssuerCode = '16901';
set @customITemSetDefaultRefusal= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_BNP_WM_1_REFUSAL' );
set @customITemSetMobileApp= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_BNP_WM_MOBILE_APP_EXT' );
set @customITemSetPhotoTan= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_BNP_WM_PHOTO_TAN' );
set @customITemSetPassword= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_BNP_WM_PASSWORD' );
set @customITemSetAccept= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_BNP_WM_ACCEPT_MAINT' );

set @pageType = 'ALL';
SET @locale = 'de';

set @customItemIds = (SELECT group_concat(id) FROM CustomItem WHERE fk_id_customItemSet IN (@customITemSetDefaultRefusal,
													@customITemSetMobileApp,
													@customITemSetPhotoTan,
													@customITemSetPassword,
													@customITemSetAccept) and `DTYPE` = 'F');


-- fonts
set @fontIDs = (SELECT group_concat(fk_id_font) FROM `CustomItem` WHERE find_in_set(id, @customItemIds));

DELETE FROM `CustomItem` WHERE find_in_set(id, @customItemIds);

DELETE FROM `Font` WHERE find_in_set(id, @fontIDs);

SET @BankUB = 'BNP_WM';

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE DESCRIPTION = CONCAT('Message Banner (', @BankUB ,')'));

UPDATE CustomComponent SET value = '
<style>
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
		line-height: 16px;
		text-align: center;
	}
	span#message {
		font-size: 14px;
		font-weight: normal;
		text-align: center;
		width: 100%;
		padding-left: 25px;
	}
	custom-text#headingTxt {
		padding-left: 8px;
		display: grid;
		font-weight: bold;
		font-size: 18px;
		text-align: center;
	}
	div#message-controls {
		padding-top: 5px;
	}
	#return-button-row button {
		font-weight: normal;
		color: #403f3d;
		font-size: 16px;
		text-align: center;
		background-color: #5b7f95;
	}
	#close-button-row button {
		font-weight: normal;
		color: #403f3d;
		font-size: 16px;
		text-align: center;
		background-color: #5b7f95;
	}
	div.message-button {
		padding-top: 0px;
		padding-left: 25px;
	}
	button span.fa {
		padding-right: 7px;
		display: none;
	}
</style>
<div id="messageBanner">
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>
' WHERE `fk_id_layout` = @layoutId;


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('EXT Password OTP Form Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: BNP Sans Regular;
		width: 480px;
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
	#main-container .clear {
		clear: both;
		display: block;
	}
	#main-container #content #contentHeader custom-text.ng-isolate-scope {
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 100px;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-size: 14px;
		color: #403f3d;
	}
	#main-container #content #contentMain {
		margin-top: 1em;
		background-color: #f7f7f7;
		border-radius: 1em;
		padding: 1em;
		display: flex;
		flex-direction: column;
	}
	#main-container #content #contentMain span.custom-text.ng-binding {
		font-size: 14px;
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #content {
		text-align: left;
	}
	#main-container #content h2 {
		font-size: 1.25em;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container #content #contentMain .flex-right {
		align-self: flex-end;
	}
	#main-container #otp-input {
		display: flex;
		flex-direction: row;
		justify-content: flex-end;
		margin-top: 10px;
		align-self: flex-end;
	}
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#main-container .input-label {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	#main-container .otp-input input {
		margin-left: 16px;
	}
	#main-container #otp-input span {
		padding-right: 10px;
	}
	#main-container #otp-input input:focus {
		outline: none;
	}
	#main-container #footer {
		background-image: none;
		height: 100%;
		width: 100%;
		background-color: #f7f7f7;
		border-radius: 1em;
		clear: both;
		margin-top: 1em;
	}
	#main-container .contact {
		width: 70%;
		order: 1;
	}
	#main-container #footer .contact custom-text.ng-isolate-scope {
		text-align: center;
		color: #403f3d;
	}
	#main-container #footer .help-area .help-link #helpButton .btn-default {
		background-color: #5b7f95;
	}
	#main-container #helpButton button span {
		font-size: 16px;
		font-weight: normal;
		text-align: center;
		color: #749bb3;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 2px;
		background-color: #5b7f95;
	}
	#main-container #helpButton .fa-info {
		display: none;
	}
	#main-container .help-link {
		width: 30%;
		order: 2;
		text-align: right;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 0.7em;
	}
	#main-container #footer .small {
		font-size: 0.8em;
	}
	#main-container #footer .bold {
		font-size: 14px;
		font-weight: normal;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
	}
	#main-container #footer .bottom-margin {
		margin-bottom: 10px;
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
	#main-container .col-xs-12 {
		width: 100%;
		margin-bottom: 20px;
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
		padding: 0px;
		color: #5b7f95;
		font-size: 14px;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	#main-container .row .back-link span {
		text-align: left;
		margin-left: 0.5em;
		color: #749bb3;
	}
	#main-container .row .back-link span.fa-ban {
		display: none;
	}
	#main-container .row .submit-btn {
		text-align: right;
		float: right;
	}
	#main-container #val-button-container {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#main-container #validateButton button {
		font-size: 16px;
		height: 30px;
		line-height: 1.0;
		border-radius: 6px;
		background: #5b7f95;
		box-shadow: none;
		border: 0px;
		color: #fff;
		width: 163px;
	}
	#main-container #validateButton span.fa-check-square {
		display: none;
	}
</style>
<div id="main-container" class="ng-style="style" class="ng-scope">
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
	<div id="content">
			<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
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
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '
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
	.mobileapp {
		text-align: center;
	}
	#main-container {
		font-family: BNP Sans Regular;
		font-size: 14px;
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
	custom-text#title {
		font-weight: bold;
		font-size: 18px;
		color: #403f3d;
	}
	#content {
		text-align: left;
		color: #403f3d;
	}
	#content h2 {
		font-size: 14px;
		font-weight: normal;
		margin-bottom: 0.25em;
		margin-top: 0.25em;
		color: #403f3d;
	}
	.menu-elements {
		color: #403f3d;
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
		content: '';
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 0.7em;
	}
	#main-container #footer .small {
		font-size: 0.8em;
	}
	#main-container #footer .bold {
		font-size: 14px;
		font-weight: normal;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
	}
	#main-container #footer .bottom-margin {
		margin-bottom: 10px;
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
		border-radius: 6px;
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
		font-size: 16px;
		height: 38px;
		border-radius: 6px;
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
		color: #06c2d4;
	}
	#main-container .row .back-link span {
		text-align: left;
		margin-left: 0.5em;
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
		color: #749bb3;
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
</style>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Photo Tan Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: BNP Sans Regular;
		width: 100%;
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
	#main-container #content {
		text-align: left;
	}
	#main-container .leftMenuLayout {
		clear: both
	}
	#main-container #content #contentHeader {
		margin-bottom: 0.25em;
		margin-top: 0.25em;
	}
	#main-container #content #contentHeader custom-text.ng-isolate-scope {
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 146px;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-size: 14px;
		color: #403f3d;
	}
	#main-container #content #transactionDetails {
		margin-bottom: 1em;
		width: 100%;
	}
	#main-container .clear {
		clear: both;
		display: block;
	}
	#main-container #content #contentMain {
		font-size: 14px;
		font-weight: bold;
		text-align: center;
		margin-top: 1em;
		background-color: #f7f7f7;
		border-radius: 0.25em;
		padding: 1em;
	}
	#content h2 {
		font-size: 14px;
		font-weight: bold;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container #qrcontrols {
		display: flex;
		flex-direction: row;
	}
	#main-container #form-input span.custom-text.ng-binding {
		font-size: 14px;
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #form-input {
		align-items: start;
		display: flex;
		flex-direction: column;
	}
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#main-container #otp-input {
		display: flex;
		flex-direction: row;
		justify-content: flex-end;
		margin-top: 10px;
		align-self: flex-end;
	}
	#main-container #otp-form {
		margin-left: 10px;
	}
	.input-label {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	.otp-field input {
		margin-left: 16px;
	}
	.otp-field input:focus {
		outline: none;
	}
	#main-container #qr-display {
		display: flex;
		justify-content: center;
	}
	#main-container #form-controls-container {
		display: flex;
		justify-content: space-between;
	}
	#main-container #form-controls .back-link button:hover {
		background-color: #5b7f95;
	}
	#main-container #form-controls .back-link {
		text-align: left;
	}
	#main-container #form-controls .back-link button {
		border-style: none;
		background: none;
		padding: 0px;
		color: #5b7f95;
		font-size: 14px;
	}
	#main-container #form-controls .back-link span {
		text-align: left;
		margin-left: 0.5em;
		color: #749bb3;
	}
	#main-container #form-controls .back-link span.fa-ban {
		display: none;
	}
	#main-container #footer {
		width: 100%;
		background-color: #f7f7f7;
		margin-top: 1em;
		border-radius: 1em;
		background-image: none;
		height: auto;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	#main-container #helpButton button span {
		font-size: 16px;
		font-weight: normal;
		text-align: center;
		color: #749bb3;
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
	}
	#main-container #footer .extra-small {
		font-size: 0.7em;
	}
	#main-container #footer .small {
		font-size: 0.8em;
	}
	#main-container #footer .bold {
		font-size: 14px;
		font-weight: normal;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
	}
	#main-container #footer .bottom-margin {
		margin-bottom: 10px;
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
	#main-container .externalImage {
		padding: 1em;
		width: 100%;
		min-width: 268px;
		margin-left: auto;
		margin-right: auto;
	}
	p {
		margin-bottom: 10px;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto
	}
	#main-container .row button {
		font-size: 16px;
		height: 38px;
		border-radius: 6px;
		background: linear-gradient(#4dbed3, #007ea5);
		box-shadow: none;
		border: 0px;
		color: #fff;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#main-container #validateButton {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#main-container #validateButton button {
		font-size: 16px;
		height: 30px;
		line-height: 1.0;
		border-radius: 6px;
		background-color: #5b7f95;
		box-shadow: none;
		border: 0px;
		color: #fff;
		width: 163px;
	}
	#main-container #validateButton span.fa-check-square {
		display: none;
	}
	#main-container #val-button-container {
		align-self: flex-end;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	@media (max-width: 760px) {
		#main-container {width: auto;}
		body {font-size: 14px;}
		#header {height: 65px;}
		#networkLogo {width: 100px;}
		#schemeLogo {margin-top: 1em; width: 70px; height: 70px;}
		.transactiondetails ul li {text-align: left;}
		.transactiondetails ul li label {display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value {clear: both; text-align: left; margin-left: 0.5em;}
		.row {width: auto; clear: none;}
		.row .back-link {float: none; text-align: center; padding-top: 0.5em;}
		.row .submit-btn {float: none; text-align: center; padding-bottom: 0.5em;}
		.row button {width: 100%;}
		.mtan-input {display: flex; flex-direction: column; width: 100%; padding-bottom: 1em; padding-top: 1em;}
		.resendTan {margin-left: 0px; flex-grow: 2; text-align: center;}
		.resendTan a {color: #06c2d4; margin-left: 90px; padding-left: 16px;}
		.mtan-label {flex: 0 0 90px;}
		.input-label {justify-content: center;}
		.otp-field {display: inline;}
		.otp-field input {}
		#main-container #footer {width: 100%; background-image: none; background-color: #f5f5f5; height: unset;}
		#main-container #footer .help-area {display: flex; flex-direction: column; padding: 16px; text-align: center;}
		#main-container #helpButton button {border-style: none; padding: 0px}
		#main-container #helpButton .fa-info {display: none;}
		.help-link {width: 100%; order: 2; text-align: center; padding-top: 1em;}
		#main-container #footer .help-area .contact custom-text.ng-isolate-scope {text-align: center; color: #403f3d;}
		.contact {width: 100%; order: 1;}
		#main-container #footer .small-font {font-size: 0.75em;}
		#otp-error-message {margin-top: 0px; position: relative; background-color: #f5f5f5; text-align: center; width: 100%; margin-left: 0px; margin-bottom: 16px; box-sizing: border-box;}
		#otp-error-message:after {
		content:
	''; position: absolute; top: 0; left: 0px; width: 0; height: 0; border: 10px solid transparent; border-bottom-color: #f5f5f5; border-top: 0; margin-left: 50%; margin-top: -10px;}
		#main-container #qrcontrols {display: flex; flex-direction: column;}
	}
</style>
<div id="main-container">
		<div id="headerLayout">
		  <div id="pageHeader">
		  <div id="pageHeaderLeft">
			  <custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		  </div>
		  <div id="pageHeaderRight">
			  <custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false"></custom-image>
			  </div>
		  </div>
	  </div>
	  <div id="content">
			  <message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
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
 ' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: BNP Sans Regular;
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
		width: 100%;
		height: 76px;
		padding-bottom: 4px;
		margin-top: 8px;
		margin-bottom: 0px;
		border-bottom: 1px solid #dcdcdc;
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
	span#paragraph1 {
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
	}
	#main-container #content {
		text-align: left;
	}
	#main-container #content contentHeaderLeft {
		font-size: 1.25em;
		margin-bottom: 0.25em;
		margin-top: 0.25em;
	}
	#main-container .paragraph {
		display: block;
		margin-block-start: 1em;
		margin-block-end: 1em;
		margin-inline-start: 0px;
		margin-inline-end: 0px;
		margin-bottom: 10px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container #resend button span {
		color: #06c2d4;
	}
	#main-container #resend button {
		border-style: none;
		padding: 0px
	}
	#main-container .help-link {
		width: 30%;
		order: 2;
		text-align: right;
	}
	#main-container .contact {
		width: 70%;
		order: 1;
	}
	#main-container .mtan-input {
		padding-top: 25px;
		padding-bottom: 10px;
	}
	#main-container .resendTan {
		display: block;
		margin-left: 196px;
		margin-top: 10px;
		margin-bottom: 25px;
	}
	#main-container .input-label {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	#main-container .resendTan a {
		color: #06c2d4;
	}
	#main-container .mtan-label {
		text-align: right;
		flex: 0 0 180px
	}
	#main-container .otp-field input {
		margin-left: 16px;
	}
	#main-container .otp-field input:focus {
		outline: none;
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
		margin-top: 1em;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 0.7em;
	}
	#main-container #footer .small {
		font-size: 0.8em;
	}
	#main-container #footer .bold {
		font-size: 14px;
		font-weight: normal;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
	}
	#main-container #footer .bottom-margin {
		margin-bottom: 10px;
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
	#main-container #helpButton button span {
		color: #749bb3;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 2px;
		background-color: #5b7f95;
	}
	#main-container #helpButton .fa-info {
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
	#main-container .col-xs-12 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container message-banner {
		display: block;
		width: 100%;
		position: relative;
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
		padding: 0px;
		color: #06c2d4;
	}
	#main-container .row .back-link span {
		text-align: left;
		margin-left: 0.5em;
	}
	#main-container .row .back-link span.fa-ban {
		display: none;
	}
	#main-container .row .submit-btn {
		text-align: right;
		float: right;
	}
	#main-container #validateButton {
		font-size: 16px;
		height: 38px;
		border-radius: 6px;
		box-shadow: none;
		border: 0px;
	}
	#main-container #validateButton span.fa-check-square {
		display: none;
	}
	#main-container #validateButton button:disabled {
		font-size: 16px;
		height: 38px;
		border-radius: 6px;
		background: linear-gradient(#4dbed3, #007ea5);
		box-shadow: none;
		border: 0px;
		color: #fff;
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
		<div id="pageHeader">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<hamburger hamburger-text-key="''network_means_pageType_1''"></hamburger>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="mainLayout" class="row">
		<div id="content">
			<div id="contentHeaderLeft">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</div>
			</div>
			<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
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
						<div class="">
							<custom-text custom-text-key="''network_means_pageType_7''"></custom-text>
						</div>
					</div>
					<div class="line small">
						<div class="">
							<custom-text custom-text-key="''network_means_pageType_8''"></custom-text>
						</div>
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
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: BNP Sans Regular;
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
	#main-container #content #contentHeader custom-text.ng-isolate-scope {
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 100px;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-size: 14px;
		color: #403f3d;
	}
	#main-container #content {
		text-align: left;
	}
	#main-container #content h2 {
		font-size: 1.25em;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container #content #paragraph1 {
		font-size: 18px;
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
		margin-block-start: 1em;
		margin-block-end: 1em;
		margin-inline-start: 0px;
		margin-inline-end: 0px;
		margin-bottom: 10px;
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
		margin-top: 1em;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 0.7em;
	}
	#main-container #footer .small {
		font-size: 0.8em;
	}
	#main-container #footer .bold {
		font-size: 14px;
		font-weight: normal;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
	}
	#main-container #footer .bottom-margin {
		margin-bottom: 10px;
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
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #helpButton button span {
		font-size: 16px;
		font-weight: normal;
		text-align: center;
		color: #749bb3;
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
	#main-container .col-xs-12 {
		width: 100%;
		margin-bottom: 20px;
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
	</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#help-container {
		overflow: visible;
	}
	#helpContent {
		font-size: 16px;
		font-weight: normal;
		text-align: left;
		color: #403f3d;
		padding: 5px 10px 0px;
		min-height: 200px;
	}
	#helpContent #helpCloseButton div {
		display: inline;
	}
	#helpButton #help-container #helpContent #helpCloseButton button {
		font-size: 16px;
		font-weight: normal;
		height: 30px;
		line-height: 1.0;
		border-radius: 6px;
		background-color: #5b7f95;
		box-shadow: none;
		border: 0px;
		color: #403f3d;
		width: 163px;
	}
	#helpButton #help-container #helpContent #helpCloseButton span.fa-times {
		display: none;
	}
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
</style>
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
' WHERE `fk_id_layout` = @layoutId;


