/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A707825';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "EXT_PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
} ]';
SET @issuerCode = '41001';
/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Liechtensteinische Landesbank AG';
SET @subIssuerCode = '88000';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'en,fr,it';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'EXT_PASSWORD';
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

SET @3DS2AdditionalInfo = '{
	  "VISA": {
		"operatorId": "acsOperatorVisa",
		"dsKeyAlias": "3DS2-VISA-CERTIFICATION"
	  }
}';

set @availableAuthMeans = 'REFUSAL|OTP_SMS_EXT_MESSAGE|MOBILE_APP|INFO|UNDEFINED|EXT_PASSWORD';
update Issuer set availaibleAuthentMeans = @availableAuthMeans where id = @issuerId;


SET @subIssuerIDSOBA = (SELECT id FROM SubIssuer where code = 83340 AND name = 'Baloise Bank SoBa AG');
SET @cryptoConfigIdSOBA = (SELECT fk_id_cryptoConfig FROM SubIssuer where name = 'Baloise Bank SoBa AG');

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
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, FALSE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://secure.six-group.com/', '1', @3DS2AdditionalInfo,'3', TRUE, TRUE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIdSOBA, @currencyFormat);
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
SELECT `acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`, `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`,  @subIssuerID
FROM `SubIssuerCrypto` si WHERE si.fk_id_subIssuer = @subIssuerIDSOBA ;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB = 'LLB';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
	SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), @updateState, si.id
	FROM `SubIssuer` si
	WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'EXT_PASSWORD_OTP_FORM_PAGE', CONCAT('EXT Password OTP Form Page (', @BankB, ')'));

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
	SELECT cpl.id, p.id
	FROM `CustomPageLayout` cpl, `ProfileSet` p
	WHERE cpl.description like CONCAT('%(', @BankB, '%') and p.id = @ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('EXT Password OTP Form Page (', @BankB, ')') );

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
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
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
				<div id="otp-fields-container">
					<div x-ms-format-detection="none" id="otp-fields">
						<otp-form></otp-form>
					</div>
				</div>
				<div class="paragraph">
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
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_RBADECLINE'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_PASSWORD_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_PASSWORD'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_SMS'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '__MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_REFUSAL_FRAUD'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBADECLINE'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansPassword = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'EXT_PASSWORD');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'PASSWORD', NULL, NULL, CONCAT(@BankUB,'_PASSWORD_01'), @updateState, 3, '6:(:DIGIT:1)', '^[^OIi]*$', @authentMeansPassword, @customItemSetPassword,
   NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (FRAUD)', NULL, NULL, CONCAT(@BankUB,'_REFUSAL_FRAUD'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusalFraud, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);


/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusalFraud),
  (@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 3, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 4, @profileRBADECLINE),
  (@createdBy, NOW(), 'OTP_PASSWORD (COMBINED)', NULL, NULL, 'PASSWORD (COMBINED)', @updateState, 5, @profilePassword),
  (@createdBy, NOW(), 'OTP_SMS_EXT (COMBINED)', NULL, NULL, 'OTP_SMS_EXT (COMBINED)', @updateState, 6, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 7, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @rulePassword = (SELECT id FROM `Rule` WHERE `description` = 'OTP_PASSWORD (COMBINED)' AND `fk_id_profile` = @profilePassword);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (COMBINED)' AND `fk_id_profile` = @profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_03_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_04_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_05_FRAUD'), @updateState, @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT'), @updateState, @ruleRBAAccept),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE'), @updateState, @ruleRBADecline),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_PASSWORD_COMBINED'), @updateState, @rulePassword),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED'), @updateState, @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), @updateState, @ruleRefusalDefault),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @ruleINFOnormal);

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
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_05_FRAUD') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);

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
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_PASSWORD_COMBINED') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED') AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_PASSWORD_COMBINED')
	AND mps.`fk_id_authentMean` = @authentMeansPassword
	AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_PASSWORD_COMBINED')
	AND mps.`fk_id_authentMean` = @authentMeansPassword
	AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_PASSWORD_COMBINED')
	AND mps.`fk_id_authentMean` = @authentMeansPassword
	AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_PASSWORD_COMBINED')
	AND mps.`fk_id_authentMean` = @authentMeansPassword
	AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed` = true);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED')
	AND mps.`fk_id_authentMean` = @authMeanOTPsms
	AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = true);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_COMBINED')
	AND mps.`fk_id_authentMean` = @authentMeansPassword
	AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

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

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
	SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
	WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @rulePassword, @ruleSMSnormal, @ruleRefusalDefault, @ruleINFOnormal);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`, `expertMode`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID, 0);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
