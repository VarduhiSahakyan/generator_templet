/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
}, {
  "authentMeans" : "PHOTO_TAN",
  "validate" : true
}, {
  "authentMeans" : "EXT_PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "ATTEMPT",
  "validate" : true
} ]';
SET @issuerCode = '16900';
/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'BNP Paribas Wealth Management';
SET @subIssuerCode = '16901';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'de';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'MOBILE_APP_EXT';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = '*,6,4';
SET @dateFormat = 'DD.MM.YYYY  HH:mm|GMT';

SET @3DS2AdditionalInfo = '  {
	  "VISA": {
		"operatorId": "acsOperatorVisa",
		"dsKeyAlias": "3DS2-VISA-CERTIFICATION"
	  },
	  "MASTERCARD": {
		"operatorId": "acsOperatorMasterCard",
		"dsKeyAlias": "key-masterCard"
	  }
	}';
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
						 `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
						 `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
						 `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
						 `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
						 `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
						 `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`,`paChallengePublicUrl`,
						 `verifyCardStatus`,`3DS2AdditionalInfo`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
						 `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`) VALUES
  ('ACS_U5G', 300, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://ssl-qlf-u5g-fo-acs-pa.wlp-acs.com/', '1', @3DS2AdditionalInfo,'3', TRUE, TRUE, b'0', b'0', @activatedAuthMeans);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerCrypto                                                               /!\
--  /!\ This is a very specific configuration, in production environment only,        /!\
--  /!\ for internal and external acceptance, use the one given here                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerCrypto` DISABLE KEYS */;
INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
							   `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
	SELECT '0A', '1', '03', 'EC11223344554B544F4B5F4D5554555F414301', 'EC11223344554B544F4B5F4D5554555F414300', '1', '01', 'NO_SECOND_FACTOR', si.id
	FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = '16900';
SET @BankUB = 'BNP';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
	SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), @updateState, si.id
	FROM `SubIssuer` si
	WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (', @BankUB, ')')),
	   (NULL,'EXT_PASSWORD_OTP_FORM_PAGE', CONCAT('EXT Password OTP Form Page (', @BankUB, ')')),
	   (NULL,'POLLING_PAGE', CONCAT('Polling Page (', @BankUB, ')')),
	   (NULL,'PHOTO_TAN_OTP_FORM_PAGE', CONCAT('Photo Tan Page (', @BankUB, ')')),
	   (NULL,'REFUSAL_PAGE', CONCAT('Refusal Page (', @BankUB, ')')),
	   (NULL,'FAILURE_PAGE', CONCAT('Failure Page (', @BankUB, ')')),
	   (NULL,'HELP_PAGE', CONCAT('Help Page (', @BankUB, ')'));


SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
	SELECT cpl.id, p.id
	FROM `CustomPageLayout` cpl, `ProfileSet` p
	WHERE cpl.description like CONCAT('%(', @BankUB, '%') and p.id = @ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;


/*!40000 ALTER TABLE `CustomPageLayout` DISABLE KEYS  */;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @BankUB, ')%'));

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`) VALUES ( 'div','
<style>
	#message-container {
		position: relative;
	}
	div#message-container {
		padding-top: 5px;
	}
	div#message-container.info {
		background-color: #f5f5f5;
		font-family: BNP Sans Regular;
		font-size: 12px;
		color: #403f3d;
	}
	div#message-container.success {
		background-color: #f5f5f5;
		font-family: BNP Sans Regular;
		font-size: 12px;
		color: #7f9c90;
	}
	div#message-container.error {
		background-color: #f5f5f5;
		font-family: BNP Sans Regular;
		font-size: 12px;
		color: #ab7270;
	}
	div#message-container.warn {
		background-color: #f5f5f5;
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
		font-weight: normal;
		text-align: center;
		width: 100%;
		padding-left: 25px;
	}
	custom-text#headingTxt {
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
		font-weight: normal;
		color: #403f3d;
		font-size: 16px;
		text-align: center;
		background-color: #5b7f95;
	}
	#close-button-row button {
		font-family: BNP Sans Regular;
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
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('EXT Password OTP Form Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`) VALUES ( 'div', '
<style>
	#main-container {
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
		font-family: BNP Sans Regular;
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 100px;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #footer .help-area .help-link #helpButton .btn-default {
		background-color: #5b7f95;
	}
	#main-container #helpButton button span {
		font-family: BNP Sans Regular;
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
		font-weight: bold;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
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
		font-family: BNP Sans Regular;
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
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`) VALUES ( 'div', '
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
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
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
			</div>
		</div>
		<div id="copyright" class="extra-small">
			<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
			<div><span><custom-text custom-text-key="''network_means_pageType_44''"></custom-text></span></div>
		</div>
	</div>
</div>
<style>
	:root {
		font-family: proximaLight, Times;
		padding: 0px;
		margin: 0px;
	}
	.mobileapp {
		text-align: center;
	}
	#main-container {
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
	#content {
		text-align: left;
		color: #403f3d;
	}
	#content h2 {
		font-size: 1.25em;
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
		font-weight: bold;
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
', @layoutId);


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Photo Tan Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES ('div', '
<style>
	#main-container {
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
		font-family: BNP Sans Regular;
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 146px;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
		font-weight: bold;
		text-align: center;
		margin-top: 1em;
		background-color: #f7f7f7;
		border-radius: 0.25em;
		padding: 1em;
	}
	#content h2 {
		font-size: 1.25em;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container #qrcontrols {
		display: flex;
		flex-direction: row;
	}
	#main-container #form-input span.custom-text.ng-binding {
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
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
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		#networkLogo {
			width: 100px;
		}
		#schemeLogo {
			margin-top: 1em;
			width: 70px;
			height: 70px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.row {
			width: auto;
			clear: none;
		}
		.row .back-link {
			float: none;
			text-align: center;
			padding-top: 0.5em;
		}
		.row .submit-btn {
			float: none;
			text-align: center;
			padding-bottom: 0.5em;
		}
		.row button {
			width: 100%;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
			text-align: center;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
			justify-content: center;
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			background-image: none;
			background-color: #f5f5f5;
			height: unset;
		}
		#main-container #footer .help-area {
			display: flex;
			flex-direction: column;
			padding: 16px;
			text-align: center;
		}
		#main-container #helpButton button {
			border-style: none;
			padding: 0px
		}
		#main-container #helpButton .fa-info {
			display: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		#main-container #footer .help-area .contact custom-text.ng-isolate-scope {
			font-family: BNP Sans Regular;
			font-size: 14px;
			font-weight: normal;
			text-align: center;
			color: #403f3d;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#main-container #footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
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
			margin-left: 50%;
			margin-top: -10px;
		}
		#main-container #qrcontrols {
			display: flex;
			flex-direction: column;
		}
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
		  </div>', @layoutId);


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	:root {
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
		font-weight: bold;
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
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES(  'div', '
 <style>
	:root {
		font-family: proximaLight, Times;
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
		font-family: BNP Sans Regular;
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 100px;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
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
		font-family: BNP Sans Regular;
		font-size: 14px;
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #helpButton button span {
		font-family: BNP Sans Regular;
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
	</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
	VALUES( 'div', '
	<style>
	#help-container {
		overflow: visible;
	}
	#helpContent {
		font-family: BNP Sans Regular;
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
		font-family: BNP Sans Regular;
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
 </div>', @layoutId);

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;


/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES
(@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', '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',
		'/');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_1_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_1_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),

  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),

  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_PHOTO_TAN_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_PHOTO_TAN'), @updateState, @status, 1, NULL, NULL, @subIssuerID),

  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_ACCEPT_MAINT_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_ACCEPT_MAINT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),

  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_PASSWORD_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_PASSWORD'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_1_REFUSAL'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetPhotoTan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PHOTO_TAN'));
SET @customItemSetAcceptMaint = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ACCEPT_MAINT'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanAttempt = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ATTEMPT');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP_EXT');
SET @authMeanPhotoTan = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PHOTO_TAN');
SET @authMeanPassword = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'EXT_PASSWORD');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
	(@createdBy, NOW(), 'Authentication refused', NULL, NULL, CONCAT(@BankUB,'_REFUSAL_01'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), 'Authentication by Mobile App', NULL, NULL, CONCAT(@BankUB,'_MOBILE_APP_EXT_01'), @updateState, 3, '6:(:DIGIT:1)', '^[^OIi]*$', @authMeanMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), 'Authentication by Photo Tan', NULL, NULL, CONCAT(@BankUB,'_PHOTO_TAN_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanPhotoTan, @customItemSetPhotoTan, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), 'Automatic Authentication', NULL, NULL, CONCAT(@BankUB,'_ACCEPT_01'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanAttempt, @customItemSetAcceptMaint, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), 'Authentication by Ext Password', NULL, NULL, CONCAT(@BankUB,'_PASSWORD_01'), @updateState, 3, '4:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)', '^[^OIi]*$', @authMeanPassword, @customItemSetPassword, NULL, NULL, @subIssuerID);
	/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_01'));
SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MOBILE_APP_EXT_01'));
SET @profilePhotoTan = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PHOTO_TAN_01'));
SET @profileAcceptMaint = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT_01'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
	(@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusal),
	(@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'ACCEPT (RBA)', @updateState, 2, @profileAcceptMaint),
	(@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'DECLINE (RBA)', @updateState, 3, @profileRefusal),
	(@createdBy, NOW(), 'MOBILE_APP_AVAILABLE_NORMAL', NULL, NULL, 'MOBILE_APP(NORMAL)', @updateState, 4, @profileMobileApp),
	(@createdBy, NOW(), 'PHOTO_TAN_AVAILABLE_NORMAL', NULL, NULL, 'PHOTO_TAN (NORMAL)', @updateState, 5, @profilePhotoTan),
	(@createdBy, NOW(), 'PASSWORD_AVAILABLE_NORMAL', NULL, NULL, 'EXT_PASSWORD(NORMAL)', @updateState, 6, @profilePassword),
	(@createdBy, NOW(), 'ACCEPT_MAINTANCE_NORMAL', NULL, NULL, 'ACCEPT MAINT', @updateState, 8, @profileAcceptMaint),
	(@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 9, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusal);
SET @ruleMobileApp = (SELECT id FROM `Rule` WHERE `description` = 'MOBILE_APP_AVAILABLE_NORMAL' AND `fk_id_profile` = @profileMobileApp);
SET @rulePhotoTan = (SELECT id FROM `Rule` WHERE `description` = 'PHOTO_TAN_AVAILABLE_NORMAL' AND `fk_id_profile` = @profilePhotoTan);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileAcceptMaint);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRefusal);
SET @ruleAcceptMaint = (SELECT id FROM `Rule` WHERE `description` = 'ACCEPT_MAINTANCE_NORMAL' AND `fk_id_profile` = @profileAcceptMaint);
SET @rulePassword = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD_AVAILABLE_NORMAL' AND `fk_id_profile` = @profilePassword);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_FRAUD'), @updateState, @ruleRefusalFraud),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_FRAUD'), @updateState, @ruleRefusalFraud),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_03_FRAUD'), @updateState, @ruleRefusalFraud),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_04_FRAUD'), @updateState, @ruleRefusalFraud),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT'), @updateState, @ruleRBAAccept),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE'), @updateState, @ruleRBADecline),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MOBILE_APP_NORMAL'), @updateState, @ruleMobileApp),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_PASSWORD_NORMAL'), @updateState, @rulePassword),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN'), @updateState, @rulePhotoTan),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_ACCEPT'), @updateState, @ruleAcceptMaint),
	(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), @updateState, @ruleRefusalDefault);

/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_FRAUD') AND (ts.`transactionStatusType` = 'PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_FRAUD') AND (ts.`transactionStatusType` = 'CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_03_FRAUD') AND (ts.`transactionStatusType` = 'CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_04_FRAUD') AND (ts.`transactionStatusType` = 'MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_DEFAULT') AND (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PHOTO_TAN') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
		AND mps.`fk_id_authentMean` = @authMeanPhotoTan AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ACCEPT')
		AND mps.`fk_id_authentMean` = @authMeanAttempt AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = TRUE);

--

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MOBILE_APP_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

--

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
		AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

--

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN')
		AND mps.`fk_id_authentMean` = @authMeanPhotoTan AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN')
		AND mps.`fk_id_authentMean` = @authMeanPhotoTan AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PHOTO_TAN')
		AND mps.`fk_id_authentMean`=@authMeanPhotoTan AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PHOTO_TAN')
		AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN')
		AND mps.`fk_id_authentMean` = @authMeanMobileApp AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PHOTO_TAN')
		AND mps.`fk_id_authentMean` = @authMeanPhotoTan AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);


--

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;
SET @ruleConditionPhotoTan = (SELECT `id` FROM `RuleCondition` WHERE `fk_id_rule` = @rulePhotoTan);
SET @ruleConditionPassword = (SELECT `id` FROM `RuleCondition` WHERE `fk_id_rule` = @rulePassword);
SET @ruleConditionAcceptMaint = (SELECT `id` FROM `RuleCondition` WHERE `fk_id_rule` = @ruleAcceptMaint);
/*!40000 ALTER TABLE `TransactionValue` DISABLE KEYS */;
INSERT INTO `TransactionValue` (`reversed`, `transactionValueType`, `value`, `fk_id_condition`) VALUES
	(b'1', 'DEVICE_CHANNEL', '01', @ruleConditionPhotoTan ),
	(b'1', 'DEVICE_CHANNEL', '01', @ruleConditionPassword ),
	(b'1', 'DEVICE_CHANNEL', '01', @ruleConditionAcceptMaint );
/*!40000 ALTER TABLE `TransactionValue` ENABLE KEYS */;


/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
	SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
	WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud,
																   @ruleRBAAccept,
																   @ruleRBADecline,
																   @ruleMobileApp,
																   @ruleRefusalDefault,
																   @rulePhotoTan,
																   @rulePassword,
																   @ruleAcceptMaint);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
