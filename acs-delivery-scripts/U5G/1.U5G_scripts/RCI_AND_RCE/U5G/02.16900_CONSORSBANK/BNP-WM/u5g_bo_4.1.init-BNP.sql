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
		color: #7F9C90;
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
        color: 	#403f3d;
        font-size: 16px;
        text-align: center;
        background-color: #5b7f95;
	}
	#close-button-row button {
         font-family: BNP Sans Regular;
        font-weight: normal;
        color: 	#403f3d;
        font-size: 16px;
        text-align: center;
        background-color: #5b7f95;
	}

	div.message-button {
		padding-top: 0px;
		padding-left: 25px;
	}
	div#spinner-row {
		display: none;
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

        input {
            border: 1px solid #d1d1d1;
            border-radius: 6px;
            color: #464646;
            padding: 7px 10px 5px;
            height: 20px;
            box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
        }

		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
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
                border-bottom: 1px solid #DCDCDC;
        }

		#main-container   #pageHeaderLeft {
            text-align:left;
		}
		#main-container   #pageHeaderRight {
			text-align: right;
		}

        #main-container .clear {
            clear:both;
            display:block;
        }
       #main-container #content #contentHeader  custom-text.ng-isolate-scope  {
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

        custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
        }
         #main-container #content #contentMain {
                margin-top:1em;
                background-color: #f7f7f7;
                border-radius:1em;
                padding:1em;
                display: flex;
                flex-direction:column;
        }

        #main-container #content #contentMain span.custom-text.ng-binding {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }

		#main-container   #content {
			text-align:left;
		}
        #main-container #content h2 {
            font-size: 1.25em;
            margin-top: 0px;
            margin-bottom: 0.25em;
        }
        #main-container #footer .contact custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }

        #main-container .menu-title {
            display:none;
        }

        #main-container #resend button span{
            color:#06c2d4;
            background-color: #f7f7f7;
        }

        #main-container #resend button {
            border-style: none;
            padding:0px
        }

        #main-container #helpButton  button span{
                font-family: BNP Sans Regular;
                font-size: 16px;
                font-weight: normal;
                text-align: center;
                color: #403f3d;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
            border-style: none;
            padding:0px
        }
        #main-container #helpButton .fa-info {
            display:none;
        }
        #main-container #otp-input {
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            margin-top: 10px;
            align-self: flex-end;
        }
		#main-container   .help-link {
			width: 30%;
			order: 2;
			text-align: right;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
		#main-container   .resendTan {
			display:block;
			margin-left:196px;
			margin-top:10px;
			margin-bottom: 25px;
		}
		#main-container   .input-label {
			display:flex;
			flex-direction: row;
			align-items: center;
		}
		#main-container   .otp-input input {
			margin-left:16px;
		}
        #main-container   #otp-input span {
			padding-right:10px;
		}
		#main-container   #otp-input input:focus {
			outline:none;
		}
        #main-container #content #contentMain .flex-right{
                align-self: flex-end;
        }
		#main-container   #footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			background-color: #f7f7f7;
            border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
        #main-container #footer .help-area .help-link #helpButton .btn-default {
            background-color: #5b7f95;
        }
		#main-container   #footer:after {
			content: "";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container   #footer .extra-small {
            font-size:0.7em;
        }
        #main-container   #footer .small {
            font-size:0.8em;
        }
        #main-container   #footer .bold {
            font-weight: bold;
        }

       #main-container   #footer .grey {
           color: #6b6b6b;
        }

        #main-container   #footer .bottom-margin {
	        margin-bottom:10px;
         }
		#main-container   #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
        #main-container #footer #copyright custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }
		#main-container   #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container   #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container  #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
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
		#main-container   .col-xs-12 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container   message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
		#main-container   .row .back-link {
			text-align:left;
			float:left;
		}

        #main-container   .row .back-link button {
            border-style:none;
            padding:0px;
            color:#06c2d4;
		}
		#main-container   .row .back-link span {
			text-align:left;
			margin-left:0.5em;
		}

		#main-container   .row .back-link span.fa-ban {
            display:none;
		}

		#main-container   .row .submit-btn {
			text-align:right;
			float:right;
		}

        #main-container #val-button-container {
            margin-top:10px;
            margin-bottom:10px;

        }

		#main-container #validateButton button {
            font-size: 16px;
            height: 30px;
            line-height:1.0;
            border-radius: 6px;
            background: #5b7f95;
            box-shadow: none;
            border: 0px;
            color: #FFF;
            width:163px;
        }

		#main-container   #validateButton span.fa-check-square{
            display:none;
        }

	</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
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
            <message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>
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
<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
		border-bottom: 1px solid #DCDCDC;
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
	#main-container #i18n-container {
		width:100%;
		text-align:center;
	}
	#main-container #i18n-inner {
		display:inline-block;
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
		margin-right:25%;
	}
	#main-container #contentBottom {
		margin-left: 26%;
	}
	#main-container   message-banner {
		display: block;
		margin-top: 5px;
		position: relative;
		width: 196px;
	}
	#main-container   div#footer {
		background-image:none;
		height:100%;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
		margin-top:2em;
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
		margin-bottom: 20px;
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
	@media all and (max-width: 480px) {
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 600px) {
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
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
        <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
', @layoutId);


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Photo Tan Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`) VALUES ( 'div', '
<style>
        #main-container {
            width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }

        input {
            border: 1px solid #d1d1d1;
            border-radius: 6px;
            color: #464646;
            padding: 7px 10px 5px;
            height: 20px;
            box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
        }

		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
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
                border-bottom: 1px solid #DCDCDC;
        }

		#main-container   #pageHeaderLeft {
            text-align:left;
		}
		#main-container   #pageHeaderRight {
			text-align: right;
		}

        #main-container .clear {
            clear:both;
            display:block;
        }
       #main-container #content #contentHeader  custom-text.ng-isolate-scope  {
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

        custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
        }
         #main-container #content #contentMain {
                margin-top:1em;
                background-color: #f7f7f7;
                border-radius:1em;
                padding:1em;
                display: flex;
                flex-direction:column;
        }

        #main-container #content #contentMain span.custom-text.ng-binding {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }

		#main-container   #content {
			text-align:left;
		}
        #main-container #content h2 {
            font-size: 1.25em;
            margin-top: 0px;
            margin-bottom: 0.25em;
        }
        #main-container #footer .contact custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }

        #main-container .menu-title {
            display:none;
        }

        #main-container #resend button span{
            color:#06c2d4;
            background-color: #f7f7f7;
        }

        #main-container #resend button {
            border-style: none;
            padding:0px
        }

        #main-container #helpButton  button span{
                font-family: BNP Sans Regular;
                font-size: 16px;
                font-weight: normal;
                text-align: center;
                color: #403f3d;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
            border-style: none;
            padding:0px
        }
        #main-container #helpButton .fa-info {
            display:none;
        }
        #main-container #otp-input {
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            margin-top: 10px;
            align-self: flex-end;
        }
		#main-container   .help-link {
			width: 30%;
			order: 2;
			text-align: right;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
		#main-container   .resendTan {
			display:block;
			margin-left:196px;
			margin-top:10px;
			margin-bottom: 25px;
		}
		#main-container   .input-label {
			display:flex;
			flex-direction: row;
			align-items: center;
		}
		#main-container   .otp-input input {
			margin-left:16px;
		}
        #main-container   #otp-input span {
			padding-right:10px;
		}
		#main-container   #otp-input input:focus {
			outline:none;
		}
        #main-container #content #contentMain .flex-right{
                align-self: flex-end;
        }
		#main-container   #footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			background-color: #f7f7f7;
            border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
        #main-container #footer .help-area .help-link #helpButton .btn-default {
            background-color: #5b7f95;
        }
		#main-container   #footer:after {
			content: "";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container   #footer .extra-small {
            font-size:0.7em;
        }
        #main-container   #footer .small {
            font-size:0.8em;
        }
        #main-container   #footer .bold {
            font-weight: bold;
        }

       #main-container   #footer .grey {
           color: #6b6b6b;
        }

        #main-container   #footer .bottom-margin {
	        margin-bottom:10px;
         }
		#main-container   #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
        #main-container #footer #copyright custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }
		#main-container   #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container   #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container  #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
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
		#main-container   .col-xs-12 {
			width: 100%;
			margin-bottom: 20px;
		}
		#main-container   message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
		#main-container   .row .back-link {
			text-align:left;
			float:left;
		}

        #main-container   .row .back-link button {
            border-style:none;
            padding:0px;
            color:#06c2d4;
		}
		#main-container   .row .back-link span {
			text-align:left;
			margin-left:0.5em;
		}

		#main-container   .row .back-link span.fa-ban {
            display:none;
		}

		#main-container   .row .submit-btn {
			text-align:right;
			float:right;
		}

        #main-container #val-button-container {
            margin-top:10px;
            margin-bottom:10px;

        }

		#main-container #validateButton button {
            font-size: 16px;
            height: 30px;
            line-height:1.0;
            border-radius: 6px;
            background: #5b7f95;
            box-shadow: none;
            border: 0px;
            color: #FFF;
            width:163px;
        }

		#main-container   #validateButton span.fa-check-square{
            display:none;
        }

	</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
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
            <message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>
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


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '
<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container   #pageHeader {
		width: 100%;
		height: 74px;
		border-bottom: 1px solid #DCDCDC;
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
	#main-container #i18n-container {
		width:100%;
		text-align:center;
	}
	#main-container #i18n-inner {
		display:inline-block;
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
		font-family:  Frutiger55Roman;
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
		margin-right:25%;
	}
	#main-container #contentBottom {
		margin-left: 26%;
	}
	#main-container   message-banner {
		display: block;
		margin-top: 5px;
		position: relative;
		width: 196px;
	}
	#main-container   div#footer {
		background-image:none;
		height:100%;
	}
	#main-container   #footer {
		width:100%;
		clear:both;
		margin-top:2em;
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
		margin-bottom: 20px;
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
	@media all and (max-width: 480px) {
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 600px) {
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
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
        <div id="i18n-container">
             <div id="i18n-inner">
                <i18n></i18n>
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
', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES(  'div', '
 <style>
        :root {
             font-family: proximaLight, Times;
             padding:0px;
             margin:0px;
        }
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
                border-bottom: 1px solid #DCDCDC;
        }
		#main-container   #pageHeaderLeft {

            text-align:left;
		}
		#main-container   #pageHeaderRight {

			text-align: right;
		}
        #main-container   #centerPieceLayout {
            padding: 5px 10px 0px;
            min-height: 200px;
        }
        #main-container #content #contentHeader  custom-text.ng-isolate-scope  {
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
        custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
        }
		#main-container   #content {
			text-align:left;
		}
        #main-container #content h2 {
            font-size: 1.25em;
            margin-top: 0px;
            margin-bottom: 0.25em;
        }
        #main-container   #content contentHeaderLeft {
            font-size:1.25em;
            margin-bottom:0.25em;
            margin-top:0.25em;
        }
        #main-container   .paragraph {
            display: block;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            margin-bottom: 10px;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container   .help-link {
            width: 30%;
            order: 2;
            text-align: right;
        }
        #main-container   .contact {
            width: 70%;
            order: 1;
        }
        #main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			background-color: #f7f7f7;
            border-radius: 1em;
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
		#main-container   #footer .extra-small {
            font-size:0.7em;
        }
        #main-container   #footer .small {
            font-size:0.8em;
        }
        #main-container   #footer .bold {
            font-weight: bold;
        }
       #main-container   #footer .grey {
           color: #6b6b6b;
        }
        #main-container   #footer .bottom-margin {
	        margin-bottom:10px;
         }
		#main-container   #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
        #main-container #footer #copyright custom-text.ng-isolate-scope {
            font-family: BNP Sans Regular;
            font-size: 14px;
            font-weight: normal;
            text-align: center;
            color: #403f3d;
        }
		#main-container   #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container   #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container  #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
        #main-container #helpButton  button span{
                font-family: BNP Sans Regular;
                font-size: 16px;
                font-weight: normal;
                text-align: center;
                color: #403f3d;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
            border-style: none;
            padding:0px
        }
        #main-container #helpButton .fa-info {
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
        #main-container   .col-xs-12 {
            width: 100%;
            margin-bottom: 20px;
        }
        #main-container   message-banner {
            display: block;
            width: 100%;
            position: relative;
        }
        #main-container .halfdivsRight {
            width:50%;
            float: right;
        }

        #main-container  .halfdivsLeft{
            width:50%;
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
		<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>
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
        overflow:visible;
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
    #helpButton #help-container #helpContent #helpCloseButton button{
        font-family: BNP Sans Regular;
        font-size: 16px;
        font-weight: normal;
        height: 30px;
        line-height: 1.0;
        border-radius: 6px;
        background: linear-gradient(#4dbed3,#007ea5);
        box-shadow: none;
        border: 0px;
        color: #FFF;
        width: 163px;
    }
    #helpButton #help-container #helpContent #helpCloseButton button span{
        color:#FFF;
        background:inherit;
    }
    #helpButton  #help-container #helpContent #helpCloseButton span.fa-times {
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
                 <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_pageType_4''" id="paragraph4">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_pageType_5''" id="paragraph4">
                 </custom-text>
             </div>
             <div class="paragraph">
                <help-close-button help-close-label="''network_means_pageType_11''" id="helpCloseButton"></help-close-button>
             </div>
         </div>
     </div>
 </div>', @layoutId);

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;


/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, 'PUSHED_TO_CONFIG', 'iVBORw0KGgoAAAANSUhEUgAADqsAAAG9CAYAAAA4Zq0tAAAACXBIWXMAALiMAAC4jAHM9rsvAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAmDZJREFUeNrs3W1S3EjWBlB5otdjh1dg8d9bYQ0ka2Ar/Le8AgI25EFIBQUU9amPzLznRPidnn572iZLyrxXyqfyvwYAAAC4zO+7fwahSc399a1hAAAAAACAFXhXMbi//mYQAAAAANbxP0MAAAAAAAAAAAAAAAAAAMC5hFUBAAAAAAAAAAAAAAAAADibsCoAAAAAAAAAAAAAAAAAAGcTVgUAAAAAAAAAAAAAAAAA4GzCqgAAAAAAAAAAAAAAAAAAnO0/QwAAAAAAFOP33c2Hv9OOvza68deb++tbAwcAAAAAAAAAADAfYVUAAAAAIF9DOLVt3gdS9/n8z/6+S+Nfda+/7q//GlwAAAAAAAAAAIBpCKsCAAAAAHk5PaB6rLd/5++7/v8mp64CAAAAAAAAAABcTlgVAAAAAFjf77tfzRAkTQv+rmk8dbVrhuCq01YBAAAAAAAAAADOIKwKAAAAAKxnCKmmZvpTVE/R/97d85+la4RWAQAAAAAAAAAATvY/QwAAAAAArOL33U0znGraZvInapshtPrHhwMAAAAAAAAAAHA8J6sCAAAAAMvK4zTVfdrnP+O/l/90yioAAAAAAAAAAMBBTlYFAAAAAJaT32mq+zhlFQAAAAAAAAAA4AjCqgAAAADAMobgZyrsT90KrAIAAAAAAAAAAOwnrAoAAAAAzG8IfLaF/un7wOq/51+/fJAAAAAAAAAAAACfCasCAAAAAPPpA5590LPcoOq2TmAVAAAAAAAAAADgM2FVAAAAAGAeQ7Czq+ynElgFAAAAAAAAAAD4QFgVAAAAAJhLqvTnElgFAAAAAAAAAADYIqwKAAAAAEzv992f5//bVvwTJh8yAAAAAAAAAADA4D9DABMZTtPoXn7dX18ZEAAAACCs+oOqzcvP1/+cngMBAAAAAACVeHh8uvnwt9pmnnc+6ePf+Pnj+61PAAAAyiasClN4C6oOjbmNigAAAEBUw3OSNshP2z8Humnur22eAAAAAAAAivDw+LT9Lqdt1nmvk3b8uT7+va5525srzAoAAAUQVoVLvQ+qNq/Nu8AqAAAAEFMX7OdNze+7rrm//uujBwAAAAAAcrN1Wmoq7I/eNltB2g9h1te/FmIFAIB8CKvCJXYHVd+aZIFVAAAAIJL+WUhM6fmXZ0AAAAAAAMDqCg6nniJt/bybv+42v37++O5LRgEAYAXCqnCu/UHVjfbln3OyBgAAAFC74VlJG/Sn758B3TT31765GwAAAAAAWNTD49PmHU0KPhTt+Ksfk83fexkTp68CAMAyhFXhHMcFVTe653++FVgFAAAAKpf8/I2NDgAAAAAAwOwEVI+WxvFK2/9deBUAAObxP0MAJzotqLrRjf87AAAAgPr0p4rGPVX14zgAAAAAAADM4uHx6eb5159m2MeajMjJ+jFLz2P4b/zVj6f3OwAAMBEnq8IpzguqbjhhFShpvvtnEIqUvlyDrD8AAKxTi0YcB9/EDQA1GL6EQo1Tnq756l3e/bU6DQAAgCKNp6imxheHziGNY9z/Z7f59fPHd3utgFzWAPt5C15fdrDGANUTVoVjXRZUfS0uBFYBWKG57dexff+sMCsAAOcbnpnwNh43ghAAAKtpm6827v6+Sx/+Ttdsv/tTwwEAAJCZ8cTPr3tdpvY61s9j3/9HaoSKADhP2rO+7/tnrTtA8YRV4RjTBFVfCwiBVQCya4Tfwqzpdb2yVgEAcE5tST8egg4AAPlrm+3Nvu/DrMNfC7ACAACwgjGkmozE6tL4eWz+WoAIgNnWm6064OPft/4ARRFWhUOmDapuCKwCkH/T+zHAamMWAAC7tYbgg/55kuc+AAAlS2Ndl8b/3r3+UucBAAAwEyHVrKXxM9r8teAQAIusPVvrz+vfe16D7OcFsiWsCvvME1TdEFgFoKyGd9iY1TU2ZQEAsPH77sYg7NQ+/1IvAwDUVd+1Yw3c/9+uGZ6R2hAEAADAxYRUi5PGz23z14KrACy9Br2sP5tf1iEgJ8Kq8JV5g6obAqsAlKZt3m/KGhpeaxkAQOT6kM/6OllwAQCg7jq4ffcFf4KrAAAAnOjh8anfp5oa71tKlsbPsmuGsJDnAwAspd3UEL5AAcjJ/wwB7LBMUHWjG38/AChRGteyf07VAgAIqTUEAACoiZs0PiP9470fAAAAx3h4fPrTDPtUW6NRhf5zTM+f67/+pNwxiAwAS0p9bbFZiwwHsBZhVfho2aDqhsAqAHU0ujZkAQDEoeY7ND5e/gAAxNM2vtwPAACAPcYg479GSLVmqRnCQn+EhQBYay0aQ6t/fIECsDRhVdi2TlB1Q2AVgFq047omtAoAUH/dBwAA7ObL/QAAAHjVB0XG01ST0QijbbZOWzUcAKy0FnVCq8CShFVhY92g6obAKgDVNbnjhizrGwBAnfUeX0uGAACAxpf7AQAAhDcGFbvGu5XIXkOrwkIArKCvQTpfoAAsQVgVenkEVTcEVgGokc1YAAD1aQ0BAACcVD8Pz0kBAAAIw2mqfNBfC064A2DVtcg6BMxJWBXyCqpuCKwCUKO2EVoFAAAAAGJrm993/55/+fZ6AACAivUBkP70ssaXf7Jbf10IrQJgHQKqI6xKbHkGVTcEVgGousm1GQsAgOp5tgMAwNeSL/YDAACo08PjU78npjMSHKFthIUAWH8dsp8XmIywKnHlHVTdEFgFoGY2YwEAULvWEAAAcKBe7F6ekwIAAFCFPnTY9Hti4DRtI7QKwHqSNQiYirAqMZURVN0QWAWgZm3jlFUAAAAAILbWF/sBAACUbwyqtkaCC/TXjxPuALAGAcUSViWesoKqGwKrANQuOT0AAKAgvmwEAACm1jbeCQIAABSpP4Xs+de/RlCV6SRhIQBWXIPs5wXOJqxKLGUGVTe8nAagdk4PAAAAAACi63yxHwAAQDn6oGpT7r5U8ua6AmAtbR9YHescgJMIqxJH2UHVt8ZTgAeAyhtc6x0AQBE6QwAAALNpBVYBAADyJ6jKjLqfP77/NQwArKjt1yOBVeBUwqrEUEdQ9bUBFeABIADrHQBAzu6vvRwHAIB5CawCAABkTFCVmSVDAEAmBFaBkwirUr+6gqqvC74ADwARGlzrHQAAxde0AABwPoFVAACADAmqMjOnqgKQ3doksAocS1iVutUZVH1d8AV4AIjQ4FrvAAAolhNoAQC4nMAqAABARgRVWUAyBABkSGAVOIqwKvWqO6j6uuAL8AAQocG13gEAAAAAgQmsAgAAZEBQlQU4VRWArNcpgVXgEGFV6hQjqPq64AvwAGC9AwBglRoNAABYisAqAADAigRVWUgyBABkTmAV2EtYlfrECqq+LvgCPABY7wAAWLw+Y59kCAAAmJjAKgAAwHqSIWDua8ypqgAUQmAV+JKwKnWJGVR9XfAFeAAIIBkCAAAAACCwPrB6YxgAAACW8/D49OelH4MZ/fzx/dYoAFCQZAiAXYRVqUfsoOqGwCoAtXNyAABALu6vvTDfrzMEAADMJHknCAAAsAxBVRbr9QGgLO1YJwG8I6xKHQRVtwmsAlB9g2utAwDIRmcIvnB//dcgAACgFgcAACjXw+NTvz+lNRLMzamqABSqHeslgFfCqpRPUHUXgVUA6l/rAABQl+UrGQIAAGb3+8631gMAAMxkDF50RoIFJEMAQME6gVVgm7AqZRNU3bvoC6wCUHkdYCMWAMDa7q99y/NunSEAAGABrfeBAAAAs0mGgCU4VRUAdRNQE2FVyiWoegyBVQBqZiMWAEAeOkPwwf31X4MAAIB6HAAAoEwPj0/9F6i3RoIFJEMAQAVap6sCG8KqlElQ9RQCqwDUvc4BAKAmy0syBAAALOr33Y1BAAAAmMYYtGiNBEtwqioAFekMAdATVqU8gqrnLfwCqwDUWxvYiAUAsKb7ay/RjQcAAOtK3gUCAABMpjMELNbPA0BFHh6f7OcFhFUpjKDqJQRWAahVMgQAAGoy4wAAgFoUAACASzw8Pv0xCizFqaoAVCgZAkBYlXIIqk5BYBWAWusE38YEALAmp4kaBwAA1tZ6DwgAAHC+h8enXy+9FSwjGQIAKq2pfPkHBCesShkEVacksApAjZIhAABYXasmBQAANSkAAICeCvZzqioAFWvHLwEBghJWJX+CqnMQWAWgxprB6aoAAGu6v/7bxH2G0zlVFQCADDhdFQAA4AwPj083jS/lZDnJEABQOXUVBCasSt4EVecksApAbZIhAABQk/m5AQAIrjUEAAAAJ0uGgKU4VRUAtRVQM2FV8iWougSBVQBqqx+crgoAsKbhdNU22E+dxp8bAADyqE8BAAA42niqKujbAUCNBUxAWJU8CaouSWAVgJokQwAAsLIhuNkF+Wm755/Xt18DAJAXX+oHAABwimQIWIpTVQFQYwG1E1YlP4KqaxBYBaC2WgIAgDXdX181EZ7vDD8nAADkJhkCAACAwx4en/4YBfTrADBbrWU/LwQkrEpeBFXXJLAKQC1aQwAAkIH6g5zqTgAA8uW9HwAAwF5jeKI1EizFqaoABKTWgoCEVcmHoGoOBFYBqEEyBAAA2Wir/bnur//6eAEAUIsDAAAUKxkC9OkAoN4CpiWsSh4EVXMisApALbUFAABrGwKdbWU/laAqAAAlSIYAAABgr9YQsJDu54/v3i0BENLD49ONUYBYhFVZn6Bqlo2xkA8AhWsNAQBAJuoKrAqqAgBQDu/7AAAAdhKaYGHJEAAAEIWwKusSVM2ZwCoAJUuGAAAgI33A8/76W1Puc6D+zy2oCgBAaVpDAAAAsFMyBCzEqaoAqLuAUIRVWY+gahFNssAqAIXXGgAA5OT++qop73lQ9/LnFlQFAKA8yRAAAAC851RV9OYAsHj9ZT8vBCKsyjoEVUsisApAqVpDAACQoSGwWkqt1o5/XgAAAAAAoA6tIWAhTlUFAPUXhCOsyvIEVYtsmAVWAdDcAgAwmf6U0vvrb02+z4i6lz+f01QBACjd7zsnBgEAAIzGU71aI8FCkiEAgBfqLwhEWJVlCaqWTGAVAM0tAADTejtltcvkT9Q1TlMFAAAAAIBatYaAhThVFQDUYBCSsCrLEVStonkWWAWgwPoDAICcDaesrh1a7ZpNSNVpqgAA1CUZAgAAAD0SrjUAWNN4wj0QgLAqyxBUrYnAKgAlaQ0BAEAhNqHV++tvzXIv8FMjpAoAAAAAANV7eHy6MQosxKmqAPBZawggBmFV5ieoWmUjLbAKAAAAzOb++nYMrbbNECjtJvy3p2YIqH4bfx+bBQAAqJv3egAAAL3WELCQZAgAAIjqP0PArARVa9YHVlsbOgHIXHr+dWsYAAAKNTx3+Pta0w3Pmtqtf6Jtvt5ckrb+uvMMAwCAwNqxrgYAAIjeG7Gcrnm/f3jnaaMPj0+/dnw2bcGfl1NVAWC31NjPCyEIqzIfQdUIBFYBAACA5byFVze8yAAAAAAAAPYaA5HMq2uGoOZJ727GYOfHPai3Hz67dvyvqYBxSC4FAAAiE1ZlHoKqkQisAtGkCf4dbePbGgEAAACAMnXNNO8Bk6FcTNv4ohcAAEBfxPS6vr+f8yTRD2HWl9724fHppslz/5VTVQGWlSaqEdQJABMSVmV6gqoRCawCcdxfT7Gh53bH2tlqfGerTW4m+twAAAAAgP690DzPSW+2/lsyzJNqDQEAABCcPnPi8Tz1BNUpjb/3Jri62XeVXGcAsUy0Fr37d3w40bttPFudVP+FE2vWEMAyhFWZlqBqZAKrAOca5s533wC4FWBNBggAAAAAqN77AOzmOekmwJoMEAAAAOcYQydMI+UWMNk6efV2/KxTs06wyKmqABX44kTvzX7ethFeBThIWJXpCKoisAownbcA6/amrGRgAAAAAIAw3gKst+O7yNTYDAQAAMBp9JGX64OYV7n/IceA0cufsz+5rVl2r1VymQDUafuLEVZaYwCK8j9DwCQEVXnTjdcDAFPqN2XdX38bG1xrLgAAAAAQS/8Ff/fXV1vPSTmF93cAAEBcrSG4bPxKCKp+1J8A+/zr2/j5dzP/dk5VBQhk4TUGoDjCqlxOUJUdjbcX3gAzGUKr/QPgZDCO1hoCAAAAAKjI25f7dQbjaK0hAAAA9EOcoA9gfis9hNn/+cewbX8ddDP9NsnlAhDP1hpjHbBmAluEVbmMoCpfE1gFmJPNWKdoDQEAAAAAVGj4Yr/WQAAAAMCkuhJPU91nxtCqU1UBgts6abUzGgDCqlxCUJUjmnCBVYCZOWUVAAAAAIjs/vqvL/YDAABgl4fHpxujcLLqgqrbPoRWp/j3XblkANhaE5KRAKITVuU8gqocT2AVYG79KatODwAAAAAAIhu+2K8zEAAAAHC2Lkr4cgyt9l9+lS741ySXDAAf1hf7eYHwhFU5naAqpxNYBZhbf3qABhcAAAAAiExgFQAAgPeSIThaF/GU0D5UNIZWu3P+ty4bAHasD/bzAqEJq3IaQVXOJ7AKMLchsJoMBAAAAAAQlsAqAAAAnCNF/uHHoG5rvACYaF2xnxcIS1iV4wmqcjmBVYC53V/fWq8BAAAAgOCSITAmAAAAHN8zjqGa0PoxOPaUVaeqAnDkWtEZCSAaYVWOI6jKdARWAeaXDAEAAAAAENb9tW+tBwAACO7h8enGKBxH8PLTeBw6ZTUZJQCOZM0AwhFW5TBBVaYnsAowJxuxAAAAAIDo7q9ttAUAAIDDkiH4bDxptm127J8W7gXgxPXEWrvFF4pA/YRV2U9QlfkIrALMyUasjzWN5hYAAAAA4kmGAAAAAL4meLl3bP6Op6x2W387GRkArLUAXxNW5WuCqsxPYBVg7nkWAAAAACAqX+oHAAAQWTIEB3WG4LAxsJrGv/asAQB1CcAewqrsJqjKcgRWATS3AAAAAABz6QwBAAAA6Jkv0YdUn399MxIAWHMB9hNW5TNBVdYovgRWAaZ3f/3XIAAAAAAAwXWGAAAAAPTMALCWnz++288LhCGsynuCqqxHYBVgHskQAAAAAABh3V/fGgQAAAD4THAGABaVDAEQgbAqbwRVWZ/AKgDzsCENAAAAAAAAACCEh8cn+xABAABWIKzKQFCVfAisAkw9rwIAAAAAxJYMAQAAQCitIQAAMtMZgpeT3R0+A5UTVkVQlTwLMYFVgGncX/81CAAAAAAAAAAAAACwjp8/vtvPC4QgrBqdoCr5ElgFAAAAAACAaSRDAAAAAAAAwJyEVSMTVCV/AqsAAAAAAAAAAAAAE3t4fLI/EwAAmJSwalSCqpRDYBUAAAAAAIDz3V/fGgQAAAD4pDUEAADAlIRVIxJUpTwCqwAAAAAAAAAAAADTaQ0BAAAwpf8MQTCCqpSrD6y2zf31X0MBAGzVtzeT1BlqDIA551lzL5DLnNY/G23Na7iGd3DiIACoEdS0wHy9h/kFAPLVGgJY1sPj02zv4H/++K7uBqD0Nc56VgFh1UgEVSmfwCoA50iGoPgath3/W9vM9aLk993X141N20C9c+z2A8L55tjj596P67ZNbEAN81rXvH8ma27jmN5n+V7291062E/rjQAgl1o3zfj7fFXLqmPBvDJ1z5z0GgCQhz5U8PPHd+sxXH4vfXzO3zYLv6t6/jN8/Fvbvf3LfxcAAlbWGYJq1rrZ1rkd61na/IW6tQzCqlEIqlJTgSKwCgA116ztx+ZyJWnrz5Ve65DNL7UIUObc2jb5fzty+vDn3/X/Mw+DuS2nuvGQz3Pv7rnN/GZtLmFdTtZloPD5NzZBoJKu15tMaoX3v/9bHZtcU1BsH5JTD5J29Bpd4z0MAKy1Lqvv4UhLBXVm6e2bTwGg11pciBVYSGcIilzvUgb16ubPlbaupc4alidh1QgEVamxSBFYBYBa6tS2KSM81bz7cw4bs16bXXUJkNHcutnQmir86dLWz/nx75mLQd1Y/txmfqt9ba7t+v16XRZcAfLUGgL08hPXAW/hMjUA5Du3lNaHvP15vYcBgEU5XRX23x+F9e2n9/jNuxDr5u8J/wDEWu+K3c87rmFdI7yaDWHV2gmqUi+BVQAotz7tG8RUwU/z1pQPmyZSY8MEsPy8WvOLsWOkrbEYekUb2KCmmvGt3jK/vf09IQA9T+7XreAKABzbz9dS727XAJue3PoP5pYpvP0s3sMAwOx1/cPjk4390FQfTj2+z2+EfwACrHlV7ucd169k7VqPsGrNBFWpn8AqAIfZFJNLXVpLQ7tPGn/e4a9de4A5dQ1ts+v0BXMymN/qqjfT1n+3STeP67e2DeFzXLNd4wslANbUGQI1w6J9ueAqLN1PpyD9yKbHGP7a/AIAc/SO3wwD0QinHtnrN+/Dq05jBs5h7shi3Qu1n3cTXHXtLUtYtVaCqsQhsAqwvya4MQisfP2loD992tqQlWavVdzrQ12oJqTu+bRtBGDOMYybYNcS1+kv16j16ILrJhmMM2vOYRybRhDA+lzKmvx2zVqTgTXmodh1KmvWvCnoNbjdk8+/9utLB2v2BD6DZZ8NxJ5fhp5iyfcwUG4t4h1i7esvTOzh8enPzx/fr4wEAa51z/gv7PefxzC91uZOroNT5h5Y8/pLQX/8NK5bXTMEV/+61+clrFojQVXiEVgFgLxq0b6paw3Gi3asVV4a3hlfVCZD/TIG6kFqmk+9HJtzvhSSmWvNsx5Zj8xx696DTrBy7Za4JrtegSXXSli6btAj7V775wqV6UsHa9ZVPoMlng14D7Pruutmnl+g1Hrkj7lCrwHnXNMCq9RKQHXenn9zcl0juAqQ09rnOdLn/q1b4LTVFH2ghVVrI6hKXAKrAApeP/+6dagHusdcj5tTBGzEBr7u6ZO5dOE6QUgGlq4Z1ejzG+pywdUp1+fWtbvY9WpzOTDXXB5dZwjUvBmt/UJlcP56lhrPDs0vcNycIai61NxjvqHSa1tglVoI6SwujePe1+XdjCEgKPoe8fNj/cvjehxPW03Wq+kJq9ZEUBUEVgFg+RrU5qszmlyhVcBcmpW2EZKBOec4L0HMca5dTrleO18kAcw0v8Rm/dfb573uq1Hh8BwjdHbO/HJ/LWBDxPnC/sEl5xs1DJVf431gtRk277vWKcoY0Gn16avX5e0YAurMJQCLrYGeU59OaHUG/zMElfCgCTY635AN8Fof3IQfAxtb560/f9/909he1uS+jKF7FSLPo3/Mpdlpx77S/AxTzXPDM8vWgJjjiuqlh/XZtbvutapfAqYUvefqXAKL1A56+8tq1D/e8cKXvfU/vcmZ84uegohzhtpvuTlGUJVA9foYeoDs9SHVMWTd6dOznEv+mU8IPke5/vUrc6+BnlNfJlmrpiOsWgMPmuBzIeNlJkCj6WC22vMtdMBU96rNWBBpHr0R3ipqfrahDS6rF81z+c9x6tD3a7QXeNZjoMbahM4QqB0K0DbDO15rPrzNM97FTNdT6H2JUveaM5aore+vvwmqEnE97QOA42mVkJ0+VDIGdLrGu6kS5hNBIOL2p8E5YXmWNXD7ixpQ+2ZDWLV0HjTBVwRWgeg1ggc6aqTp606hgzm1zeYEAaDetfltE6t5tCwCXXBaH6JeLLMOvQl93QqalLQee94BnD5/0BmCSWuHX2qHRdZ8/TfmGb31HL2vuYV65w013zJ19f31lWEg+noqYEZOtkKqevQC+/8xtCoMRJj5yijoWSa+prZDqq0Rma32tZ/3TMKqJfOgCQ4XNV42AHElQ6BOmrDuFDpYssm1GQvqm0NtYq1njt58sYB5Gsx1tbm/vnXdUggBFuCUuf5X43lW49SnCa8npxwuyRf7Ebe/Ns+YW+D0mte8scT8IagKG05FZHVCqlVpmzEMJLRK7eunIdC3TLkONvbzLrZOjbWvNepEwqql8qAJji9sbFwC4tUJHgj3Im62nqPmHF7aJ4OxSg1jwwSUvh4LwNSqbYRWQb1Yl+S6pdieyVoMHJorMAZT9fg2/6zTf/uSCmLNNfqU5eYW71+oZd6wf3CpmlpQVT/ELkKrLE5ItfI63Ql2VDx3GYWm+fnju/28l19Lm9NUrYMr9BbWqNMIq5bIgyY4eXHwEhMIVidoRNRKU1xLNmCtr7X5Ggpdi4VU48zTQ7/pxQLqRcoW6Yt+3k5Dc91ai4EYcz6ek07R49v8k8N1bL0nxrqlT1mylxCGp4Y6Ra23TB0iqFqsnz++/zUKixBaZXZjOMc7+CC1ujmF2uYvc9dYV3PptWR/Rh5rlJPAjySsWhoPmuD8IseLBkCdoLnluOvIBqysGlx1DBQ3f1qD4knj5jYvzFAvUuYcFuO63Zx43vrIq16L9U3A27xvzh9E+lKKea6jzrWU1XovhE6t842g6nq8f6HUecO+gKXmCEFVOKlmHwNmNvAzma0T5Kx7cecU7+Apeg4zf23V1ly6FiajkYW2GU5ZVe8eIKxaEg+a4PJCx4sGoG6akQ2bsM6tN23AUscA582fTmljqMWciE39890v811lNWbtvZNwdcS+SYgF1Cu+qX57XuSSPt91lJ9W302F/Yov1cmjjzCvUFq9q85bou4QVIXz759hA/9LyMxGfs61FVJVL8eWhOAp+fo1BIOfP77bz3veWmg/b746X6iwn7BqKTxogskWBi8agCrrBC+z38/1nHMd2YBVRh1j4zVYg8lba76m8npRrV2XVPk1K1wddS0WYoHI9cqNeiXQWq/Pj953W+uppV8hD+YVzB28rzfur/8aBpisL+3GoJnN/BxlDDnrzfn0LGAMMEMJ89gv89iHnptzriP7eQuoda1NXxNWLYEHTTB90eNFA6BOqLoBMAQnXkND8KA1GEVoBaAgq7nTGsy++fqf3pOK5j31Yn26qjfdWaetw8MzYBvgIF69kgzEFhvsT72GhJ1Lq2f13JR+DWNegdNqFfsCliGoWh99Yi731rCZ/5/gKl8Zw12e77B3LhnnEXU7Wc9l6vYd/TbnrIet0ShmbbKfdwdh1dx50ATzFT5eNADl1wk23+7i5dE5tabGtrAGV2AVVp07b8ydnNh7mrOpoe8w59UnVdvjOA2N7evcOgwRahVzf6S1ft6a15iV2XN730upcw7mFTit5rUvYAmCqrDUvfYWXP03nqJp/Q1uDDB3jec7HFm3CwaR6VxmP+8OP398vzUKR19D9vMWWt9alz4TVs2ZB00we8PiRQNQaI1wYwPWl5IhOOE6UmsW3eDa0AKrzJ02r3LunO2UVUqc8wQ/6lXnqaqep7Ovd7IOQ621is0/X7m/tgHotF5fzVtybWudx5zDtJIhILu6V827BEFVWHft7baCq05dDcZpqpy7djtllYzmsX798l5dj33pdaT3K39dsp93i7BqrjxogqV4gQmUVB9sQqoauK/YhHXsteRBbyUNrsAqLNijC2wxTf9p3qacec+zyZqlCq9ZYSX2906eA0Nt/dlm3tejRVnr9foc7ret85TSt5hzSugfPMMjp3rF845l7ntB1bprRUrrZzenrv4RXK1bH8oR7mKKed5cwYrz2CakmozGbk5VPfpa8q67kt5SYPXNf4YgQx40weLNyvN958EjkGtd0D9MaRsP5o6h6T/umrIZorIG16YJWGQttsYw9byd9KBkPO95Nlm3+k5V1eNwyvXvOTCUXJ+0erMT5jvUvDGve58p+ham0r48F/YluahX6q8f7q+vDEPdfv74/vfh8clAlLoeDxv+N88C+v/s+s/U0JRvDHKoj5lKH3Lvr6dkjmCB+ct+3hPuTUNgTYxYwwqsDoRVc+NBE6zFRiUgl1rgRqN2Ji+Mj7m+NLaVNriGAMybFDdv60HJdd7zbLJ+yfVKcP0anDxDgCLm+La6tWuptV6foYaI3W9D7usaJa2pv+866yrqlYqfDwiqQnlrc/MS6Hj9a6e1lUkohxmfCfSnrLYCq0w8Z9nPeybrtDUx+JoUnrBqTjxogrXZLAwstebf7ChMFaeX8TDg8HWnsQXQn5NfDyosg7mPZeedWp57uV65TBqfA9uUCuvP5e2n+5PL6C/UEIB5h2n76Kb5Zhgwb1R4b3smEE3Sb1b5mTbjqav9nNkJxOTv+fOyxrHIOt/PDeYETpyf7Oedaa1m73VnPy9VE1bNhQdNkE2jIrAKHFiz/xmEDOdum7AOXbcaWwD9OXkSliGv6xGfsbWaONqXXtkaDJfUsWoHa70aAsDcHGH90DegXqmLoCrUp+1/jcHVTf3VOVkxL4KqLN2HjSesWvNjzC/282ZIYPzgdWs/L9X7nyHIgAdNkJtuvC8BKEMyBHtrTY0twPFz5o3+nBW043oNakbm7Ztq+HI2z9KxBgN8xRf6qSEAvTbz9Q32j6BeqadmFlqJ+tkTSWqGkxX/9SfljSFJVjQGctyHLF7Hj9cesEYfzaF10RhRPWHVtXnQBLkSWAUoZb52Gva+WlNjC3DanJkMBCvpN73904ey0vx3o2YMoIbwimfpzLcG27AC1EA/q4YA8pt79NrWWVCv5ENQNTAnbIZfwwVXVySQw8peAqvufVi27lZ7WRehJ6y6Jg+aIPuCyUZhgMx5obSv1tTYApgz0YfCofmvv96SgahequRa7XyUzKQdg/sA5a71vtBPDQHkxtyjZwD1Sk73sH0FuM/4EFw1HPMTyCGbOmC4972DhwX8/PFd3W1dhBfCqmvxoAlKYaMwQL40bl/XmhpbAHMm+lA47nqjfqWfqupZOstI1l+g2HquhhPU1btAbbUlPlc4hmceS2h9sQt6A3at62No1YmLMxHIIcd1wP0OC9TeWBdhJKy6Bg+aoLgmxUYlgOw4LeDrWvNGYwtw9JzpYSD6UKLPgUToncq+Tj1Lx/oLUPNar94FoKy1xSlsTHk9eeYxP0FVXv388d2X/LB7nnDa6uQEcsiYwCrMJz3XW2rv3eviL+siEQmrLs2DJii2SbFRCSCjOdlpAftqzWQgAI6aM70kQx9K9LrRHBhB+b1T50PE+gvwJZvv9fwALCsZAiaqVW4azzzUyqzBfcfedd5pq5cTVKWEtcA9DtPfV74Y5Mt1UXaMsIRVlySoCsUXUzYqAWQwF99fXxkGtSbAhXOml2ToQ3FtEUGqYL0GcyTAbjbf6/kBWGedceoaU9QqyUColVlFZwg4ag4ZwmxCqycSVKWk9cD9DdPdTz9/fLefd/e6aD8voQmrLkV4AKopqmwUBlhxDhZU3ScZAoCj+nMvydCHYh4khpJPVbVeY64E2N8j2Hz/1fz9Sw0BwMySIeDCXlOtMmedLKjKHk784kT9fN2Np636sooDBFUpsW4QWIXL7yNB1b2SISAyYdUlCKpCdcWVjcIAKxBU3VdveugLYL5EHwrHzIM278eRCr5Ob1ynZKB1YhKQbW/gOem+WrczEAAs1LfCqdeN9xNL1MmCqhxzrcDpktDq1wRVsSZA3PXREFgb4SvCqnPzUgzqbVJsFAZYbs7VuO2rN23kBjhuvvQgkNIlQ4DriKN7qFJPVR2et7lOyWfO9AwYyG+NF1RV6wJgzaE03k+ok8nreoELagCh1feEcajkGgZO1/788d0XxeyeV+znhUZYdV6CqlA7gVWAJeZa34B6qN5MBgLgqPmyNRAUrh03NYG5kENK7hE6Hx+uSYAv5iMb8PfVujbHArD02iOkgjpFnUyBfv74fmsUmEAfWv3z/Cv03tHx57fGUbpWYBVOq7+f66lvgqp718ZkJEBYdT6CqhCm6BJYBZhxjvVi6RCNLYD+nFgEVlE7ckwfVebLQfMbrk2Ar/sAz0kP9f2tgQBg8fUZjusnXSvzsZ+AcyVDwES1QBc1tDr+zJ3LgFruZ4FVOK7+/vnju/pbnQlHEVadg42wFhjCFV8CqwAzzK1eLB2qOb3cBNCfE1Pr5AbOnA/VjjGkQq/RG9coma+9nv8C681BpX4RxXL0/QDoE8iPd7nz14D2E3Amp6syeU0whFbDvLsTVKXWezn6aclwqP4WVD24PuoBYYuw6tRshI3ddN5f31pk4hZhXkQATLqmamwP15xqDoDDkiGg2mtbD4r5kM/KPFV1mM9co+R/fwEsP+8Iqh6uI5x6AcCaWkPAnhrF9TGfZD8Bk1xHMPE19fD49C9I2M39Q606gVXY3fsKqu43zh16QNgirDolQdXQi/Dry+LhPy02QRsVm4UBLpxHbcA6ZawA2N+j2wyCegCG+dCLkTiSPzfMXl8CLLM29pvvPSdV5wKgn6XU3lGNMp/NYRJwEaerMqNuPFmtSk6NI8I9bAjg3f3QB1U9pzZ3wMmEVaciqBrZ51CNwGrsYkNgFeAcNmAdX3faHAtwXI+uJ0NdAAPzYQylnqp64xqlqPnUs19gibnG5vvj6x8AWL+v1SOwfT0I8MxfK9tPwJSSIWCu+arGU1adGkcUNQfO4ZQ6qT9NVVD1qDnjxijAZ8KqUxBUDd1UfvkQTGA1MoFVgFPmTBuwTq071RcAenTYaMegF+yTDIHPOeM12/U57TWw/avvtb99+vX5n1M3ncZ4AfPN48NcbfPPcXWETYMA5KI1BGzVJ66HOe81tTITc7oqC6jmlNUxqNr5SIlSdwifEXntaobTVNVJx6+PyUjAZ/8ZggvZBBu6GD34EKz///++a10jQYu1/rP3oBTgsrWUjzS2AOZK+HzN/77r1FXs5Mu0oih1DrBmX/KZb36d+tl//rKo2635ot36xddz640v3QImntOTev7kGtdaBUBOva3+QH0iqDov+wqYex5PhoE557AxsJoKP53OfUK49eH53u2cKkm0Ncs1b32EqQirXkJQNfRifPRDMIHVyARWAb5q0GzqPKf2vGm85AQwV8JX9VXTXBkGdjAnnnc/zfnP5/BnzmHNFjI573OeL5g8/Hv7X7cf6iqf0+7PwnMN4FJdI6Qap/YBAOolqDo3+66YVX9q2MPjU+s+Zva5bDhltcgQ0HjCpHuEiFLjHTxBrnUnqZ61PnrfDXsIq55LUDV243j6t9ULrMYlsArwcV4caqmbcY3U5J7wUMAQABzs082VRNU65Q015EVjdEkA8PbDWtS+3pfLvJwq9VTVzqV39Dh1q8zvw++5HVw1n7yvPf88j5FNKsClc3z7+v7Qe6Rj518bZAHIc33yXC5ub6g2mbNe9uUuLCU1nley0Nz28PhUVCBoDOIkHx1B9Scj3wjxEaDu3nwxQeN6P33sgN2EVc8hqBq68Dz7IZjAauxiRGAV4G0t3X5h9/subTVu3bhmang/1583BgHgoGQICH8P/L6zyZ3tGvKXQdi7Zkx/v7ydTNm73VHPT79WlRiW098co2ty2pC5Ca4KrW5rX+ZZ6y4wVQ/7+257DegaAVa9PwCQN0HVOXW+IIol9Sdd9gFC/QZL9bXjCaulzHPuC9yzj09diaciw5Ha7b5mrImGmnzczyvA+tkm3At8TVj1VIKqsRfjS18KC6xGJrAKcGzT+xZgTeP6qdn18BfgmF69NRDwUjPYxMN2jc3He2S9Eyp7t1trVjvBZ5SK/Rz4StfkfGqI0Kp1F1iqhmvHXnezNgy/or9j8oUXAOTdG3ifGasuEVSdj6Aqq+hDGH2A0L3NUr3/8/X2J/fA6hjEcU+AdwEEXas2a8BWgDVt6ibD4z0pHPI/Q3ACQdXYC+5UL4CHf48GLqbOqSYAJzd0/Qlh/15e+EXdjDS87ATgUK0N9FobuHl3PfC2Ttxff8vii3D6Z4P9n6PfdNf/mTanvJ737yrvRaA5an8PPFwX+QeRhmuvVYONp6sCzF/TDfXC8Jz0JvDck1wOAMDqBFXnJKjKqgo66ZJK+v0+sKoPh2LuV+8CYNzP+3w//OvXsKinizpVFY4jrHosQdXQRebkG4QEViMTWAU4dz2OGFx1UiDAMXOlh4DwXjIEbNXQbAKAuTo/uJqK/Tz4qGuGZ9BlhY+H4PWVz9Q1Dawy78QLrur9AbBWkcfnLKg6H0FVcuEeZ9HrLdfAagFBWli+VgE+1kxRg6vJxw+HCaseQ1A19kI61zfZC6zGbloEVgEubnRfN2RpbAGi9+vmSvh8b9gc5xrw3GFTT5cUANwEV99OUNv/z5qbatAVc5rq/muxDfwZOl0VWLfWGd45/fGcFABgZoKqcxJUJRs/f3y3p5OlZRdYHU+QdB/A53vDey74Yi1r3oKrN+YBoCeseoigauyFc+5NQgKrkQmsAkxj+7TVuuZVp6oCHLcOAO4NdlFHDpvcbov8kw8nVt5unbZayz1ubvp4n9ayEfPtOXdnzgVYbR6q98v9fOEFAHpe1q9HBFXnvHcEVcmMwCpr9PWZBVbVNeDegLPvk63TVn+ZByAuYdV9BFVDN3+LfZu9wGpkAqsAU67db6cI/KroZwJgf89uroSv75E/BoHQ6gkBfg6tOlW1jn6v5NNUd1+rf8f7rgv4eSaXNJDVnFRfaNU8C7B7bhx+9T3jKb+2/7fAYYKqc2qL/bI5qjcGVjsjwZJzYg6BVaeqwsF7xPsuOLbWf66lagqtuv/hNMKqXxFUjb04Lr1RSGA1MoFVgBma3ErCGcnHCWCehIvqIv2mOdLPX4+30GrrM6lgfq4tqPr+Wo0ZWBXIBnJce2sIrZpfATa65n0w9fb113n95e2HPlPPBrtrEUHV+dT9fIQq/PzxPeoXs7Hi3JhBYFVdCO4RmLbuH0Or7n+IRVh1F0HV2AviWg/CBFYjE1gFmGNNL3kzlk1YAMf07fonOCwZAoLqqv3JStzEp79536tG2IgZM7BqzQXynZ/6kEW576HMr4B5fAinXs12+mDfo7wPrnaGXf9LI6g6L0FVijEGVvUlLDpHrnVym1NV4eh7Rd0P561v/0q9f9z3cDph1Y8EVUMvgqs/CBNYjUxgFWAepW7GSj46APMkTMDpqsRks1t+cxFD/RLr2oxXr1lzgbzX4q64AI3AD6B/+DZbQHVfPz18+cywdkBEfW/Xfymy5xnz1aae3VGYnz++35oTWLoWHIOjy9eggHsF5l/j/qy0zrnvYUH/GYItgqqR5fMgrP9z/L5rXYshdS+fvYeyANOv88McmxZ/qX9eTWoT1vrSCddWa7hgld7dvWeu5LRaSJ8Zb54E63ZeuiL60SnFfM7d10dXLncg63lqmJtL+QIFNcTa9cvx63gyXDBp77B+TTmsE1fjOyv3OHHYOzh/fWdPFIX6+eP734fHp9YcwZJ1YX/N9dfeEr+ZU1WzcWzt3fq81tWfsjh+mQFwTl8wrHOphPuowGCt9ZEsCKtueNgUe8HL7UGYwGpkAqsAczYswxyb+8ZRzdLyTWx35tp7+6GnuNH0wqL3LuZKjv8MvSiLxb2F6zE3+fehc/3cf1++OCpO/eZ6B0qZq/J/F+ULL5bUNZt30ud/ucbtF59dMrxw4hyd396V2+f7+m2e4JDUeA5XLnsH5643kr1QlG4rsJr0KyxYW1wt+Hux7Gf7skaeGUh+V3P2wcnXnsL8pPaHgu6j8YsZrgq437E+ciJh1Z6HTZHl+yJWYDUygVWAOdf+33d/mlxfhtmENf8aO+eJRm//3tsPn2cy9DDxXE5Nc+XmwaC5ct4a4ybciX5ALszv0WuXYXN7G2YcrLlASb1fHz7K9wsV9P5L1GhzrFnDc/e/O3r/1ucKe+bknL/g5m3vSnIfU3EvZ+9g1DkOTjRumr96eHz6Y11kid54wdMbXc9zr4dD8GaWz3Lr3/vyn1vhnGTo5+N0VZhsrfvX/+dSp4lbI0Ovj/bzLuh/4UfAw6bQi1v2YcDhz2eBi7r4DvMTAPM0j7nOs9b9efTh5G8vL0KX3DTc13L979f/3pvrDri0h78xCNXNlbfmyoU+X7Be4HNYQ+cL6cKtQ/p6oKw5a/hiP2tHlLpkeD/+7bUXX7b3vxp7f58tfO4Z8g9xDe87hM2ok72D5jg4w3gCWGskWKI/HoMVs9kKNjLD5/c8X3zr54wlQ4397zX+8g5+5s/XEMB0vcPc65010vrYB6Ktj8uJHVb1sCmyck6tFFgNXXgJrAKEm2eTj2XCz3d781UONZ0NWWCeNFeaK9ckNEYsrSHwOWTBhsy3NT7O2u66B8qbt3ILrOpdppbG3v8qi/fjvrAKtpUY4lLvHl7H7PEo7/OyHpnj4Czj6V/qWpbq60r+98dbA4cTAr/lcOrmGMzZBOx91hPLMVwHJc+fGd5T5s3K18cxuOpznkHcsKqHTZG1xX2bvcBq7IXZywyAGPOs+X7SpjabzVe7a7tbQSwwT5orzZUraA0Boa5364Z5Z33WsI9re5y6VcgKKLF2+pdR/aR3mar3fztFNb/e/+2Uxraxb4O492h5IS57V6xjdfVu9g6a4+BiWyGwZDSYs76Y62Q3J8ZNvP4NIZyrMcye43y1OU1ODTQd8z9MPJfmElgVRo+xPo5r5K3Q6vRihlU9bArdtBUXVN3w0D/2Im2DJUCEedY6f7mUdfDqc31329iMBafd45grUWvAKXU+6xHWixXOVM9Zc4F66ifPSWupg9tiAiLvQ6sQ5z4tOcQ1PFfUc1M2ewfNcTCx8XSo1tzCjJIePGtZh3B2zFm+PMo9BFn3FJkERd3fE9Qvha2PavoJxQuretgUuyAsNai6IbAauvASWAWofp5NPoYLPr/NKQEl1nc2Y8HxPR3R50pr5aWEx4h3zf8xCNZt/V1Wa/qt6x/AGqZnmfnzK+kLqj73/k53wVxbzj0riEa57B2cvxaBoLZOWW3NM8zh4fFpjncerZG9SNefxFZKCOeLOSv5GC++Nz3Pghnm1wwCq+bHy9fH4t4Nf6jpuUCssKqHTZGVH1TdEFgNvXALrAJUOs+a3y97KFDDS8+3Gk+/ArvnSQ/3L++Ja5grfYPdFOsmRJv/+sCqenudsY/eXxJ7LVK/AqXXT2qIEmuPtoovhvDFfkSoh2vZu+I5E2X2avYOzlnHxfmSKthLAIw559opgzsCdpd/HuO9Xvqc5R38FHUQMIfVAquZnOxaqlTJ+mg/74XihFU9bIpdBNbzsH8gsBq68LLBEqDKeda6fn6dV89Lz7eTA/UtYJ7UE5sr56OnJOYa4nnKsvNM9A0uXXXPo6ceH/UrQP5z2HqBVfPnebXHVXW9v41A1Hu/1vROQyiNstg7OG8N51kIfNIHwPoTpRqhVaY15fWkBz+3rh+CqtWsfVshe7WSewmym3NXCo66r88ctxJPU7U+ziNGWNXDptgFYK0PwwRWYze7NlgCzCkF+T3LXgvvr79VXOc5PQB29XaYKz/PldZP9xOcNi86ZZWlrjX2reFRNq9ab4Hy57Glv4DCF16c2/tfVfmT+bIq6pT8THoBVmLv4LzXvKAq7CW0ytTz7oShHXXLGX14H1qpKaj6Yb7Sh5/JScUw79y7wu+pbjv9M2orXx/VTSeqP6zqYVPopqz6h2ECq7EXdZsrAearIZY8OcB8fvoaWOsGLHUefDVPeqhvrvxqrrw1V54lGQJC1/pCq+aZZdYnXCP6faCO+dpclndtG6P3t1GWWnRV7l/R/+yen8mxN7OWzFePCKrCkYRWmbRfv5Bg3Xk1/RhWqX2uEsjRB0B2ntetPwv+Xp6Jn7E+1hpU3Vof7ec9Ud1hVQ+bYhd9UR6GCTKEXtxtEgCYsZZYLhxlHT9l7YuwAUudB+ZJc6W5Elhibemfq/zzpQiwUr2ijgUwZ3+WDPcJa0ykYIjAKnVIfjZYgb2D6hHI0FZotTVHcfYcnMe/I5IQQdWteco7ePcUZHePLfhFC+5n66P1cQL1hlU9bIpd8EV7GGZzbuhFXmAVYDZLnRxgDT92zYsUvlLngXnSXHnqXJl8/CcQzoOPdf+/1+Cq5yzml0uvJ45du9WxAOWs738W+D3UYKfUGxGDIQKrlK2r/L51b5JrDWPv4Hz3vKAqTKDf7L51gmEyIpxigsBOaxSPX/siBXG25yhz0+L3JbBfWujUU2uk9fHQ+ugaOcJ/Vf5UHjZFFvdhWP9z/75rXfsxF/uXz96DYIBZGtznX3M3VBqX4z+LmIY6r3OtEJLNqqfOF1eBf/bbsSc2Vx5ff9waBvii5vx91//frtk8Z+vnGDh2fh2uH9DvA7Wtb79mfg9lzjxOF7o27Z979F8yA6X2mvXem3/1QWTH3sE5a5ErwwDTGje8979ux6BTq0fiyBrzrP5QoO7ke/Qq8M/ez0vmJCC39c9+3nw+i7D1+/P62LlW9qsvrOphU2TCegKrkQmsAsxVX/QnA821AUgIS513fJ13NZ5iocEl3v2PsTJXul5gvfukHev2NP69rnl77tZ5DrNTct2YY/nQ95srgDr0NdA3PcrKn4FwyOZa6QwDRYlRD3bmcjK8JlGLQHH6YFgzhFZ/NU5c5YD+OhnDzszbg0afl66erzXv4I/Tz9m+ABdmnpf7L10Ya6ZZ1lZDfNznEL0GsT4e9r+qfhpB1dgNgQ0fg2EcTHoxdUJPALNIs9YwHB5/dd6mzvMCGHMw5kpz5XT0j3Bu/Z7GX93LqU7Dr5vxl/sK0PcDNfcQf8yXK/f+eBeOezdfnY8aKr/HPXuHRfWb//sQxvOvb43QKtPXmq6n47TCwK6ZUwm6QfFzUmt4D4+/9fG1Ztcn71FPWFVQNXRDYFPuB17SRSawCjBPrTnXRizr9aF1ba5TbUuufQHMleZK48SheYGlpearAGusvunGpQAAlfcQ3kGtN/beh78ZxkLfgx49r/vS80moeR4TVIVVCa6yt1dktvVPEOf9POR6c19CTsYTLd3D66yPngG5Zo5SR1hVUDX2ze3F3G4Cq6ELAZsFAGaoOeaZW63V+yVDsLPG0/sQg8DLsfOCTSLmSnUIu+4B8qhlU+jwKqCvBcxr+v8pdGr8nX2P5yHo0QGWqUOsuZARwVU+enh8upnznw98r1n/dsw/jXfwQD7amU4ybg3tXmpP6+PRyg+rCqqGXmQ82D9AYDUygVUAjVb5463W+6rG81AcsDaZK6fQGgJYfM7ehFf/jOFVz24AgPL6CDWM/javGhtco/nofORQWd2nDoGsCa6COn6FeUdt4PoB91vg8XbquPXxFGWHVQVVIxNUPZbAamQCqwBT1x9TzqtODDhUw9wahP3NvyEgxLzL/nrfXGmuhH1zBLmvcakZnt38qyi4at6F3f2/Z7SAXksNYWzmMDwX0ftAPtyPUA/78qAwXwRXrc36xt1zPHtr2v5eMgyTXnMAs/UtU56u6vTxg/Wm9dH6eJJyw6qCqqEXFg/ETiSwGrp5thkKQENhnKus7zT/xOj9MFeaK+flyzPqfh5AaXN693riKqCuBch9XvPuSV+bVy0N7mGAKWs9+/KgaFvB1asxvNrXzJ2RqdeJQZ3WiOkxL5xj9DmH70nv+sC8bZytj+H9V+SfWlA1Mg/EztWP2++71r0TUvfy2bt3YKr59NtK9c/NznXRQ8Tla5E8/1213Wcat+MfAngQAFFrfPW9uRKotd/owx+pGZ7hpWLme4EVgHh19lrPb3Y/J1Xzr9NrXRmG2ceYQ4Z34F3jeTsATMHeIqjQuHH+pYcfQ42tfqPC+btpzN+X609VNY7HSeYRMlrnVtnP+0UouW08o1p8Dezrm4nmb5/d/noS6+NJygurCqrGbqg8ELuMwGroRlpgFYqfw3cV+7cfaqR2q+Blvnr0ZqLNeJrbrxs2jp0XhiAD1DnXsr++x1w5jfZdTYlrn9zuz27ceN8V8IUu+hvY3+dab2HKOuez2y/6SfXQnGt//0z60vdO+v9Tr3W+Xms7w0CG12W8ecuzCCi7vrOnCKo3Bjn+Nm/h1ZtGsKaOOfyI549Oe1TDTziX3D5fT8aL8PfBjr99uzXn2s+77DoorGp9tD5m5n9F/WkFVWMvIh6ITWMYR4tpTJ1TLqDy+b1/CTz8+jaeAJs0CpqvAq9lm7Bcj4C50ly5HM8HoIz7NDW/7/4JcwDAkf3S7uekncHRT+hjq73v7SMAgEvrOusphNRvqH/+dTWeStfqRfTnwe8Ha+FpzBfGhgNzyrjO9r++jWttcn2450qsF42C6/Ec5YRVBVVjN1IeiE1LYDUygVWINd+/bcryUHnq2vTmwv+9uVijNt19DpgrMVeC+SLOZyq0CgDn9QT311eCq+rNgrhGXY+4jwGWmauGL3ixLw/YDtVsB2rUNOgp0fPAdGvta3i1sZ93Uk4Ptz7mdJ8bhUEZYVVB1cgEVecisBq7SRSSgpjz/ltwVQMxRY2y7v++3jUK4wYDa9XXa7qHWubKaekPocx18vfdn8zuXz0OWG+hnJ6qD64Oa5c+4fL57dJNQPr/Xf2r9+Pn3duQ1zXpPgZKqDmuDAPwlQ+nrib9W96ODOn4DPdc70bh5DH723i2BhfdQ1vBVfPz5doF1tGYfSPG7Uz5h1UFVWMvGh7gz0tgNfYiaIMURJ7/hVZXbm7ZW5uguQXc78ZOXcNUdT+137vdS2jVXALWW+CcWumv0Kr5Tf9q7AAg7JopqAqcwElw6CUxdqcRfOOMddZ+3su0hmCWa9N+Xuvj2fIOqwqqxl4whBWWIbAaeyEUWIXoa8AmtKreOq9W9VBpWskQXHAvA3FqeMyVYN7gvfa5N/nnGQ8AnN0rbIdWOacWQf+q/wGAstZLQVXgAh9OgmvV4fpzvWTo+cAzDJj4nhrXV/PSGYTEJ5cMgfXxEvmGVQVVYzdNgqrLEliN3WjbzAjYjHV+zbLO/7beNQnjB7jXjR9MLRmCQHNcPqesAkB5htCqjUDn8KV+5HMf2wREPv0ZQK7zk6AqMKExuHq1dRqcOmg9rSE4+zrWSwK5zUv281oL8+gfMX4XyDOsKqgae5EQVF2HwGrsxVBgFbAOLN3cGuvd1yCaW7DJ1VxprgTzBpf0GU5ZBYBL66d+I1AyEIv0/2qWz1x7UIfOPAZkOTcJqgIzGk+D24RrOiOSF6fNoQeA4tZV+3lPd8l4mct2X4Nc0oMHl19YVVA19gJhA926BJViL4g2BQBv64Ba7Pja1cNcjZkxBJaSDIG50rWFz5ij57slexV9EZiLoTbD6YytgZh9jjPGWHMBYBmtoCqwlB2nrYIekpj1F0yzpvbraWc0juPLGSbjmjOGF8srrCqoGrsoE1TNg8Bq7EVRYBUY1oFkINCYFXnvAmCuhF3X/q1BCCk1v+/+GAYAuKh/aA3EkbxfUrsDALmyJw9YzXjaqtDqQh4en/TmrHKfG4UvajCY7j7zxTMsrTMEF9+34fvwfMKqgqqxCzIPxfLiBXzs4sKGAsA6cIpkCABYrFYHULdymlZgFQAuMDwn1YsdW3dAHtyzALBdo9mTB2RgK7SqXteb6yEBzPFzSoYA8pBHWFVQNfbC6aFYngSVYjfgAquAE1ZZ9nrzLXvTcM9C/Wsz5kpQb3EqgVUAuKyO6r+1vjMQR9QcXMp1Ns096/kJAGzqM+sikJnxZLhW/0NG16S1chruaVhmvmqNBAtdb/aXTCNF/uHXD6sKqkbmoVjuBFZjN48Cq8CwoV2ddrievTEIAAAUIBmCsARWAUAdNX+9waU6QwAAqGGB2vVhmzG0ap6CenSGAJZZQ91vhz08PtnPCxlYN6wqqBqZoGopBFZjN5ACq4CHw3PUwJphAACW58toohNYBYDz66j+XVkyEAd4p0Q+9D0A4FkQkLnxxK5W/b6YZAgAzOcAS1kvrCqoGpmgamkEViMTWAVrgG9j8gBg/rUGYwnmVWMCmE9Ygk2KAHCu4Ys/OFRrQB46QwAAY33mWRCQsa1TVtXwrCEZAqDEtdP8Ne387iRWZhS6xl0nrCqoGpmgaqkEVmMvlAKroHkDDVkp9RoA++dKG8xRL6jvo+s3KXrhBmtw70EN1FFT1yVs6wwBADBLzSWwCmROYBWK5/4F9xz1SIZgsho39H7e5cOqgqqRCaqWTmA1dmErsArR53/1GwAA1FHf36rvw0ue8wDAWdRQh2qM07SG7F2d7j06ADAXgVUge2NgVZ946XwP69y/nmnA8vdcZyS+9vD45F04rGzZsKqgauwmyAu2OgisRiawCtHnAPbVuU5HAQDUMpTj/tq3lOPzB4DTayibgAAAKJXAKpC9MXyTjMQFcz0AUXSGwJoIOVsurCqoGnuyF1Sti8Bq7OJWYBWizv23BgEAAKqSDEFwNigCwDk6QwAAQKEEVoHs/fzx/VbvDQBHrZcA2VomrCqoGpmgaq0EViMTWIXI9z8AAFAHz3YYNih6xgMAp+kMwR5qCwCA3AmsAtn7+eP7lf4bAA6yVgLZmj+sKqgamaBq7WxqjF3g2nAAmlu2JUMAAKjzKI5nO7j/AeCc+omvqS0BAEqo2QRWgfwlQwAAe3WGQB0BuZo3rCqoGpmgahQ2NcYucgVWAQAAauntif35t43nuHH9vrsxCABwEnWTcQQAKJ3AKpC1nz++9+8ukpEAAIDyzBdWFVSNTFA1GoHVyARWIdZ8f2sQAICi6V/gq1r/7/Ovq8bz3KiSIQCAk6iZjOMc/aovEAEAliawCmTt54/v9ilBAR4enzzTAOskwDvzhFUFVSMTVI1KYDUygVUALqsfmaoP8/CXeupLzJXGEtYhsKqWBADQcwEAxKrfBFaBvCVDcLTOEADAaYR+1V5zif5lDv9N/m8UVI1MUDW6/vP/fdeaA0LqA6tGYYkC0MmWkK++Dj6mFurv4993GrrtGhLgY21pbjBXAuvpA6ue8UbU9yieOQAA+ldqqW0BgFNquD6wOnyRHUBW+gDJw+OTGv843YH/n579c+/ovQhApfqgoCAqrGfak1VtYopMUJWBE1YBiFwPAQBADfrnO/fX3xrPemNxuioAHEuNBABAbZywCujDjSEAAExiurCqoGpkgqq8J7AKAABAnvSqcIrhNAX3TRzJEADwf/buMMltG9sfNqfL60kqK4j83Vu5awi9Bm9lvodZQSrZ0FzTktzqbrWaEkHwAOd5qvK+85+bsbsp4OAA5E9kUY/kvij2qwBAn/2IwCoQ0+QSQPAeAgDgQpmwqqBq7gbTDVmuEVgFAJbvJ7zBqYzRJYCua+XvLkIR9qlwr+e3rOo19OYAANivRu9nnZ8AwNqeRGAViGdyCdjC3//8aw9Zqn8AoKf10TMDZYyZf/n1YVVB1dzNpaAqtwisAgAAlNuDA+zpv//3VWjVegMAAPpZAEiwngqsAoH89usvnlPGHhLgusklACJaF1YVVM3doAuqsoTAKgCwpLdkHW8MALUStfJxk0vAXYRWrTfqCABgL7LVvtU31gMAUQisAgAf8va9d40uAdX6djCuIq6P6Z9R+/Tw/1JQNXfxEVTlHvN4+fLtoGYAwE+TDZ3NrWsIN2sk5rlraM4R3RxaHYavp3Pi0RzryBySOH6+S8fCfPbnuh1D3ADkWCt9Ec5H12fJvWQ9BNsYXQIAKOYYWP3v/312KcjuFMY6/PbrL+YD9LeH/OoyAFgPBueKL/eCuIYrPfZmVUHV3JNGUJVHeMMqAFzSS1/fY2BzC4M9p1qpVkKDdXt+YM3bVgEAewtcn7X002s4NwGAbXo7b1iFc69++Puff80HmvTbr78IZL7Dm8+K1EcArI+83ksnd39YVVA194Tx0DBrCKwCADZnrh9grrt+0K/5bZzH0Oo830YXpFk+OwAA7PsBgOc1VmCVxF4FVH8EVj28D/aSAGB9xPV7331hVUHV3JNFUJUSBFYB2uVbydnW6BI8PDf/cBFArUSthFCOb1t9HVydXBj7PwCAV/SI9q8lHVwCANhwnRVYJaFTKPVwpe+cBFaJxttT7SV3qJHOMN43uQRU6lNgK6NLYH1cY3lYVVA1dyMuqEpJAqsA7fYElFoLHRC/v+fA3ITZ5BKolWqlvoRuxtg5uPr5FF4dBzc2eqybPlPBEoBMrHv2//avrh0A5FxrBVax/3uxn/EgOvbg9pKuHdf89usvcheYgw1dH1/4cJ1AtLm5xrKwqqBq7okiqMoWBFYBAJs01w3eN7kE5nwxx3Mt1w2iOAZXj29dFV4FAIC3+35fVPXI3l9IAADq9SoCq6TwzltVXxu//3vmRJ3PgvUml+DdMWZPuU2NBNh374Jr6Lrt5uOwqqBq7kkiqMqWBFYBWjO6BBhjwXgIC9RKlrDvhMjehlcPp1o3uTjWGwAIx1kM9rH6VwBAYBU95qs5MQdWBSrtkbCnNC85mVwC1C7XxzXMyRdgPLsdVhVUzd1ECqpSg8AqQBt8k/sW9NnXx5rNmgMBUCPVSrXStSGz+azoGF79fOXtq9YHazcA0Ffv99VFsFdbzTkJAG8dXIIK11hglY498MbA+d+dBFbZ0eQSrJ739pb3GV0C85HdexXUNeujcRTW+2FVQdXMBFWpS2AVoI3+gNL02jZr63gIi/73CKiVaiVwXhe+vgiwPr99VT20dgOA/Rj2sxxcAgBe8BxSvTVYYBV7v9fmwKp5YS++h+mjf+G3X3/xhVH2lkUILoGahT4M6+NHrodVBVVzL1weLGIPDooBbDjgeT9i02ZeAmqlWlnH5BLQpOe3r3698vZVyq01vpHXmgOAfViNfYZ9id5ibc96cCEAeMNzSLUIrNKdB96q+mZezIFVbzwr+nlAlTXNeFtsdAlumlwCzEM668fcGzEv7/Y2rCqomrrRFlRlVw6KAWLyENZW655vLLRpMy9BLXB91MoI+3Dop78+h1ef37w6uTCrHO78911vAOzDeGSfoYewr13D+AHgo77k4EJsTmAVe79r8+L4llXBtzLXEnso1ycIgaWP/fbrL+7BYx62OXc9z7ttf2xeJvMyrCqomntD5wFFInBQDGCjAce9ic3b+9fmd/MSUCvVSuCG5zevfr546+rkwmzONfY2WgD7Lyhr1F+YlwCs5DmkWgRW6cLpIfOSNWMOrJoba/dFLBprhf+97HWA69fGPXhzDGsjedcAPa318S7PYVVB1cwEVYnFQTFAHG4obU3//T4PYt26NqBGolaqla4RLHcOrj6/cRW2cnAJADrky3C279WwdzMvAdi23/AcUh0Cq+i/35kbf//z7/+8ZfV+QoPL3fEmx8nV+rgOmK9Va2RvzDG2Xhv12+rcbvs966Nxc49jWFVQNXXREFQlJAfFAPs79ohq8bb04DZx5iXc3hOgVj5SK0t/6zXQ09pyDK7+R/3c5PoKmgBg3wXlHbxB1LwEoADPIdXsXTxAT5MqBCO9ZVXfv7s7Qq3GHtdqpF4K9p2Hnhtkb5NLYF4u9SSompqgKrE5KAbYjx7R5i1Kv+pmpnmJOolaeX+tHF2IRXtuoTLMgeO5k7WGkqxBAP3tMf4c3Kuyhka4Psf9Lsd56QFZAB7jOaRaDnoX7Evenx+nt6z6QpoPCPbeZdr430+5lpmnL+aje/AL/fbrL+7Bs+U8VL/jral6NPPSmHnHk4uTt5EWVKUJDooB6hOIe3TN+vrA/0Y/tqRvdTPzbHQJSMh6pFYaM8CWPfz8ptXPaseN9UUdfnRPDUAfNV0gDvvdmL3W6EIA8LDj/VlrSY3exRkJDdkhlDbOD/qfHnDn7efhDVXb7hftL5fPU3PUmHGdiLIuGl8V5qQ3kC9ysD4+9wouwfuEVZMWCMEImiKwClCPoGoTm+KU1yj7zUxv8UCNRK1cWitZZnQJ4MIxsKrXeuuRa2LtNpYAetlf/KFvrrjXeOSLAO17M/7+7l8AUMax97CmbM99C/rfy6xzmOeJt1O9JJBTqT6z+FplD+SoUeYW1sVWrQiejq6e9XHh+ngwFN735JvjEzZCgqq0SGAVYHse9NivP2PZdcp6M1NQFfsA1Eq1Uv8Btdac0YVQXwowjgD62F+o50R0SBtYdf8CgNI8M1mLwCrh7fBW1Td9/vef4X8Bfo4In4W+/wG//frL1zv/fffg71zLsgZyBHEe6HvAuoj10frID08//r8OXzI5eNMIzRJYBdjO8U0B+sF91jdvDbhjg5vuZqbwFcxGl0CtVCs32V8D13tz+yL1pcTa5CFMgFbrt/2F/X98+e73C6oCsBXPTNYisEpYpwfso+xFxsyhVYEce/Doa1m2QI4gzv0EwSk8Bz3Pu99c9jyv9dH6WMDTz//k8CUTgVXaJbAKUNbzA1iji7GK61dxg5vmZqaHI+F53qNWqpXmFOjt1RnjCIBt9xbnh3/sL/brA/QQy+W53y+oCsDWPDNZr08UWCWmMeLPlC20Kqja3Rjudi3LEsgRxDEX2XdNPM1BY2rfOakvsT5aH1d6evH/cviSicAq7RJYBSjj2AtMamoXm+N0G9zub2YKX8Hr/h+1Uq0sOTZgDmN8+fa/UyiDt+uOeaLOrGV9AminL/JlflH28Pb/9/cbvd/vF1QFoF4P45nJOgRWCeX0UP0h8I+YIrQqqLoPb417fC3rPZAjiLOiz4Ey828yB81p66P1sQdPb/4bhy+ZCKzSLoFVgMecH76aH0xXR21uW79mPfayxzlqfsJbo0vwcK3s7wa2Wrl2P+3mM5d1dTztDzwkpj8vt/6qM+f1ShgcIHqd9mV+9v/tO5y+hOb3LueovhyAmjwzWYvAKvYfD/ycvYZWL0I5rKmr+/xvU1/zTufj/DZH9+Af9Nuvv/gSNtbMvT/Mv67W18zr45+dzlHz8wFPV/9bhy+ZCKzSLoFVgOU8fLX1mvR15f/egdWaXraXG5oewIJbzI3HjWol5hJX5tHLnqrXcPte/T3qzXkNBiBaH/T7zzfMH+v0wUUJt/7rIR69bj318952DMBePDNZs3cRWGVXDbxV9ZpzaPXP1t9c5aH/clYG5Oy71s3Hbp69P4Vv9UDmEpXn3cWXNhhD5dfHryv/957nfcyhh17V+ljGp3f/L/Phy/EmgM1AgqLw47M+HrhBW+Zwz5dvBwsBwBXHh1MO+rlmjIODh8d62eMNzbHZUMHxZuxorsKHfb/roFaqlWX6DRjf/e/nOjHPM1+mwnqTmj0Mzt1frON5x4MAPESpQXrhOuu//f+eff7xnunYbD9/vKdhrgKw9x7OM5O1ese5d3EOyZ79c7vm+jS/uer8e0ytBCpOwYVRjY2xD5/HzWkc8eBcPIWux7WhKHMy91wkj1Pw7WDONdUvji7Dw72q9TG5Tzf/rw5fchUFD87QKoFVgNcPftog1d+UlmAdW/s5tPgwlgew4N56a77krJXOpkrun8m+b1jytqX5QbFpaPkhdyLUm6+n8HN2hx/7dXNpSv67C6tC3X7nfE56sI9ott7b/6/pPc79fEv3/X1BFQDReGayXv8osMoOGn2r6q390xA9uOqB/9D7cHvwAtfw+xifx/bY0pv4Tm90NCcL8AZGFvQb6mx76+OPt7POgUuXM9366HneQj59+G84fMlEYJV2CawCWbx9uFxT3NdaNum7V/azrYQrhFThkTop9KJWso5ryT3j4LlWOCvkcfY3z9fhP2l/++P9peyfP7DdfuGyd7Hm7L9vL7W/VDtL7P2/fPvfad//NfA89sA6AJF7m8+n9ZSt980Cq9Q39vx7XQRXhz3fZnUR0hkNuW0U+nztwUvtw49vkZuvZ+hQjhCONYVN5pQxEW2PUfbPOrik1kfu92nRvyWwmqsgCKzSKoFVoIZlbyIq1aTrvWxuWbHJ/T5fhyHSA1kevgJ1MmatnH78/9XKDHtmb3Wzl3lkL9PGQ+5Yt+PPv5xn7s9vN3RmAD3uJ47nLjWMLneyene83+eKlpo/xy/+moZIX1h13Jsc9AkANNH32tfV6SUFVqmks7eqfriXvngb2Pn/v+mbVy8CO/byjezD5/FwCpDYnxXsHU7XdNozMH6l9o0+5/KifMbJ13bP87LJGnnxZ/ncy62PP/pE62MOnxb/mwKruYqBwCqtElgFtje6BLxZe8r9Wd4auMWcfX4gq34Y6/nhbJ8rlFuH9fqlzwCO5wBqZd/MG9buZc49VY7Qar0vKeq7dtjfvFxv5/Uu00OXx/Xd+uNBW3rfR8B2e47RHrH4nH3+cr/j3r/uGiWgCkCrezrPINXrJwVWaXPv0oqf+6tTSOB8LS6vx+Ig66tgkD6//bE8Wus22YcfToHxadghuOrtxtaUjGsczEp+Mcdcuy++/INCc9b6mMOnu/5tgdVcjbLAKq1yWAxAxY3TBn/mpN/eqL99HcY69g1lN7sv3xxkQwvb9PquQ91aWf4BVrWyl56FlpQLX2YJrerHz+uu/U3ZvV6uhy6tPc6nATVvTR/iSy+2XqOP5ys19v4H/SAATfMMUt2eUmCVDVV881or3vTqF0FWEu3DT29XdUU3nmuXwZxhg7ccv3pz9OiyV+E6Q455OZrv1dbH4m+stj7u59Pd/wuB1VwFQGCVVjksBqDtDbP1q8JG98d/en7obbpy3a8/pHU97GEjC3XrpDlXt1YOamXTJg/3sMH8ew6t9jbGXgbqsb8pX5MzPHTpHtJl7wSQwzZr22Q92WXvPy7aV17vmw8+MwC67XU8g1RvLy2wynZGl4BelA46Du7BV9+H33jL8Y//7vVn/Cpso7YF6Fk2mIdA1D0KNdfH8Z718fS/8YxaQJ8e+l8JrOaa+AKrtMphMQDbrzVfN/gz5/Vr0mvvt+F9wRscIWbt9XYVtZJ7mC/ZlXur6vvj69i/jp08RGbOlN/fuA4v9f3QpXtH254ZAOTqn8bBPb44n6eeDgB7PM8g1SOwSnHeqop9+G3zW8wuwiHUdRiunKl7222+eQiUWc82+DPnN5BPg/uf1kfu8vTw//IYXpxcwiQT/fiACbTneHCpOQBgC1OjfzZAD0aXAO7aF6Nmbu0wHB8i+9/G4dhtHX/2gyFTfNxYt6/t+Y5vI+uLoKp9PaDmld/LqKcAQByeQarbY/Z4dsKeRpeAXmwRxDFP4L4+xVtVIegeQi8JYTyt+l8LrGYisEq7HBYD0NoG1NtXANRJiN6v0IZ9zvPGU2j1z6YeKDv+rOaMdbumqaszd0HVt58vQJ61fsuH8/RnAEDE3sf+t9beWmCVArxVle5q40Y2DMFCb0aXANKtkQLqcKen1X+CwGomAqu0y2ExANusLVsaXWQAdRJWmATEkjs+yHXY8Sc4DJdvW438YNnxjaqTQfOqhli368yT1oLd12qNoOq1MwNrMGBvXqaeeggIAIi45/MMUj0Cq8Tft0Dtumi+wK5zUGgNYqrwpQvWSLjDU5E/RWA1E4FV2uWwGICWNp4ebAVQJyF6v4IxcN/PEi+4+hyyM1/errN/Ff7zrNvvO5zmR3tveDjO5Wlw5moNBjKb1FUAICXPINXtOQVWedDf//zrWVe6snUQx9tV4UOjSwA556Y1Eu7zVOxPEljNRGCVdjksBqCMWn3v6FIDqJPwUK/iDUS57f9W1Y9q92Vw9Y+drtH5baoHA6bafse6/dH1Oc+LFmrM8R7B5GPb9cwAIMe+w5deAABReQapbu8psMqd/v7n39/NUTozdvb3QHP9iLeqQuD9gjUSQnkq+qcJrGYisEq7HBYDsHZjWyv84UEsgCV1cnIh4I3RJTAGGvo5zwG9PzcPr54DdvPfZ57c3vPY3+w7LyKHVgW945wZAOTqOfVuAEBMxz3g5EJU2nMLrGIfQWK13uh2+nusbWBdgWb2CbWC5N6uCss9Ff8TBVYzEVjltshvARBYBeBxY+d/H4C6DG0Tksku9ltVbzkML8Orz29eXXPG9Pxn/G8QsFteR6zbMXqcyyD33nXleR75DI1xgKOa+w5fVgUAxO6LPC9Zj8Aqi3irKl3Wv7pGlxxezglvVYW489MaCfF82uRPnQ9gjiFGm73+HQOrx0M3eHauAV++HcKOj/km+vzzOTAGYLn64Y/5Qawv32xwAW739dPgDALOc8IZDWOXv8vbnngarp/pHKwJBdZW+5tIjmP6eN2mn/9svTd9Dr77vKLMHwA95zi4pwcAxN0Pel6ynun0PJo9ONH2LNDNmJ5DeX//8+9kXYOfc8LbFCHo3qB2kHyuB9/XSL0mfODTZn+yA5hMBFZ56eXcjz0+BFYBuM9em0xrFcDtvv7z6U1foFcht3bfqvpoj3zwoTdZR0b1qsC4//JtGF6Hto9vnVtbO8wt6zDAkn341x3+Tl9WBQBE75E8L1mPwCrv8lZVeqx5e7zR8fvf+fn7fHIPHqwpENm4Y12YXH5436dN/3QHMLkaMYFVZtfnvMAqAD2YdrvZ5UEsgCXGQUAAvYpvdEUdZH0t2X5/4+2q5Rxe7BNd131ZhwE9Z62/e/IRAACB94ael6xHYJWIexbocR9uTpG639gjLA7Enp/eQA4fe9r8bziG0yaXOoXDjzfZHL+FnYxuH7YeTv/3mI4HlxoGAG4Zk//9ALEdwwGTC4FehbRyvVWV7dbTWjf0jFWswwBt2vdLco69ir0/ABCb5yXr9qeeVeSCt6rSY53bMyj3/e92D57U5jcMuwoQ1pj874fQnqr8LQ5g0m2OHAIltOxbAQVWAWi3v9n7G1k9iAWwxOgSkHbs+/Z41EBaGkP2N/TGW1UB/ULNmushQQCghX2i5yXr8awisfYs0N+YNq/I6uASQNw9wN5vPT79/fZ88I6nan+TA5h0C4BDoESWBVWfm3eBVQBaE+UBKA9iAejn4a1JQAZvVaVYPbG/gUeov0CmvUeUL8kZfRwAQHiel6zbq3pWMb2///n3j8E5DX0Z9w7izE4/g3046XqLCPMPeH+NjPBDePsyvO+p6t/mACZdo+YQKIH7gqpnAqsA2Ng+zhoF8HE/P7kQJBrzDr+J2LPSnr3CJ8Yu5g6AvccjP8tXe38AoKEeSt9Sa4/uWcXsRpeAnvz26y9fg/0s1jMyzT/34CFwzxcsTH7wkcBbT9X/Rgcw2TgE6tljQdXnhVlgFYAWeplobyoTwgJYUiudPZCFfSvz+Yxvi6eEcac12wMumDsA6p0aDAD0zT2LmjyrmNTprarQk0O0H0h4D/MPiNDvR/oyh9P66HleuOJpl7/VAUy6RcEhUIfWBVWfG3qBVQBiG/1cAGo4BOVNbqh39FFPvCGaluuvtRjI0yt8DfdTHWuwXhgAaIPzj7r9q2cVM7I3oKs6FuyNcZcOPh56X08Czz8gaM/nCx3grafd/maB1XSbp+4Pgb58e/6nd2WCqs+bV4FVAKJubKM+dGp9AlAryW7ycBM/HN+qCuv3PvuzZtNiv/nVRQCS1LvPgX82b2kHAFpycAmqEVhNxFtV6dAY9Qc7hfisZ3TbP0R7YyPwcn0MHia3PsKFp13/doHVdE1ct4dArwOqPQdWywZVnxdngVUAovUt0R86Pa5PemkAtZKcY1tQlbPRJaDA3mf/m3rWbNpzcAkA9U5PDABwF88f1Sawmoc9AV2N5+hvdTz9fJOPit76Bm9GhPBzNPTzvNZHeOlp959AYDXdQtHdIdB7wdQeA6vbBFXPBFYBiFT3P/s5Abqq6ZMLQUfsTTnyVlXKGK3ZcLcYIW8A9e7cQ7iHBwC0Q+9Sv6cVWO2at6rSW81q5a2Op1Df5COjI6NLAOHXHT8nNOQpxE/hIZR0G6puDoE+CqT2FFjdNqh6JrAKQAQHPy9AZ5w70FOfIhzDs9ElYKWIARTjmlZ6S4AMfUI79c5b2gGAtvaVnj+q3dsKrHbp73/+nT/X0ZWgF60FXARW6cgh+huNIfsc9fNCe57C/CQeHM2m/UOgpUHUHgKrdYKqzwu0wCoAe24UWwuAHH/e0UcH8GG9FCpAn0I/vFWVMuLtI5y90cJ6DNC/qck9tOcNAIC2ehdnILV7XIHVHo0uAR05mIewz9wTVAVztKTTz2t9JL2nUD+NG0jZtHsIdG8AteXAat2g6vPGW2AVgB02ts0GQP77f1/10QALaz20aRRU5c2YgF7rii/kwbwB0GvqkwGADDx/VJvAakdOb1U1f+hmH95qWO70c5uLtEpQFayPW62PnuclvadwP5HAajbtHQI9GjxtMbC6T1D15yZAYBWAqj1J6w+c6qMB9PH03Kd8dRn4yVtVyVBXfCEP5g3AXg5Nn5Pa9wMA+hc+2t8LrPZidAnopS6dAi3NElil1XVEUBWsjxuvj57nJbWnkD+VB+3TLSbNHAKtDZy2FFjdN6h6JrAKQJ1e5Nh/9mD0cQLo49Gn0D09HznGkPsEWI8Bajt08QZpb2kHANrsXw4uRMV9vsBq07xVlZ7q0SnI0jyBVRqce76cEqyPNYw+TrJ6CvuTeRAl3aIS/hCoVNC0hcBqjKDqmcAqANv2ID09cGpdAlAv0afsoaUv52r9enirKuuNTYVQ3CcgzjgE6F0fQdXn2u0t7QBAa/2L+xZ1Cay2bXQJ6EFHQZzz72Mto4keoLe5B+aotREiegr903kQJd3iEvYQqPRDhpEf4owVVD0TWAVgm96jxwdOrUsA6iX6FHo2ugSsrC3tfVO0+wTsS78I5Kh1PQVV9RAAQLv9i/sWdQmsNshbVelqL94hoRyir/2CqmCOWhuhjqfwP6GbSOkWmXCHQFsFSyMGVmMGVZ835wKrAJQzdh0AsS4BqJe0TFC1B1uc+0Q+F6GVde9z4z/75EOksj7DWwCZap0eAgBor3/5S/9SlcBqq58bNL4XPwVXuiSUQ+B55x48xDX2PEetjWT01MRP6SZSNnEOgbYOlEYKrMYOqv7cLAisAlBkPWnxbUKPrUt6aAB9PO31KW0dwEf8Mq4eHc/K1CrW1Zf212z3Cai9JguqAj2bvyTnPylqnR4CANC/8FFvLLDajPlB/1OQYXQ1aFTXQdXLuTq4r4V5Byyfo90/z3uqQ/Z5pPHUzE/qECab/Q+Baj1sGeGhzjaCqj8bEoFVAFatI5keNtVDAyzv4+eHdNVM9CnENboEqC/2OJgzAIVMTb9x/fEeAgCgtf5lciEq9sgCq005BRoO5gmNSRWYuwismqeYd4A5elwb7fNI46mpn9YhTDb7HQLVDpDuGVhtK6j6szERWAXg7r4iy5sC9NA5xzegZtI6oRje562qqC/Wa8wZgHLGxMFNPXX/9IgA9MUZSP1eQmC1Kd6ySmt70oyBuYt5aj3DvANe9t5510brYo7xnd5Tcz+xQ5h8E7X2IdBewdE9/t42g6o/NxECqwAs7ieyf3O+Htr4BtRM4tbxlkMxe375Vq7rM7qYrOgV+7zBZ71mG4KqQIY69zXxft+9u76N+kMAOu1hnIHU7ylojLes0sJ+PHtgTjCHyqbvY+4/gqoQeo5+zjxHrYv9j2+XocWw6swhTLoJWy2wuvdDljX//raDqj838QKrAHy4Vgjy6aH7NroEsFnN1MuzteMXDgjFcIu3qrK2xvS/XuuHKUVQFei9L/iPOjcc793N18I5aY9j/KvLAEDHPYz7vDXPByI/i8a7vGWVsHuVYZj3oH/9/c+/w/xP8nnqHjxV5p2QEMTut83RF+uifV5/7EdOnpr9yR3C5Nu0bR1YjfI2kBo/Rx9B1Z9Ni8AqAFd7Bw9gvddD2wz1tLE1xqFGLz+5GGxUwx3As2yswGP7oRw15hhKOPjIWUlQFbD3yLfn96yBfRMA6F94j8Bqw+a3rM5v0zNfCGAeg2/24+fQatbg6uktegfDg63WcCE4iLsueuPx1XXRFzn0ZTTGnz01/dM7hMm3edsqsBolqFrj5+krqPpzgyGwCsCLdcEDWLfWJQ9z99Ibe1sA1OnlnT2wTa+ihvMxb1XlMfkCKb5ggnX7Kl90BfRb4+w9Puoh7Pf72WNbywHQv1C+xxBYbdrFg//mDHsYhytB1deyhlZPb0IWKqekeSwdBIQgbm8tSH57XRw8F9LFWjR/cY7L8Oyp+d/AIUy+hrJ0YDVaUHXLn6vPoOrPRkZgFUCf4CFT61Kise4AB+rWTd9kh16FPag73D9msgZSfMEE9lUAr3uCz/Yei/f7+od2jcY5APoXNu2rBVabdgrEfR6OwUGoVzuG4a5z+sShVffgKWEOB30WVIWw89PbVBf2rdbE9tcil+Glpy5+C4cw6SZzscBq1KDqFj9f30HV542+wCpAzt7A21TXrEv66PaMLgGomzS4X9Wr5LTmbOcYOrTuc0+dcaPvWGvNGz7eU1mXgX7rmy/I0T9kMXlzMADJ+5fJhahCYLUD8xuOTm9x1Pez7R5lGOZx9vCePGNo9SKcY13joXVaOAjCronmpzUxE/uMK566+U0cwuRbxNYGVqMHVUv+nDmCqj83HwKrALk2td4SsHJd0ke31+sY7xChbo4uBov7FQ+Ls67ufB3ckGDZvkidMW9YvqcSbAF67QfUt/X9A+3stT3sBkD2/sVaWI/Aaifm0Org3JBtjN//KVaXs4VWvQWZR84FvK0RYs7N4RRSNT9Xr4n61Yb2i8b7dU9d/TYetM+3oD0aWG0lqFri580VVP1Z9AVWAbo3CqkW76NHF6KBHseYhyh1081sltZtDwxRouacg/LqDq9N9kUfzhv7HC7niy+QAPqrbb7Mr2z/oOdupwcGAIbBs0d1r7XAahcuAgB6f8rty4dhky+PSviWVffgWbQme1sjhDQKqRZdE93nbmdNMubf8dTdbySwmm+zd29gtbWg6pqfO2dQ9WfxF1gF6HDdP4ZU/+MtAZusTd4eEL238dAhxOvpn8Nj8LJnyRCGafV8pY+6M7oYDALx9+5zJhfDfHEZgK72HEKqW/fceoe4+21rOgBc9i7uUdQksNoRoVUKGIfj21Q33ZcnDKxezk14Mee8TRXCmS7mpud5y6+JnucNvj+0Jt321OVv5QZSvoVuaWC19Qcp7/n5cwdVfy4CAqsA3Wxqzw9f2dRuvTbN4Rq9dLyexoOH0ELtHF0MPcsgDEOduvNV3VFr9Id3r9WC3lnni7epAn05f5GfkOr2/YMHY2Ou6/bbAPC2b/HsUV0Cq50RWuWhvcmGb1Plxdx0L4yfc04QDkLOy8/mZrX1UJ8abF8oqPqxp25/M4HVfIveR4HVXt74seT3EFR9sRgIrAI0axy8IWDPXnp0IQL0uIII0FLt9Oa27HtPPQt71B2h1Xx7JLWmxJyxVmdamwHaNw3PIVUP/tTtHXyxX6R5YF0HgNt9i2ePahJY7ZDQKguNQ4W3qb4am9nnpnvwydfcUxjOfTGIsw6al/ush75cMdbaZPwv8NT1byewms37gdVegqpLfh9B1auLgsAqQEPr+XFTOz8E9NVD2LuuTw58954LggjQYu386+LtK+pnDmPaN7b99/98+pH6NqHVDPukg4BKsTljrbY2A7RRz47r1Wc9QJjegX34AgoAWNazePaodo8isNoloVVu7NGPzzFhXlJlzs1vEhQGghCmy3XQvNx3PbQW7jsXrE33eer+NxRYzbcgvg6s9hZUvfV7CareIrAKENt5Qzv3bl+7X8fb6aX/8jDWTvPBA1jQU/2cXJBua7U3GxGt9git9smbm+11WGYahLqBPmrZ3MudH4A9rv/OSKP0Dt6yuk8vrA8GgHt6FmcddXsVgdVuvQrHja5I6n36YdgppJr9raofzEv78z6dQ6rO+SHAfByuPM/79z//ujJx1kLqrk+e573TU4rfUmA13wbxHFjt/ebt5e8nqLqEwCpApPX6+e0At7990MNYMdYoD2PV61c8XA291U83zPoipMq9dWCPv/MytKr2tF9vPJxfZ68zuhhNny8IdQOt17F5HXr7RX6XnJFG6R3s8WvNC70wADzar3j2qC6B1c6dAgHzW8ScIebbqx9O+3T7kpjz0v68L0KqEGPtG4cFz/MKrIZZCz3PW2nPZ316zFOa31RgNd+C+foNq72ab04Lqt61YAisAuy+ob188GrZoa6HsSL11Ad99UbzwwNY0HP9FFptn5AqLdaer2qPesNd88UDZ63toYRUgZbX++eHft4PqL7mjDTaHl/fsI3D6foCAGv6Fc8e1e1fBFZTuAitzvNrckW6NA1BQqreqrroGgmttk9IFfZf98bhged5BVbDrIXWwQ3nx2mNch/6QU+pfluB1YwLaIbAqqDq/QRWAepuZg/DvQ9eXeNhrDjrlNBD+d7EA1iQsYaOLkgTvcxBaIxuao8gXnRCqjHmyzm0ar8Tf30WUgXaWuefH/o5fyv9YzXMGWnEvkGPXWqN92V+AFCyV/HsUV0Cq0mcghnz/HK/r7f9iDepNutVaNWcbGS+CanCbvNvHAo9zyuwGnIdnFyRMvu70zVlhad0v7HAasZFtefAqqDqikVEYBWguHF4+dDVfW9PXcLDWLHWKqHV9XPGA1iQuYZ6qDV2TyMEQ6/1RxAvbk/ohnzc/Y61OobJ+gw0VK/G4W04tdxa74w0ao+tZ1i7xgMApfsUzx7VJbCaz1+nvZ4z93aNQ8CQqreqPnzd/rp4A7I9etD5Nod/vKUOqs67cdjweV6B1XDroOd5V84Zb1Mt51PK33q+0XE8GDgYAilMp8+6t6JhDK93PCSMevNzPjT+8k3DAERdW6eL/6wxz+x4k3Pur+cvCBn1JwvnkIevgOc6enxo+VhHD4MbZ/v2N8JiZOvhZl++/XGqP/o4NYfrc+Wv01ptruxjNFeA0DXqWd1aNQdW//t/PoGY+/s/7O2t8wAQqEeZnz2aBucZtcR+Fo1VPghjPJ+5D4NzxDb28yH3IoKqxa7jjz3693nrHvy+5h5k8gZVqDPXLv6z53lzr4E/+tLTGjjqSZfNIW9SLe9T2t9cYDXjInzoaPE1dsuJH1g9fpsJQG3jq/93nEMjD2JF7a+FVpf1pKO3AAE36qgwzB49jwdj14xbb3Xq43N8ftOX+lNjnzXpBxufK75gwt4JyLh+X9anOLXJOWn0nkFo1V4cAKL0J56TrEtgtUN3vjXs+cxdcDWS6bRHc+aYyCmw8+Me/Pd5bD5W3PcLqEL5eXWl3wjTJ/myhbBroNDqgv7Qm1S38Sn1b+8gJmMxOXSw2TRmy3NICPS+/k0f/DvtHQ55ECtyj/36LV2ji+LhK+DuWio4tnVdFhajzlxWfzjvyYTu+tvznL9gQnC17FzxxmFg+zpz+/9uvaZ8b+3L/az1ABCjN/GcZF2HH+erep8u3BlUfU1wNcZZQBNzUdBn8+v7cz4Krm5iHI5vpnO+BsvWpo/6h+b6JetY2PXv5/O8p/VvdFWsWTV4W9/MQUw282fdamExVrduAAVW4bw2ugbEJ6zaUk3J+EDWNHj4ytqpNlN+nP1x+k+ji6Emq39qovoT2ngaA+pOvn3PwTyxRqPPAX0nH/TVhyHfOakvbwHQw+qPgCatDKreIii37R5k/qe5M0chn93muXtgK+aaN6g2vx6BtSxnTcl4X9u6VZmw6pnAajbzZ93aDTFjtNZCJLAKbmLRDjcaW6wvvd90GQdv67N2qsvUGXO/X9RTe0X1WA1UE9UfdYeYe5/z2MBcQY8Dek+u9Qq99tTT4AspAPSweiOgA5XCQc7cS+1BGgyongn3hJnz5uNt4+BNdD2vR2A9y1lfUjzPa+2qT1j1ksBqNvNn3UrRMTbrElgFN7FoiZuNLdeaXr6haRw8bI21U02OU1OHIV8oZjr94y2GaqB6qP7U7gHVHe6ZK1nDq+YKehzQf7KsTzgMbd8PPu7NrfkAeli9EdCJHYNBwnJL9x/Hf7p4TkO4J2wdcA/+OD7t9fOuSWBNy7nutb7mzT+/gOrOhFVfE1jN5tDAZtWY3GujJbBK7vXQNaAdbjb2VHtaeXh7PI09h7FYO9XkVupqC7V1+V7tHEz1RQFqoHqo/tTu/9Qdys6THh9ymYbnoIq5gh4H9KCs6xEOQ+x7xNZ9AD2svgjoVrBQUOaw3Nv9Ryfh1EtCPc3Vh/M9sOj79kfmmGCqdQmsa1xb86L3oKM1LB5h1WsEVrM5BN7AGot7b8AEVsm7FroGtMUNx15r0eVNl8NOfdE0eFsf1k71uN/aOhvD7seEUtVBtbDHcRI9xDq+qENqD/vPk732QeYK6G/Qi6KPfm/9t/YD6GH1RED3GggF9RxgnYbne4QpntEQ6umiZrRyD/7y5/LGOesSWNtYs94dhp2f5xVOjU1Y9T0Cq9nMn3W0ptsYjEFglazroGtAW9xwzFajfn+nTxof+NPGK+PJJhZrp3qsxi6tmffur55vLqu96qBayNL6cxjWn5GNag8dzZU/3vm/mCugvwG9qB760Z7g2n5dKBVAD6snAlJqPBD0+uxwDPyzvt6HpDyDFOZJU1d2uQcvxGNtAusbFevUH4XWuNF61gdh1VsEVrOZP+soN9yMvVgEVsm4BroGtMdNR8DaqRYDaqE6CADobdCTugYAoIfVDwE8IEEYaMsvwjsb3/nvhQyuEOYBrE9Y44AefXIJbpjDaQKrmUxDjMCqMRfP4UctEFgFAAAAAAAAAAAA2vP1zv+eDQnxANCzOWRtrYO8nlyCDxzDaZMLkcb8Wf++498vqBrX4RReByAq3xQMALCv7G8s8MYGAAAicE4KAABwN2+tAwAAKENYdQmB1Wzmz3qPwKqganwCqwAAAAAAAAAAAAA8xJvmAADombDqUgKr2cyfdc3AqqBqOwRWASLz1gAAgH1lfbuot6oCAAAAAECTvFUVAECPBZQjrHoPgdVs5s+6RmBVULU9AqsAAADwnmzBTUFVAACi8aV+AAAAEJK3qgIA0Dth1XsJrGYzf9ZbBlYFVdslsAoQlQexAAD2lyXAKagKAAAAAADN8sYvAAC9FlCWsOojBFazmT/rLQKrgqrtE1gFAACA9whyAgDAfnypHwAAwE3CE9TmraoAAGQgrPoogdVs5s+6ZGBVULUfAqsAAACQkTAuAAAAAAAAAADAT8KqawisZjN/1iUCq4Kq/RFYBYjGWwMAAGLoNdApqAoAAAAAAMBC3qoKQFbeZg/5CKuuJbCazfxZrwmsCqr2S2AVAAAArukt2CmoCgBAK3ypHwAAwFVCEwAAANsQVi1BYDWb+bN+JLAqqNo/gVUAAAC4Zg549hDyFFQFAAAAAADgDt6qCgBAJsKqpQisZjN/1vcEVgVVAaA2bw0AAIin1bBnL2FbAAAAAABIzltVAQD0X8B2hFVLEljNZv6slwRWBVUzjYljHQAAAADe01roU0gVAAAAAACAB3irKgAA2Qirliawms38Wd8KrAqqZhoLgqoAAACwTAtvKvU2VQAAevDlm2sAAABw4q1eAAAA2xJW3YLAajbzZ30tsCqommkMCKoCAADA/aKGQYVUAQAAAAAAWMFbVQEAyEhYdSsCq9nMn/VlYFVQNdNnL6gKEJe3BgAAxBfpDabepgoAAAAAAAAAUJQ33EMen1yCDc0Bti/fhBbzmE6f9egzT/SZC6oCAABAGZch0dpfOiKgCgAAAAAAXROQoCZvVQUAICtvVt2aN6xmM3/WB5chyWctqAoAAADbqPGG0/PfIagKAEDvan8ZDAAAAAAAACl5s2oN3rAKvRFUBQAAgBpeB0nXPGQvlAoAAAAAALCba28b7fGNt96qCgBAZsKqtQisQi8EVQEAAGAvAqcAAAAAAMCdegxERnVvUPOjf99nBwAAbRFWrUlgFVonqAoAAAAAAAAAAABwsuWbRFt7G6u3qgIAkJ2wam0Cq9AqQVXgvJaX/zO/fHNdtzRfX2/gAgAAAIBynJMCAABAanuGMi//bm9eBbAWlWRd2dZ8fX2xA/RPWHUPAqvQGkFVYOve4O1/58EsAAAAACAT56QAAABsQOikrGgBk0jBVeEbgD7XOb0EwH2EVfcisAqtEFQF9uoVXv6/PZQFAAAAAGRzeU7qjBQAAAB200IQ0xtXAaixBlpjAG57cgl2dAzATS4EhCWoCkTqG66/WQAAAAAAIIPzGalz0scI+wIAAPCgFt8YOv/MNX9ub1UFyLUuqvsA7xNW3ZvAKkQlqApE7R08jAUAAAAA5OacFAAAADbXQxhHoAgAawxAXcKqEQisQjSCqkAL/YOHsQAAAACA3JyRAgAAwCZ6C99sGSgSVAKwZloLAJ4Jq0YhsApRCKoCrfUQrgEAAAAAkJcv9gMAAOAdf//zr4vwgJ4DN6UDRcJJAFgTAF4SVo1EYBX2JqgKtNpDuAYAAAAAQG7OSQEAAGC1LEEbb8EDwDoKsA1h1WgEVmEvgqpA6z2EawAAAAAA5OacFAAAAB6WMWCzJrQqkASA9QHgLWHViARWoTZBVaCXHsI1AAAAAAByc04KAAAA3EmwCADrCkAZwqpRCaxCLYKqQG89hGsAAAAAAAAAAAAsJlRz31tWXS8ArBUA1wmrRiawClsTVAUAAAAAAOiNL/UDAABI7+9//nURFhKmcT0AAKAUYdXoBFZhK4KqQM/9g2sAAAAAAOTmnBQAAAB40K3AqjArACXWk6x8oQj0T1i1BQKrUJqgKpChf3ANLn355hoAAAAAAAAAAMAFIZrb18b1AcBaC3AfYdVWCKxCKYKqAAAAAAAAGfhSPwAAAGCly5CRwBEAANwmrNoSgVVYS1AVAAAAAAAAAAAAgMW8ZRUAAJYRVm2NwCo8SlAVyNg3uAYAAAAAAAAAAAAAsBNfeABkIqzaIoFVuJegKgAAAAAAQEa+1A8AAACuEpwBAABKE1ZtlcAqLCWoCoAH0gAAAAAAAAAAkvj7n39dBAAAgB0Iq7ZMYBU+IqgKAAAAAAAAAAAAAACwM292h/4Jq7ZOYBXeI6gKcOwVXAMAAAAAAAAAAAAA2ImQJpCFsGoPBFbhNUFVAAAAAAAAAAAAAAAAgEqEVXshsApngqoAAAAAAAAAAAAAN/z9z78uAgAAUJSwak8EVkFQFQAAAAAAgJf++3+uAQAAAAAAAGxMWLU3AqvkJagKAAAAAAAAAAAAAAAAsINPLkGH5sDel29/fv9PBxeDJARVASCrL99K9dCuJcCWdVbtBXqvaeoa1mUAoIceQU8AbLX3UF8AAOCHv//5d7M/+7dff3GBAWh+jbOetU9YtVcCq+QhqAoAPds6ULDk7/EABaDG7vf3q8FAb3VNbcO6DABE7hWck4K6or4AQDpzqEAgAMrMpRZ+BvMdgOhr3a2/xzrWBmHVngms0j9BVQDoyd4PZ9/zc3lwAlBb9/351WFQ23r9+dU349e6DKD+bkW9Nl5L/1zGFKgrW/58agwAAEFFCKVu8fML/wDQwnp37eeyhsUjrNo7gVX6JagKAK3r6SFtD00Aauv+v6daDGqb+obxa38EAPoFPQDQx15EjQGAqrxdFW7Pj6y/p7oAYL1r8We3fu1PWLV3x8PbOdAnsEpPph/jeh7fbkgAQIv9ad+/l/4EUFdjXAv1GNQ29Q3j15gFAD3DPr+T9R/UFjUGAJojsArPc4Hr10KNALDmtfZ7Wbv2Iazas5eH0AKr9GI6jefnce5GBAC3WCei9aV5fl9jD1BT41wrNRnUt56vlRpn/BqzAKBnsCcHtSXj76y+AABQgHDqY9dK+Ad4hNph3dvr9zX26hJW7dX1w2iBVVo3DZdB1cvx7iYEwD09ARh/tX//rXsVc73OdQb1tJ9rqF4Yp9Yj40bfifFrzAKAnqGvtd+13r+/8hnU/Rxcb3sLUCusv7ABb1cl01in7DVUO0Dtwfhr5fffes0y14VV+3T7kElglVZNw7Wg6uW4d/AHANF7UddFvwKop/Gur9oMapz6hrFrrwQA+gZrP6gv6guoFwA/CKzS89imzvVVQwCsfS1cF+vVdoRVe7PskElgldZMw62g6uX4d+MBACL3oXhYAlBL1WYw39jjeqtxxq3xCqgxYLzZi4P6or6AmkF56g2dElilp7HMftddHQGw/lmvchJW7cl9h0wCq7RiGpYEVS/ngUNAAIjag/L6uulbALU05uegPoMap8Zh7NovAfRETdU7WPdBjcl4zdQW1Av02bCKh/dpfewS67NQSwCsgfrePIRVe/HYQZPAKtFNwz1B1cv54DAQwI2omfXA+GrlOhqroI6iPoM6hxpn7GKsAqB3sO67FqDGqC2gZrRBbSERb1mlpbFK/M9HPUGNAuPLWtU/YdUerDtoElglqml4JKh6OS8cCgJAtN6Tj66r/gXUUdRnUOfY47NS54xd6zGgvoOxFeW6WvNBnbGnADUjMrWEpDy4TwvjE/UEiM28twZaq/IQVm1dmYMmgVWimYY1QdXL+eGAENAjgDHV2nXWv4A6SuzPT50GtU4fatyy72dlLQZA72DNB3UGe19QN/aghoC3rBJuPNLH56euoF6BMaX37YuwasvKHjQJrBLFNJQIql7OEweFABCp72Tp9dbDgBqKOg1qHbVkrGnGrbUYUOut8xhP8a+58Ytag9oC6oa+GsLxpimijEHUFQDrINaomIRVW7XNQZPAKnubhpJB1cv54sAQ0Cfko/YbSz1cf+MY1FDif8ZqNeYBGLdYiwHQP2C9B7WmrWutrqBucA81A67y4D57jTn6/ozVFNSuPpnbxpI1Kpcnl6BB2x40zUHByUVmB9OwRVC1zrwByNInYCyxx+fgswDzFmsmGPtsKdPDdsatzxVQG8Ae35wGYxw1HnWDewiqNsuD5PXMD+4LT2CM4fOG6+MZjCVrVEberNqaOgdN3rBKbdOwZVD1cv44QAT0CWActfq56GNA/ST+569Wo96BcYu1GFD3I1EXjaPePhNjGvUGtQXUDf00hHX54L6wMKXHFHk/f/UENQzjiIifi/XpNm9WbUndgyZvWKWWaagRVN1nHgGwFzeNrJM+H8D8ZK+xYDyg3mHvpC6jTgHqAMYR+jswntV9MF7b5pkDWOX81ikBC9aMIbisJ0C7hPqshT6ffIRVW7HPQZPAKlubhppB1X3nE8C2dU1tw/rocwKswajXYFyDMYseDdR+sIaY72AM4zPBOGUdQVUoStAM44VSYwPUMdQ8fE5tEFZtwb4HTQKrbGUa9giqxphXAOoZscaQcWTeA2onxgnoP/Lp+aE7YxbjAMx5PGBvDPnMANQVjE/00RCKt62yZHyAcULrYxTUOfMeYdX4Yhw0CaxS2jTsGVSNNb8A1LHS3Dwyhnx2gPmHMQPGMHnHqzGLGgZqP1gvfHZg3OLzwbjkEZ41gGoug6se8McYwJjBuOzXb7/+4iIYQz67hD65BIHFOmiag4V/fv/n4INhpWmIEFS9nGcOGgE9AsYRrX6G+hhQO2lr7KjbqHlE0WM9MmaxDoNehb7XemOJW5+hMY+aA6gb6KGhaZcP+Au15P3s4ZGxo2agjmEcEeUztCY982bVqGIeNHnDKmtNQ6Sgauz5BnC9XqlZt7mBZO3zWQLWYNRtMFYxZsE4AfszMJas82Cc4rPCWGQpzxlAKN64mutzhhJjCdSxmAT31DGfZV7erBpR7IMmb1jlUdMQMah6Oe8cPAL6AowpfKaAOUatMWUPirrHXnqrP8Ys944XazCo9WBMAeoO9g6oG8zM8+7NAQkPjLft9ecn9NLn5wqlxpQagfqFMYXPNAZh1WjaOGgSWOVe0xA5qHo5/xxCAnqBdqnhxheAuklr40v/groHxivWYECNL02NM74AdQd7B9QN9M3QqcuH/4XS2v8MYYvxpTagZsVgLhpf5CasGklbB00Cqyw1DS0EVS/nocNIwJqPcQegZoI9KGofPeql5hivWINBLafvtd64A9QdQN1A3wx8QHC13c8Lth5ragLqE8Yd7EtYNYo2D5oEVvnINLQUVL2cjw4lgb7W7P6p28YtgJpJy2NOLwNgrcYaDOoxGLMA2DdgvLE9cxq69DrwIagW+/OBGmNOHVBf2I/5Z9zCk0sQQNsHTXMQcfIhcsU0tBhU7WNeAoA1DUDNxNgDY5CXengQz1jFmALoe61X7wG1B58lxhl6ZqCAOQRy/of9Pwsw9gDUJnIRVt1bHwdNAqu8Ng0tB1X7mp8A/XNDyVoGoGbSyxg0DlH/sG8yVjG2AFDnAbUHUDMoz3MFaXmzF4Kr+157iDD/Ab2XdRHqElbdU18HTQKrnE1DD0HVPucpQH/cULKGAaiZGI9gvGGsgjEGZOecVH0HwJqCsYV+GfiQ4Frdaw3GI+QiqKoOwZmw6l76PGgSWGUaegqq9j1fAdBrAqBmYlwCGbT+MJ6aiLEG0PdaDwBgH4p+GajM21a3v75gXAKoP+QlrLqHvg+aBFbzmoYeg6o55i1Am9xUsmYBqJkYn2CMYZyCMQeAmg6AtQXjiWs8U8CJt3xxi9Bq+esJxifot1B3yE1YtbYcB00Cq/lMQ89B1VzzF6ANbipZqwDUTIxTMLawdwI1ErDWuwZqOQCgV0GvDBTgbatlriEYp5CPoKp6A68Jq9aU66BJYDWPacgQVM05jwFiclPJGgWgZmK8Aqh/AJCdc1I9BADWGYwh9MrAJoRWH7tmYLxCPoKq6gxcI6xaS86DJoHV/k1DpqBq7vkMEIObSgDo5zFuwXii//2TcYoxCNDvOq9+AwB6FfTK7ECQgkcIrS6/TmDcgv4K4ExYtYbcB00Cq/2ahoxBVfMaYD9uKlmXANRLjF8wjjBOwVgEsnNOqm4DYM3BuOF6n6xXBjYitHr72gAA1ka4JKy6NQdNM4HV/kxD5qCq+Q2A9QhAvQSAyFp9MM96jTEJ0OcaDwBgb4k+GeiA0Orb6wHGMOTkrarqCtwirLolB02XBFb7MQ2CquY5QE2+AdU6BKBegrGM8QMAkJ0zUr0uANYejBX0yawiVEEpQqvCOBjLkLmf0lOpJ/ARYdWtOGi6RmC1fdMgqGq+A9TkxhIA+nUwpoEc+yj1DWMToL/1XZ0GAPQp6JOBjmUNrQrjYExDTkKqwFLCqltw0HSLwGq7pkFQ1bwHqMmNJWsPgFoJxjbGDMYoGKNAds5JAcA+AeMDfTLFCFmwhUxBN6E+jG3QQ6GGwEeEVUtz0LSEwGp7pkFQ1fwHqMmNJWsOAKAfAHLspdQzAOhrbddHAAB6FNdAnwwklPUtq9DbPAbeElRVO+BewqolOWi6h8BqO6ZBUFUdAKjJjSUA9OYA6iGAegpkNp+ROidVlwEAPQrXe2VYSeCCLfUcWBHGAdA3ASwhrFqKg6ZHCKzGNw2CquoBQC0ewLLOAKiVYKwD6/ZU6hgYs4A1HQCwR8B40CsD7KrHt6wKqpJp/gLHkKqgqpoBjxJWLcFB0xoCq3FNg6CqugBQi5tK1hcAtRKMeUD9ovxe+/U/AMSv2+gjAAD9Cdf7ZShI+IIaegmwCOJg7oI+CbUC7vHJJVjJQVMJcyDyz+//HFyKMKZBULVMfXBQCnCbOgkAYP/JtmMDeyt89kv+ffXCugtYy/W4AAD6E/0yQHHnIIvgD7Q3d81bsjHmgVKEVddw0FSSwGoc0yCoWrZOODAFeEtt1HsCqJUAYM0mzn769Z/rMwJou64DAFCH/bOemabNgQxvxKKWVoNv5ghAjp4I6yOUJKz6KAdNWxBY3d80CKpuUy8cnAJc76XURwDs08HeEyIoMX/2WovMfeNz679Tn2XdBbbfy6op9v4A2B+gN+EtcwvoTGuBVUEczFlvVyXPWJ8Z70ApwqqPcNC0JYHV/UyDoOq2dcMBKsCyvkq91H8CAPae6CFrKD1f3vvztvwsWpzzxmZ7n+/55/DZWXeBuuujGgMA0Fb/Rjl6YSrydlVqE34DcxYij/drvRIfXyfgJWHVezloqkFgtb5pEFStUz8cpgLc32+pnQDYqwNQijdUYpyu/7mMY4B99rrZz0mtPwCAviQHzwewA4FVamsh/GZOAHBtPRBeBZYQVr2Hg6aaBFbrmQZB1bp1xKEqwOM9WMYaqgcFAOw7Yb1ob6gs0e97q6pxuufP6bO07gL7rqNqDwDA/j0Z5elz2ZHAKrV5WyOYr9DqfLjsnzL//sD7hFWXctC0B4HV7U2DoOo+9cThKsD6nixDLdWDAqiVAKwXee/grau0usf1llWAOHth56QAEGOt8hyInoR1zCEgoagBOEEcAO5dLwS6gUtPLsECDpr2NAcpJ5dhE9MgqKquALReS9VTAGsBYG5gDNzS0kNu88+69Of1VtW+xmjLD2N6kNTYBmLUIbUIAMDer2XOFwhCyII9RAuGCqqCuQGPzpHe54k6AMsJq37EQVMEAqvlTYOgqvoC0FM97fGBLOsEAACs0+pDbufwoof0jFG/BwD36DW06pwUANCP9M25AsEIrLIH4RcAelrTMgRXgds+uQQ3OGiKZA5W/vn9n4NLsdo0CKrGqjMOXQHK929qK4A9O5gjeiJy6y0EeLnueauqMdrKWAVg33XXfgDA3sL+DMr1VsSoYVDJHFgVsKC2ecztHZY27iH+PIXW5sy5t+rldwGW8WbV9zhoisgbVtebBkFV9QZAbQUA0BMBbfGm1f4+T7+bNRegRm1qvT6prwDX94aX/6z9MwC9yJ41DQITRmIPgjAAWN+AHgirXuOgKTKB1cdNg6CqugOQrba2Wl+tCwDqJABc462qPkO/IwCPrMXWY4C2++stg6WCq/a/+Dz3qm3QAIFV9rBXoEeQCMwV2HrutDp/zHu4n7Dqaw6aWiCwer9pEFRVfwAy11c1FgCw14Q8POyGsYk1F6D9OqWuAvYP9fcQQqvg3nKtWgMNEVhlD0IxAPS8xlnnoH/CqpccNLVEYHW5aRBUVYcAaKfGWgsA1EkAdRLjsT/ZHsT04ClA3LXZ+gwQv5feu58WWiVzr8T29QUaJLDKHmoGeYSGwJwB88h8h5I+uQQnDptaNAcw//z+z8GleNc0CKq2WY8czgKosdRVYlzYUwBqpVoJAFutoa3+3tZ+gJiin5NaP+z7wTzU04P+Q42DYObAqrACsEVtWUttAlo11y9fCoL1sU/CqjOHTS0TWH3fNAiqtl2XHNICbNv7Rayz+tI6tvrsX/+5Pk9ArVQr7TEB0FPkWu+tuYCaRfa9/7U/094f9pmPenq4ry8iZ42DO50fmvfgO7UI8fRZQ7b+c9Uo8xNam0tb1kisj9bHfQirOmzqgcDqW9MgqNpHfXJgC6DOUsYen/Xl32nfAfbwaqVaCej1rdvWVwDQN2Hv7zOAFvcM55/RHKbXfojcNQ4e4C2r1LR1IM5Y3r5e7Pl3+nwB65010vpofdzDU+rf3mFTT+Zg5uQy/DANgqrqFADqLEfzDdAIN0HPP4cbsoBaqVbqewByrbG4DgD2CvYu9v7xfg7QK2Mdw+elxsFK3v4FfFQjItSJKD9Hr4SdwJyi7fXRGrmdvGFVh009ElgVVFWvAGi3zqr3ZUV+6MkDWaBOqkdqJWDdgIx9h/oDELt2qV/97vsjrsP2/dDmHDBvsXdDvYAXPOBOLVuFd4SC8tQFoRwg+5pnjbQ+6unryhlWddjUs8yB1WkQVFW3AFBns2vpISc3aQG1Uq0EsMfqe70FAGs4epGPf059E+aonx30PGocNM7D7UBLQRc1C4hOUNT6aH1sX76wqsOmDDIGVqdBUFX9AkCdzazVh5o8jAWoOWqlfgeMecjUiwCA/s0e2t4f9Pag31AfoEPeyMTWBHfMfT+3uQnmFtYZP3crcoVVHTZlkimwOg2CquoYAG3XWfV9nR5uerpxC+qkOqNWAtutIdYRQP8KoIbZ+/sdwDgH9DnqG1TgAXe2VDK4IwRUZr77HQDaWPeskdYW62NdecKqDpsyyhBYnQZB1XzUMwB1lmc93fT09gBArVQr9Tpg7LvW1l4AsJ6Tfa+sl8Jewe8C+hs1ATogtAr9z3H1CmB7gqPWR+tjm3KEVR02ZdZzYHUaBFXzUtcAyK7nsJKbuYBaqVYC2/CWVbCGA3Bf79Tz32dtjf976RsA0GfoR6ADHnKnNKEdc3rL3w3zEsA6Yn0sof+wqsOm3I43sXoMrE4/fi+HfbmpbwB91Fj1/LEez+8IajLqiFoJrFlbrC9Yn9DHAqhl+g6/IxjPfif0M6gDUInQKpEI1j0+j/2OAH2vW9ZIfa71sYy+w6oOm3K7PAzrK7A6nX6ft78n+ahzAGps5h7P7wqgfqiVwNqeX98PAID9sN8VgD4597FGQ0BCq9Du3PW7AuxHiNSa4XdtS79hVYdNuV07DOsjsPoyqHrr9yUP9Q5Ajc3c4/mdAdQNtVKPAyXmxOU/qC9YuwGou77rIaylfmeMYUB/oa5BMkKrrCGwU3+++p0xL8E8w1phfVzuU5e/lcOm3G4dhs1Bzy/f/vz+nw4N/mbXg6qXv7exn9f82TsIBoB++1t9Hpn7XMrsh9VKgMfXH2cu6F8AsL7piez97f0BcxN7c/SEsIHLB94FMKjBOHt8jmb83Y0XALA+PqK/N6s6bMptyYFYm29YvR1Uvef3p1/qH0B79VXtLtvn+f0B1EqArfr2a/8A2PcDYN8LmLuAegYU4m2r3ENIglp1CSDL+mdttT74/cvpK6zqpn9u9xyItRVYXRZUfeQ60B91EIDsfZ7rAKgRrgP2j1BzHgmwAgD2EGDfDwDWYKCgc2jVQ/Cw/1yEewi6AdZH14GjfsKqbo7l9siBWBuB1fuCqmuuB/1QDwHU1ux9HoBaCcCee4es4VX7JgCw3mPv71qAeQmY40BRgquw39zDtQBiEgy3JhBfH2FVN8VyW3MgFjuw+lhQtcR1QV0EQG2lv94X1F11wTUBc4B91jNvXgUAsP/X47smGKsA6hiwkuAqr90b1hHuWT7XcE2AvtZAsD7W1X5Y1c2r3EociMUMrK4Lqpa8PqiPANByr+e6AKiVAJEIrwIAPfQz2N8CAPoQYFeCq8AedQcA6wCuyxJth1XdCMut5IFYrMBqmaDqFtcJdRJAXVWjW+z1ANRKACLvMQRXof95DgCU51wEAKyzwA+Cq1B2PgHQhpJvV/WmVusjZbUbVnVzP7ctDsRiBFbLBlW3vF6olwBAX/0wgFppvwjsPyfNSwDAXgL7WjCHAdQv4EGXwVWhghyEa6hdYzAnAbA+fuRTkz+1m1+5bXkgNgdFv3z78/t/Ouzwm20TVL28buZOXvNn7zAZ4q9D+h/Yd54BqJUARHC5/2ul3tuzAtiTWHOAvWqRugAA7ff5wGYuH5wXoILl8wUwb2+xpsYxfxbqt/WReNoLq7rRkFuNA7F9AqvbBlUvr585lJfAKvS9Bqrv6ik564K5T8+1FtRKMPZ5/hztQQBg2ZqoB6rbp6ztUXxej491gIh1S10H/QcQ2uuggaBNLj5vStYS4wnz4Bc1F7A+3tBWWNWhZm41D8TqBlbrBFUvr6O5lJeAFeRaJ9V79HwAaiUAfRBaBYDH90vOSaH/eW+eA0D5PhronreuwvX5ALBFTbHWYn0kk6dmflI3F3Lb40DsGCCdNv5b6gZV97yeqKfAPuvn+R9i1VK1GH0dgFoJ8Ohewn4CAO7fEzgnBQCA93tlIL05iHD5DwCw3VpLWYLARJrnHLURVvXwTW57HohtG1jdJ6ga4bqirgL71H03mgDAHhnsD6GfuWv+gvUWeGxPZV+lvtn7u2ZgTAKoVcBNAjVtEdJZP95xzcA6ax0FyokfVnWDK7cIh2LbBFb3DapGur6or8A+9d8agN4PAEBvRfuc7wDA472SfgkAgMz9MMBCAjUA9xF845F1FiKOTXhU7LCqB21yi3QoVjawGiOoGvE6o84C9dcA64Aair4ZQK0EaH9vYn8CAI/vFewXsH8FAPQbAIsIrgKX9QAov8byGCFxrI+xxA2rergmt4iHYmUCq7GCqpGvN+otYB0AAABgOWc8APA4oVU9CH3MYwDAeglUI7hKL+MYQF0CKCtmWNUNrdwiH4qtC6zGDKq2cN1RdwHrAMYgoDdFrQTUDZato9ZSANA/2f8DAKDXBSoSWo3N2+YA2ltXwRikZfHCqm5K5dbCodhjgdXYQdWWrj/qL2AdUDsBAADi7FXsiwDojXNS+H/27uUIYRiGAmD/1TFQUQ6cwmRIMAz67ZaAbVkReQAA6HEBlvi3VQD47Z3KdX6cAfLIFVb1UstslYZinwVWawRVK64D6jDgHgCcXQC1Eux9jpnzAIAeSt9h3wEA6DGAIEI2/yWgQ9Q5B5wzwLl9lSes6gus2SoOxa4FVmsFVSuvB+ox4B4AAABgz5wHANaZkwIAoKcF+JrQKgAAzJIjrOqFmdkqD8XeB1ZrBlU7rAvqMuAewH4DUCsB1BCezHkAQB8FziwAuBcBggmsYk8CqFfYb8wQH1b1osxsHYZix4HV2kHVTuuD+gy4B9RLAADAc4vPAAAAAACAUP5lFQDW71DO3e4PHwIkEBtW9YLMbJ0CMPvAao+gasd1Qp0GUFsBAJjKjAfPIgCgj9JrAADozwASELgBAIC+NgEGABGMS4rOdGZeAAAAAElFTkSuQmCC',
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

/*
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean`=@authMeanPassword AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean`=@authMeanPhotoTan AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean`=@authMeanPhotoTan AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);
*/
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
