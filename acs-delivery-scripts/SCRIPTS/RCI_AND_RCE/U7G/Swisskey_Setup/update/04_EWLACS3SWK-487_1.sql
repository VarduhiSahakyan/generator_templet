USE `U7G_ACS_BO`;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';

SET @issuerCode = '41001';
SET @subIssuerNameAndLabel = 'Swisskey Unified AG';
SET @subIssuerCode = '41002';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = 'en,fr,it';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
/*IAT*/
#SET @acsURLVEMastercard = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-qlf-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*CAT*/
#SET @acsURLVEMastercard = 'https://ssl-liv-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
#SET @acsURLVEVisa = 'https://ssl-liv-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/*PRD*/
SET @acsURLVEMastercard = 'https://ssl-prd-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-prd-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'MOBILE_APP';
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
/*SET @3DS2AdditionalInfo = '{
	  	  "VISA": {
		"operatorId": "acsOperatorVisa",
		"dsKeyAlias": "3DS2-VISA-CERTIFICATION"
	  },
	  "MASTERCARD": {
		"operatorId": "acsOperatorMasterCard",
		"dsKeyAlias": "key-masterCard"
	  }
}';*/

/* PRD */
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

/* PASSWORD and OTP_SMS used for PWD_OTP Authentication mean like child . PWD_OTP works only with OTP_SMS and PASSWORD.
   In code PWD_OTP will map to EXTOTP_PWD */
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "PWD_OTP",
  "validate" : true
}, {
  "authentMeans" : "PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
} ]';

/* IAT */
#SET @paChallengeURL = '{ "Vendome" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-qlf-u7g-fo-acs-pa.wlp-acs.com/" }';

/* CAT */
#SET @paChallengeURL = '{ "Vendome" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Seclin" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/", "Unknown" : "https://ssl-liv-u7g-fo-acs-pa.wlp-acs.com/" }';

/* PRD */
SET @paChallengeURL = '{ "Vendome" : "https://authentication1.six-group.com/", "Brussels" : "https://authentication2.six-group.com/", "Unknown" : "https://secure.six-group.com/" }';

# SET @subIssuerIDNAB = (SELECT id FROM SubIssuer where code = 58810 AND name = 'Neue Aargauer Bank');

SET @subIssuerIDNAB = (SELECT id FROM SubIssuer where code = 77800 AND name = 'Luzerner KB AG');
SET @cryptoConfigIDNAB = (SELECT fk_id_cryptoConfig FROM SubIssuer where id = @subIssuerIDNAB);
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`,`paChallengePublicUrl`,
                         `verifyCardStatus`,`3DS2AdditionalInfo`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`, `fk_id_cryptoConfig`, `currencyFormat`, `npaEnabled`) VALUES
('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
 @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
 @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
 @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @paChallengeURL, '1', @3DS2AdditionalInfo,'3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans, @cryptoConfigIDNAB, @currencyFormat, TRUE);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);


/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB = 'SWISSKEY_UNIFIED';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), @updateState, si.id
FROM `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;

/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));


/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
SELECT cpl.id, p.id
FROM `CustomPageLayout` cpl, `ProfileSet` p
WHERE cpl.description like CONCAT('%(', @BankB, '%') and p.id = @ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;



/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @cisMissingAuthSwisskey = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_MISSING_AUTHENTICATION_REFUSAL');
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL_Current'), `lastUpdateBy`, `lastUpdateDate`,
       CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'),
       `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, @subIssuerID
FROM CustomItemSet WHERE `id` = @cisMissingAuthSwisskey;


SET @cisMissingAuthSwisskeyUnified = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                          `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
       `fk_id_network`, `fk_id_image`, @cisMissingAuthSwisskeyUnified FROM `CustomItem` n
        WHERE fk_id_customItemSet = @cisMissingAuthSwisskey AND `DTYPE` != 'I';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                          `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
       `fk_id_network`, `fk_id_image`, @cisMissingAuthSwisskeyUnified FROM `CustomItem` n
WHERE fk_id_customItemSet = @cisMissingAuthSwisskey AND `DTYPE` = 'I' AND `ordinal` = 2;

UPDATE `CustomItem` SET `fk_id_customItemSet` = @cisMissingAuthSwisskeyUnified WHERE `ordinal` = 88000 AND
                                                                                     `DTYPE` = 'I' AND
                                                                                     `fk_id_customItemSet` = @cisMissingAuthSwisskey;


SET @cisOTP_OverrideSwisskey = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_SMS_OVERRIDE');
UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_SMS_OVERRIDE'),
                           `description` = CONCAT('customitemset_', @BankUB, '_SMS_OVERRIDE_Current'),
                           `fk_id_subIssuer` = @subIssuerID
WHERE `id` = @cisOTP_OverrideSwisskey;


SET @cisPWD_OverrideSwisskey = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_PASSWORD');
UPDATE `CustomItemSet` SET `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'),
                           `description` = CONCAT('customitemset_', @BankUB, '_PASSWORD_Current'),
                           `fk_id_subIssuer` = @subIssuerID
WHERE `id` = @cisPWD_OverrideSwisskey;



SET @cisRefusalSwisskey = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_DEFAULT_REFUSAL');
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
SELECT @createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), `lastUpdateBy`, `lastUpdateDate`,
       CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'),
       `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, @subIssuerID
FROM CustomItemSet WHERE `id` = @cisRefusalSwisskey;

SET @cisRefusalSwisskeyUnified = (SELECT `id` FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                          `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`,
                          `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
       `fk_id_network`, `fk_id_image`, @cisRefusalSwisskeyUnified FROM `CustomItem` n
WHERE fk_id_customItemSet = @cisRefusalSwisskey AND `DTYPE` NOT LIKE 'I';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                          `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
       `fk_id_network`, `fk_id_image`, @cisRefusalSwisskeyUnified FROM `CustomItem` n
WHERE fk_id_customItemSet = @cisRefusalSwisskey AND `DTYPE` = 'I' AND `ordinal` = 2;

UPDATE `CustomItem` SET `fk_id_customItemSet` = @cisRefusalSwisskeyUnified WHERE `ordinal` = 88000 AND
                                                                                    `DTYPE` = 'I' AND
                                                                                    `fk_id_customItemSet` = @cisRefusalSwisskey;

SET @cisRefusalFRAUDSwisskeyUnified = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_SWISSKEY_REFUSAL_FRAUD');
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                          `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
       `fk_id_network`, `fk_id_image`, @cisRefusalSwisskeyUnified FROM `CustomItem` n
WHERE fk_id_customItemSet = @cisRefusalFRAUDSwisskeyUnified AND `DTYPE` = 'T' AND `ordinal` in (220,230);

/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;


set @customPageLayoutDesc = 'Refusal Page (SWISSKEY)';
set @pageType = 'REFUSAL_PAGE';

set @pageLayoutId = (select id
                     from `CustomPageLayout`
                     where `pageType` = @pageType
                       and DESCRIPTION = @customPageLayoutDesc);

UPDATE `CustomComponent` SET `value` = '
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
div#bankLogoDiv {width: 40%;float: left;padding-left: 16px;height: 100%;display: flex;align-items: center;}
div#bankLogoDiv img.custom-image {max-height: 64px; max-width: 100%}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="bankLogoDiv">
			<alternative-display attribute="''issuer''" value="''48350''" enabled="''cs_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="cs_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_48350_IMAGE_ALT''" image-key="''network_means_pageType_48350_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''58810''" enabled="''nab_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="nab_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_58810_IMAGE_ALT''" image-key="''network_means_pageType_58810_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''78100''" enabled="''sgkb_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="sgkb_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_78100_IMAGE_ALT''" image-key="''network_means_pageType_78100_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''83340''" enabled="''soba_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="soba_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_83340_IMAGE_ALT''" image-key="''network_means_pageType_83340_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''77800''" enabled="''lukb_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="lukb_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_77800_IMAGE_ALT''" image-key="''network_means_pageType_77800_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''87310''" enabled="''bali_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="bali_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_87310_IMAGE_ALT''" image-key="''network_means_pageType_87310_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			 <alternative-display attribute="''issuer''" value="''79000''" enabled="''bekb_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="bekb_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_79000_IMAGE_ALT''" image-key="''network_means_pageType_79000_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''77400''" enabled="''grkb_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="grkb_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_77400_IMAGE_ALT''" image-key="''network_means_pageType_77400_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			 <alternative-display attribute="''issuer''" value="''88000''" enabled="''llb_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
				<div class="llb_logo_div" ng-style="style" class="ng-scope" style="display: none;">
					<custom-image alt-key="''network_means_pageType_88000_IMAGE_ALT''" image-key="''network_means_pageType_88000_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			 <alternative-display attribute="''issuer''" value="''78400''" enabled="''tgkb_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="tgkb_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_78400_IMAGE_ALT''" image-key="''network_means_pageType_78400_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''69900''" enabled="''entris_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="entris_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_69900_IMAGE_ALT''" image-key="''network_means_pageType_69900_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<alternative-display attribute="''issuer''" value="''77900''" enabled="''nidwalden_logo_div''" default-fallback="''defaultContent''" ></alternative-display>
			<div class="nidwalden_logo_div" ng-style="style" class="ng-scope" style="display: none;">
				<custom-image alt-key="''network_means_pageType_77900_IMAGE_ALT''" image-key="''network_means_pageType_77900_IMAGE_DATA''" class="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div class="defaultContent" ng-style="style" class="ng-scope" style="display: none;"></div>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<alternative-display attribute="''currentProfileName''" value="''SWISSKEY_REFUSAL_FRAUD''" enabled="''fraud_refusal''" default-fallback="''default_refusal''" ></alternative-display>
	<div class="fraud_refusal" ng-style="style" class="ng-scope" style="display: none;">
		<message-banner display-type="''1''" heading-attr="''network_means_pageType_220''" message-attr="''network_means_pageType_230''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>
	</div>
    <alternative-display attribute="''currentProfileName''" value="''SWISSKEY_UNIFIED_REFUSAL_FRAUD''" enabled="''unified_fraud_refusal''" default-fallback="''default_refusal''" ></alternative-display>
	<div class="unified_fraud_refusal" ng-style="style" class="ng-scope" style="display: none;">
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
' WHERE fk_id_layout = @pageLayoutId;


SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_OVERRIDE'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansPassword = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PASSWORD');
SET @authentMeansPasswordOTP = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PWD_OTP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');


INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
SELECT @createdBy, NOW(), `description`, `lastUpdateBy`, `lastUpdateDate`, CONCAT(@BankUB,'_REFUSAL_FRAUD'), `updateState`,
       `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`, NULL, NULL, NULL, @subIssuerID FROM `Profile`
WHERE `name` = 'SWISSKEY_REFUSAL_FRAUD';


INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
SELECT @createdBy, NOW(), `description`, `lastUpdateBy`, `lastUpdateDate`, CONCAT(@BankUB,'_ACCEPT'), `updateState`,
       `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`, NULL, NULL, NULL, @subIssuerID FROM `Profile`
WHERE `name` = 'SWISSKEY_ACCEPT';

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
SELECT @createdBy, NOW(), `description`, `lastUpdateBy`, `lastUpdateDate`, CONCAT(@BankUB,'_DECLINE'), `updateState`,
       `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`, NULL, NULL, NULL, @subIssuerID FROM `Profile`
WHERE `name` = 'SWISSKEY_DECLINE';

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
SELECT @createdBy, NOW(), `description`, `lastUpdateBy`, `lastUpdateDate`, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), `updateState`,
       `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`, @customItemSetRefusal, NULL, NULL, @subIssuerID FROM `Profile`
WHERE `name` = 'SWISSKEY_DEFAULT_REFUSAL';

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_OTP_PWD'),
                     `fk_id_subIssuer` = @subIssuerID
WHERE `name` = 'SWISSKEY_OTP_PWD';

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_PASSWORD_Override'),
                     `fk_id_subIssuer` = @subIssuerID
WHERE `name` = 'SWISSKEY_PASSWORD_Override';

UPDATE `Profile` SET `name` = CONCAT(@BankUB,'_SMS_Override'),
                     `fk_id_subIssuer` = @subIssuerID
WHERE `name` = 'SWISSKEY_SMS_Override';


INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`)
SELECT @createdBy, NOW(), `description`, `lastUpdateBy`, `lastUpdateDate`, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), `updateState`,
       `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`, @customItemSetINFORefusal, NULL, NULL, @subIssuerID FROM `Profile`
WHERE `name` = 'SWISSKEY_MISSING_AUTHENTICATION_REFUSAL';


/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRefusalFraud = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REFUSAL_FRAUD'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_Override'));
SET @profilePasswordOTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_OTP_PWD'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_Override'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusalFraud),
(@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
(@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 3, @profileRBAACCEPT),
(@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 4, @profileRBADECLINE),
(@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 8, @profileRefusal);

UPDATE `Rule` SET `orderRule` = 5 WHERE `fk_id_profile` =  @profilePasswordOTP;
UPDATE `Rule` SET `orderRule` = 6 WHERE `fk_id_profile` =  @profilePassword;
UPDATE `Rule` SET `orderRule` = 7 WHERE `fk_id_profile` =  @profileSMS;
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;


/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusalFraud);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @rulePasswordOTP = (SELECT id FROM `Rule` WHERE `description` = 'PWD_OTP_NORMAL' AND `fk_id_profile` = @profilePasswordOTP);
SET @rulePasswordOverride = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD_OVERRIDE' AND `fk_id_profile` = @profilePassword);
SET @ruleSMSnormalOverride = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_OVERRIDE' AND `fk_id_profile` = @profileSMS);
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
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), @updateState, @ruleRefusalDefault),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @ruleINFOnormal);

UPDATE `RuleCondition` SET `name` = CONCAT('C1_P_', @BankUB, '_01_PWD_OTP_NORMAL')
WHERE `name` = CONCAT('C1_P_', @BankB, '_01_PWD_OTP_NORMAL');

UPDATE `RuleCondition` SET `name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_OVERRIDE')
WHERE `name` = CONCAT('C1_P_', @BankB, '_01_PASSWORD_OVERRIDE');

UPDATE `RuleCondition` SET `name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_OVERRIDE')
WHERE `name` = CONCAT('C1_P_', @BankB, '_01_OTP_SMS_OVERRIDE');

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

/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;


/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
  AND mps.`fk_id_authentMean`=@authentMeansPasswordOTP AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

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

UPDATE `BinRange` SET `fk_id_profileSet` = @ProfileSet WHERE `lowerBound` = '4396640000' and `upperBound` = '4396640099';


/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline,@rulePasswordOTP, @rulePasswordOverride, @ruleSMSnormalOverride, @ruleRefusalDefault, @ruleINFOnormal);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;


SET @profileSetSWK = (SELECT `id` FROM `ProfileSet` WHERE `name` = 'PS_SWISSKEY_01');
DELETE FROM `ProfileSet_Rule` WHERE `id_profileSet` = @profileSetSWK and `id_rule` in (@rulePasswordOTP, @rulePasswordOverride, @ruleSMSnormalOverride);


SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
SELECT n.id, si.id
FROM `Network` n, `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
  AND n.code = 'MASTERCARD';

INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
SELECT n.id, si.id
FROM `Network` n, `SubIssuer` si
WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID
  AND n.code = 'VISA';
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '1111111111', 16, FALSE, NULL, '1111111111', FALSE, @ProfileSet, @MaestroMID, NULL);
/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
SELECT b.id, s.id
FROM BinRange b, SubIssuer s
WHERE b.lowerBound='1111111111' AND b.upperBound='1111111111' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`, `expertMode`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID, 0);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;


