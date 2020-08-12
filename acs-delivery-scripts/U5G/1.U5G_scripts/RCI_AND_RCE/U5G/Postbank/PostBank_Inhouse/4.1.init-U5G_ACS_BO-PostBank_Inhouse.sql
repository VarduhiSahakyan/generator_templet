/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;


/* add the new authentication means */

INSERT INTO `AuthentMeans` (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
  SELECT 'InitPhase', sysdate(), 'KBA', NULL, NULL, 'KBA', 'PUSHED_TO_CONFIG' FROM dual
  WHERE NOT EXISTS (SELECT id FROM `AuthentMeans` where name = 'KBA');

INSERT INTO `AuthentMeans` (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
  SELECT 'InitPhase', sysdate(), 'EXT_PASSWORD', NULL, NULL, 'EXT_PASSWORD', 'PUSHED_TO_CONFIG' FROM dual
  WHERE NOT EXISTS (SELECT id FROM `AuthentMeans` where name = 'EXT_PASSWORD');

/* !40000 ALTER TABLE `MeansProcessStatuses` DISABLE KEYS ; */
-- create the missing entries in MeansProcessStatuses

INSERT INTO `MeansProcessStatuses` (meansProcessStatusType, reversed, fk_id_authentMean)
  SELECT * FROM
  (SELECT DISTINCT(meansProcessStatusType) as stat FROM `MeansProcessStatuses`) as mp,
  (SELECT flag
   from (SELECT 0 as flag UNION SELECT 1) as temp ) as b,
  (SELECT a.id as aid FROM `AuthentMeans` a where a.name in ('KBA', 'EXT_PASSWORD', 'PASSWORD')) as c
  WHERE NOT EXISTS (SELECT id
                    FROM `MeansProcessStatuses`
                    WHERE meansProcessStatusType = mp.stat
                      AND b.flag = reversed
                      and aid = fk_id_authentMean);

/* Issuer
   At first, the different authentication means need to be activated, so 'validate' is set to 'true'.
*/
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;

SET @availableAuthMeans = 'INFO|OTP_SMS|MOBILE_APP|PASSWORD|REFUSAL|UNDEFINED|MOBILE_APP_EXT|OTP_SMS_EXT_MESSAGE|KBA';

SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
},{
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
},{
  "authentMeans" : "KBA",
  "validate" : true
},{
  "authentMeans" : "INFO",
  "validate" : true
} ]';

SET @activatedAuthMeansShared = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "UNDEFINED",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "KBA",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "PASSWORD",
  "validate" : true
},{
  "authentMeans" : "INFO",
  "validate" : true
} ]';


SET @issuerNameAndLabel = 'Postbank';
SET @issuerCode = '18500';
SET @createdBy ='A699391';


INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `availaibleAuthentMeans`) VALUES
  (@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, 'PUSHED_TO_CONFIG', @issuerNameAndLabel,
    @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Postbank EBK';
SET @sharedSubIssuerNameAndLabel = 'Postbank';
SET @subIssuerCode = '18501';
SET @sharedSubIssuerCode = '18500';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = '';
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
SET @maskParam = 'x,6,4';
SET @dateFormat = 'DD.MM.YYYY HH:mm|CET';
SET @3ds2AdditionalInfo = '
	{
		"VISA": {
		"operatorId": "acsOperatorVisa",
		"dsKeyAlias": "3DS2-VISA-CERTIFICATION"
		},
		"MASTERCARD": {
		"operatorId": "acsOperatorMasterCard",
		"dsKeyAlias": "key-masterCard"
		}
	}
';
INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`, `authentMeans`, `combinedAuthenticationAllowed`,`paChallengePublicUrl`,`verifyCardStatus`,`3DS2AdditionalInfo`) VALUES
  ('ACS_U5G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @activatedAuthMeans, TRUE, 'https://postbank-3ds.wlp-acs.com/', TRUE,@3ds2AdditionalInfo),
   ('ACS_U5G', 120, @backUpLanguages, @sharedSubIssuerCode, @sharedSubIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @sharedSubIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @sharedSubIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, @activatedAuthMeansShared, TRUE, 'https://postbank-3ds.wlp-acs.com/', TRUE,@3ds2AdditionalInfo);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = @subIssuerCode);

SET @sharedSubIssuerID = (SELECT `id` FROM `SubIssuer` WHERE `code` = @sharedSubIssuerCode);
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

INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
    SELECT '0A', '1', '03', 'EC11223344554B544F4B5F4D5554555F414301', 'EC11223344554B544F4B5F4D5554555F414300', '1', '01', 'NO_SECOND_FACTOR', si.id
    FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId and si.id = @sharedSubIssuerID;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'Postbank EBK';
SET @BankS = 'Postbank';
SET @BankUB = '18501_PB';
SET @BankUS = '18500_PB';
SET @Bank_B = '18501_';
SET @Bank_S = '18500_';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB,' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId and si.id in ( @subIssuerID);
	
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankS,' Shared profile set'), NULL, NULL, 'PS_Shared_PB_01', 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId and si.id in ( @sharedSubIssuerID);
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (',@BankB, ')')),
     (NULL,'HELP_PAGE',CONCAT('Help Page (',@BankB, ')')),
     (NULL,'KBA_OTP_FORM_PAGE',CONCAT('EXT Login OTP Form Page (',@BankB, ')')),
     (NULL,'MEANS_PAGE',CONCAT('Means Page (',@BankB, ')')),
     (NULL,'INFO_REFUSAL_PAGE',CONCAT('Info Refusal Page (',@BankB, ')')),
     (NULL,'OTP_FORM_PAGE',CONCAT('SMS OTP Form Page (',@BankB, ')')),
     (NULL,'OTP_SMS_EXT_MESSAGE_CHOICE_PAGE',CONCAT('SMS Choice Page (',@BankB, ')')),
     (NULL,'POLLING_PAGE',CONCAT('Polling Page (',@BankB, ')')),
     (NULL,'MOBILE_APP_EXT_CHOICE_PAGE',CONCAT('BestSign Choice Page (',@BankB, ')')),
     (NULL,'REFUSAL_PAGE',CONCAT('Refusal Page (',@BankB, ')')),
     (NULL,'FAILURE_PAGE',CONCAT('Failure Page (',@BankB, ')'));

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));
SET @ProfileSetShared = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_Shared_PB_01');
/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p
  WHERE cpl.description like CONCAT('%(',@BankB, '%') and p.id=@ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;
SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (',@BankB, ')%') );
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
VALUES (@layoutId,@ProfileSetShared);
/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div','
<div id="messageBanner">
	<span id="info-icon" class="fa fa-info-circle"></span>
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>
	<style>
		span#info-icon {
			position:absolute;
			top:15px;
			left:15px;
			float:none;
		}
		@media all and (max-width: 480px) {
			span#info-icon {
				position: absolute;
				font-size: 3em;
				top: 1px;
				left: 5px;
				display: inline-block;
			}
			.spinner {
				padding-top:10px;
				padding-bottom:10px;
			}
		}
		.spinner {
			position: relative;
			display:block;
			padding-top:15px;
			padding-bottom:15px;
		}
		div#message-container.info {
			background-color:#002395;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.success {
			background-color:#04BD07;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.error {
			background-color:#DB1818;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.warn {
			background-color:#E0700A;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		#headingTxt {
			font-family: Arial,bold;
			color: #FFFFFF;
			font-size:18px;
			width : 70%;
			margin : auto;
			display : block;
			text-align:center;
			padding:4px 1px 1px 1px;
		}
		#message {
			font-family: Arial,bold;
			color: #FFFFFF; font-size:14px;
			text-align:center;
		}
		span#message {
			font-size:14px;
		}
		#message-container {
			position:relative;
		}
		#optGblPage message-banner div#message-container {
			width:100% ;
			box-shadow: none ;
			-webkit-box-shadow:none;
			position: relative;
		}
		div.message-button {
			padding-top: 0px;
		}
		div#message-content {
			text-align: center;
			background-color: inherit;
			padding-bottom: 5px;
		}
	</style>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_1''"></custom-text></p>
	</div>

	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button id="helpCloseButton" help-label="toto"></help-close-button>
		</div>
	</div>
</div>
<style>
	#helpCloseButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#help-contents {
		text-align:left;
		margin-top:20px;
		margin-bottom:20px;
	}
	#help-container #help-modal {
		overflow:hidden;
	}
	#helpCloseButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		vertical-align:-10px;
	}
	#help-page {
		font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		padding:14px;
		overflow:auto; 
		text-align:left;
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#helpCloseButton > button {	}
	}
	@media screen and (max-width: 360px) {
		#helpCloseButton > button { }
	}
	@media only screen and (max-width: 480px) {
		div#message-container {
			width:100%;
			box-shadow: none;
			-webkit-box-shadow:none;
		}
		#help-page {
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:10px;
		}
		#help-container #help-modal { overflow:auto; }
		body {line-height:0.92857143;}
	}
	@media only screen and (max-width: 309px) {
		#help-page {
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:9px;
		}
	}
	@media only screen and (max-width: 250px) {
		#help-page {
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:7.9px;
		}
	}
</style>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('EXT Login OTP Form Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#switchId button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		padding: 6px 0px 6px 0px;
		margin-bottom: 5px;
	}
	#switchId button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		padding: 6px 0px 6px 0px;
		margin-bottom: 5px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#helpButton button {
		font: 300 16px/20px Arial,bold;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 28px;
		background: #fff;
		color: #323232;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 3rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#helpButton button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align:0px;
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:24px;
		background-position-y: -4px;
		background-position-x: 6px;
		background-size: 100%;
		display:inline-block;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-x: -2px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-bottom: 4px;
	}
	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#switchId button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#switchId button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#switchId button span custom-text {
		vertical-align:2px;
	}
	#validateButton button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #switchId button span:before {
		content:'' '';
	}
	#footer #validateButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#switchId button span + span {
		margin-bottom: 4px;
	}
	#footer #switchId > button > span.fa-check-square {
		display:none;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	#paragraph2{ 
		margin-top: 4px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	#otp-form {
		display:inline-block;
		padding-top:0px;
		padding-bottom: 10px;
	}
	#otp-form input {     
		box-sizing:content-box; 
		padding: 0px 0px 0px;
		background-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
		font-family: Arial,bold;
		color: #333333;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 25px;
		width: 220px;
	}
	#otp-form input:disabled {      
		color: #bebebe!important; 
		background-color: #dcdcdc!important; 
		border-color: rgba(0,0,0,.05)!important; 
		box-shadow: none!important;
	}
	#otp-form input:focus {
		border-color:#FF6A10 !important; 
		outline-color: #FF6A10;
	}
	div#otp-fields-container {
		width:70%;
		text-align:left;
		margin-top:10px;
		margin-bottom:10px;
	}
	div#otp-fields {
		display:inline-flex;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 12px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
		div#otp-fields {display:inherit;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#pageHeader {height: 60px;}
		#switchId button:disabled { font-size : 12px; }
		#switchId button { font-size : 12px; }
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#switchId button:disabled { font-size : 10px; }
		#switchId button { font-size : 10px; }
		#otp-form input { width:100%; }
		#helpButton button { margin-left: auto; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#switchId button:disabled { font-size : 8px; }
		#switchId button { font-size : 8px; }
		#otp-form input { width:100%; }
		#helpButton button { margin-left: auto; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_3''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text></strong>
			</div>
			<div id="otp-fields-container">
				<div x-ms-format-detection="none" id="otp-fields">
						<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>&emsp;
						<pwd-form></pwd-form>&emsp;
						<help help-label="" id="helpButton" ></help>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Means Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button button span.fa-life-ring:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#switch-means-mobile_app_ext-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 12.5px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-otp_sms_ext_message-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	#meanParagraph{
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
		margin-top: -2px;
		margin-bottom : 20px;
	}
	#meanchoice{
		text-align: center;
		display: flex;
		padding-bottom: initial;
	}
	#meanchoice .text-center {
		margin-bottom: 20px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	#paragraph2{
		margin-top: 4px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	@media all and (max-width: 1610px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center; display: flex;}
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center; display: flex;}
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center; padding-left: 1.3rem; display: block; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px; }
		.rightColumn { margin-left:0px; margin-top: 110px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center; padding-left: 1.3rem; display: block; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { padding-top: 0px; }
		#pageHeader { height: 70px; }
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center; padding-left: 1.3rem; display: block; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px; text-align: center;}
		#pageHeader {height: 60px;}
		#meanParagraph{ text-align: center; font-size : 12px; }
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 90px; text-align: center;}
		div#otp-fields {display:inherit;}
		#meanParagraph{ text-align: center; font-size : 10px; }
		div#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 2px; margin-bottom: 5px;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#meanParagraph{ text-align: center; font-size : 8px; }
		div#optGblPage #selection-group switch-means-button:nth-child(1) button { margin-right: 0px; margin-bottom: 5px;}
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<div class="side-menu text-center">
				<div class="row menu-title"></div>
				<div class="menu-elements">
					<div>
						<div>
							<div class="break-word">
								<span class="col-sm-5 col-xs-6 col-xs-offset-0 col-sm-offset-1 text-right padding-left">
									<label>
										<custom-text custom-text-key="''network_means_pageType_2''" class="ng-isolate-scope" id="paragraph3"></custom-text>
									</label>
									<label id="menu-separator">:</label>
								</span>
								<span class="col-sm-6 col-xs-6 text-left padding-left">
									<span><custom-text custom-text-key="''network_means_pageType_3''" id="paragraph4"></custom-text></span>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<side-menu menu-title="''''"></side-menu>
		</div>
		<div class="rightColumn">
			<div id="meanParagraph">
				<strong><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></strong>
			</div>
			<div id="meanchoice">
				<means-select means-choices="meansChoices"></means-select>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Info Refusal Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
	}
	div#message-container.info {
		background-color:#DB1818 !important;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
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
	<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_4''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer"></div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#validateButton button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	#paragraph2{ 
		margin-top: 4px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	#otp-form {
		display:inline-block;
		padding-top:0px;
		padding-bottom: 10px;
	}
	#otp-form input {     
		box-sizing:content-box; 
		padding: 0px 0px 0px;
		background-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
		font-family: Arial,bold;
		color: #333333;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 25px;
		width: 220px;
	}
	#otp-form input:disabled {      
		color: #bebebe!important; 
		background-color: #dcdcdc!important; 
		border-color: rgba(0,0,0,.05)!important; 
		box-shadow: none!important;
	}
	#otp-form input:focus {
		border-color:#FF6A10 !important; 
		outline-color: #FF6A10;
	}
	div#otp-fields-container {
		width:70%;
		text-align:left;
		margin-top:10px;
		margin-bottom:10px;
	}
	div#otp-fields {
		display:inline-flex;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
		div#otp-fields {display:inherit;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#otp-form input { width:100%; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
		#otp-form input { width:100%; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_4''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text></strong>
			</div>			
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text></strong>
			</div>		
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text></strong>
			</div>
			<div id="otp-fields-container">
				<div x-ms-format-detection="none" id="otp-fields">
					<otp-form></otp-form>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS Choice Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		font-size:14px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;		
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button button span.fa-life-ring:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#switch-means-mobile_app_ext-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-otp_sms_ext_message-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;} 
	#optGblPage #selection-group switch-means-button:nth-child(2) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:8px;
	}	
	#validateButton button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x: -2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
		clear:both;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	#meanParagraph{
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
		margin-top: -2px;
		margin-bottom : 20px;
	}
	#meanchoice{
		text-align: left;
		padding-right: 52.7%;
	}
	#meanchoice .text-center {
		margin-bottom: 20px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	@media all and (max-width: 1610px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center; padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		#pageHeader {height: 60px;}
		#meanParagraph{ text-align: center; font-size : 12px; }
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		div#otp-fields {display:inherit;}
		#meanParagraph{ text-align: center; font-size : 10px; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		div#otp-fields {display:inherit;}
		#meanParagraph{ text-align: center; font-size : 8px; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_2''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<div id="meanParagraph">
					<strong><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></strong>
				</div>
				<div id="meanchoice">
					<device-select devices="deviceSelectValues" select-box-style-enabled="true"></device-select>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#switchId button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 25rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		padding: 6px 0px 6px 0px;
		margin-bottom: 5px;
	}
	#switchId button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 25rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		padding: 6px 0px 6px 0px;
		margin-bottom: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#switchId button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#switchId button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#switchId button span custom-text {
		vertical-align:2px;
	}
	#switchId button span + span {
		margin-bottom: 4px;
	}
	#footer #switchId button span:before {
		content:\' \';
	}
	#footer #switchId > button > span.fa-check-square {
		display:none;
	}
	#footer #cancelButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: center;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		#pageHeader {height: 60px;}
		#switchId button:disabled { font-size : 12px; }
		#switchId button { font-size : 12px; }
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		#switchId button:disabled { font-size : 10px; }
		#switchId button { font-size : 10px; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		#switchId button:disabled { font-size : 8px; }
		#switchId button { font-size : 8px; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_3''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text></strong>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('BestSign Choice Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		font-size:14px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;		
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button button span.fa-life-ring:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#switch-means-mobile_app_ext-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-otp_sms_ext_message-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#cancelButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;} 
	#optGblPage #selection-group switch-means-button:nth-child(2) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	#cancelButton button:hover:enabled {
		border-color: rgba(255,106,16,.75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:8px;
	}	
	#validateButton button:hover {
		border-color: rgba(255,106,16,.75);
		background: #FFFFFF;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:'''';
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x: -2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
		clear:both;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	#meanParagraph{
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
		margin-top: -2px;
		margin-bottom : 20px;
	}
	#meanchoice{
		text-align: left;
		padding-right: 52.7%;
	}
	#meanchoice .text-center {
		margin-bottom: 20px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	@media all and (max-width: 1610px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center; padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
		#meanParagraph{ text-align: center; font-size : 14px; }
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		#pageHeader {height: 60px;}
		#meanParagraph{ text-align: center; font-size : 12px; }
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		div#otp-fields {display:inherit;}
		#meanParagraph{ text-align: center; font-size : 10px; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px;}
		div#otp-fields {display:inherit;}
		#meanParagraph{ text-align: center; font-size : 8px; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_2''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<div id="meanParagraph">
					<strong><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></strong>
				</div>
				<div id="meanchoice">
					<device-select devices="deviceSelectValues" select-box-style-enabled="true"></device-select>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_2''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text></strong>
			</div>
		</div>
	</div>
	<div id="footer"></div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (',@BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#footer #cancelButton button span:before {
		content:'''';
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 90px;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 80px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 80px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 78px; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 66px; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; padding-right: 5px; padding-left: 5px; margin-right: 57px; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_3''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text></strong>
			</div>
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text></strong>
			</div>
		</div>
	</div>
	<div id="footer"></div>
</div>', @layoutId);

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES (@createdBy, NOW(), CONCAT(@BankB,' Logo'), NULL, NULL, @BankB, 'PUSHED_TO_CONFIG', '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fRcN+33vqf6bP5r9N/2mUvL4eQliyQkMeOPMDkc4we5KOCXOT5fmZezLJxzzYsEs/D7n+bROeYSidSYHJHir1e2J/N/e4Hvq/V9NvrbBbA9QVklgd+cK3P8Ac5n8tSQsXIGTj13iuyn1GyarmlljD+dXYx4a7cx3+f8AziKuTmCJyEhwyBIlH92X7rpxIIBBvTd//9HrkxDXCHAOHgQCPxTpLzsXejsmurH06v8ARs/zW/3KQAAgAADgAQPwSSRPF1v6oHD0r6KSSSQXKSSSSUrjhLnlJJJSpKSSSSlJJJJKUkkkkpSSSSSlJJJJKf/Z/+0QAlBob3Rvc2hvcCAzLjAAOEJJTQQlAAAAAAAQAAAAAAAAAAAAAAAAAAAAADhCSU0D7QAAAAAAEAJX/7EAAQACAlf/sQABAAI4QklNBCYAAAAAAA4AAAAAAAAAAAAAP4AAADhCSU0EDQAAAAAABAAAAB44QklNBBkAAAAAAAQAAAAeOEJJTQPzAAAAAAAJAAAAAAAAAAABADhCSU0nEAAAAAAACgABAAAAAAAAAAI4QklNA/UAAAAAAEgAL2ZmAAEAbGZmAAYAAAAAAAEAL2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAAAAYAAAAAAAEANQAAAAEALQAAAAYAAAAAAAE4QklNA/gAAAAAAHAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAOEJJTQQIAAAAAAAQAAAAAQAAAkAAAAJAAAAAADhCSU0EHgAAAAAABAAAAAA4QklNBBoAAAAAA1UAAAAGAAAAAAAAAAAAAAKBAAAJOgAAABAAUABCAF8AWgBlAG4AdAByAGEAbABlAF8AcwBSAEcAQgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAJOgAAAoEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAQAAAAAAAG51bGwAAAACAAAABmJvdW5kc09iamMAAAABAAAAAAAAUmN0MQAAAAQAAAAAVG9wIGxvbmcAAAAAAAAAAExlZnRsb25nAAAAAAAAAABC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LjM1MjYyNCwgMjAwOC8wNy8zMC0xODowNTo0MSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M0IE1hY2ludG9zaCIgeG1wOkNyZWF0ZURhdGU9IjIwMTMtMDEtMTFUMTE6MTA6MzIrMDE6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDEzLTAxLTExVDExOjExOjQzKzAxOjAwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDEzLTAxLTExVDExOjExOjQzKzAxOjAwIiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDowQUFBNDgyMTRDMjA2ODExOTdBNUZEMUE0NjM2QkFCRSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDowOUFBNDgyMTRDMjA2ODExOTdBNUZEMUE0NjM2QkFCRSIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjA5QUE0ODIxNEMyMDY4MTE5N0E1RkQxQTQ2MzZCQUJFIiB0aWZmOk9yaWVudGF0aW9uPSIxIiB0aWZmOlhSZXNvbHV0aW9uPSI1OTk5OTg4LzEwMDAwIiB0aWZmOllSZXNvbHV0aW9uPSI1OTk5OTg4LzEwMDAwIiB0aWZmOlJlc29sdXRpb25Vbml0PSIyIiB0aWZmOk5hdGl2ZURpZ2VzdD0iMjU2LDI1NywyNTgsMjU5LDI2MiwyNzQsMjc3LDI4NCw1MzAsNTMxLDI4MiwyODMsMjk2LDMwMSwzMTgsMzE5LDUyOSw1MzIsMzA2LDI3MCwyNzEsMjcyLDMwNSwzMTUsMzM0MzI7Rjc5QUJFMURDRjRDRURGN0UwODQ3MkYzNDg5NjE5NzciIGV4aWY6UGl4ZWxYRGltZW5zaW9uPSIyMzYyIiBleGlmOlBpeGVsWURpbWVuc2lvbj0iNjQxIiBleGlmOkNvbG9yU3BhY2U9IjEiIGV4aWY6TmF0aXZlRGlnZXN0PSIzNjg2NCw0MDk2MCw0MDk2MSwzNzEyMSwzNzEyMiw0MDk2Miw0MDk2MywzNzUxMCw0MDk2NCwzNjg2NywzNjg2OCwzMzQzNCwzMzQzNywzNDg1MCwzNDg1MiwzNDg1NSwzNDg1NiwzNzM3NywzNzM3OCwzNzM3OSwzNzM4MCwzNzM4MSwzNzM4MiwzNzM4MywzNzM4NCwzNzM4NSwzNzM4NiwzNzM5Niw0MTQ4Myw0MTQ4NCw0MTQ4Niw0MTQ4Nyw0MTQ4OCw0MTQ5Miw0MTQ5Myw0MTQ5NSw0MTcyOCw0MTcyOSw0MTczMCw0MTk4NSw0MTk4Niw0MTk4Nyw0MTk4OCw0MTk4OSw0MTk5MCw0MTk5MSw0MTk5Miw0MTk5Myw0MTk5NCw0MTk5NSw0MTk5Niw0MjAxNiwwLDIsNCw1LDYsNyw4LDksMTAsMTEsMTIsMTMsMTQsMTUsMTYsMTcsMTgsMjAsMjIsMjMsMjQsMjUsMjYsMjcsMjgsMzA7NTQzMTVBNjc1QkZEMTYyQUQ1RUREN0YwNkI0OTMzMTQiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjA5QUE0ODIxNEMyMDY4MTE5N0E1RkQxQTQ2MzZCQUJFIiBzdEV2dDp3aGVuPSIyMDEzLTAxLTExVDExOjExOjQzKzAxOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ1M0IE1hY2ludG9zaCIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGltYWdlL3BuZyB0byBpbWFnZS9qcGVnIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDowQUFBNDgyMTRDMjA2ODExOTdBNUZEMUE0NjM2QkFCRSIgc3RFdnQ6d2hlbj0iMjAxMy0wMS0xMVQxMToxMTo0MyswMTowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIENTNCBNYWNpbnRvc2giIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz7/4gxYSUNDX1BST0ZJTEUAAQEAAAxITGlubwIQAABtbnRyUkdCIFhZWiAHzgACAAkABgAxAABhY3NwTVNGVAAAAABJRUMgc1JHQgAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLUhQICAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFjcHJ0AAABUAAAADNkZXNjAAAB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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_1_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_1_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_2_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_2_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBADECLINE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_LOGIN_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_LOGIN'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_UNDEFINED_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_UNDEFINED'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Choice'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Choice'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Choice'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS_Choice'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MOBILE_APP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUS, '_Shared_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUS, '_Shared_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @sharedSubIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));
SET @customItemSetInfoRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_2_REFUSAL'));
SET @customItemSetPBSHRDRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUS,'_Shared_REFUSAL'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_RBAACCEPT'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_RBADECLINE'));
SET @customItemSetLogin = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_LOGIN'));
SET @customItemSetUndefined = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_UNDEFINED'));
SET @customItemSetMobileAppChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MOBILE_APP_Choice'));
SET @customItemSetSMSChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS_Choice'));
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MOBILE_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanLogin = (SELECT id FROM `AuthentMeans` WHERE `name` = 'KBA');
SET @authMeanUndefined = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP_EXT');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `dataEntryAllowedPattern`, `dataEntryFormat`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), CONCAT(@Bank_B,'REFUSAL (FRAUD)'), NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'REFUSAL (MISSING AUTHENTMEANS)'), NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENT_MEANS_REFUSAL'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanINFO, @customItemSetInfoRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_S,'REFUSAL (SHARED)'), NULL, NULL, CONCAT(@BankUS,'_Shared_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanINFO, @customItemSetPBSHRDRefusal, NULL, NULL, @sharedSubIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'RBA_ACCEPT'), NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'RBA_DECLINE'), NULL, NULL, CONCAT(@BankUB,'_DECLINE'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanRefusal, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'EXT LOGIN (NORMAL)'), NULL, NULL, CONCAT(@BankUB,'_LOGIN_01'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '50:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)', @authMeanLogin, @customItemSetLogin, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'MEANS_CHOICE (NORMAL)'), NULL, NULL, CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_01'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanUndefined, @customItemSetUndefined, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'BESTSIGN_CHOICE'), NULL, NULL, CONCAT(@BankUB,'_BESTSIGN_01'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanMobileApp, @customItemSetMobileAppChoice, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'OTP_SMS_CHOICE'), NULL, NULL, CONCAT(@BankUB,'_SMS_01'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)', @authMeanOTPsms, @customItemSetSMSChoice, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'BESTSIGN_NORMAL'), NULL, NULL, CONCAT(@BankUB,'_BESTSIGN_02'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanMobileApp, @customItemSetMobileApp, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT(@Bank_B,'OTP_SMS_NORMAL'), NULL, NULL, CONCAT(@BankUB,'_SMS_02'), 'PUSHED_TO_CONFIG', 2, '^[^OIi]*$', '6:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileSharedRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUS,'_Shared_DEFAULT_REFUSAL'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileLogin = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_LOGIN_01'));
SET @profileUndefinedRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENT_MEANS_REFUSAL'));
SET @profileMEANSCHOICE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_AUTHENT_MEANS_CHOICE_01'));
SET @profileMobileAppChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_BESTSIGN_01'));
SET @profileSMSChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_BESTSIGN_02'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_02'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', 'PUSHED_TO_CONFIG', 2, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', 'PUSHED_TO_CONFIG', 3, @profileRBADECLINE),
  (@createdBy, NOW(), 'LOGIN_AVAILABLE_NORMAL', NULL, NULL, 'EXT LOGIN (NORMAL)', 'PUSHED_TO_CONFIG', 4, @profileLogin),
  (@createdBy, NOW(), 'REFUSAL_MISSING_AUTHENTMEANS', NULL, NULL, 'REFUSAL (MISSING AUTHENTMEANS)', 'PUSHED_TO_CONFIG', 5, @profileUndefinedRefusal),
  (@createdBy, NOW(), 'BESTSIGN_AVAILABLE_CHOICE', NULL, NULL, 'MOBILE_APP (CHOICE)', 'PUSHED_TO_CONFIG', 6, @profileMobileAppChoice),
  (@createdBy, NOW(), 'SMS_AVAILABLE_CHOICE', NULL, NULL, 'OTP_SMS (CHOICE)', 'PUSHED_TO_CONFIG', 7, @profileSMSChoice),
  (@createdBy, NOW(), 'MEANS_CHOICE_NORMAL', NULL, NULL, 'AUTHENT MEANS CHOICE', 'PUSHED_TO_CONFIG', 8, @profileMEANSCHOICE),
  (@createdBy, NOW(), 'BESTSIGN_AVAILABLE_NORMAL', NULL, NULL, 'MOBILE_APP (NORMAL)', 'PUSHED_TO_CONFIG', 9, @profileMobileApp),
  (@createdBy, NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'OTP_SMS (NORMAL)', 'PUSHED_TO_CONFIG', 10, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 11, @profileRefusal),
  (@createdBy, NOW(), 'SHARED_REFUSAL_DEFAULT', NULL, NULL, 'SHARED REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 1, @profileSharedRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description`='RBA_ACCEPT' AND `fk_id_profile`=@profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description`='RBA_DECLINE' AND `fk_id_profile`=@profileRBADECLINE);
SET @ruleLoginNormal = (SELECT id FROM `Rule` WHERE `description`='LOGIN_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileLogin);
SET @ruleUndefinedRefusal = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_MISSING_AUTHENTMEANS' AND `fk_id_profile`=@profileUndefinedRefusal);
SET @ruleMobileAppChoice = (SELECT id FROM `Rule` WHERE `description`='BESTSIGN_AVAILABLE_CHOICE' AND `fk_id_profile`=@profileMobileAppChoice);
SET @ruleSMSChoice = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_CHOICE' AND `fk_id_profile`=@profileSMSChoice);
SET @ruleAuthentMeansChoice = (SELECT id FROM `Rule` WHERE `description`='MEANS_CHOICE_NORMAL' AND `fk_id_profile`=@profileMEANSCHOICE);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description`='BESTSIGN_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileMobileApp);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
SET @ruleSharedRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='SHARED_REFUSAL_DEFAULT' AND `fk_id_profile`=@profileSharedRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES 
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_02_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_03_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_04_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_05_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_RBA_ACCEPT'), 'PUSHED_TO_CONFIG', @ruleRBAAccept),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_RBA_DECLINE'), 'PUSHED_TO_CONFIG', @ruleRBADecline),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL'), 'PUSHED_TO_CONFIG', @ruleLoginNormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN'), 'PUSHED_TO_CONFIG', @ruleUndefinedRefusal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE'), 'PUSHED_TO_CONFIG', @ruleMobileAppChoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE'), 'PUSHED_TO_CONFIG', @ruleMobileAppChoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE'), 'PUSHED_TO_CONFIG', @ruleSMSChoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE'), 'PUSHED_TO_CONFIG', @ruleSMSChoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL'), 'PUSHED_TO_CONFIG', @ruleAuthentMeansChoice),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL'), 'PUSHED_TO_CONFIG', @ruleMobileAppnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL'), 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleRefusalDefault),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_Shared_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleSharedRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_FRAUD') AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_03_FRAUD') AND (ts.`transactionStatusType`='CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_04_FRAUD') AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_05_FRAUD') AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

/*INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);
*/
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

/*INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);
*/
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

/*INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);
*/
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='USER_CHOICE_ALLOWED' AND ts.`reversed`=FALSE);

/*INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);
*/
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType`='COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_RBA_ACCEPT') AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_RBA_ACCEPT') AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_RBA_DECLINE') AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_RBA_DECLINE') AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_DEFAULT') AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_Shared_01_DEFAULT') AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);

/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
-- 
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
*/
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MEANS_CHOICE_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

-- 
/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);
*/
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);
*/
-- 
/*
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_LOGIN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);
*/
-- 
/*
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

-- 
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_PASSWORD_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanPassword
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);
*/
-- 
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanUndefined
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
*/
--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_BESTSIGN_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
*/
-- 
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanUndefined
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
*/
--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

/*INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_02_OTP_SMS_CHOICE')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);
*/
--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_BESTSIGN_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanLogin AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='COMBINED_MEANS_REQUIRED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanUndefined AND (mps.`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanINFO
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);


/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_',@BankUB,'_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @ruleUndefinedRefusal, @ruleLoginNormal, @ruleMobileAppChoice, @ruleSMSChoice, @ruleAuthentMeansChoice, @ruleMobileAppnormal, @ruleSMSnormal, @ruleRefusalDefault);
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = 'PS_Shared_PB_01' AND r.`id` IN ( @ruleSharedRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, @subIssuerID),
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, @sharedSubIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
