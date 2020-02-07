/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;
/* Issuer
   At first, the different authentication means need to be activated, so 'validate' is set to 'true'.
*/
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @activatedAuthMeans = '[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
} ]';
SET @availableAuthMeans = 'REFUSAL|OTP_SMS_EXT_MESSAGE|MOBILE_APP_EXT';
SET @issuerNameAndLabel = 'UBS Switzerland AG';
SET @issuerCode = '23000';
SET @createdBy = 'A758582';

INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`,  `availaibleAuthentMeans`) VALUES
  (@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, 'PUSHED_TO_CONFIG', @issuerNameAndLabel,
     @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'UBS Switzerland AG';
SET @subIssuerCode = '23000';
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
SET @preferredAuthMean = 'MOBILE_APP_EXT';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = '*,6,4';
SET @dateFormat = 'DD.MM.YYYY HH:mm|CET';

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                          `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`, `paChallengePublicUrl`, `verifyCardStatus`,`resendSameOTP`,`combinedAuthenticationAllowed`, `authentMeans`) VALUES
  ('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://secure.six-group.com', '1', TRUE, FALSE, @activatedAuthMeans);
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
SET @BankB = 'UBS';
SET @BankUB = 'UBS';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (', @BankB, ')')),
     (NULL,'OTP_FORM_PAGE', CONCAT('SMS OTP Form Page (', @BankB, ')')),
     (NULL,'REFUSAL_PAGE', CONCAT('Refusal Page (', @BankB, ')')),
     (NULL,'FAILURE_PAGE', CONCAT('Failure Page (', @BankB, ')')),
     (NULL,'POLLING_PAGE', CONCAT('Polling Page (', @BankB, ')')),
     (NULL,'HELP_PAGE', CONCAT('Help Page (', @BankB, ')'));

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

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
  VALUES( 'div',
  '<div id="messageBanner">
        <span id="info-icon" class="fa fa-exclamation-triangle"></span>
        <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
        <custom-text id="message" custom-text-key="$parent.message"></custom-text>

        <style>
            span#info-icon {
                font-size: 1em;
                top: 5px;
                left: 5px;
                float: left;
                margin-right: 5px;
            }
            @media all and (max-width: 480px) {
                span#info-icon {
                    position: absolute;
                    font-size: 3em;
                    top: 1px;
                    left: 5px;
                    display: inline-block;
                }
            }
            div#message-container.info {
                background-color:#DEE2E9;
                font-family: FrutigerforUBSWeb
                font-size:12px;
                color: #E0B519;
            }
            div#message-container.success {
                background-color:#DEE2E9;
                font-family: FrutigerforUBSWeb;
                font-size:12px;
                color: #E0B519;
            }
            div#message-container.error {
                background-color:#FFF3D8;
                font-family: FrutigerforUBSWeb;
                font-size:12px;
                color: #E0B519;
            }
            div#message-container.warn {
                background-color:#FFF3D8;
                font-family: FrutigerforUBSWeb;
                font-size:12px;
                color: #E0B519;
            }
            #headingTxt {
                font-family: FrutigerforUBSWeb,bold;
                color: #1C1C1C;
                font-size:12px;
                width : 70%;
                margin : auto;
                display : block;
                text-align:center;
                padding:4px 1px 1px 1px;
                display: none;
            }
            #message {
                font-family: FrutigerforUBSWeb,bold;
                color: #1C1C1C;
                font-size:12px;
                line-height: 16px;
                text-align:center;
            }
            span#message {
                font-size:10px;
                width: 100%;
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
                display: none;
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
           div#spinner-row .spinner div div{
               background: #E0B519!important;
            }
        </style>
    </div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
        <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                                <otp-form ></otp-form>
                            </div>
                        </div>
                        <message-banner></message-banner>
                         <div class="mtan-label"><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></div>
                    </div>

                   <div class="resendTan">
                          <span class="fa fa-angle-right"></span>
                          <re-send-otp id="resend" rso-Label="''network_means_pageType_19''"></re-send-otp>
                   </div>

                    <div id="form-controls">
                        <div class="row">
                            <div class="submit-btn">
                                <val-button id="validateButton" val-label="''network_means_pageType_42''"></val-button>
                                <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
                            </div>
                        </div>
                    </div>

                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>

		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
            max-height: 64px;
            max-width:100%;
            padding-left: 0px;
            padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
            width:100%;
            text-align:center;
        }
        #main-container #i18n-inner {
            display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout {
            font-family: Frutiger55Roman;
            font-size: 16px;
            letter-spacing: 0;
            line-height: 24px;
        }
        div#leftMenuLayout label {
           color: #646464;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
        #main-container #resend button span{
            color:#007099;
        }
        #main-container #resend button {
            border-style: none;
            padding:0px
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
		#main-container   .mtan-input {
			padding-bottom:10px;
		}
		#main-container   .resendTan {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			display:block;
			margin-top:10px;
			margin-bottom: 25px;
            color:#007099;
		}
		#main-container   .input-label {
			flex-direction: row;
			align-items: center;
		}
		#main-container   .resendTan a {
			color:#007099;
		}
        #main-container   .help-link a {
			color:#007099;
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
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            background: #FFFFFF;
			margin-left:0px;
            border: 1px solid #AAAAAA;
		}
		#main-container   .otp-field input:focus {
			outline:none;
		}
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:3em;
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
			margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
            margin-left: 0%;
        }
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 60%;
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
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            height: 38px;
            border-radius: 2px;
            background: #6A7D39;
            opacity: 1;
            box-shadow: none;
            border: 0px;
            color: #FFFFFF;
        }
        #main-container   #cancelButton button{
            font-family: Arial;
            font-size: 14px;
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
        #main-container #validateButton button:disabled {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            height: 38px;
            border-radius: 2px;
            background: #6A7D39;
            box-shadow: none;
            border: 0px;
            color: #FFFFFF;
        }
	</style>'
, @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
         <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
          width:100%;
          text-align:center;
        }
        #main-container #i18n-inner {
          display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
        #main-container   .help-link a {
			color:#007099;
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
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:1em;
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
			margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
            margin-left: 0%;
        }
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 65%;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
	</style>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES(  'div', '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
         <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
          width:100%;
          text-align:center;
        }
        #main-container #i18n-inner {
          display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
        #main-container   .help-link a {
			color:#007099;
		}
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:1em;
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
			margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
            margin-left: 0%;
        }
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 65%;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
	</style>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
         <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
          width:100%;
          text-align:center;
        }
        #main-container #i18n-inner {
          display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }

        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
        #main-container   .help-link a {
			color:#007099;
		}
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:1em;
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
			margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
            margin-left: 0%;
        }
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 65%;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
	</style>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '<div id="main-container" class="" ng-style="style" class="ng-scope">
  <div id="help-page">
        <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
             </div>
        </div>
	   <div id="help-contents">
		  <p><custom-text custom-text-key="\'network_means_HELP_PAGE_1\'"></custom-text></p>
	   </div>

	<div class="row">
		<div class="help-link">
			<span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
		</div>
	</div>
</div>
</div>
<style>
	#help-contents {
		text-align:left;
		margin-top:20px;
		margin-bottom:20px;
	}
	#help-container #help-modal {
		overflow:hidden;
	}
    #main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: center;
            color:#007099;
	}
    #main-container #i18n-container {
          width:100%;
          text-align:center;
    }

    #main-container #i18n-inner {
          display:inline-block;
    }
	help-page {
		font-family: FrutigerforUBSWeb;
		font-size:14px;
		padding:14px;
		overflow:auto;
		text-align:left;
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#helpCloseButton > button {		}
	}
	@media screen and (max-width: 360px) {
		#helpCloseButton > button {		}
	}
	@media only screen and (max-width: 480px) {
		div#message-container {
			width:100%;
			box-shadow: none;
			-webkit-box-shadow:none;
		}
	}
</style>', @layoutId);


/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES (@createdBy, NOW(), CONCAT(@BankB,' Logo'), NULL, NULL, @BankB, 'PUSHED_TO_CONFIG', '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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBADECLINE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBADECLINE'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP_EXT');
SET @authMeanUndefined = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), 'PUSHED_TO_CONFIG', 3, @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), 'PUSHED_TO_CONFIG', 3, @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'MOBILE_APP_EXT', NULL, NULL, CONCAT(@BankUB,'_APP_01'), 'PUSHED_TO_CONFIG', 3, @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID);

/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_APP_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', 'PUSHED_TO_CONFIG', 2, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', 'PUSHED_TO_CONFIG', 3, @profileRBADECLINE),
  (@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', 'PUSHED_TO_CONFIG', 4, @profileMOBILEAPP),
  (@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', 'PUSHED_TO_CONFIG', 5, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 6, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusal);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleSMSFallback = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_02_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_03_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_04_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_ACCEPT'), 'PUSHED_TO_CONFIG', @ruleRBAAccept),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_RBA_DECLINE'), 'PUSHED_TO_CONFIG', @ruleRBADecline),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL'), 'PUSHED_TO_CONFIG', @ruleMobileAppnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK'), 'PUSHED_TO_CONFIG', @ruleSMSFallback),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
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
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL')
    AND mps.`fk_id_authentMean` = @authentMeansMobileApp
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK')
    AND mps.`fk_id_authentMean` = @authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @ruleMobileAppnormal, @ruleSMSFallback, @ruleRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
