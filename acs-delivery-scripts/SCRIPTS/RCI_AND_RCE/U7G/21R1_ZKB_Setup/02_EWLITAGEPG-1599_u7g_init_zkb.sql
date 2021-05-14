/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'W100851';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @activatedAuthMeans = '[ {
	"authentMeans" : "REFUSAL",
	"validate" : true
}, {
	"authentMeans" : "OTP_SMS_EXT",
	"validate" : true
}, {
	"authentMeans" : "MOBILE_APP_EXT",
	"validate" : true
}, {
	"authentMeans" : "INFO",
	"validate" : true
}, {
	"authentMeans" : "UNDEFINED",
	"validate" : true
} ]';

SET @availableAuthMeans = 'REFUSAL|OTP_SMS_EXT|MOBILE_APP_EXT|INFO|UNDEFINED';
SET @issuerNameAndLabel = 'Zürcher Kantonalbank ';
SET @issuerCode = '70000';
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					  `updateState`, `label`, `availaibleAuthentMeans`) VALUES
(@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, @updateState, @issuerNameAndLabel,
 @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Zürcher Kantonalbank ';
SET @subIssuerCode = '70000';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'de,fr,it';
SET @defaultLanguage = 'en';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
/*IAT*/
SET @acsURLVEMastercard = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*CAT*/
#SET @acsURLVEMastercard = 'https://ssl-liv-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-liv-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*PRD*/
#SET @acsURLVEMastercard = 'https://ssl-prd-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-prd-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';


/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'MOBILE_APP_EXT';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = '*,6,4';
SET @dateFormat = 'DD.MM.YYYY HH:mm|CET';
SET @currencyFormat = '{
							"useAlphaCurrencySymbol":true,
							"currencySymbolPosition":"LEFT",
							"decimalDelimiter":".",
							"thousandDelimiter":"''"
						}';
/* IAT/CAT */
SET @3DS2AdditionalInfo = '{
	  "VISA": {
		"operatorId": "acsOperatorVisa",
		"dsKeyAlias": "3DS2-VISA-CERTIFICATION"
	  }
}';

/* PRD */
/*
SET @3DS2AdditionalInfo = '{
		"VISA": {
		"operatorId": "acsOperatorVisa",
		"dsKeyAlias": "dsvisa_call_alias_cert_01"
		}
}';
*/
/* IAT */
SET @paChallengeURL = '{ "Vendome" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/" }';

/* CAT */
#SET @paChallengeURL = '{ "Vendome" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/" }';

/* PRD */
#SET @paChallengeURL = '{ "Vendome" : "https://authentication1.six-group.com/", "Brussels" : "https://authentication2.six-group.com/", "Unknown" : "https://secure.six-group.com/" }';

# SET @subIssuerIDNAB = (SELECT id FROM SubIssuer where code = 58810 AND name = 'Neue Aargauer Bank');


SET @cryptoConfigID = (SELECT id FROM CryptoConfig where description = 'CryptoConfig for RCH');


INSERT INTO `CryptoConfig` (`protocolOne`, `protocolTwo`, `description`)SELECT conf.protocolOne, conf.protocolTwo, 'CryptoConfig for ZKB' FROM `CryptoConfig` conf where conf.id = @cryptoConfigID;



SET @cryptoConfigIDNAB = (SELECT id FROM CryptoConfig where description = 'CryptoConfig for ZKB');
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
						 `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
						 `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
						 `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
						 `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
						 `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
						 `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`,`paChallengePublicUrl`,
						 `verifyCardStatus`,`3DS2AdditionalInfo`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
						 `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`, `fk_id_cryptoConfig`, `currencyFormat`) VALUES
  ('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @paChallengeURL, '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDNAB, @currencyFormat);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;

SET @BankB = 'Kantonal';
SET @BankUB = 'ZKB';

INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), @updateState, si.id
FROM `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (', @BankB, ')')),
	 (NULL,'OTP_FORM_PAGE', CONCAT('SMS OTP Form Page (', @BankB, ')')),
	 (NULL,'REFUSAL_PAGE', CONCAT('Refusal Page (', @BankB, ')')),
	 (NULL,'FAILURE_PAGE', CONCAT('Failure Page (', @BankB, ')')),
	 (NULL,'POLLING_PAGE', CONCAT('Polling Page (', @BankB, ')')),
	 (NULL,'HELP_PAGE', CONCAT('Help Page (', @BankB, ')')),
	 (NULL,'INFO_REFUSAL_PAGE', CONCAT('INFO Refusal Page (', @BankB, ')'));

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
	SELECT cpl.id, p.id
	FROM `CustomPageLayout` cpl, `ProfileSet` p
	WHERE cpl.description like CONCAT('%(', @BankB, '%') and p.id = @ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @BankB, ')%'));

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
	VALUES( 'div','
<style>
	#message-container {
		position:relative;
	}
	div#message-container.info {
		background-color:#de3919;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
	div#message-container.success {
		background-color:#449D44;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
	div#message-container.error {
		background-color:#de3919;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
	div#message-container.warn {
		background-color:#EC971F;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
	span#info-icon {
		position:absolute;
		top:15px;
		left:15px;
		float:none;
	}
	#headingTxt {
		font-family: Arial,bold;
		color: #FFFFFF;
		font-size : 14px;
		font-weight : bold;
		width : 70%;
		margin : auto;
		display : block;
		text-align:center;
		padding:4px 1px 1px 1px;
	}
	#message {
		font-family: Arial,regular;
		color: #FFFFFF;
		font-size:12px;
		text-align:center;
	}
	span#message {
		font-size:14px;
	}
	div.message-button {
		padding-top: 0px;
	}
	div#message-content {
		text-align: center;
		background-color: inherit;
		padding-bottom: 5px;
	}
	#return-button-row button {
		border-radius: 30px
	}
	#close-button-row button {
		border-radius: 30px
	}
	@media all and (max-width: 480px) {
		span#info-icon {position: absolute;font-size: 3em;top: 1px;left: 5px;display: inline-block;}
	}
</style>
<div id="messageBanner">
	<span id="info-icon" class="fa fa-info-circle"></span>
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );


INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
	VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	#optGblPage .warn {
		background-color: #3399ff
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 40%;
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
	#i18n > button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n-container {
		width: 100%;
		clear: both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear: both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color: #ffffff !important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom: 10px;
	}
	.paragraphDescription {
		text-align: left;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding-top: 1.5em;
		padding-right: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		padding-top: 1em;
		clear: both;
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align: center;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		text-align: left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
		display: grid;
	}
	#otp-form {
		display: inline-block;
		padding-top: 12px;
	}
	#otp-form input {
		box-sizing: content-box;
		padding: 5px 10px 3px;
		background-color: #fff;
		border: 1px solid rgba(0, 0, 0, .2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0, 0, 0, .1);
		font: 300 18px "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 35px;
	}
	#otp-form input:disabled {
		color: #bebebe !important;
		background-color: #dcdcdc !important;
		border-color: rgba(0, 0, 0, .05) !important;
		box-shadow: none !important;
	}
	#otp-form input:focus {
		border-color: #ff6a10 !important;
		outline-color: #ff6a10;
	}
	div#otp-fields-container {
		width: 100%;
		text-align: left;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	div#otp-fields {
		display: inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
		bottom: 40px;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	#reSendOtp > button {
		background: none !important;
		color: #000000;
		border: none;
		padding: 0 !important;
		font: inherit;
		cursor: pointer;
		font-family: Arial, regular;
		font-size: 12px;
	}
	#reSendOtp > button:disabled {
		background: none !important;
		color: #000000;
		border: none;
		padding: 0 !important;
		font: inherit;
		cursor: not-allowed;
		font-family: Arial, regular;
		font-size: 12px;
	}
	#validateButton {
		display: inline-block;
		padding-top: 10px;
		margin-left: 1em;
		border-radius: 20px;
	}
	#validateButton button {
		display: inline-block;
		font-family: "Arial", Helvetica, Arial, sans-serif;
		font-size: 14px;
		border-radius: 20px;
		color: #ffffff;
		background: #449d44;
		padding: 10px 30px 10px 20px;
		border: solid #449d44 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton button:disabled {
		display: inline-block;
		font-family: "Arial", Helvetica, Arial, sans-serif;
		font-size: 14px;
		border-radius: 20px;
		color: #000;
		background: #fff;
		border-color: #dcdcdc;
		padding: 10px 30px 10px 20px;
		border: solid #000 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton > button > span {
		display: inline-block;
		float: left;
		margin-top: 3px;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #4e4e4e;
		color: #ffffff;
		border: 1px solid #4e4e4e;
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#validateButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		width: 100%;
		background-color: #ada398;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-size: contain;
		display: inline-block;
		margin-left: 3px;
	}
	#footer #helpButton button span:before {
		content: '''';
	}
	#footer #cancelButton button span:before {
		content: '''';
	}
	#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.leftColumn { padding-bottom: 10em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		#optGblPage { font-size: 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 10px; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size: 18px; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { margin-left: 0px; display: block; float: none; width: 100%; margin-top: 10px;}
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size: 16px; }
		div.side-menu div.menu-title { display: inline; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 10px; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto;}
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 10px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 10px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 10px; }
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

		<div id="i18n-container" class="text-center">
			<div id="i18n-inner">
				<i18n></i18n>
			</div>
		</div>
		<div id="displayLayout" class="row">
			<div id="green-banner"></div>
		</div>
		<div class="contentRow">
			<div x-ms-format-detection="none" class="leftColumn">
				<side-menu menu-title="''network_means_pageType_11''"></side-menu>
			</div>
			<div class="rightColumn">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
				</div>
				<div class="paragraphDescription">
					<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
				</div>
				<div class="paragraphDescription">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<div id="otp-fields-container">
					<div x-ms-format-detection="none" id="otp-fields">
						<otp-form></otp-form>
					</div>
				</div>
				<div class="paragraph">
					<div class="refreshDiv">
						<span class="fa fa-life-ring" aria-hidden="true"></span>
						<re-Send-Otp id="reSendOtp" rso-Label="''network_means_pageType_19''"></re-Send-Otp>
					</div>
					<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
				</div>
			</div>
		</div>
		<div id="footer">
			<div ng-style="style" class="style">
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
				<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			</div>
		</div>
</div>
', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
	}
	#optGblPage .warn {
		background-color: #3399FF
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 40%;
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
		max-width:100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width:100%;
	}
	#i18n > button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n-container {
		width:100%;
		clear:both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear:both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color:#FFFFFF!important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom : 10px;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
		padding-top:1.5em;
		padding-bottom:1.5em;
		padding-right:1em;
	}
	.rightColumn {
		width:60%;
		margin-left:40%;
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
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align:center;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		display:inline;
		text-align:left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
		display: grid;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color:#ada398;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
	div#footer #helpButton button span:before {
		content:'''';
	}
	div#footer #cancelButton button span:before {
		content:'''';
	}
	div#footer #helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-y: -1px;
		background-size: 115%;
		display:inline-block;
	}
	div#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-size:contain;
		display:inline-block;
		margin-left: 3px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom:12px;
		clear:both;
		width:100%;
		background-color:#F0F0F0;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:8px;
	}
	#helpButton button:hover {
		border-color: rgba(255,106,16,.75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align:8px;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height : 55px; }
		#networkLogo {max-height : 55px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height : 50px; }
		#networkLogo {max-height : 50px; }
		#optGblPage {	  font-size : 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 60px;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height : 45px; }
		#networkLogo {max-height : 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; margin-top: 65px;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage {	font-size : 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height : 35px; }
		#networkLogo {max-height : 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 75px;}
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 85px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 115px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 120px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope">

		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<div class="contentRow">
		<div class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
	VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
	}
	#optGblPage .warn {
		background-color: #3399FF
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 40%;
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
		max-width:100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width:100%;
	}

	#i18n > button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	#i18n-container {
		width:100%;
		clear:both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear:both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color:#FFFFFF!important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		margin: 0px 0px 10px;
		text-align: left;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
		padding-top: 1.5em;
		padding-right: 1em;
	}
	.rightColumn {
		width:60%;
		margin-left:40%;
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
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align:center;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}

	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		display:inline;
		text-align:left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
		display: grid;
	}
	div#form-controls {
		padding-top: 15px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color:#ada398;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-size:contain;
		display:inline-block;
		margin-left: 3px;
	}
	#footer #helpButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-y: -1px;
		background-size: 115%;
		display:inline-block;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #4e4e4e;
		color: #ffffff;
		border: 1px solid #4e4e4e;
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:8px;
	}
	#helpButton button:hover {
		border-color: rgba(255,106,16,.75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align:8px;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height : 55px; }
		#networkLogo {max-height : 55px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#pageHeader {height: 90px;}
		#issuerLogo {max-height : 50px; }
		#networkLogo {max-height : 50px; }
		#optGblPage {	  font-size : 14px; }
		.leftColumn {display:block;float:none;width:100%; }
		.rightColumn {display:block;float:none;width:100%;margin-left:0px;	margin-top: 10px; }
		.paragraph {margin: 0px 0px 10px;text-align: center;}
		.paragraphDescription {text-align: center;}
		div#form-controls {text-align : center; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage {font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height : 45px; }
		#networkLogo {max-height : 45px; }
		.leftColumn {display:block;float:none;width:100%; }
		.rightColumn {margin-left:0px;display:block;float:none;width:100%;	margin-top: 10px; }
		.paragraph {margin: 0px 0px 10px;text-align: center;}
		.paragraphDescription {text-align: center;}
		div#form-controls {text-align : center; }
	}
	@media all and (max-width: 480px) {
		h1 {font-size:16px;}
		div.side-menu div.menu-title {display:inline;}
		#optGblPage {	font-size : 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height : 35px; }
		#networkLogo {max-height : 30px; }
		.leftColumn {display:block;float:none;width:100%; }
		.rightColumn {display:block;float:none;width:100%;margin-left:0px;	margin-top: 10px; }
		.paragraph {text-align: center;}
		.paragraphDescription {text-align: center;}
		div#form-controls {text-align : center; }
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 10px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 10px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 10px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope">
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<div class="contentRow">
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			 <div id="form-controls">
				<div class="TASwitchButton" >
						<div class="back-link">
							<switch-means-button change-means-label="''network_means_pageType_10''" id="switchId"></switch-means-button>
						</div>
					</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
	}
	#optGblPage .warn {
		background-color: #3399FF
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 40%;
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
		max-width:100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width:100%;
	}

	#i18n > button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	#i18n-container {
		width:100%;
		clear:both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear:both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color:#FFFFFF!important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom : 10px;
	}
	.paragraphDescription {
		text-align: center;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
		padding-top:1.5em;
		padding-bottom:1.5em;
		padding-right:1em;
	}
	.rightColumn {
		width:60%;
		margin-left:40%;
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
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align:center;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		display:inline;
		text-align:left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
		display: grid;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom:12px;
		clear:both;
		width:100%;
		background-color:#F0F0F0;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
	div#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-size:contain;
		display:inline-block;
		margin-left: 3px;
	}
	div#footer #helpButton button span:before {
		content:'''';
	}
	div#footer #cancelButton button span:before {
		content:'''';
	}
	div#footer #helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-y: -1px;
		background-size: 115%;
		display:inline-block;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
	}
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:8px;
	}
	#helpButton button:hover {
		border-color: rgba(255,106,16,.75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align:8px;
	}

	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height : 55px; }
		#networkLogo {max-height : 55px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height : 50px; }
		#networkLogo {max-height : 50px; }
		#optGblPage {	  font-size : 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 60px; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height : 45px; }
		#networkLogo {max-height : 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage {	font-size : 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height : 35px; }
		#networkLogo {max-height : 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 75px;}
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 85px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 115px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 120px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope">
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<div class="contentRow">
		<div class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>

		<div class="rightColumn">
			<div class="paragraph">

			</div>
			<div class="paragraph">

			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div','
<style>
	help-page {
		font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		padding:14px;
		overflow:auto;
		text-align:left;
	}
	#help-contents {
		text-align:left;
		margin-top:20px;
		margin-bottom:20px;
	}
	#help-container #help-modal {
		overflow:hidden;
	}
	#helpCloseButton button {
		display: flex;
		align-items: center;
		margin-left: auto;
		margin-right: auto;
		justify-content: center;
	}
	#helpCloseButton button custom-text {
		vertical-align:0px;
	}

	@media screen and (max-width: 700px) and (min-width: 361px) {
		#helpCloseButton > button {		}
	}
	@media screen and (max-width: 360px) {
		#helpCloseButton > button {		}
	}
	@media only screen and (max-width: 480px) {
		div#message-container {width:100%;box-shadow: none;-webkit-box-shadow:none;}
	}
</style>
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_1''"></custom-text></p>
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_2''"></custom-text>
			<custom-text custom-text-key="''network_means_HELP_PAGE_3''"></custom-text></p>

	</div>
	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button help-close-label="''network_means_HELP_PAGE_174''" id="helpCloseButton" help-label="help"></help-close-button>
		</div>
	</div>
</div>
', @layoutId);

SET @layoutIdRefusalPage =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	#optGblPage .warn {
		background-color: #3399ff
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 40%;
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
	#i18n > button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n-container {
		width: 100%;
		clear: both;
	}
	#i18n-inner {
		display: block;
		margin-left: auto;
		margin-right: auto;
		clear: both;
	}
	#i18n > button {
		background: transparent;
		color: #557a8e;
		border: none;
		box-shadow: none;
	}
	#i18n > button.active {
		background: #06446c !important;
		color: #ffffff !important;
		border-radius: 5px !important;
	}
	div#green-banner {
		height: 50px !important;
		background-color: #ada398;
		border-bottom: 5px solid #ada398;
		width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom: 10px;
	}
	.paragraphDescription {
		text-align: left;
		display: none;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding-top: 1.5em;
		padding-bottom: 1.5em;
		padding-right: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		padding-top: 1em;
		clear: both;
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align: center;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		text-align: left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
		display: grid;
	}
	div#message-controls {
		text-align: center;
		padding-bottom: 10px;
		padding-top: 0px;
	}
	div#message-container.warn {
		background-color:#de3919 !important;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		width: 100%;
		background-color: #ada398;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	div#footer #helpButton button span:before {
		content: '''';
	}
	div#footer #cancelButton button span:before {
		content: '''';
	}
	div#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-size: 115%;
		display: inline-block;
	}
	div#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-size: contain;
		display: inline-block;
		margin-left: 3px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		clear: both;
		width: 100%;
		background-color: #f0f0f0;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
	}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		#optGblPage { font-size: 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 60px;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size: 18px; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { margin-left: 0px; display: block; float: none; width: 100%; margin-top: 65px;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size: 16px; }
		div.side-menu div.menu-title { display: inline; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 75px;}
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 85px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 115px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 120px; }
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
	<alternative-display attribute="''externalWSResponse''" value="''40312''" enabled="''card_cooldown''" default-fallback="''card_blocked''" ></alternative-display>
	<div class="card_cooldown" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>
	</div>

	<div class="card_blocked" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner display-type="''1''" heading-attr="''network_means_pageType_32''" message-attr="''network_means_pageType_33''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>
	</div>
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<div class="contentRow">
		<div class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
', @layoutIdRefusalPage);

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;


/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', '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',
		'/');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_ZKBDECLINE_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_ZKBDECLINE'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_ZKBACCEPT_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_ZKBACCEPT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_EXT_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_SMS_EXT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_BACKUP_REFUSAL_Current'), NULL, NULL,
		CONCAT('customitemset_', @BankUB, '_BACKUP_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	  CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));
SET @customItemSetZKBACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ZKBACCEPT'));
SET @customItemSetZKBDECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ZKBDECLINE'));
SET @customItemSetMOBILEAPPEXT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_EXT'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetBackupRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_BACKUP_REFUSAL'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansMobileAppExt = (SELECT id FROM `AuthentMeans`	WHERE `name` = 'MOBILE_APP_EXT');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');
SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
						`updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
						`fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
						`fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'ZKB_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetZKBACCEPT, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'ZKB_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetZKBDECLINE, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'OTP_SMS_EXT', NULL, NULL, CONCAT(@BankUB,'_SMS_EXT_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'MOBILE_APP_EXT', NULL, NULL, CONCAT(@BankUB,'_APP_EXT_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansMobileAppExt, @customItemSetMOBILEAPPEXT, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'REFUSAL (FRAUD)', NULL, NULL, CONCAT(@BankUB,'_REFUSAL_FRAUD'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusalFraud, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_BACKUP_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$',
 @authMeanINFO, @customItemSetBackupRefusal, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@BankUB,'_UNDEFINED_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanUNDEFINED, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);

/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));
SET @profileZKBACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileZKBDECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileMOBILEAPPEXT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_APP_EXT_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_EXT_01'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @profileBackupINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_BACKUP_REFUSAL'));
SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusalFraud),
(@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
(@createdBy, NOW(), 'BACKUP_REFUSAL', NULL, NULL, 'BACKUP_REFUSAL', @updateState,3, @profileBackupINFO),
(@createdBy, NOW(), 'ZKB_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 4, @profileZKBACCEPT),
(@createdBy, NOW(), 'ZKB_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 5, @profileZKBDECLINE),
(@createdBy, NOW(), 'OTP_APP_EXT(NORMAL)', NULL, NULL, 'OOB (NORMAL)', @updateState, 6, @profileMOBILEAPPEXT),
(@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', @updateState, 8, @profileSMS),
(@createdBy, NOW(), 'OTP_SMS_EXT (BACKUP)', NULL, NULL, 'OTP_SMS_EXT (BACKUP)', @updateState, 9, @profileSMS),
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, 'UNDEFINED', @updateState, 10, @profileUNDEFINED),
(@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 11, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud);
SET @ruleZKBAccept = (SELECT id FROM `Rule` WHERE `description` = 'ZKB_ACCEPT' AND `fk_id_profile` = @profileZKBACCEPT);
SET @ruleZKBDecline = (SELECT id FROM `Rule` WHERE `description` = 'ZKB_DECLINE' AND `fk_id_profile` = @profileZKBDECLINE);
SET @ruleMobileAppEXT = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP_EXT(NORMAL)' AND `fk_id_profile` = @profileMOBILEAPPEXT);
SET @ruleSMSFallBack = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleSMSBackUP = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (BACKUP)' AND `fk_id_profile` = @profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);
SET @ruleBackupInfo = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupINFO);
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_03_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_04_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_05_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_ZKB_ACCEPT'), @updateState, @ruleZKBAccept),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_ZKB_DECLINE'), @updateState, @ruleZKBDecline),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_APP_EXT'), @updateState, @ruleMobileAppEXT),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT'), @updateState, @ruleSMSFallBack),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT'), @updateState, @ruleSMSFallBack),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP'), @updateState, @ruleSMSBackUP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP'), @updateState, @ruleSMSBackUP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), @updateState, @ruleRefusalDefault),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @ruleINFOnormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_BACKUP_REFUSAL'), @updateState, @ruleBackupInfo),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_UNDEFINED'), @updateState, @ruleUNDEFINED);

/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;

-- REFUSAL --

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
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_05_FRAUD') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);

-- MISSING AUTHENTICATION --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
AND mps.`fk_id_authentMean`=@authMeanINFO
AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

-- ACCEPT --

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ZKB_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ZKB_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

-- DECLINE --

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ZKB_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_ZKB_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);

-- MOBILE APP EXT --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_EXT')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_EXT')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_EXT')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_EXT')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_EXT')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);


-- OTP_SMS_EXT	--

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);



INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);


-- UNDEFINED --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authMeanUNDEFINED AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authentMeansMobileAppExt AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_UNDEFINED')
AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


-- BACKUP --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authentMeansMobileAppExt
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_BACKUP')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);



INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_DEFAULT') AND (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_BACKUP_REFUSAL')
AND mps.`fk_id_authentMean` = @authMeanOTPsms
AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);



/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleZKBAccept, @ruleZKBDecline, @ruleMobileAppEXT, @ruleSMSFallBack, @ruleSMSBackUP, @ruleRefusalDefault, @ruleINFOnormal, @ruleBackupInfo, @ruleUNDEFINED);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`, `expertMode`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID, 0);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;