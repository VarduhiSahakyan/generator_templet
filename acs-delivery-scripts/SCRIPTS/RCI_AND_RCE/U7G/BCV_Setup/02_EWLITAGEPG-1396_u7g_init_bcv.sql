USE `U7G_ACS_BO`;

SET @createdBy = 'A709391';
SET @updateState =  'PUSHED_TO_CONFIG';

SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
}]';

SET @availableAuthMeans = 'REFUSAL|OTP_SMS_EXT_MESSAGE|MOBILE_APP|INFO';
SET @issuerNameAndLabel = 'Banque Cantonale Vaudoise';
SET @issuerCode = '76700';

INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `availaibleAuthentMeans`) VALUES
(@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, @updateState, @issuerNameAndLabel, @availableAuthMeans);

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Banque Cantonale Vaudoise';
SET @subIssuerCode = '76700';

SET @backUpLanguages = 'en,de';
SET @defaultLanguage = 'fr';

SET @HUBcallMode = 'PA_ONLY_MODE';

/*IAT*/
SET @acsURLVEMastercard = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*CAT*/
#SET @acsURLVEMastercard = 'https://ssl-liv-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-liv-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*PRD*/
#SET @acsURLVEMastercard = 'https://ssl-prd-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-prd-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

SET @preferredAuthMean = 'MOBILE_APP';

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
	  },
	  "MASTERCARD": {
		"operatorId": "acsOperatorMasterCard",
		"dsKeyAlias": "key-masterCard"
	  }
}';
/* PRD */
/*
SET @3DS2AdditionalInfo = '{
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "dsvisa_call_alias_cert_01"
      },
      "MASTERCARD": {
        "operatorId": "ACS-V210-EQUENSWORLDLINE-34926",
        "dsKeyAlias": "1"
      }
}';
*/

/* IAT */
SET @paChallengeURL = '{ "Vendome" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/" }';

/* CAT */
#SET @paChallengeURL = '{ "Vendome" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/" }';

/* PRD */
#SET @paChallengeURL = '{ "Vendome" : "https://authentication1.six-group.com/", "Brussels" : "https://authentication2.six-group.com/", "Unknown" : "https://secure.six-group.com/" }';


SET @cryptoConfigID = (SELECT id FROM CryptoConfig where description = 'CryptoConfig for RCH');

INSERT INTO `CryptoConfig` (`protocolOne`, `protocolTwo`, `description`)SELECT conf.protocolOne, conf.protocolTwo, 'CryptoConfig for BCV' FROM `CryptoConfig` conf where conf.id = @cryptoConfigID;

SET @cryptoConfigIDBCV = (SELECT id FROM CryptoConfig where description = 'CryptoConfig for BCV');

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
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @paChallengeURL, '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDBCV, @currencyFormat);


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

SET @bank = 'BCV';

INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT(@bank, ' profile set'), NULL, NULL, CONCAT('PS_', @bank, '_01'), @updateState, si.id
FROM `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @bank, '_01'));

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (', @bank, ')')),
       (NULL,'OTP_FORM_PAGE', CONCAT('SMS OTP Form Page (', @bank, ')')),
       (NULL,'REFUSAL_PAGE', CONCAT('Refusal Page (', @bank, ')')),
       (NULL,'FAILURE_PAGE', CONCAT('Failure Page (', @bank, ')')),
       (NULL,'POLLING_PAGE', CONCAT('Polling Page (', @bank, ')')),
       (NULL,'HELP_PAGE', CONCAT('Help Page (', @bank, ')')),
       (NULL,'INFO_REFUSAL_PAGE', CONCAT('INFO Refusal Page (', @bank, ')'));

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
SELECT cpl.id, p.id
FROM `CustomPageLayout` cpl, `ProfileSet` p
WHERE cpl.description like CONCAT('%(', @bank, '%') and p.id = @ProfileSet;

SET @messageBannerLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @bank, ')%'));
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
</div>', @messageBannerLayoutId);

SET @smsLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @bank, ')%') );
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
', @smsLayoutId);

SET @refusalLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @bank, ')%') );
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

   <alternative-display attribute="''currentProfileName''" value="''BCV_REFUSAL_FRAUD''" enabled="''fraud_refusal''" default-fallback="''default_refusal''" ></alternative-display>
	<div class="fraud_refusal" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner display-type="''1''" heading-attr="''network_means_pageType_220''" message-attr="''network_means_pageType_230''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>
	</div>
	<div class="default_refusal" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" ></message-banner>
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
', @refusalLayoutId);

SET @pollingLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @bank, ')%') );
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
', @pollingLayoutId);

SET @failureLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @bank, ')%') );
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
</div>', @failureLayoutId);

SET @helpLayoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @bank, ')%') );
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
', @helpLayoutId);

SET @infoLayoutId =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @bank, ')%') );
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
', @infoLayoutId);

INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@bank,' Logo'), NULL, NULL, @bank, 'PUSHED_TO_CONFIG', 'iVBORw0KGgoAAAANSUhEUgAACToAAAKeCAYAAACP5DZ8AAAACXBIWXMAAFxGAABcRgEUlENBAAA4KWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxMTEgNzkuMTU4MzI1LCAyMDE1LzA5LzEwLTAxOjEwOjIwICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDYtMjhUMTY6MTY6MjcrMDI6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxOS0xMS0xOVQxNDowOTozMyswMTowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTktMTEtMTlUMTQ6MDk6MzMrMDE6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6NDBiZWNmMGYtYTE2Ni0zNTQwLWI1ZDQtMzk5ZTA1ODYwZjdhPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD54bXAuZGlkOjQwYmVjZjBmLWExNjYtMzU0MC1iNWQ0LTM5OWUwNTg2MGY3YTwveG1wTU06RG9jdW1lbnRJRD4KICAgICAgICAgPHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD54bXAuZGlkOjQwYmVjZjBmLWExNjYtMzU0MC1iNWQ0LTM5OWUwNTg2MGY3YTwveG1wTU06T3JpZ2luYWxEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNyZWF0ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDo0MGJlY2YwZi1hMTY2LTM1NDAtYjVkNC0zOTllMDU4NjBmN2E8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDYtMjhUMTY6MTY6MjcrMDI6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj42MDAwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj42MDAwMDAwLzEwMDAwPC90aWZmOllSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjY1NTM1PC9leGlmOkNvbG9yU3BhY2U+CiAgICAgICAgIDxleGlmOlBpeGVsWERpbWVuc2lvbj4yMzYyPC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY3MDwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg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', '/');


SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
    (@createdBy, NOW(), CONCAT('customitemset_', @bank, '__MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
     CONCAT('customitemset_', @bank, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
    (@createdBy, NOW(), CONCAT('customitemset_', @bank, '_MOBILE_APP_Current'), NULL, NULL,
     CONCAT('customitemset_', @bank, '_MOBILE_APP'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
    (@createdBy, NOW(), CONCAT('customitemset_', @bank, '_SMS_Current'), NULL, NULL,
     CONCAT('customitemset_', @bank, '_SMS'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
    (@createdBy, NOW(), CONCAT('customitemset_', @bank, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
     CONCAT('customitemset_', @bank, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);


SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_MOBILE_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@bank,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @bank, '_DEFAULT_REFUSAL'));

SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@bank,'_ACCEPT'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@bank,'_DECLINE'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'MOBILE_APP', NULL, NULL, CONCAT(@bank,'_APP_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@bank,'_SMS_01'), @updateState, 4,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'REFUSAL (FRAUD)', NULL, NULL, CONCAT(@bank,'_REFUSAL_FRAUD'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@bank,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@bank,'_BACKUP_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@bank,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);


SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank, '_REFUSAL_FRAUD'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_MISSING_AUTHENTICATION_REFUSAL'));
SET @profileBackupINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_BACKUP_REFUSAL'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_DECLINE'));
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank, '_DEFAULT_REFUSAL'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_APP_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@bank,'_SMS_01'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusalFraud),
(@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
(@createdBy, NOW(), 'BACKUP_REFUSAL', NULL, NULL, 'BACKUP_REFUSAL', @updateState,3, @profileBackupINFO),
(@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 4, @profileRBAACCEPT),
(@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 5, @profileRBADECLINE),
(@createdBy, NOW(), 'OTP_APP(NORMAL)', NULL, NULL, 'TA (NORMAL)', @updateState, 6, @profileMOBILEAPP),
(@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', @updateState, 7, @profileSMS),
(@createdBy, NOW(), 'OTP_SMS_EXT (BACKUP)', NULL, NULL, 'OTP_SMS_EXT (BACKUP)', @updateState, 8, @profileSMS),
(@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 9, @profileRefusal);


SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP(NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleSMSFallBack = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleSMSBackUP = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (BACKUP)' AND `fk_id_profile` = @profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);
SET @ruleBackupInfo = (SELECT id FROM `Rule` WHERE `description` = 'BACKUP_REFUSAL' AND `fk_id_profile` = @profileBackupINFO);


INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_02_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_03_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_04_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_05_FRAUD'), @updateState, @ruleRefusalFraud),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_RBA_ACCEPT'), @updateState, @ruleRBAAccept),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_RBA_DECLINE'), @updateState, @ruleRBADecline),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_OTP_APP'), @updateState, @ruleMobileAppnormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT'), @updateState, @ruleSMSFallBack),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT_BACKUP'), @updateState, @ruleSMSBackUP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_02_OTP_SMS_EXT_BACKUP'), @updateState, @ruleSMSBackUP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_DEFAULT'), @updateState, @ruleRefusalDefault),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @ruleINFOnormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL'), @updateState, @ruleBackupInfo);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_FRAUD') AND (ts.`transactionStatusType` = 'PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_02_FRAUD') AND (ts.`transactionStatusType` = 'CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_03_FRAUD') AND (ts.`transactionStatusType` = 'CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_04_FRAUD') AND (ts.`transactionStatusType` = 'MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_05_FRAUD') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_RBA_ACCEPT') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_RBA_DECLINE') AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_DEFAULT') AND (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE);

/* Condition_MeansProcessStatuses */
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_02_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_02_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_02_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_02_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_02_OTP_SMS_EXT_BACKUP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@bank,'_01_MISSING_AUTHENTICATION_REFUSAL')
  AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @bank, '_01_BACKUP_REFUSAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_PROCESS_ERROR' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@bank,'_01_MISSING_AUTHENTICATION_REFUSAL')
  AND mps.`fk_id_authentMean`=@authMeanINFO
  AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@bank,'_01_MISSING_AUTHENTICATION_REFUSAL')
  AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@bank,'_01_MISSING_AUTHENTICATION_REFUSAL')
  AND mps.`fk_id_authentMean`=@authentMeansMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);


INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @bank, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @ruleMobileAppnormal,  @ruleSMSFallBack, @ruleSMSBackUP, @ruleRefusalDefault, @ruleINFOnormal, @ruleBackupInfo);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`, `expertMode`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID, 0);

