/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

SET @createdBy = 'A757435';
SET @updateState =  'PUSHED_TO_CONFIG';
/* add the new authentication means */
INSERT INTO `AuthentMeans` (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
  SELECT @createdBy, sysdate(), 'OTP_SMS_EXT_MESSAGE', NULL, NULL, 'OTP_SMS_EXT_MESSAGE', @updateState FROM dual
  WHERE NOT EXISTS (SELECT id FROM `AuthentMeans` where name = 'OTP_SMS_EXT_MESSAGE');

/* !40000 ALTER TABLE `MeansProcessStatuses` DISABLE KEYS ; */
-- create the missing entries in MeansProcessStatuses
INSERT INTO `MeansProcessStatuses` (meansProcessStatusType, reversed, fk_id_authentMean)
  SELECT * FROM
  (SELECT DISTINCT(meansProcessStatusType) as stat FROM `MeansProcessStatuses`) as mp,
  (SELECT flag
   from (SELECT 0 as flag UNION SELECT 1) as temp ) as b,
  (SELECT a.id as aid FROM `AuthentMeans` a where a.name in ('OTP_SMS_EXT_MESSAGE')) as c
  WHERE NOT EXISTS (SELECT id
                    FROM `MeansProcessStatuses`
                    WHERE meansProcessStatusType = mp.stat
                      AND b.flag = reversed
                      and aid = fk_id_authentMean);

INSERT IGNORE INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), 'The Mastercard Identity logo', NULL, NULL, 'MC_ID_LOGO', @updateState, 'iVBORw0KGgoAAAANSUhEUgAAANEAAAA8CAYAAAD44F+zAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAACrVJREFUeNrsXc1uG8kRLv35f+1x1gEW2INHwAJBsgg0PuQUBKJOOQWmkAfQcF9A5BOIegJKLxBSTyD6mBNHT0D6EiAnj4EYMLKbiIoVbyxLYqaparDY7J4/9lC0VB/QoET29G99XdXVPwPAYDAYDAaDwWAwGAwGg8FgMBgMBoPBuI1YyPvgj/CtF32Uo7AeBfG3o0TpR6EXhaMotH8J73pJaf78l2GaW5heSRNFpvkqCsH9H5LTZDDmjkQRefzoYycKbsZHwyjsRmRqKcQR5BNpbudIU5BoPyJTi7uSMfckisgjNEMDtcQ0EGSqRGQKIgKVMU13yjSDKNRYMzHmlkQRgeqofazhbgV6K3+YmpAqBJH2uFsZs8RiCgI1bRPo3ncf4eH5e2/x9LPt+jQi7dbkbmXMjSZCAvm2CfTo98dX/ywvwtnaM7h8tGK7Xq1II1W4exnXqokiAlVtE2j5F5/h4e9ORl+cX8Kd1z9BARrJjzSSz93LMEDMwUsYnEJIhO7rhlWVd+cSHm/8a/g5hohIK38/LqKhhGnn3kIBcYiAuMwX/SAbhQ4GrxAS2SaQwP3f/BcWH13oCRZpouW3H4oQpts4P/KIgLA2vg5zDteBSjYzWYrI82DtP/Gm3j9OYeH80nb9SpE2KnE3M2Y9J9qyncm9X58mR4oItPT+YxF13OJuZsyMRJEWcm1roSGJvktHjqV3p0XU0cddEXnNoXoUxKRtgIHa0aKtuuS3YzQhTfmJ+Ick/gD/p3k2NJPgplIGWY4qycvXPL9F0tWZd7q0uwYzkM4jyko9uoa4AyVOPUWbyDYsG8rtK993lDahqCv988ZQhqmwrPxftp3ByjefJp0JJufD/y6GnroCXN6io9oZJ+aSUI4mLdExeyjE6rM+tuMqXO31o52vm6OVwewlcjEvx1AnEdaiUIGRx0l9njoXjjSDhaMZREQ51zFdmpapXXqk/oeGgdjD8Jyk24hpQ99QbloONR9aDp3TQDy7o/SLdRKt2SfRWTbV2P9UBInWM5BI7dA+PvsWR3YplLLzwygcoHCU8RkHO6tGOpsSSPeMDjvkN7nxFvC5EpZll6QZYHyPfBcq+VJhl2kHRFC3iSC/NYzcDinPGtZFlpcKtmi31xhHDhT7ZPCoKgR4laJNVMiy03I0FQLJcqyDJbd2HIlc66ruaTYSLXy6KMpjlRcbZITbQ83gko7fICPbATEpqDBtk79byghfA7OrlfbHpkIIWa+QpNvCfDukPHWDaeYSAdtUyie137bh+QDrrZa1qrRboBCvTNqSmp27Sj67WIckeVTLLttEWlR9pf/iLAJrjgXr86GFO4Ns8e0vvE6DQOmAvqLR9hXTICBC7WnM5FAhkEyzZsifpt1BQSuTtPNuuF1XSAyKtmppTFuKA4NZCmSwCTR1aWnMzJ6GqGFMm2Qpx76mjVqkHIV5524i8mqiI813JxrzCGK+KykkM5FVh32NPX+ImuJ4ikkyNWfeKA6AgWaeklRHNc1XCc+7KeKmMb91c5vnKdr1iEl0eyDNprZBaHeggIVxxnQk6t/QevaumQhJ5nIp4Xlh94vNwi/wb2qOVHOUifbzKqZtCkGONF9m0GSmuH7O9n6bol3XiySRdWG7PF3KFt+5exNJ3CZmTFOjURoxZo+v9E8b51Vp+uqJko+jMaEahnzrOesoiV2KqUuozB3rGvO7MWVbS4eOpyGnb7Nzl1PYulPh/HgFstBicHepCCE+umYS7ZMJrw+jdSvpsTK5XJsYdwfjn5CR1ORcCBVhdsiEexcn/W0YHfEv47xITtLXSFl7kH5pIITxtbMOjLufaZo9dBwc4nc7qJHyuLh1VkebpNGFkYv7JYD1g6ATJDqyzdLP77NploI00XUfGw9QezTJqFxVTCFHo6E8Q3z6XEUjzAHRBLQ/t1DQ+2gWysVW6bTQmT1Z1tdqhJjSnFI10jaWuY3xG0T72BJwufjskQGknNDePkx6X3OZc23b0nP+75XUJt3g0QoM7lnXRP37P7zLUq8+CmEAZu+b/L1vIGygmUu0cE7TIs/JTntBnumR31ZR0AJNGWR6ugFiU8lHEnlfKecqaqdQqX8bHRq1DPWmeVc0siS1DyX9nsZxIl3hG4Z+SFOOPrZNTWmfEOtb06SxAzn3WU6cbP0Rvj0Ey9t/HngfEndxD7XWr57CxTcPbJOIT7kyCsWiwX63ip//9hAGZ/HedKGBCiAQwGhbDIMxGxKJq6xsm3WCQB9ffxVv9j1/XET9hBYKuZsZRUJ7UQkeieiC5Y16zp/+ObxnYcKZ8OwenH3/tfW5ENrVYmLbZjIxZmnOCW0UwqTXZ2p86Hw9YdYJM07MhQrAJl7m6NzSvhWDhzenZfPmuGx2NBHRSD5Y3vEqNNGTP/50dcaouCuzKlNeLSzdruomSNEecR4cQVqxHiFM4tCiwMn7yV38LgRyJ7nJigb9but5gNxlvnETSLQc96O4NzsiEtgkknB5n/z1GXz15xO4+O2TeSQQxIySLsRv0aG/tWDSfZwFLowWW6V52iPlE99XYbQGxebqPJlzKpHgyvfft0ik/sezZy3LBBrOgWZ0uf0G6PeZPUWBDlBrdXOaLR4+WyLa5Cl+0r8DGJ209Vic55RESCS5IGjDayc6/sXjg+HazQtIv8ExDoI4qxGBgmtuT7pQWAHzMeVY/wuMTp3WYPJwG21H8dsejA7QMebNnNM4Gzbx7RBbkH17kCDgPrrQh8CJ/wZeayWEoJxRYEWau3PqeZMasYlzrLT2fxVNuT0MSajhPKzN4jyHjoUEp4M89Uhf8kU3RfbJRFu85CvRHMRbeQSR1shE2tWkKfb4iZd8FXV0wzTxrcPV9pCNDBq0g+20mnLeIq+DXZ3ShKaOBRdGGzLltqak/YSyL1yi+dLUmZ68DQ1OljjHApWjgCn65aIDk9cvSRININsx+iqkOy0qHRMDS44ceYVUAyZPrg5g/KISXT2PNc/Ezb3KhmcGMHmswdS+ctf1APj2ViaRhhj1DITzLZFoQPJ2SXm6BuGmdaRzOQfLdozB0RBI3hnnw/jxC3kvnJfQvkwgJlGsWTQwpGcj/SQSVQ1lkncrUEK4CWXVaUqHkMukpbyE9v2iCcR3LBSPPDfz2NplERqcE2JedKARcCnApk27ci5VVrSQ9CSa6thLqKvUehWwfBPPLLDMMl44JCFOUsQN0HGR97JJHYmS8qJYJxrHpA3lgTbppJBmYjvH4NIhzqMvkkBMotngZQYh65HRvXaNZU7zelEXJu/ku5Vgc654U86H0V63JMjFWhey3eLjWiqvJMJCitBLmPekGTCEi1uezrXxZnom0Q0kkJw8Z9EquyjMOymFykMngY37546UuVEaBPi5PQVxK8ThwNuXbgim8c45ML7O4ufI34dx93Tceo6Mp+72SPIIljR1SfK0ybcP6rxtprrqrr/Sta8HyV4+xg0iURfG3/sjg/quomnuqqCLl+LzEPOvw/g7hUz55CGRKswNGL36pUHyLGvMyTckzzqao03SHl6K9vVI+zoshjebRKbQRWH3LZVDarWuJq83CVoqL4kkKQ5Bv8vBiymr7mVkh5C8TqTTwl0St8oiybA5z5q1qePmcFw4bJIxGAwGg8FgMBgMBoPBYDAYjOLxfwEGAGtIh0YXZzwkAAAAAElFTkSuQmCC',
        '/');

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
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
} ]';
SET @availableAuthMeans = 'REFUSAL|OTP_SMS_EXT_MESSAGE|MOBILE_APP|INFO';
SET @issuerNameAndLabel = 'Swisskey AG';
SET @issuerCode = '41001';

INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `availaibleAuthentMeans`) VALUES
  (@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, @updateState, @issuerNameAndLabel,
    @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Crédit Suisse AG';
SET @subIssuerCode = '48350';
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
SET @preferredAuthMean = 'MOBILE_APP';
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
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`, `paChallengePublicUrl`,`verifyCardStatus`,`resendOTPThreshold`, `resendSameOTP`,`combinedAuthenticationAllowed`,
                         `displayLanguageSelectPage`,`trustedBeneficiariesAllowed`,`authentMeans`) VALUES
  ('ACS_U7G', 120, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   @updateState, @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat, 'https://secure.six-group.com', '1', '3', TRUE, FALSE, b'0', b'0', @activatedAuthMeans);
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
SET @BankB = 'SWISSKEY';
SET @BankUB = 'CS';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB, ' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), @updateState, si.id
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
     (NULL,'HELP_PAGE', CONCAT('Help Page (', @BankB, ')')),
     (NULL,'INFO_REFUSAL_PAGE', CONCAT('INFO Refusal Page (', @BankB, ')'));

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
                width: 20%;
                float: right;
                text-align: right;
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
                padding-right: 16px;
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
        .paragraphDescription {
                text-align: left;
        }
        .leftColumn {
                width:40%;
                display:block;
                float:left;
                padding-top:1.5em;
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
                text-align:left;
        }
        div.side-menu div.menu-title::before {
                display:inline;
        }
        div.side-menu div.menu-title::after {
                display:inline;
        }
        div.side-menu div.menu-title {
                display:inline;
                padding-left:40%;
                text-align:left;
                font-size: 14px;
                color: #000000;
        }
        div.side-menu div.menu-elements {
                margin-top:5px;
        }
        #otp-form {
                display:inline-block;
                padding-top:12px;
        }
        #otp-form input {
                box-sizing:content-box;
                padding: 5px 10px 3px;
                background-color: #fff;
                border: 1px solid rgba(0,0,0,.2);
                border-radius: 2px;
                box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
                font: 300 18px "Helvetica Neue",Helvetica,Arial,sans-serif;
                font-size: 1.8rem;
                line-height: 25px;
                min-height: 35px;
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
                width:100%;
                text-align:left;
                margin-top:10px;
                margin-bottom:10px;
        }
        div#otp-fields {
                display:inline-block;
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
        #reSendOtp > button{
                background:none!important;
                color: #000000;
                border:none;
                padding:0!important;
                font: inherit;
                cursor: pointer;
                font-family: Arial, regular;
                font-size: 12px;
        }
        #reSendOtp > button:disabled{
                background:none!important;
                color: #000000;
                border:none;
                padding:0!important;
                font: inherit;
                cursor: not-allowed;
                font-family: Arial, regular;
                font-size: 12px;
        }
        #validateButton {
                display:inline-block;
                padding-top:10px;
                margin-left:1em;
                border-radius: 20px;
        }
        #validateButton button {
                display:inline-block;
                font-family: "Arial",Helvetica,Arial,sans-serif;
                font-size:14px;
                border-radius: 20px;
                color: #FFFFFF;
                background:#de3919;
                padding: 10px 30px 10px 20px;
                border: solid #de3919 1px;
                text-decoration: none;
                min-width:150px;
        }
        #validateButton button:disabled {
                display:inline-block;
                font-family: "Arial",Helvetica,Arial,sans-serif;
                font-size:14px;
                border-radius: 20px;
                color: #000;
                background:#fff;
                border-color: #dcdcdc;
                padding: 10px 30px 10px 20px;
                border: solid #000 1px;
                text-decoration: none;
                min-width:150px;
        }
        #validateButton > button > span {
                display:inline-block;
                float:left;
                margin-top: 3px;
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
        #validateButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
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
                content:\'\';
        }
        #footer #cancelButton button span:before {
                content:\'\';
        }
        #footer #helpButton button span.fa {
                background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
                width:24px;
                height:26px;
                background-position-y: -1px;
                background-size: 115%;
                display:inline-block;
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
                .leftColumn { padding-bottom:10em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                div.side-menu div.menu-title { padding-left:37px; text-align:left; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1278px) and (min-width: 764px) {
                #pageHeader {height: 96px;}
                #pageHeaderLeft { padding-top:0px; }
                #issuerLogo {max-height : 64px;  max-width:200%;  padding-top: 10px;}
                div.side-menu div.menu-title { padding-left:34px; text-align:left; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1199px) and (min-width: 701px) {
                h1 { font-size:24px; }
                #pageHeader {height: 90px;}
                #pageHeaderRight {width: 25%;}
                #issuerLogo {max-height : 64px;  max-width:200%; }
                #networkLogo {max-height : 72px;px;  max-width:100%; padding-top: 5px;}
                #optGblPage {     font-size : 14px; }
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom:0em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; }
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
                #otp-form{ display:block;  width:200px; margin-left:auto; margin-right:auto; }
                #otp-form input { width:100%; }
                div#otp-fields { width:100%; }
                #validateButton { display:block; width:180px; margin-left:auto; margin-right:auto; }
                #validateButton button { width:100%; }
        }

        @media all and (max-width: 700px) and (min-width: 481px) {
                h1 { font-size:18px; }
                #optGblPage { font-size : 14px;}
                #pageHeader {height: 70px;}
                #pageHeaderRight {width: 25%;}
                #pageHeaderLeft { padding-top:10px; }
                #issuerLogo {max-height : 54px;  max-width:200%; }
                #networkLogo {max-height : 67px;  max-width:100%; padding-top: 10px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom:0em; }
                .rightColumn { margin-left:0px; display:block; float:none; width:100%; margin-top: 75px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
                #otp-form{ display:block;  width:200px; margin-left:auto; margin-right:auto; }
                #otp-form input { width:100%; }
                div#otp-fields { width:100%; }
                #validateButton { display:block;  width:180px; margin-left:auto; margin-right:auto; }
                #validateButton button { width:100%; }
        }
        @media all and (max-width: 480px) {
                h1 { font-size:16px; }
                div.side-menu div.menu-title { display:inline; }
                #optGblPage {   font-size : 14px;}
                #pageHeaderRight {width: 25%;}
                #pageHeader {height: 65px;}
                #issuerLogo { max-height : 42px;  max-width:200%; }
                #networkLogo {max-height : 62px;  max-width:100%; padding-top: 0px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom:0em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 85px; }
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
                #otp-form{ display:block; width:200px; margin-left:auto; margin-right:auto; }
                #otp-form input { width:100%; padding:0px; }
                div#otp-fields { width:100%; }
                #validateButton { display:block; width:180px; margin-left:auto; margin-right:auto;}
                #validateButton button { width:100%; }
        }
        @media all and (max-width: 347px) {
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .rightColumn { margin-top: 100px; }
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
                <custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
            </div>

            <div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>

            <div id="pageHeaderRight" ng-style="style" class="ng-scope" >
                <custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
            </div>
        </div>

        <message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
                <side-menu menu-title="\'network_means_pageType_11\'"></side-menu>
            </div>
            <div class="rightColumn">
                <div class="paragraph">
                    <custom-text custom-text-key="\'network_means_pageType_1\'"></custom-text>
                </div>
                <div class="paragraphDescription">
                    <custom-text custom-text-key="\'network_means_pageType_2\'"></custom-text>
                </div>
                <div class="paragraphDescription">
                    <custom-text custom-text-key="\'network_means_pageType_3\'"></custom-text>
                </div>
                <div id="otp-fields-container">
                    <div x-ms-format-detection="none" id="otp-fields">
                        <otp-form></otp-form>
                    </div>
                </div>
                <div class="paragraph">
                    <div class="refreshDiv">
                        <span class="fa fa-life-ring" aria-hidden="true"></span>
                        <re-Send-Otp id="reSendOtp" rso-Label="\'network_means_pageType_19\'"></re-Send-Otp>
                    </div>
                    <val-button val-label="\'network_means_pageType_42\'" id="validateButton" ></val-button>
                </div>
            </div>
        </div>
        <div id="footer">
            <div ng-style="style" class="style">
                <cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton"></cancel-button>
                <help help-label="\'network_means_pageType_41\'" id="helpButton"></help>
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
                width: 20%;
                float: right;
                text-align: right;
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
                padding-right: 16px;
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
                text-align:left;
        }
        div.side-menu div.menu-title::before {
                display:inline;
        }
        div.side-menu div.menu-title::after {
                display:inline;
        }
        div.side-menu div.menu-title {
                display:inline;
                padding-left:40%;
                text-align:left;
                font-size: 14px;
                color: #000000;
        }
        div.side-menu div.menu-elements {
                margin-top:5px;
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
                content:\'\';
        }
        div#footer #cancelButton button span:before {
                content:\'\';
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
                div.side-menu div.menu-title { padding-left:37px; text-align:left; }
                .leftColumn { padding-bottom: 10em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1278px) and (min-width: 764px) {
                #pageHeader {height: 96px;}
                #pageHeaderLeft { padding-top:0px; }
                #issuerLogo {max-height : 64px;  max-width:200%;  padding-top: 10px;}
                div.side-menu div.menu-title { padding-left:34px; text-align:left; }
                .leftColumn { padding-bottom: 10em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1199px) and (min-width: 701px) {
                h1 { font-size:24px; }
                #pageHeader {height: 90px;}
                #pageHeaderRight {width: 25%;}
                #issuerLogo {max-height : 64px;  max-width:200%; }
                #networkLogo {max-height : 72px;px;  max-width:100%; padding-top: 5px;}
                #optGblPage {     font-size : 14px; }
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom: 0em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 60px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
        }
        @media all and (max-width: 700px) and (min-width: 481px) {
                h1 { font-size:18px; }
                #optGblPage { font-size : 14px;}
                #pageHeader {height: 70px;}
                #pageHeaderRight {width: 25%;}
                #pageHeaderLeft { padding-top:10px; }
                #issuerLogo {max-height : 54px;  max-width:200%; }
                #networkLogo {max-height : 67px;  max-width:100%; padding-top: 10px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom: 0em; }
                .rightColumn { margin-left:0px; display:block; float:none; width:100%; margin-top: 65px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
        }
        @media all and (max-width: 480px) {
                h1 { font-size:16px; }
                div.side-menu div.menu-title { display:inline; }
                #optGblPage {   font-size : 14px;}
                #pageHeaderRight {width: 25%;}
                #pageHeader {height: 65px;}
                #issuerLogo { max-height : 42px;  max-width:200%; }
                #networkLogo {max-height : 62px;  max-width:100%; padding-top: 0px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom: 0em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 75px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
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
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope">

		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
			<side-menu menu-title="\'network_means_pageType_11\'"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
                <custom-text custom-text-key="\'network_means_pageType_1\'"></custom-text>
			</div>
			<div class="paragraphDescription">
                <custom-text custom-text-key="\'network_means_pageType_2\'"></custom-text>
			</div>
			<div class="paragraphDescription">
                <custom-text custom-text-key="\'network_means_pageType_3\'"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="\'network_means_pageType_41\'" id="helpButton"></help>
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
                width: 20%;
                float: right;
                text-align: right;
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
                padding-right: 16px;
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
                text-align:left;
        }
        div.side-menu div.menu-title::before {
                display:inline;
        }

        div.side-menu div.menu-title::after {
                display:inline;
        }
        div.side-menu div.menu-title {
                display:inline;
                padding-left:40%;
                text-align:left;
                font-size: 14px;
                color: #000000;
        }
        div.side-menu div.menu-elements {
                margin-top:5px;
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
                div.side-menu div.menu-title { padding-left:37px; text-align:left; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1278px) and (min-width: 764px) {
                #pageHeader {height: 96px;}
                #pageHeaderLeft { padding-top:0px; }
                #issuerLogo {max-height : 64px;  max-width:200%;  padding-top: 10px;}
                div.side-menu div.menu-title { padding-left:34px; text-align:left; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1199px) and (min-width: 701px) {
                h1 {font-size:24px;}
                #pageHeader {height: 90px;}
                #pageHeaderRight {width: 25%;}
                #issuerLogo {max-height : 64px;  max-width:200%; }
                #networkLogo {max-height : 72px;px;  max-width:100%; padding-top: 5px;}
                #optGblPage {     font-size : 14px; }
                .leftColumn {display:block;float:none;width:100%;}
                .rightColumn {display:block;float:none;width:100%;margin-left:0px;  margin-top: 60px; }
                .paragraph {margin: 0px 0px 10px;text-align: center;}
                .paragraphDescription {text-align: center;}
                div.side-menu div.menu-title {padding-left:0px;text-align:center;}
                side-menu div.text-center {text-align:center;}
        }
        @media all and (max-width: 700px) and (min-width: 481px) {
                h1 { font-size:18px; }
                #optGblPage {font-size : 14px;}
                #pageHeader {height: 70px;}
                #pageHeaderRight {width: 25%;}
                #pageHeaderLeft { padding-top:10px; }
                #issuerLogo {max-height : 54px;  max-width:200%; }
                #networkLogo {max-height : 67px;  max-width:100%; padding-top: 10px;}
                .leftColumn {display:block;float:none;width:100%;}
                .rightColumn {margin-left:0px;display:block;float:none;width:100%;  margin-top: 65px; }
                .paragraph {margin: 0px 0px 10px;text-align: center;}
                .paragraphDescription {text-align: center;}
                div.side-menu div.menu-title {padding-left:0px;text-align:center;}
                side-menu div.text-center {text-align:center;}
        }
        @media all and (max-width: 480px) {
                h1 {font-size:16px;}
                div.side-menu div.menu-title {display:inline;}
                #optGblPage {   font-size : 14px;}
                #pageHeaderRight {width: 25%;}
                #pageHeader {height: 65px;}
                #issuerLogo { max-height : 42px;  max-width:200%; }
                #networkLogo {max-height : 62px;  max-width:100%; padding-top: 0px;}
                .leftColumn {display:block;float:none;width:100%;}
                .rightColumn {display:block;float:none;width:100%;margin-left:0px;  margin-top: 75px; }
                .paragraph {text-align: center;}
                .paragraphDescription {text-align: center;}
                div.side-menu div.menu-title {padding-left:0px;text-align:center;}
                side-menu div.text-center {text-align:center;}
        }
        @media all and (max-width: 347px) {
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .rightColumn { margin-top: 75px; }
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
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
                width: 20%;
                float: right;
                text-align: right;
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
                padding-right: 16px;
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
                text-align:left;
        }
        div.side-menu div.menu-title::before {
                display:inline;
        }
        div.side-menu div.menu-title::after {
                display:inline;
        }
        div.side-menu div.menu-title {
                display:inline;
                padding-left:40%;
                text-align:left;
                font-size: 14px;
                color: #000000;
        }
        div.side-menu div.menu-elements {
              margin-top:5px;
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
                content:\'\';
        }
        div#footer #cancelButton button span:before {
                content:\'\';
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
                div.side-menu div.menu-title { padding-left:37px; text-align:left; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1278px) and (min-width: 764px) {
                #pageHeader {height: 96px;}
                #pageHeaderLeft { padding-top:0px; }
                #issuerLogo {max-height : 64px;  max-width:200%;  padding-top: 10px;}
                div.side-menu div.menu-title { padding-left:34px; text-align:left; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1199px) and (min-width: 701px) {
                h1 { font-size:24px; }
                #pageHeader {height: 90px;}
                #pageHeaderRight {width: 25%;}
                #issuerLogo {max-height : 64px;  max-width:200%; }
                #networkLogo {max-height : 72px;px;  max-width:100%; padding-top: 5px;}
                #optGblPage {     font-size : 14px; }
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 60px; }
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
        }
        @media all and (max-width: 700px) and (min-width: 481px) {
                h1 { font-size:18px; }
                #optGblPage { font-size : 14px;}
                #pageHeader {height: 70px;}
                #pageHeaderRight {width: 25%;}
                #pageHeaderLeft { padding-top:10px; }
                #issuerLogo {max-height : 54px;  max-width:200%; }
                #networkLogo {max-height : 67px;  max-width:100%; padding-top: 10px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; }
                .rightColumn { margin-left:0px; display:block; float:none; width:100%; }
                div.side-menu div.menu-title { padding-left:0px; text-align:center; margin-top: 65px; }
                side-menu div.text-center { text-align:center; }
        }
        @media all and (max-width: 480px) {
                h1 { font-size:16px; }
                div.side-menu div.menu-title { display:inline; }
                #optGblPage {   font-size : 14px;}
                #pageHeaderRight {width: 25%;}
                #pageHeader {height: 65px;}
                #issuerLogo { max-height : 42px;  max-width:200%; }
                #networkLogo {max-height : 62px;  max-width:100%; padding-top: 0px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 75px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
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
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope">
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
			<side-menu menu-title="\'network_means_pageType_11\'"></side-menu>
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
			<help help-label="\'network_means_pageType_41\'" id="helpButton"></help>
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
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_1\'"></custom-text></p>
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_2\'"></custom-text>
            <custom-text custom-text-key="\'network_means_HELP_PAGE_3\'"></custom-text></p>

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
                width: 20%;
                float: right;
                text-align: right;
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
                padding-right: 16px;
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
                text-align:left;
        }
        div.side-menu div.menu-title::before {
                display:inline;
        }
        div.side-menu div.menu-title::after {
                display:inline;
        }
        div.side-menu div.menu-title {
                display:inline;
                padding-left:40%;
                text-align:left;
                font-size: 14px;
                color: #000000;
        }
        div.side-menu div.menu-elements {
                margin-top:5px;
        }
        div#message-controls {
                text-align: center;
                padding-bottom: 10px;
                padding-top: 0px;
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
                content:\'\';
        }
        div#footer #cancelButton button span:before {
                content:\'\';
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
                div.side-menu div.menu-title { padding-left:37px; text-align:left; }
                .leftColumn { padding-bottom: 10em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1278px) and (min-width: 764px) {
                #pageHeader {height: 96px;}
                #pageHeaderLeft { padding-top:0px; }
                #issuerLogo {max-height : 64px;  max-width:200%;  padding-top: 10px;}
                div.side-menu div.menu-title { padding-left:34px; text-align:left; }
                .leftColumn { padding-bottom: 10em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; }
                .paragraph{ text-align: left;}
                .paragraphDescription {text-align: left;}
        }
        @media all and (max-width: 1199px) and (min-width: 701px) {
                h1 { font-size:24px; }
                #pageHeader {height: 90px;}
                #pageHeaderRight {width: 25%;}
                #issuerLogo {max-height : 64px;  max-width:200%; }
                #networkLogo {max-height : 72px;px;  max-width:100%; padding-top: 5px;}
                #issuerLogo {max-height : 64px;  max-width:200%; }
                #networkLogo {max-height : 72px;px;  max-width:100%; }
                #optGblPage {     font-size : 14px; }
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom: 0em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 60px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
        }
        @media all and (max-width: 700px) and (min-width: 481px) {
                h1 { font-size:18px; }
                #optGblPage { font-size : 14px;}
                #pageHeader {height: 70px;}
                #pageHeaderRight {width: 25%;}
                #pageHeaderLeft { padding-top:10px; }
                #issuerLogo {max-height : 54px;  max-width:200%; }
                #networkLogo {max-height : 67px;  max-width:100%; padding-top: 10px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom: 0em; }
                .rightColumn { margin-left:0px; display:block; float:none; width:100%; margin-top: 65px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
        }
        @media all and (max-width: 480px) {
                h1 { font-size:16px; }
                div.side-menu div.menu-title { display:inline; }
                #optGblPage {   font-size : 14px;}
                #pageHeaderRight {width: 25%;}
                #pageHeader {height: 65px;}
                #issuerLogo { max-height : 42px;  max-width:200%; }
                #networkLogo {max-height : 62px;  max-width:100%; padding-top: 0px;}
                .paragraph { text-align: center; }
                .paragraphDescription {text-align: center;}
                .leftColumn { display:block; float:none; width:100%; padding-bottom: 0em; }
                .rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 75px;}
                div.side-menu div.menu-title { padding-left:0px; text-align:center; }
                side-menu div.text-center { text-align:center; }
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
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope">

		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<div id="message-container" ng-class="[style, {unfold: unfolded}]" ng-click="foldUnfold()" click-outside="fold()" class="ng-scope error unfold" style="">
		<div id="message-content">
			<span id="info-icon" class="fa fa-info-circle"></span>
			<custom-text id="headingTxt" custom-text-key="''network_means_pageType_22''"></custom-text>
			<custom-text id="message" custom-text-key="''network_means_pageType_23''"></custom-text>
		</div>
		<div id="message-controls">
            <div id="return-button-row" class="message-button">
				<button class="btn btn-default" >
					<span class="fa fa-reply menu-button-icon" aria-hidden="true"></span>
                    <custom-text custom-text-key="\'network_means_pageType_175\'"></custom-text>
				</button>
			</div>
		</div>
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
			<side-menu menu-title="\'network_means_pageType_11\'"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
                <custom-text custom-text-key="\'network_means_pageType_1\'"></custom-text>
			</div>
			<div class="paragraphDescription">
                <custom-text custom-text-key="\'network_means_pageType_2\'"></custom-text>
			</div>
			<div class="paragraphDescription">
                <custom-text custom-text-key="\'network_means_pageType_3\'"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="\'network_means_pageType_41\'" id="helpButton"></help>
		</div>
	</div>
</div>
', @layoutIdRefusalPage);

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`, `relativePath`)
VALUES (@createdBy, NOW(), CONCAT(@BankUB,' Logo'), NULL, NULL, @BankUB, @updateState, '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',
        '/');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBADECLINE_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBADECLINE'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_RBAACCEPT_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_RBAACCEPT'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MOBILE_APP'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '__MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;

SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBAACCEPT'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_RBADECLINE'));
SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@BankUB,'_ACCEPT'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@BankUB,'_DECLINE'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'MOBILE_APP', NULL, NULL, CONCAT(@BankUB,'_TA_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID);


/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_ACCEPT'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DECLINE'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', @updateState, 1, @profileRefusal),
  (@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO),
  (@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', @updateState, 3, @profileRBAACCEPT),
  (@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', @updateState, 4, @profileRBADECLINE),
  (@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', @updateState, 5, @profileMOBILEAPP),
  (@createdBy, NOW(), 'OTP_SMS_EXT (FALLBACK)', NULL, NULL, 'OTP_SMS_EXT (FALLBACK)', @updateState, 6, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', @updateState, 7, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FRAUD' AND `fk_id_profile` = @profileRefusal);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
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
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL'), @updateState, @ruleMobileAppnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_EXT_FALLBACK'), @updateState, @ruleSMSnormal),
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

SET @authMeanMobileApp =(SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTICATION_REFUSAL')
    AND mps.`fk_id_authentMean`=@authMeanMobileApp AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=TRUE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@ruleRefusalFraud, @ruleRBAAccept, @ruleRBADecline, @ruleMobileAppnormal, @ruleSMSnormal, @ruleRefusalDefault, @ruleINFOnormal);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`,`forceAuthent`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, b'0', @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS = IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
