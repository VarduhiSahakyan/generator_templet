use U7G_ACS_BO;

set @BankUB = 'UBS';
set @BankB = 'UBS';
set @createdBy = 'A707825';

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

start transaction;
SET FOREIGN_KEY_CHECKS = 0;
/*EWLACS3SWK-143*/
delete from CustomItem
where ordinal in (174, 175)
	and fk_id_customItemSet in (@customItemSetRefusal, @customItemSetMOBILEAPP, @customItemSetSMS, @customItemSetINFORefusal)
	and DTYPE = 'T' and createdBy = @createdBy;


/*EWLACS3SWK-145*/
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @BankB, ')%') );

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

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
	}
	#main-container   #pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#main-container   #pageHeaderRight {
		width: 25%;
		float: right;
		text-align: right;
		padding-top: 16px;
	}
	#main-container  #issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container   #networkLogo {
		max-height: 100%;
		max-width: 100%;
	}
	#main-container   #content {
		text-align:left;
		margin-left: 3em;
	}
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt;
		font-size: 24px;
		color: #1C1C1C;
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
		color: #1C1C1C;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display:none;
	}
	#main-container .menu-elements {
		margin-right:9%;
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
	#main-container   .mtan-input {
		padding-bottom:8px;
	}
	#main-container   .input-label {
		flex-direction: row;
		align-items: center;
	}
	#main-container   .mtan-label {
		text-align:left;
		flex: 0 0 180px;
		font-family: Frutiger55Roman;
		font-size: 12px;
		color: #646464;
		letter-spacing: 0;
		line-height: 16px
	}
	#main-container   .otp-field input {
		font-size: 16px;
		color: #1C1C1C;
		background: #FFFFFF;
		margin-left:0px;
		border: 1px solid #AAAAAA;
		width: 218px;
		height: 48px;
	}
	#main-container   .otp-field input:focus {
		outline:none;
	}
	#main-container   message-banner {
		display: inline-block;
		margin-top: 5px;
		position: relative;
		width: 218px;
	}
	#main-container #resend button {
		border-style: none;
		padding:0px
	}
	#main-container #resend button span{
		color:#007099;
	}
	#main-container   .resendTan {
		font-size: 14px;
		line-height: 20px;
		display:block;
		margin-bottom: 16px;
		color:#007099;
	}
	#main-container   .resendTan a {
		color:#007099;
	}
	#main-container   .row .left {
		float:left;
		width:180px;
		text-align:right;
	}
	#main-container   .row .left span {
		margin-right:0.5em
	}
	#main-container   .row .submit-btn {
		text-align:left;
		float:left;
	}
	#main-container   #validateButton button{
		font-size: 14px;
		width: 104px;
		height: 38px;
		border-radius: 2px;
		background: #6A7D39;
		opacity: 1;
		box-shadow: none;
		border: 0px;
		color: #FFFFFF;
		margin-right: 8px;
	}
	#main-container   #cancelButton button{
		font-size: 14px;
		width: 104px;
		height: 38px;
		border-radius: 2px;
		border: 1px solid #919191;
		box-shadow: none;
		background: #FFFFFF;
	}
	#main-container   #validateButton span.fa-check-square{
		display:none;
	}
	#main-container   #cancelButton span.fa-ban{
		display:none;
	}
	#main-container   #helpButton span.fa-info{
		display:none;
	}
	#main-container #validateButton button:disabled {
		font-size: 14px;
		width: 104px;
		height: 38px;
		border-radius: 2px;
		background: #6A7D39;
		box-shadow: none;
		border: 0px;
		color: #FFFFFF;
	}
	#main-container   div#footer {
		background-image:none;
		height:44px;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
	}
	#main-container   #footer:after {
		content: "";
		height:100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container  #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container  .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color:#007099;
	}
	#main-container #helpButton  button {
		border-style: none;
		padding:0px
	}
	#main-container #helpButton  button span{
		color:#007099;
		background-color: #f7f7f7;
	}
	#main-container   .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-5 {
		width: 34%;
	}
	#main-container   .col-sm-6 {
		width: 65%;
	}
	#main-container   .col-xs-12 {
		width: 100%;
	}
	#main-container   .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 0%; }
		#main-container  .resendTan {width: 86%; text-align: center;}
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container  .help-link {width: 70%;text-align: center;}
	}
	@media all and (max-width: 500px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {margin-right: 9%;}
		#main-container #contentBottom { padding-left: 6%; }
		#main-container .otp-field input { width: 218px; }
		#main-container message-banner { width: 218px; }
		#main-container  .resendTan {width: 82%; text-align: center;}
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 61%;text-align: center;}
	}

	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {margin-right: 0%;}
		#main-container #contentBottom { padding-left: 28%;}
		#main-container .otp-field input { width: 218px; }
		#main-container message-banner { width: 218px; }
		#main-container  .resendTan {width: 72%; text-align: center;}
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 36%;text-align: center;}
	}

	@media all and (max-width: 250px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {margin-right: 0px;}
		#main-container #contentBottom { padding-left: 0%; }
		#main-container .otp-field input { width: 218px; }
		#main-container message-banner { width: 218px; }
		#main-container .row .submit-btn { text-align: center; float: none; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 29%;text-align: center;}
	}

</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div id="contentHeaderLeft">
					<h3><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h3>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
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
                        <message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>
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
	</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
	}
	#main-container   #pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#main-container   #pageHeaderRight {
		width: 25%;
		float: right;
		text-align: right;
		padding-top: 16px;
	}
	#main-container  #issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container   #networkLogo {
		max-height: 100%;
		max-width: 100%;
	}
	#main-container  #content {
		text-align:left;
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
		color: #1C1C1C;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display:none;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 35%;
	}
	#main-container   message-banner {
		display: inline-block;
		margin-top: 5px;
		position: relative;
		width: 218px;
	}
	#main-container   div#footer {
		background-image:none;
		height:44px;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
	}
	#main-container   #footer:after {
		content: "";
		height:100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container  #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container  .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color:#007099;
	}
	#main-container #helpButton  button span{
		color:#007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton  button {
		border-style: none;
		padding:0px
	}
	#main-container   #helpButton span.fa-info{
		display:none;
	}
	#main-container   .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-5 {
		width: 34%;
	}
	#main-container   .col-sm-6 {
		width: 65%;
	}
	#main-container   .col-xs-12 {
		width: 100%;
	}
	#main-container   .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container   .row .left {
		float:left;
		width:180px;
		text-align:right;
	}
	#main-container   .row .left span {
		margin-right:0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container  .help-link { width: 66%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 15%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 56%;text-align: center;}
	}

	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		#main-container message-banner { width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 33%;text-align: center;}
	}

	@media all and (max-width: 250px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 5%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 29%;text-align: center;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div>
                        <message-banner></message-banner>
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
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
	}
	#main-container   #pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#main-container   #pageHeaderRight {
		width: 25%;
		float: right;
		text-align: right;
		padding-top: 16px;
	}
	#main-container  #issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container   #networkLogo {
		max-height: 100%;
		max-width: 100%;
	}
	#main-container  #content {
		text-align:left;
		margin-left: 3em;
	}
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt;
		font-size: 24px;
		color: #1C1C1C;
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
		color: #1C1C1C;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display:none;
	}
	#main-container .menu-elements {
		padding-right:10%;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 32%;
	}
	#main-container   message-banner {
		display: inline-block;
		margin-top: 5px;
		position: relative;
		width: 218px;
	}
	#main-container #link-text {
		font-size: 12px;
		display: inline-block;
		margin-top: 5px;
		position: relative;
		text-align: left;
		width: 218px;
	}
	#main-container   div#footer {
		background-image:none;
		height:44px;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
	}
	#main-container   #footer:after {
		content: "";
		height:100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container  #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container  .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color:#007099;
	}
	#main-container #helpButton  button span{
		color:#007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton  button {
		border-style: none;
		padding:0px
	}
	#main-container   #helpButton span.fa-info{
		display:none;
	}
	#main-container   #return-button-row-2 button{
		font-family: FrutigerforUBSWeb;
		font-size: 16px;
		border-radius: 0px;
		margin-top: 8px;
	}
	#main-container   .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-5 {
		width: 34%;
	}
	#main-container   .col-sm-6 {
		width: 65%;
	}
	#main-container   .col-xs-12 {
		width: 100%;
	}
	#main-container   .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container   .row .left {
		float:left;
		width:180px;
		text-align:right;
	}
	#main-container   .row .left span {
		margin-right:0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 3%; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container  .help-link { width: 69%;text-align: center;}
	}
	@media all and (max-width: 500px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {padding-right: 10%;}
		#main-container #contentBottom { padding-left:10%; }
		#main-container message-banner { width: 218px; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 59%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {padding-right: 0%;}
		#main-container #contentBottom { padding-left: 30%;}
		#main-container message-banner { width: 218px; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 33%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 5%; }
		#main-container message-banner { width: 218px; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 29%;text-align: center;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div id="contentHeaderLeft">
					<h3><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h3>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div>
                        <message-banner></message-banner>
                    </div>
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
                              <button class="btn btn-default" ng-click="returnButtonAction()"> <custom-text custom-text-key="''network_means_pageType_40''" class="ng-isolate-scope"></custom-text> </button>
                        </div>
                    </div>
                </div>
		</div>
</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
	}
	#main-container   #pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#main-container   #pageHeaderRight {
		width: 25%;
		float: right;
		text-align: right;
		padding-top: 16px;
	}
	#main-container  #issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container   #networkLogo {
		max-height: 100%;
		max-width: 100%;
	}
	#main-container  #content {
		text-align:left;
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
		color: #1C1C1C;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display:none;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 35%;
	}
	#main-container   message-banner {
		display: inline-block;
		margin-top: 5px;
		position: relative;
		width: 218px;
	}
	#main-container   div#footer {
		background-image:none;
		height:44px;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
	}
	#main-container   #footer:after {
		content: "";
		height:100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container  #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container  .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color:#007099;
	}
	#main-container #helpButton  button span{
		color:#007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton  button {
		border-style: none;
		padding:0px
	}
	#main-container   #helpButton span.fa-info{
		display:none;
	}
	#main-container   .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-5 {
		width: 34%;
	}
	#main-container   .col-sm-6 {
		width: 65%;
	}
	#main-container   .col-xs-12 {
		width: 100%;
	}
	#main-container   .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container   .row .left {
		float:left;
		width:180px;
		text-align:right;
	}
	#main-container   .row .left span {
		margin-right:0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container  .help-link { width: 69%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 16%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 59%;text-align: center;}
	}

	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		#main-container message-banner { width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 30%;text-align: center;}
	}

	@media all and (max-width: 250px) {
		#main-container #content { text-align: c; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 5%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 29%;text-align: center;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div>
                        <message-banner></message-banner>
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
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
	}
	#main-container   #pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#main-container   #pageHeaderRight {
		width: 25%;
		float: right;
		text-align: right;
		padding-top: 16px;
	}
	#main-container  #issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container   #networkLogo {
		max-height: 100%;
		max-width: 100%;
	}
	#main-container  #content {
		text-align:left;
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
		color: #1C1C1C;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display:none;
	}
	#main-container .menu-elements {
		padding-right:10%;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 32%;
	}
	#message-container {
		display: inline-block;
		margin-top: 5px;
		position: relative;
		width: 196px;
	}
	div#message-content {
		text-align: center;
		background-color: inherit;
		padding-bottom: 5px;
		background-color:#F7E1DF;
		font-family: FrutigerforUBSWeb;
		font-size:12px;
		color: #E0B519;
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
		color: #1C1C1C;
		font-size:12px;
		line-height: 16px;
		text-align:center;
	}
	span#message {
		font-size:10px;
		width: 100%;
	}
	div.message-button {
		padding-top: 0px;
		display: none;
	}
	div#spinner-row .spinner div div{
		background: #E0B519!important;
	}
	#main-container   div#footer {
		background-image:none;
		height:44px;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
	}
	#main-container   #footer:after {
		content: "";
		height:100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container  #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top:24px;
	}
	#main-container  .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color:#007099;
	}
	#main-container #helpButton  button span{
		color:#007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton  button {
		border-style: none;
		padding:0px
	}
	#main-container   #helpButton span.fa-info{
		display:none;
	}
	#main-container   .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container   .col-sm-5 {
		width: 34%;
	}
	#main-container   .col-sm-6 {
		width: 65%;
	}
	#main-container   .col-xs-12 {
		width: 100%;
	}
	#main-container   .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container   .row .left {
		float:left;
		width:180px;
		text-align:right;
	}
	#main-container   .row .left span {
		margin-right:0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container  .help-link { width: 66%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 15%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 56%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		#main-container message-container { width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link {width: 33%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 5%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container  .help-link { width: 29%;text-align: center;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<div id="content">
		<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>

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
' WHERE `fk_id_layout` = @layoutId;



/*EWLACS3SWK-146*/
DELETE FROM `Image` WHERE `name` = 'VISA_LOGO_SMALL';

SET @idImageVisaScheme = (SELECT id FROM `Image` im WHERE im.name LIKE '%VISA_LOGO%');

UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetRefusal ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetMOBILEAPP ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE CustomItem SET `fk_id_image` = @idImageVisaScheme WHERE `ordinal` = 2 AND `name` = 'Visa Logo' AND `fk_id_customItemSet` = @customItemSetINFORefusal ;
SET FOREIGN_KEY_CHECKS = 1;
commit;