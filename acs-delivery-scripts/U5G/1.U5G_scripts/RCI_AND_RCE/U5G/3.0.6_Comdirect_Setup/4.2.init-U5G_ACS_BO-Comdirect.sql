/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

START TRANSACTION;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @activatedAuthMeans = '[{"authentMeans":"OTP_SMS", "validate":true}, {"authentMeans":"PHOTO_TAN", "validate":true}, {"authentMeans":"I_TAN", "validate":true} ,{"authentMeans":"REFUSAL", "validate":true}]';
SET @availableAuthMeans = 'OTP_SMS|PHOTO_TAN|I_TAN|REFUSAL';
SET @issuerNameAndLabel = 'Comdirect';
SET @issuerCode = '16600';


-- add the new authentication means

INSERT INTO AuthentMeans  (createdBy, creationDate, description, lastUpdateBy, lastUpdateDate, name, updateState)
VALUES ('MZecher', sysdate(), 'PhotoTAN', NULL, NULL, 'PHOTO_TAN', 'PUSHED_TO_CONFIG'),
        ('MZecher', sysdate(), 'iTAN', NULL, NULL, 'I_TAN', 'PUSHED_TO_CONFIG'),
        ('MZecher', sysdate(), 'MTAN (No message included)', NULL, NULL, 'OTP_SMS_EXT_MESSAGE', 'PUSHED_TO_CONFIG'),
        ('MZecher', sysdate(), 'ACCEPT', NULL, NULL, 'ACCEPT', 'PUSHED_TO_CONFIG');

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanAccept = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanOTPPhototan = (SELECT id FROM `AuthentMeans` WHERE `name` = 'PHOTO_TAN');
SET @authMeanITan = (SELECT id FROM `AuthentMeans` WHERE `name` = 'I_TAN');

-- create the missing entries in MeansProcessStatuses

INSERT INTO MeansProcessStatuses (meansProcessStatusType, reversed, fk_id_authentmean)
  select * from (SELECT distinct(meansProcessStatusType) from MeansProcessStatuses) as m1 ,
               (select distinct(reversed) from MeansProcessStatuses) as m2,
					(select id from AuthentMeans where name in ('PHOTO_TAN', 'I_TAN', 'OTP_SMS_EXT_MESSAGE')) as m3;

INSERT INTO MeansProcessStatuses (meansProcessStatusType, reversed, fk_id_authentMean)
SELECT 'HUB_AUTHENTICATION_MEAN_AVAILABLE', flags.temp, a.id
FROM AuthentMeans a join (select 0 as temp union select 1 as temp) as flags where a.name <> 'MOBILE_APP';

INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `authentMeans`, `availaibleAuthentMeans`) VALUES
  (@issuerCode, 'InitPhase', NOW(), NULL, NULL, NULL, @issuerNameAndLabel, 'PUSHED_TO_CONFIG', @issuerNameAndLabel,
    @activatedAuthMeans, @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'Comdirect';
SET @subIssuerCode = '16600';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages ='';
SET @defaultLanguage = 'de';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'PA_ONLY_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-qlf-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'PHOTO_TAN';

/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '272';

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `otpExcluded`, `otpAllowed`, `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`) VALUES
  ('ACS_U5G', 300, @backUpLanguages, @subIssuerCode, @subIssuerCode, 'EUR', 'InitPhase', NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, '^[^OIi]*$', '8:(:DIGIT:1)', NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `Network_SubIssuer` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerCrypto                                                               /!\
--  /!\ This is a very specific configuration, in production environment only,        /!\
--  /!\ for internal and external acceptance, use the one given here                  /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerCrypto` DISABLE KEYS */;
INSERT INTO `SubIssuerCrypto` (`acsIdForCrypto`, `binKeyIdentifier`, `cavvKeyIndicator`, `cipherKeyIdentifier`,
                               `desCipherKeyIdentifier`, `desKeyId`, `hubAESKey`, `secondFactorAuthentication`, `fk_id_subIssuer`)
    SELECT '0A', '1', '03', 'EC11223344554B544F4B5F4D5554555F414301', 'EC11223344554B544F4B5F4D5554555F414300', '1', '01', 'NO_SECOND_FACTOR', si.id
    FROM `SubIssuer` si WHERE si.fk_id_issuer = @issuerId;
/*!40000 ALTER TABLE `SubIssuerCrypto` ENABLE KEYS */;

--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
--  /!\ SubIssuerNetworkCrypto                                                     /!\
--  /!\ This is a very specific configuration, in production environment only,     /!\
--  /!\ for internal and external acceptance, use the one given here               /!\
--  /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\ /!\
/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` DISABLE KEYS */;
INSERT INTO `SubIssuerNetworkCrypto` (`authorityCertificate`, `authorityCertificateExpiryDate`, `cardNetworkAlgorithm`,
                                      `cardNetworkIdentifier`, `cardNetworkSeqGenerationMethod`, `cardNetworkSignatureKey`,
                                      `rootCertificate`, `rootCertificateExpiryDate`, `signingCertificate`, `signingCertificateExpiryDate`,
                                      `fk_id_network`, `fk_id_subIssuer`)
  SELECT 'MIIFGzCCBAOgAwIBAgIRANh0YTBB/DxEoLzGXWw28RAwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRwwGgYDVQQDExNWaXNhIGVDb21tZXJjZSBSb290MB4XDTE1MDYyNDE1MjcwNloXDTIyMDYyMjAwMTYwN1owcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkmC50Q+GkmQyZ29kKxp1d+nJ43JwXhGZ7aFF1PiM5SlCESQ22qV/lBA3wHYYP8i17/GQQYNBiF3u4r6juXIHFwjwvKyFMF6kmBYXvcQa8Pd75FC1n3ffIrhEj+ldbmxidzK0hPfYyXEZqDpHhkunmvD7qz1BEWKE7NUYVFREfopViflKiVZcYrHi7CJAeBNY7dygvmIMnHUeH4NtDS5qf/n9DQQffVyn5hJWi5PeB87nTlty8zdji2tj7nA2+Y3PLKRJU3y1IbchqGlnXqxaaKfkTLNsiZq9PTwKaryH+um3tXf5u4mulzRGOWh2U+Uk4LntmMFCb/LqJkWnUVe+wIDAQABo4IBsjCCAa4wHwYDVR0jBBgwFoAUFTiDDz8sP3AzHs1G/geMIODXw7cwEgYDVR0TAQH/BAgwBgEB/wIBADA5BgNVHSAEMjAwMC4GBWeBAwEBMCUwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMIIBCwYDVR0fBIIBAjCB/zA2oDSgMoYwaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL1Zpc2FDQWVDb21tZXJjZVJvb3QuY3JsMDygOqA4hjZodHRwOi8vd3d3LmludGwudmlzYWNhLmNvbS9jcmwvVmlzYUNBZUNvbW1lcmNlUm9vdC5jcmwwgYaggYOggYCGfmxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgUm9vdCxvPVZJU0Esb3U9VmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFN/DKlUuL0I6ekCdkqD3R3nXj4eKMA0GCSqGSIb3DQEBCwUAA4IBAQB9Y+F99thHAOhxZoQcT9CbConVCtbm3hWlf2nBJnuaQeoftdOKWtj0YOTj7PUaKOWfwcbZSHB63rMmLiVm7ZqIVndWxvBBRL1TcgbwagDnLgArQMKHnY2uGQfPjEMAkAnnWeYJfd+cRJVo6K3R4BbQGzFSHa2i2ar6/oXzINyaxAXdoG04Cz2P0Pm613hMCpjFyYilS/425he1Tk/vHsTnFwFlk9yY2L8VhBa6j40faaFu/6fin78Kopk96gHdAIN1tbA12NNmr7bQ1pUs0nKHhzQGoRXguYd7UYO9i2sNVC1C5A3F8dopwsv2QK2+33q05O2/4DgnF4m5us6RV94D',
    NULL, 'CVV_WITH_ATN', '241122334455434156565F4D5554555F414300', 'STRING_TIMESTAMP', 'ED11223344554B544F525F4D5554555F414311',
    'MIIDojCCAoqgAwIBAgIQE4Y1TR0/BvLB+WUF1ZAcYjANBgkqhkiG9w0BAQUFADBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwHhcNMDIwNjI2MDIxODM2WhcNMjIwNjI0MDAxNjEyWjBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvV95WHm6h2mCxlCfLF9sHP4CFT8icttD0b0/Pmdjh28JIXDqsOTPHH2qLJj0rNfVIsZHBAk4ElpF7sDPwsRROEW+1QK8bRaVK7362rPKgH1g/EkZgPI2h4H3PVz4zHvtH8aoVlwdVZqW1LS7YgFmypw23RuwhY/81q6UCzyr0TP579ZRdhE2o8mCP2w4lPJ9zcc+U30rq299yOIzzlr3xF7zSujtFWsan9sYXiwGd/BmoKoMWuDpI/k4+oKsGGelT84ATB+0tvz8KPFUgOSwsAGl0lUq8ILKpeeUYiZGo3BxN77t+Nwtd/jmliFKMAGzsGHxBvfaLdXe6YJ2E5/4tAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQVOIMPPyw/cDMezUb+B4wg4NfDtzANBgkqhkiG9w0BAQUFAAOCAQEAX/FBfXxcCLkr4NWSR/pnXKUTwwMhmytMiUbPWU3J/qVAtmPN3XEolWcRzCSs00Rsca4BIGsDoo8Ytyk6feUWYFN4PMCvFYP3j1IzJL1kk5fui/fbGKhtcbP3LBfQdCVp9/5rPJS+TUtBjE7ic9DjkCJzQ83z7+pzzkWKsKZJ/0x9nXGIxHYdkFsd7v3M9+79YKWxehZx0RbQfBI8bGmX265fOZpwLwU8GUYEmSA20GBuYQa7FkKMcPcw++DbZqMAAb3mLNqRX6BGi01qnD093QVG/na/oAo85ADmJ7f/hC3euiInlhBx6yLt398znM/jra6O1I7mT1GvFpLgXPYHDw==',
    NULL, 'MIIFUTCCBDmgAwIBAgIQNGkVAwj/6btPCxH1ZOokdjANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJVUzENMAsGA1',
    NULL, n.id, si.id
    FROM Network n, SubIssuer si
    WHERE n.code='VISA' AND si.fk_id_issuer = @issuerId;

/*!40000 ALTER TABLE `SubIssuerNetworkCrypto` ENABLE KEYS */;

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT 'InitPhase', NOW(), 'Comdirect profile set', NULL, NULL, CONCAT('PS_', si.name, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

-- create custom page layout for Comdirect

INSERT INTO CustomPageLayout (controller, pageType, description) VALUES
( NULL, 'REFUSAL_PAGE', 'Refusal Page (Comdirect)'),
( NULL, 'OTP_FORM_PAGE', 'OTP Form Page (Comdirect)'),
( NULL, 'MESSAGE_BANNER', 'Message Banner (Comdirect)'),
( NULL, 'FAILURE_PAGE', 'Failure Page (Comdirect)'),
( NULL, 'HELP_PAGE', 'Help Page (Comdirect)'),
( NULL, 'PHOTO_TAN_OTP_FORM_PAGE', 'OTP Phototan Form Page (Comdirect)'),
( NULL, 'I_TAN_OTP_FORM_PAGE', 'OTP Itan Form Page (Comdirect)');



INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
  from CustomPageLayout cpl, ProfileSet ps
    where cpl.description like '%Comdirect%' and ps.name like '%Comdirect%';
-- custom components

SET @idRefusalPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'REFUSAL_PAGE' and DESCRIPTION = 'Refusal Page (Comdirect)') ;
SET @idOtpFormPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'OTP_FORM_PAGE' and DESCRIPTION = 'OTP Form Page (Comdirect)') ;
SET @idMessageBanner=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MESSAGE_BANNER' and DESCRIPTION = 'Message Banner (Comdirect)') ;
SET @idFailurePage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'FAILURE_PAGE' and DESCRIPTION = 'Failure Page (Comdirect)') ;
SET @idHelpPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'HELP_PAGE' and DESCRIPTION = 'Help Page (Comdirect)') ;
SET @idPhototanOtpFormPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'PHOTO_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'OTP Phototan Form Page (Comdirect)') ;
SET @idItanOtpFormPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'I_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'OTP Itan Form Page (Comdirect)') ;


INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
 '

	<div id="main-container">

	<style type="text/css">


:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding:0px;
	margin:0px;
}

#main-container {
	width:480px;
	max-width:480px;
	margin-left:auto;
	margin-right:auto;
	padding-left:10px;
	padding-right:10px;
}

#main-container .btn {

		border-radius: 20px;
		border:0px;
		height:40px;
		margin-left:10px;
}



#main-container #header {
	height:64px;
	position:relative;
}

#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
	background-size:contain;
	height:25px;
	margin-left:5px;
	margin-top:1em;
}

#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width:100px;
	position:absolute;
	right:1px;
	top:5px;
	padding-right:1em;
}


#main-container #content {
	text-align:left;
	display:flex;
	flex-direction: column;
}

#main-container #content .transactiondetails {
	border-top:1px solid black;
	border-bottom: 1px solid black;
}

#main-container #content .transactiondetails ul {
	list-style-type: none;
	padding-left:0px;
}

#main-container #content .transactiondetails ul li {
	width:100%;
	text-align: left;
}

#main-container #content .transactiondetails ul li label {
	display:block;
	float:left;
	width:180px;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
}

#main-container #content .transactiondetails ul li span.value {
	clear:both;
	text-align: left;
	margin-left:0.5em;
}

#main-container #content div.autharea {
	display: flex;
	flex-direction: row;
}

 #main-container #footer {
	display: flex;
	width:100%;
	border-top: 1px solid #000;
	padding-top:10px;
	justify-content: space-between;
	background-image:none;
}

#main-container #cancelButton .btn-default{
		background-color:#f4f4f4;
		align-content: flex-start;

}

#main-container #validateButton .btn-default {
	background-color:#FFF500;
	align-content: flex-end;
}

	#validateButton {
		outline: 0px;
		border:0px;
		border-radius: 20px;
		height:40px;
		width:120px;
		background-color:#FFF500;
		margin-right:10px;
		align-content: flex-end;
	}

	#cancelButton {

		background-color:#f4f4f4;
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
		align-content: flex-start;
	}


.splashtext {
	width:80%;
	margin-left:auto;
	margin-right:auto;
}

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
padding: 7px 10px 5px;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

.spinner-container {
	display:block;
	width:100%;
}


#messageBanner {
	width:100%;
	border-radius: 10px;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	margin-bottom:10px;
	background-color:#F5F5F5;
	padding:10px;
	box-sizing:border-box;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

div#message-content {
	padding:10px;
}

.spinner {
	display:block;
	width:120px;
	height:120px;
	margin-left:auto;
	margin-right: auto;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	.autharea {
		display:flex;
		flex-direction: row;
		align-items: center;
		padding-top:10px;
		padding-bottom:10px;
	}

	#tan_input_ctrl {
		display:flex;
		flex-direction: row;
		align-items: center;
	}

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	#phototanImg {
		text-align:center;
		margin-top: 12px;
		margin-bottom: 12px;

	}

@media (max-width: 560px) {

	#main-container {
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}


	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
	</div>

	<div id="footer">

		<val-button id="validateButton"></val-button>
	</div>

</div>
  ', @idRefusalPage);

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '	<div id="main-container">

	<style type="text/css">


:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding:0px;
	margin:0px;
}

#main-container {
	width:480px;
	max-width:480px;
	margin-left:auto;
	margin-right:auto;
	padding-left:10px;
	padding-right:10px;
}

#main-container .btn {
	
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
}



#main-container #header {
	height:64px;
	position:relative;
}

#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
	background-size:contain;
	height:25px;
	margin-left:5px;
	margin-top:1em;
}

#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width:100px;
	position:absolute;
	right:1px;
	top:5px;
	padding-right:1em;
}

#main-container #content {
	text-align:left;
	display:flex;
	flex-direction: column;
}


#main-container #content div.autharea {
	display: flex;
	flex-direction: column;
}

display-challenge {
	margin:10px;	
}

 #main-container #footer {
	display: flex;
	width:100%;
	border-top: 1px solid #000;
	padding-top:10px;
	justify-content: space-between;
	background-image:none;
}

#main-container #cancelButton .btn-default{
		background-color:#f4f4f4;
		align-content: flex-start;

}

#main-container #validateButton .btn-default {
	background-color:#FFF500;
	align-content: flex-end;
}

	#validateButton {
		outline: 0px;
		border:0px;
		border-radius: 20px;
		height:40px;
		width:120px;
		background-color:#FFF500;
		margin-right:10px;
		align-content: flex-end;
	}

	#cancelButton {

		background-color:#f4f4f4;
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
		align-content: flex-start;
	}


.splashtext {
	width:80%;
	margin-left:auto;
	margin-right:auto;
}

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
padding: 7px 10px 5px;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

.spinner-container {
	display:block;
	width:100%;
}


#messageBanner {
	width:100%;
	border-radius: 10px;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	margin-bottom:10px;
	background-color:#F5F5F5;
	padding:10px;
	box-sizing:border-box;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

.spinner {
	display:block;
	width:120px;
	height:120px;
	margin-left:auto;
	margin-right: auto;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	.autharea {
		display:flex;
		flex-direction: row;
		align-items: center;
		padding-top:10px;
		padding-bottom:10px;
	}

	#tan_input_ctrl {
		display:flex;
		flex-direction: row;
		align-items: center;
	}

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	#phototanImg {
		text-align:center;
		margin-top: 12px;
		margin-bottom: 12px;

	}

@media (max-width: 560px) {

	#main-container {
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}

	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">

				<div id="tan_input_ctrl">
				  <custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph1"></custom-text>
				  <!-- output for photo tan -->
				  <external-image></external-image>
				  
					<div class="otp-field">
						<input type="text" size="10">
					</div>
				</div>

				<means-choice-menu></means-choice-menu>

		</div>
	</div>

	<div id="footer">
		<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
		<val-button val-label="" id="validateButton"></val-button>
	</div>

</div>
  ', @idPhototanOtpFormPage);

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '	<div id="main-container">

	<style type="text/css">


:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding:0px;
	margin:0px;
}

#main-container {
	width:480px;
	max-width:480px;
	margin-left:auto;
	margin-right:auto;
	padding-left:10px;
	padding-right:10px;
}

#main-container .btn {
	
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
}



#main-container #header {
	height:64px;
	position:relative;
}

#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
	background-size:contain;
	height:25px;
	margin-left:5px;
	margin-top:1em;
}

#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width:100px;
	position:absolute;
	right:1px;
	top:5px;
	padding-right:1em;
}

#main-container #content {
	text-align:left;
	display:flex;
	flex-direction: column;
}


#main-container #content div.autharea {
	display: flex;
	flex-direction: column;
}

display-challenge {
	margin:10px;	
}

 #main-container #footer {
	display: flex;
	width:100%;
	border-top: 1px solid #000;
	padding-top:10px;
	justify-content: space-between;
	background-image:none;
}

#main-container #cancelButton .btn-default{
		background-color:#f4f4f4;
		align-content: flex-start;

}

#main-container #validateButton .btn-default {
	background-color:#FFF500;
	align-content: flex-end;
}

	#validateButton {
		outline: 0px;
		border:0px;
		border-radius: 20px;
		height:40px;
		width:120px;
		background-color:#FFF500;
		margin-right:10px;
		align-content: flex-end;
	}

	#cancelButton {

		background-color:#f4f4f4;
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
		align-content: flex-start;
	}


.splashtext {
	width:80%;
	margin-left:auto;
	margin-right:auto;
}

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
padding: 7px 10px 5px;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

.spinner-container {
	display:block;
	width:100%;
}


#messageBanner {
	width:100%;
	border-radius: 10px;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	margin-bottom:10px;
	background-color:#F5F5F5;
	padding:10px;
	box-sizing:border-box;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

.spinner {
	display:block;
	width:120px;
	height:120px;
	margin-left:auto;
	margin-right: auto;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	.autharea {
		display:flex;
		flex-direction: row;
		align-items: center;
		padding-top:10px;
		padding-bottom:10px;
	}

	#tan_input_ctrl {
		display:flex;
		flex-direction: row;
		align-items: center;
	}

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	#phototanImg {
		text-align:center;
		margin-top: 12px;
		margin-bottom: 12px;

	}

@media (max-width: 560px) {

	#main-container {
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}

	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">

				<div id="tan_input_ctrl">

				  <!-- output for itan -->
				  <custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph1"></custom-text>
				  <custom-text custom-text-key="\'network_means_pageType_14\'"></custom-text>
				  
					<div class="otp-field">
						<input type="text" size="10">
					</div>
				</div>

				<means-choice-menu></means-choice-menu>

		</div>
	</div>

	<div id="footer">
		<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
		<val-button val-label="" id="validateButton"></val-button>
	</div>

</div>
  ', @idItanOtpFormPage);

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '	<div id="main-container">

	<style type="text/css">


:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding:0px;
	margin:0px;
}

#main-container {
	width:480px;
	max-width:480px;
	margin-left:auto;
	margin-right:auto;
	padding-left:10px;
	padding-right:10px;
}

#main-container .btn {
	
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
}



#main-container #header {
	height:64px;
	position:relative;
}

#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
	background-size:contain;
	height:25px;
	margin-left:5px;
	margin-top:1em;
}

#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width:100px;
	position:absolute;
	right:1px;
	top:5px;
	padding-right:1em;
}

#main-container #content {
	text-align:left;
	display:flex;
	flex-direction: column;
}


#main-container #content div.autharea {
	display: flex;
	flex-direction: column;
}

display-challenge {
	margin:10px;	
}

 #main-container #footer {
	display: flex;
	width:100%;
	border-top: 1px solid #000;
	padding-top:10px;
	justify-content: space-between;
	background-image:none;
}

#main-container #cancelButton .btn-default{
		background-color:#f4f4f4;
		align-content: flex-start;

}

#main-container #validateButton .btn-default {
	background-color:#FFF500;
	align-content: flex-end;
}

	#validateButton {
		outline: 0px;
		border:0px;
		border-radius: 20px;
		height:40px;
		width:120px;
		background-color:#FFF500;
		margin-right:10px;
		align-content: flex-end;
	}

	#cancelButton {

		background-color:#f4f4f4;
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
		align-content: flex-start;
	}


.splashtext {
	width:80%;
	margin-left:auto;
	margin-right:auto;
}

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
padding: 7px 10px 5px;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

.spinner-container {
	display:block;
	width:100%;
}


#messageBanner {
	width:100%;
	border-radius: 10px;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	margin-bottom:10px;
	background-color:#F5F5F5;
	padding:10px;
	box-sizing:border-box;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

.spinner {
	display:block;
	width:120px;
	height:120px;
	margin-left:auto;
	margin-right: auto;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	.autharea {
		display:flex;
		flex-direction: row;
		align-items: center;
		padding-top:10px;
		padding-bottom:10px;
	}

	#tan_input_ctrl {
		display:flex;
		flex-direction: row;
		align-items: center;
	}

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	#phototanImg {
		text-align:center;
		margin-top: 12px;
		margin-bottom: 12px;

	}

@media (max-width: 560px) {

	#main-container {
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}

	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">

				<div id="tan_input_ctrl">

				  <!-- output for itan -->

					<custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph1"></custom-text>
					<div class="otp-field">
						<input type="text" size="10">
					</div>
				</div>

				<means-choice-menu></means-choice-menu>

		</div>
	</div>

	<div id="footer">
		<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
		<val-button val-label="" id="validateButton"></val-button>
	</div>

</div>
  ', @idOtpFormPage);


INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '


  <span id="info-icon" class="col-xs-12 col-sm-1 fa fa-info-circle"></span>
  <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
  <custom-text id="message" custom-text-key="$parent.message"></custom-text>

  <style>
    span#info-icon {
        left: auto;
    }
    #headingTxt {
        font-size : large;
        font-weight : bold;
        width : 80%;
        margin : auto;
        display : block;
    }
  </style>

  ', @idMessageBanner);

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '

	<div id="main-container">

	<style type="text/css">


:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding:0px;
	margin:0px;
}

#main-container {
	width:480px;
	max-width:480px;
	margin-left:auto;
	margin-right:auto;
	padding-left:10px;
	padding-right:10px;
}

#main-container .btn {

		border-radius: 20px;
		border:0px;
		height:40px;
		margin-left:10px;
}



#main-container #header {
	height:64px;
	position:relative;
}

#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
	background-size:contain;
	height:25px;
	margin-left:5px;
	margin-top:1em;
}

#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width:100px;
	position:absolute;
	right:1px;
	top:5px;
	padding-right:1em;
}


#main-container #content {
	text-align:left;
	display:flex;
	flex-direction: column;
}

#main-container #content .transactiondetails {
	border-top:1px solid black;
	border-bottom: 1px solid black;
	padding-top:10px;
	padding-bottom:10px;
}


#main-container #content .transactiondetails h3 {
	margin-top:10px;
	margin-bottom:10px;
}

#main-container #content .transactiondetails ul {
	list-style-type: none;
	padding-left:0px;
}

#main-container #content .transactiondetails ul li {
	width:100%;
	text-align: left;
}

#main-container #content .transactiondetails ul li label {
	display:block;
	float:left;
	width:180px;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
}

#main-container #content .transactiondetails ul li span.value {
	clear:both;
	text-align: left;
	margin-left:0.5em;
}

#main-container #content div.autharea {
	display: flex;
	flex-direction: column;
}

 #main-container #footer {
	display: flex;
	width:100%;
	border-top: 1px solid #000;
	padding-top:10px;
	justify-content: space-between;
	background-image:none;
}

#main-container #cancelButton .btn-default{
		background-color:#f4f4f4;
		align-content: flex-start;

}

#main-container #validateButton .btn-default {
	background-color:#FFF500;
	align-content: flex-end;
}

	#validateButton {
		outline: 0px;
		border:0px;
		border-radius: 20px;
		height:40px;
		width:120px;
		background-color:#FFF500;
		margin-right:10px;
		align-content: flex-end;
	}

	#cancelButton {

		background-color:#f4f4f4;
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
		align-content: flex-start;
	}


.splashtext {
	width:80%;
	margin-left:auto;
	margin-right:auto;
}

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
padding: 7px 10px 5px;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

.spinner-container {
	display:block;
	width:100%;
}


#messageBanner {
	width:100%;
	border-radius: 10px;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	margin-bottom:10px;
	background-color:#F5F5F5;
	padding:10px;
	box-sizing:border-box;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

.spinner {
	display:block;
	width:120px;
	height:120px;
	margin-left:auto;
	margin-right: auto;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	.autharea {
		display:flex;
		flex-direction: row;
		align-items: center;
		padding-top:10px;
		padding-bottom:10px;
	}

	#tan_input_ctrl {
		display:flex;
		flex-direction: row;
		align-items: center;
	}

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	#phototanImg {
		text-align:center;
		margin-top: 12px;
		margin-bottom: 12px;

	}

@media (max-width: 560px) {

	#main-container {
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}


	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
	</div>

	<div id="footer">

		<val-button id="validateButton"></val-button>
	</div>

</div>
  ', @idFailurePage);

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '

	<div id="main-container">

	<style type="text/css">


:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding:0px;
	margin:0px;
}

#main-container {
	width:480px;
	max-width:480px;
	margin-left:auto;
	margin-right:auto;
	padding-left:10px;
	padding-right:10px;
}

#main-container .btn {

		border-radius: 20px;
		border:0px;
		height:40px;
		margin-left:10px;
}



#main-container #header {
	height:64px;
	position:relative;
}

#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
	background-size:contain;
	height:25px;
	margin-left:5px;
	margin-top:1em;
}

#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width:100px;
	position:absolute;
	right:1px;
	top:5px;
	padding-right:1em;
}


#main-container #content {
	text-align:left;
	display:flex;
	flex-direction: column;
}

#main-container #content .transactiondetails {
	border-top:1px solid black;
	border-bottom: 1px solid black;
	padding-top:10px;
	padding-bottom:10px;
}


#main-container #content .transactiondetails h3 {
	margin-top:10px;
	margin-bottom:10px;
}

#main-container #content .transactiondetails ul {
	list-style-type: none;
	padding-left:0px;
}

#main-container #content .transactiondetails ul li {
	width:100%;
	text-align: left;
}

#main-container #content .transactiondetails ul li label {
	display:block;
	float:left;
	width:180px;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
}

#main-container #content .transactiondetails ul li span.value {
	clear:both;
	text-align: left;
	margin-left:0.5em;
}


#main-container #content div.autharea {
	display: flex;
	flex-direction: row;
}

 #main-container #footer {
	display: flex;
	width:100%;
	border-top: 1px solid #000;
	padding-top:10px;
	justify-content: space-between;
	background-image:none;
}

#main-container #cancelButton .btn-default{
		background-color:#f4f4f4;
		align-content: flex-start;

}

#main-container #validateButton .btn-default {
	background-color:#FFF500;
	align-content: flex-end;
}

	#validateButton {
		outline: 0px;
		border:0px;
		border-radius: 20px;
		height:40px;
		width:120px;
		background-color:#FFF500;
		margin-right:10px;
		align-content: flex-end;
	}

	#cancelButton {

		background-color:#f4f4f4;
		border-radius: 20px;
		border:0px;
		height:40px;
		width:120px;
		margin-left:10px;
		align-content: flex-start;
	}


.splashtext {
	width:80%;
	margin-left:auto;
	margin-right:auto;
}

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
padding: 7px 10px 5px;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

.spinner-container {
	display:block;
	width:100%;
}


#messageBanner {
	width:100%;
	border-radius: 10px;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	margin-bottom:10px;
	background-color:#F5F5F5;
	padding:10px;
	box-sizing:border-box;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

.spinner {
	display:block;
	width:120px;
	height:120px;
	margin-left:auto;
	margin-right: auto;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	.autharea {
		display:flex;
		flex-direction: row;
		align-items: center;
		padding-top:10px;
		padding-bottom:10px;
	}

	#tan_input_ctrl {
		display:flex;
		flex-direction: row;
		align-items: center;
	}

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	#phototanImg {
		text-align:center;
		margin-top: 12px;
		margin-bottom: 12px;

	}

@media (max-width: 560px) {

	#main-container {
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}


	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>

			<custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph1"></custom-text>
		</div>
	</div>

	<div id="footer">

		<val-button id="validateButton"></val-button>
	</div>

</div>
  ', @idHelpPage);

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @subIssuerNameAndLabel, '_01'));
SET @VisaID = (SELECT `id` FROM `Network` WHERE `code` = 'Visa');


/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p
    WHERE cpl.DESCRIPTION in ('Refusal Page (Comdirect)', 'OTP Form Page (Comdirect)', 'Message Banner (Comdirect)', 'Failure Page (Comdirect)', 'Help Page (Comdirect)')
    AND p.id = @ProfileSet;

/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;

/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/



INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', 'A513048', NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(),
   '4263540000', 16, FALSE, NULL, '4263549999', FALSE, @ProfileSet, @VisaID, NULL);

/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4263540000' AND b.upperBound='4263549999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES ('InitPhase', NOW(), 'Comdirect_Logo', NULL, NULL, 'Comdirect_Logo', 'PUSHED_TO_CONFIG', 'iVBORw0KGgoAAAANSUhEUgAAAWYAAABDCAYAAAHYN5+xAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4ggQDAUqWOfIgAAADaZJREFUeNrtXcGSpKoSTSvma+oteudb+CIGv0z9MpmI24vbu1rc/h3forEvRZGQiaBo54mYmBlLBZPkkJlA0izLAqfDsixQsuL3thvvbbfkrOuvMwjWfPQEACMA+Cu9POBbMs0bNKH/u2jeoLEKein88+O9sX/z/d95fjJ/D2ulb1iFmzdo7AqulVkeXw/a15zfl3vbKasCE/aBa4U/P94bq7Lf6mSuj07laephV858cQxzQvM/vX/9CB9upA5gSbcQplXaHvXAK31vu+XedovdzMsD1v8PrpqE4BQ8EO4d1vIRvX5q4eaMPN3I4BLvZFnqejuDYN0P/4UwxYANLO7gAwAaAFRscLE7mTNwDIGBxb3WeNXDHe3s/6//9l2z/20Xuv7bZgff7+69vg+uyvbg6n0VlQ6NfsFKrzaAa384KqCJ7+050gsZTD6dvsbg0jTNqT7g3nYjxcg6YvxjG3kCuldpGj7NmuZY1lTLG7tveYBaHv+Or4V7Avm65z63jsNm6vB4tap5+yLsmGESuTY+WfaR6wiZv1BHxEt+oph7282r4WTdG7xmGVDj6sC6g9I/f//VsDTaJ6BVyJjja/87EmoYqdcxQWWAct/5+fHee8pVti9r7hsxX7dKW6kSjp1tAeceWG8+zbFNddumC2kn5hJQgg1cwzWnx+lqNoGvBw8/R7nap9EaANT6Yc0b9OsgBQCza2TbvFpCwFj0xxV2qgaGGtChE5ur53vbPV1fOXuNOH07sqcO0pwMv87sqBQeILM5K+Ko7AARcsYehQ3MIuTMlLVZyKVdbc47NgpFbXS1WXV8si6wgc9nJ1O8PKonGEBve5u2Wx0z8yxvbMS0LTYb6Q6k2Dt8121Xm+VmA8Dk2sAe+7i3fpsRwTU+W9pzfXa0bxWwtqdsmZiQ6d6Xd2JzJ9yyOXQxrTEGywmZI3EO5RGkjsU/EGdm9sUackXonHdOrvsdclJczXav36jciQR3MDdzKkipOd89IDQxEr+T74xQKxEl+jcYl0faswRXuMjAWCguQhJyjeaS+vx41yV6SKkGvEU00rYOyF0m0ZKgYj5TD3kRsifc6f24VeBOI8xn6xXUMGrA4lBZ6MJeD+No6FqwNgODcjU4Z8jTtkcz82e/KlDIlra+072vQermt5OdF4aENVm/9b7fC8aUe8z2TXynNs+6PK/dKSpPGaRZFYkn7wARsuAyCI59Z5wsOaHpP/r8vpomempCiHwldC+o3s+/bBBDcGnF9dHuBMRV9MLMgp9hMyfZNPGoZ+9bmWue9dqP1OeZ7/G+k/osJ1TjLn/OyVq+iG1s/hmzy82QHguuaupsIKEeOtfMYjZlZirP4A4bzLD/vDxwhUqcQvh+J7fTYkqdQ4EzKn1QkZnBZOVuaEutA1E+w73tbN1qiikzZbUL93lESV9Yw9r+nsSiWCcM3P+ioL46II3pZSEqi24EOqkZmb0I3mvvGk359q11z2ozY+vZtigyIOstjBkwZWLi9Z0j8/5ogwSWgvVQGTiKjP2Grb464tu3MnN2RgkpWMn1NCVxxpixtbptOMu3S2hOwLV3J6OkY21136rM0w72XtSsOQPL1dj4ezCpuy24JG6Unmr9mSkmAcOO5drAvo5Tmy3a72GOlarrxmVyExL92KUjBxca/ee//yPta2E6YU9x4khYb4oow0vMmRodKXl/JF5r7ylCv50YJXjx9DnxaK5p4amrr3xWdMYJEcZ0YXBTkGyNZmhfYzImEV7Y3TyrEUYbECVuYpMnBw7VOrBW1c5yOVRS39i+L6wdfAukRmQ9bbQjmY7RpwYbZAmo4DKQtRmCy0CYWSDMLBDUBjTOLLtM9gF3SvmnQ3aaCMTMEAhEmQWCPCbYmMVmFggOUl53coSs0MLMgpqwaUZUlFkgNrNA8KOUecv6Y3Oi15izLuuflOd+okNljoFTucouvRQUnc5OmTQh7NLWoX10hKWkOrYPz7fxlfNO36ZVDybq/kHi9v0neJZ/euWK7MlT5t7YN/RuRmDijvKemkmYsLT06V2UCaTQpEm2aAZxTbNaHjC6isBIVbDmcvXmzkjIl2G/UwM9NcCwPGCILXstmU+bEQ3AOoxO7HDzve2Cu60Z9ZgBWDKcQtGN246K/MX46Yr8JIQCh4qqhO+ea1FkJqYtIwd87R6ZAyMRtT11zo/6VVKRnTTkmNIOiUN/tFf76kHsgC/mDHK/Yiqyb2gvrvSRtR4zYfj3KbxivA/geYeNAoDsewNLTZq8KINh5JGiUJ5ne9+9ywNmSi4LTMGp5Yfud80mzMmpcfGQj12RA3D0ve16V1HdJDDU46NMR2kydMR8ZgY2zKYqGMaiK1vkMA12wFB6OD3CtNpwfMxu337bSxiIs8ZR8loVgqII/Umqmnx6FxbC2/PbbwcK5Hcm53OsRRP22lJfqq4puT0sJT58lMxuMzPytykQ1K7svwntpIwpMVxOmQ+yUUdRv+22feXhxB+hzDXh94nqqhNGRw0Af+ArRa2+vDIvD1A7O2tTRfL8cyLzCatrtYkRj3AA1QmVUGA5gYmKPF1RmXedyuQmDC+tCGdS2j3et2eE5xbzaJ0soIrSGynrJiKH9Piun+5U7jM6Vtiaix3IrZwyIwtGSCltAVkI5LmmKR9vnlMnMVWmnZQkB7yzqpS6IvdM1M5MXSed61BLbFWUa1NhCcexE5waqzNgay6WyLurMzHs4dY5HclWkgVeU9oeWVd9bzsI1NVW0GHDt2MKTVkbPd/bbo2iAJRcAmoUSm94PpZKNeW5oxU6+E01pbQlLOTB0tl6WZO5oGom+lGKIqsbcwjyGvpmYRFJoX22L1cxa1Zkp1E1nAAb6jondhCsHpvWcdxCQ5Cr0KFKNm9fCcAjQumxFXXm2T6mxGdQZLtxjMwotv1ESPp9mroGkq0/vYP5XLDDSUpbwWUgqQYEoswCQW0QM0MgEAjEyhAIBAJBCEmrmeW0E8FVwMwBJYovYCE1IiEWs0AgEFQGIWaBQCCoDJJlQCAQCAiw9tHYoa+pxLZfIWaBQCB4JeFDl6tJKEMgEAgqgxCzQCAQCDELBAKBIIRTxJhNCkXKQQQAVhrsHNmhrex2nJym2coPyAMYMvFhAuAlNmO2g12O3itTtzVBE6vn2k6/M5atGLJJTtPulJOSC4s1YcU4CORJt/bIhYtMyEX7Zo0p8m0kbckuvcEk4QT3qKJQCahA2atCTFxyKlQXkpwKlp0kiwBBDbDTEQWxDSaczSoUciz0fTqW+8ykdc0t0yyrFxLPxGbXizH5t5K997d//v4rSc+rspiRc7G3jz4EUi5VtoECAGXS+vYMUlI7N8GwPIpnI02VRWniqBEq93dipFyA8F50y6Q41ilJMUu1eYbBItZG5yXmwpZhX6Bsd5TkuHnz8iiaiTeUuDMX6WJWAvf98/KgezNMi/SprohVtKvFvZfX47m26idGyssWeTLDCWvuekpu+dIDRrUnfx9OzCZuyelsGsvq7CHc4JHxzLKp5ZJGdnO4RZ8r9kok+i1hCkpdU94/LI94DJppMZGsMnPwRXar9ChC5lp/DNILytMqd2QQ/Xxvu2CdEwZisjV+bztVc5z5UGJOIGUykcXuY5ZNturMKUNUEpmXRz5yZpC4BoDGdxpSqjzde5dH+DQljzuoA52IY9H1tU/s1AAGKbMJ//PjvSEOpMO97bwTccjxdtnaPaOOFNn5d/RyuSKknLnsiXskG8Wytsn5ih0/1zF2zOPkhJTz6l0y6TDiyEOGfnG5dj+MmLFThAPkqI8oewPBTIVk8dPAWeUgpJxxsNvp6He1cTC+ZLv/OkGHK3GIcPFzUJs3GHdY4SAEIqipvRQkxOs9B5az4spXlKUkMarHKhQS2oCdrLurgLSpJmFjyRHtLsQsENTqVQm2hQ8Okv90ZatXiPn8EMXEO66Qc91yncRzuRYxa+rIvTxgLBBnLop1HTURf0QVt8ETpxRk6KMpu/T2HDiu2u5HLpfjkNFQoOGpBJva6GRiPtugsxeYHU4s6/xyVWZCr2Zcst2zEPO97UbnT7QxuWRkNm1kAbNsdsMba5m8zEuoIo98ZBVHEbnuvs7eDBya0e6X2wuQTMz3tpvvbbeYXVmD8+f7txBJM/NFqOUBCzNEEALZRePskONudxZrOa/VfMVOejT5mX4871w/TghFxbimIH6XeGkSMTPzFswRS4Ybw5oNQc8+kl4eMJrflhChmg0rLHLGylwJ2ZTHIeVGKILUSRuGBaWOIJKTyrVPkOtC9YoNVyhzv22skUg0lmYV4ZrFlKUQz942KHOgyKCQOvmXrRJW3gZuWj8F/6aPDIZAsC3SCWWTyqS4kWIp80mEmWlMHX2g5kXlCqtnfG+7LUXPAHHDhJF346Wfxup3b7s5YJn3TJnMnvImSNyfkBrK4MZFo6Ny8wa9sSB1Zt1TsQm8gmW/yKF5g0ZIOZlEtLGiepHG+eVK9Wo+P957ptfEsXbHiEwOwS2xIUdGI7ISjFgkmUtJNCcznFW2zlh+Y/4IoWQkEotMSg6oGr7yMTQi16yYuEvxLILOVTcde48lD71nW2Q7WsoeeUqtK7TO3wuRazFrlLJ0TqzhOsDN2yBroIvIdbez9Sj1yt3GAWv7+3oKvyYTs0AgEAgqC2UIBAKBoBz+D3N3brclPOrGAAAAAElFTkSuQmCC');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_FRAUD_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_FRAUD_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
   ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_RBA_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_RBA_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
   ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_RBA_ACCEPT_Current'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_RBA_ACCEPT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_PHOTOTAN_1'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_PHOTOTAN_1'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_SMS_1'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_SMS_1'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_ITAN_1'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_ITAN_1'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_PHOTOTAN_2'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_PHOTOTAN_2'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_SMS_2'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_SMS_2'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_ITAN_2'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_ITAN_2'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), CONCAT('customitemset_', @subIssuerCode, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @subIssuerCode, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);

/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;

/* CustomItem */
/* Create custom items for default language and backup languages - in this example fr and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;

SET @idImageBank = (SELECT id FROM `Image` im WHERE im.name = 'Comdirect_Logo');
SET @idImageVisaScheme = (SELECT id FROM `Image` im WHERE im.name LIKE '%VISA_LOGO%');
SET @idVisaNetwork = (SELECT id FROM Network where code = 'VISA');
SET @codeVisaNetwork = (SELECT code FROM Network where code = 'VISA');

/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetFraudRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_FRAUD_REFUSAL'));
SET @customItemSetFraudRba = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_RBA_REFUSAL'));
SET @customItemSetAcceptRba = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_RBA_ACCEPT'));
SET @customItemSetDefaultRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_DEFAULT_REFUSAL'));
SET @customItemSetPhototan1 = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_PHOTOTAN_1'));
SET @customItemSetSMS1 = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_SMS_1'));
SET @customItemSetItan1 = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_ITAN_1'));
SET @customItemSetPhototan2 = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_PHOTOTAN_2'));
SET @customItemSetSMS2 = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_SMS_2'));
SET @customItemSetItan2 = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_ITAN_2'));

-- fraud refusal profile
SET @currentCustomItemSet = @customItemSetFraudRefusal;

-- bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

-- scheme logos


/* Elements for the refusal page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_', @currentPageType,'_180_de'), 'PUSHED_TO_CONFIG',
         'de', 180, @currentPageType, 'Titre de page (@network)', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_200_fr'), 'PUSHED_TO_CONFIG',
           'de', 200, 'REFUSAL_PAGE', 'Texte à l\'ordinal 200 sur page de refus pour le moyen d\'authentification OTP_SMS et le réseau @network',
           @idVisaNetwork, NULL, @currentCustomItemSet);

-- GUI elements
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_1_de'), 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet);

-- help and cancel button
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_41_de'), 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet);


-- Message banner
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES


-- authentication failure
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_16_de'), 'PUSHED_TO_CONFIG',
       'de', 16, 'REFUSAL_PAGE', 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_17_de'), 'PUSHED_TO_CONFIG',
       'de', 17, 'REFUSAL_PAGE', 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem Comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106-708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- transaction refusal
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_PAGE_22_de'), 'PUSHED_TO_CONFIG',
       'de', 22, 'REFUSAL_PAGE', 'Die Zahlung ist nicht möglich', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_23_de'), 'PUSHED_TO_CONFIG',
       'de', 23, 'REFUSAL_PAGE', 'Die Zahlung konnte nicht durchgeführt werden. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_32_de'), 'PUSHED_TO_CONFIG',
       'de', 32, 'REFUSAL_PAGE', 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_33_de'), 'PUSHED_TO_CONFIG',
       'de', 33, 'REFUSAL_PAGE', 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'DEFAULT_REFUSAL_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet);

-- placeholder ? for RBA Accept

-- fraud refusal profile
SET @currentCustomItemSet = @customItemSetAcceptRba;

-- bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

-- scheme logos


/* Elements for the refusal page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_', @currentPageType,'_180_de'), 'PUSHED_TO_CONFIG',
         'de', 180, @currentPageType, 'Titre de page (@network)', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_200_fr'), 'PUSHED_TO_CONFIG',
           'de', 200, 'REFUSAL_PAGE', 'Texte à l\'ordinal 200 sur page de refus pour le moyen d\'authentification OTP_SMS et le réseau @network',
           @idVisaNetwork, NULL, @currentCustomItemSet);

-- GUI elements
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_1_de'), 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet);

-- help and cancel button
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_41_de'), 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet);

-- refusal rba
SET @currentCustomItemSet = @customItemSetFraudRba;

-- bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

-- scheme logos


/* Elements for the refusal page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_', @currentPageType,'_180_de'), 'PUSHED_TO_CONFIG',
         'de', 180, @currentPageType, 'Titre de page (@network)', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_200_fr'), 'PUSHED_TO_CONFIG',
           'de', 200, 'REFUSAL_PAGE', 'Texte à l\'ordinal 200 sur page de refus pour le moyen d\'authentification OTP_SMS et le réseau @network',
           @idVisaNetwork, NULL, @currentCustomItemSet);

-- GUI elements
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_1_de'), 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet);

-- help and cancel button
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_41_de'), 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet);


-- Message banner
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES


-- authentication failure
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_16_de'), 'PUSHED_TO_CONFIG',
       'de', 16, 'REFUSAL_PAGE', 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_17_de'), 'PUSHED_TO_CONFIG',
       'de', 17, 'REFUSAL_PAGE', 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem Comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106-708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- transaction refusal
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_PAGE_22_de'), 'PUSHED_TO_CONFIG',
       'de', 22, 'REFUSAL_PAGE', 'Die Zahlung ist nicht möglich', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_23_de'), 'PUSHED_TO_CONFIG',
       'de', 23, 'REFUSAL_PAGE', 'Die Zahlung konnte nicht durchgeführt werden. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_32_de'), 'PUSHED_TO_CONFIG',
       'de', 32, 'REFUSAL_PAGE', 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_33_de'), 'PUSHED_TO_CONFIG',
       'de', 33, 'REFUSAL_PAGE', 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'DEFAULT_REFUSAL_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet);



-- default refusal profile

SET @currentCustomItemSet = @customItemSetDefaultRefusal;

-- bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet1),
       ('I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 170, 'ALL', 'Random Bank™', NULL, @idImageBank, @currentCustomItemSet1),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet1),
      ('I', 'InitPhase', NOW(), 'Visa Logo English', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet1);
-- scheme logos


/* Elements for the refusal page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_', @currentPageType,'_180_de'), 'PUSHED_TO_CONFIG',
         'de', 180, @currentPageType, 'Titre de page (@network)', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_200_fr'), 'PUSHED_TO_CONFIG',
           'de', 200, 'REFUSAL_PAGE', 'Texte à l\'ordinal 200 sur page de refus pour le moyen d\'authentification OTP_SMS et le réseau @network',
           @idVisaNetwork, NULL, @currentCustomItemSet);

-- GUI elements
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_1_de'), 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet);

-- help and cancel button
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_41_de'), 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet);

-- Message banner
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES


-- authentication failure
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_16_de'), 'PUSHED_TO_CONFIG',
       'de', 16, 'REFUSAL_PAGE', 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_REFUSAL_PAGE_17_de'), 'PUSHED_TO_CONFIG',
       'de', 17, 'REFUSAL_PAGE', 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem Comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106-708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- transaction refusal
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'DEFAULT_REFUSAL_PAGE_22_de'), 'PUSHED_TO_CONFIG',
       'de', 22, 'REFUSAL_PAGE', 'Die Zahlung ist nicht möglich', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_23_de'), 'PUSHED_TO_CONFIG',
       'de', 23, 'REFUSAL_PAGE', 'Die Zahlung konnte nicht durchgeführt werden. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_32_de'), 'PUSHED_TO_CONFIG',
       'de', 32, 'REFUSAL_PAGE', 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_33_de'), 'PUSHED_TO_CONFIG',
       'de', 33, 'REFUSAL_PAGE', 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'DEFAULT_REFUSAL_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet);

-- custom item set photoTAN1

SET @currentCustomItemSet = @customItemSetPhototan1;

SET @currentPageType = 'OTP_FORM_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_OTP_FORM_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_OTP_FORM_PAGE_2', 'PUSHED_TO_CONFIG',
       'de', 2, @currentPageType, 'Freigabe durch photoTAN:', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 3, @currentPageType, 'Verfahren wechseln', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_OTP_FORM_PAGE_40', 'PUSHED_TO_CONFIG',
       'de', 40, @currentPageType, 'Abbrechen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_OTP_FORM_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

-- authentication in progress
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 12, @currentPageType, 'Authentifizierung läuft', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um ihre Eingabe zu überprüfen.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- bad otp

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 28, @currentPageType, 'Ungültige photoTAN', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 29, @currentPageType, 'Sie haben eine ungültige photoTAN eingegeben. Nach der dritten falschen Eingabe in Folge wird ihr Konto aus Sicherheitsgründen gesperrt. Bitte lesen Sie die neue photoTAN-Grafik ein.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);



SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_FAILURE_PAGE_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_FAILURE_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 16, @currentPageType, 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein tech nischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_1_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
       'en', 1, @currentPageType, 'Help 1', @idVisaNetwork, NULL, @currentCustomItemSet);

-- custom item set sms1

SET @currentCustomItemSet = @customItemSetSMS1;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

SET @currentPageType = 'OTP_FORM_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_2', 'PUSHED_TO_CONFIG',
       'de', 2, @currentPageType, 'Freigabe durch mTAN:', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 3, @currentPageType, 'Verfahren wechseln', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_40', 'PUSHED_TO_CONFIG',
       'de', 40, @currentPageType, 'Abbrechen', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

-- authentication in progress
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 12, @currentPageType, 'Authentifizierung läuft', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um ihre Eingabe zu überprüfen.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- bad otp

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 28, @currentPageType, 'Ungültige mobileTAN', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 29, @currentPageType, 'Sie haben eine ungültige mobileTAN eingegeben. Nach der dritten falschen TAN Eingabe in Folge wird ihr Konto aus Sicherheitsgründen gesperrt. Bitte geben Sie die ihnen zugesandte mobileTAN erneut ein.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);


SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_FAILURE_PAGE_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, '', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_FAILURE_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 16, @currentPageType, 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
       'en', 1, @currentPageType, 'Help 1', @idVisaNetwork, NULL, @currentCustomItemSet);

-- custom item set itan 1

SET @currentCustomItemSet = @customItemSetItan1;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

SET @currentPageType = 'OTP_FORM_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_2', 'PUSHED_TO_CONFIG',
       'de', 2, @currentPageType, 'Freigabe durch iTAN:', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 3, @currentPageType, 'Verfahren wechseln', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_14', 'PUSHED_TO_CONFIG',
       'de', 14, @currentPageType, '@challenge1', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_40', 'PUSHED_TO_CONFIG',
       'de', 40, @currentPageType, 'Abbrechen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

-- authentication in progress
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 12, @currentPageType, 'Authentifizierung läuft', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um ihre Eingabe zu überprüfen.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- bad otp

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 28, @currentPageType, 'Ungültige iTAN', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 29, @currentPageType, 'Sie haben eine ungültige iTAN eingegeben. Die angeforderte iTAN mit der lfd. Nummer wurde entwertet. Nach der dritten falschen iTAN-Eingabe in Folge wird ihr Konto aus Sicherheitsgründen gesperrt.', @idVisaNetwork, NULL, @currentCustomItemSet),
-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);


SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_FAILURE_PAGE_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, '', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_FAILURE_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 16, @currentPageType, 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
       'en', 1, @currentPageType, 'Help 1', @idVisaNetwork, NULL, @currentCustomItemSet);

-- custom item set phototan 2

SET @currentCustomItemSet = @customItemSetPhototan2;

SET @currentPageType = 'OTP_FORM_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_OTP_FORM_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_OTP_FORM_PAGE_2', 'PUSHED_TO_CONFIG',
       'de', 2, @currentPageType, 'Freigabe durch photoTAN:', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 3, @currentPageType, 'Verfahren wechseln', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_OTP_FORM_PAGE_40', 'PUSHED_TO_CONFIG',
       'de', 40, @currentPageType, 'Abbrechen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_OTP_FORM_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

-- authentication in progress
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 12, @currentPageType, 'Authentifizierung läuft', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um ihre Eingabe zu überprüfen.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- bad otp

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 28, @currentPageType, 'Ungültige photoTAN', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 29, @currentPageType, 'Sie haben eine ungültige photoTAN eingegeben. Nach der dritten falschen Eingabe in Folge wird ihr Konto aus Sicherheitsgründen gesperrt. Bitte lesen Sie die neue photoTAN-Grafik ein.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);


SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_FAILURE_PAGE_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, '', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_FAILURE_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 16, @currentPageType, 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_PHOTOTAN_2_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'PHOTOTAN_2_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
       'en', 1, @currentPageType, 'Help 1', @idVisaNetwork, NULL, @currentCustomItemSet);

-- custom item set sms 2

SET @currentCustomItemSet = @customItemSetSMS2;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);


SET @currentPageType = 'OTP_FORM_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_2', 'PUSHED_TO_CONFIG',
       'de', 2, @currentPageType, 'Freigabe durch photoTAN:', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 3, @currentPageType, 'Verfahren wechseln', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_40', 'PUSHED_TO_CONFIG',
       'de', 40, @currentPageType, 'Abbrechen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_OTP_FORM_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

-- authentication in progress
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 12, @currentPageType, 'Authentifizierung läuft', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um ihre Eingabe zu überprüfen.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- bad otp

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 28, @currentPageType, 'Ungültige mobileTAN', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 29, @currentPageType, 'Sie haben eine ungültige mobileTAN eingegeben. Nach der dritten falschen TAN Eingabe in Folge wird ihr Konto aus Sicherheitsgründen gesperrt. Bitte geben Sie die ihnen zugesandte mobileTAN erneut ein.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);


SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_FAILURE_PAGE_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, '', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_FAILURE_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_REFUSAL_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 16, @currentPageType, 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_REFUSAL_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_REFUSAL_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_REFUSAL_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_REFUSAL_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_SMS_1_REFUSAL_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'SMS_1_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
       'en', 1, @currentPageType, 'Help 1', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentCustomItemSet = @customItemSetItan2;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ( 'I', 'InitPhase', NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', 'PUSHED_TO_CONFIG',
         'de', 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @currentCustomItemSet),
       ('I', 'InitPhase', NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'de', 171, 'ALL', 'Verified by Visa™', @idVisaNetwork, @idImageVisaScheme, @currentCustomItemSet);

SET @currentPageType = 'OTP_FORM_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_2', 'PUSHED_TO_CONFIG',
       'de', 2, @currentPageType, 'Freigabe durch photoTAN:', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 3, @currentPageType, 'Verfahren wechseln', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_3', 'PUSHED_TO_CONFIG',
       'de', 14, @currentPageType, '@challenge1', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_40', 'PUSHED_TO_CONFIG',
       'de', 40, @currentPageType, 'Abbrechen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_OTP_FORM_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

-- authentication in progress
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 12, @currentPageType, 'Authentifizierung läuft', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um ihre Eingabe zu überprüfen.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- bad otp

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 28, @currentPageType, 'Ungültige iTAN', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_<CustomSet>_<PageType>_', 'PUSHED_TO_CONFIG',
       'de', 29, @currentPageType, 'Sie haben eine ungültige iTAN eingegeben. Die angeforderte iTAN mit der lfd. Nummer wurde entwertet. Nach der dritten falschen iTAN-Eingabe in Folge wird ihr Konto aus Sicherheitsgründen gesperrt.', @idVisaNetwork, NULL, @currentCustomItemSet),
-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_OTP_FORM_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);


SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_FAILURE_PAGE_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, '', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_FAILURE_PAGE_41', 'PUSHED_TO_CONFIG',
       'de', 41, @currentPageType, 'Hilfe', @idVisaNetwork, NULL, @currentCustomItemSet),

-- message banner

('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 16, @currentPageType, 'Der Zugang wurde gesperrt', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Verified by Visa und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00', @idVisaNetwork, NULL, @currentCustomItemSet),

-- Session expired
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 30, @currentPageType, 'Die Session ist abgelaufen', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet),

-- technical error
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 32, @currentPageType, 'Technischer Fehler', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'MESSAGE_BANNER_ITAN_1_FAILURE_PAGE_', 'PUSHED_TO_CONFIG',
       'de', 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 - 708 25 00.', @idVisaNetwork, NULL, @currentCustomItemSet);

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', 'InitPhase', NOW(), NULL, NULL, NULL, 'ITAN_1_HELP_PAGE_1', 'PUSHED_TO_CONFIG',
       'de', 1, @currentPageType, 'Hilfe 1 ', @idVisaNetwork, NULL, @currentCustomItemSet),
('T', 'InitPhase', NOW(), NULL, NULL, NULL, CONCAT(@codeVisaNetwork,'_OTP_SMS_REFUSAL_PAGE_1_en'), 'PUSHED_TO_CONFIG',
       'en', 1, @currentPageType, 'Help 1', @idVisaNetwork, NULL, @currentCustomItemSet);


/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);


INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  ('InitPhase', NOW(), 'Authentication Refusal', NULL, NULL, '16600_COMDIRECT_FRAUD_REFUSAL', 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetFraudRefusal, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication RBA Accept', NULL, NULL, '16600_COMDIRECT_RBA_ACCEPT', 'PUSHED_TO_CONFIG', -1, @authMeanAccept, @customItemSetAcceptRba, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication RBA Refusal', NULL, NULL, '16600_COMDIRECT_RBA_REFUSAL', 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetFraudRba, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication Phototan 01', NULL, NULL, '16600_COMDIRECT_PHOTOTAN_01', 'PUSHED_TO_CONFIG', 3, @authMeanOTPPhototan, @customItemSetPhototan1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication SMS 01', NULL, NULL, '16600_COMDIRECT_SMS_01', 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication ITAN 01', NULL, NULL, '16600_COMDIRECT_ITAN_01', 'PUSHED_TO_CONFIG', 3, @authMeanITan, @customItemSetItan1, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication Phototan 02', NULL, NULL, '16600_COMDIRECT_PHOTOTAN_02', 'PUSHED_TO_CONFIG', 3, @authMeanOTPPhototan, @customItemSetPhototan2, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication SMS 02', NULL, NULL, '16600_COMDIRECT_SMS_02', 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS2, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication ITAN 02', NULL, NULL, '16600_COMDIRECT_ITAN_02', 'PUSHED_TO_CONFIG', 3, @authMeanITan, @customItemSetItan2, NULL, NULL, @subIssuerID),
  ('InitPhase', NOW(), 'Authentication Fraud Refusal', NULL, NULL, '16600_COMDIRECT_DEFAULT_REFUSAL', 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetDefaultRefusal, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_FRAUD_REFUSAL');
SET @profileRbaAccept = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_RBA_ACCEPT');
SET @profileRbaRefusal = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_RBA_REFUSAL');
SET @profilePhototan1 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_PHOTOTAN_01');
SET @profileSMS1 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_SMS_01');
SET @profileITAN1 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_ITAN_01');
SET @profilePhototan2 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_PHOTOTAN_02');
SET @profileSMS2 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_SMS_02');
SET @profileITAN2 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_ITAN_02');


INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  ('InitPhase', NOW(), 'COMDIRECT 1', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  ('InitPhase', NOW(), 'COMDIRECT 2', NULL, NULL, 'RBA (ACCEPT)', 'PUSHED_TO_CONFIG', 2, @profileRbaAccept),
  ('InitPhase', NOW(), 'COMDIRECT 3', NULL, NULL, 'RBA (REFUSAL)', 'PUSHED_TO_CONFIG', 3, @profileRbaRefusal),
  ('InitPhase', NOW(), 'COMDIRECT 4', NULL, NULL, 'PHOTO_TAN AVAILABLE', 'PUSHED_TO_CONFIG', 4, @profilePhototan1),
  ('InitPhase', NOW(), 'COMDIRECT 5', NULL, NULL, 'OTP SMS AVAILABLE', 'PUSHED_TO_CONFIG', 5, @profileSMS1),
  ('InitPhase', NOW(), 'COMDIRECT 6', NULL, NULL, 'OTP ITAN AVAILABLE', 'PUSHED_TO_CONFIG', 6, @profileITAN1),
  ('InitPhase', NOW(), 'COMDIRECT 7', NULL, NULL, 'OTP_CHOICE SMS DEMANDED', 'PUSHED_TO_CONFIG', 7, @profilePhototan1),
  ('InitPhase', NOW(), 'COMDIRECT 8', NULL, NULL, 'OTP_CHOICE_ITAN_DEMANDED', 'PUSHED_TO_CONFIG', 8, @profilePhototan1),
  ('InitPhase', NOW(), 'COMDIRECT 9', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 9, @profileSMS1),
  ('InitPhase', NOW(), 'COMDIRECT 10', NULL, NULL, 'OTP_CHOICE_ITAN_DEMANDED', 'PUSHED_TO_CONFIG', 10, @profileSMS1),
  ('InitPhase', NOW(), 'COMDIRECT 11', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 11, @profileSMS1),
  ('InitPhase', NOW(), 'COMDIRECT 12', NULL, NULL, 'OTP_CHOICE_SMS_DEMANDED', 'PUSHED_TO_CONFIG', 12, @profileITAN1),
  ('InitPhase', NOW(), 'COMDIRECT 13', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 13, @profilePhototan1),
  ('InitPhase', NOW(), 'COMDIRECT 14', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 14, @profilePhototan1),
  ('InitPhase', NOW(), 'COMDIRECT 15', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 15, @profileSMS1),
  ('InitPhase', NOW(), 'COMDIRECT 16', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 16, @profileSMS1),
  ('InitPhase', NOW(), 'COMDIRECT 17', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 17, @profileITAN1),
  ('InitPhase', NOW(), 'COMDIRECT 18', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 18, @profileITAN1),
  ('InitPhase', NOW(), 'COMDIRECT 19', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 19, @profilePhototan2),
  ('InitPhase', NOW(), 'COMDIRECT 20', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 20, @profilePhototan2),
  ('InitPhase', NOW(), 'COMDIRECT 21', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 21, @profileSMS2),
  ('InitPhase', NOW(), 'COMDIRECT 22', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 22, @profileSMS2),
  ('InitPhase', NOW(), 'COMDIRECT 23', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 23, @profileITAN2),
  ('InitPhase', NOW(), 'COMDIRECT 24', NULL, NULL, 'OTP_CHOICE_PHOTOTAN_DEMANDED', 'PUSHED_TO_CONFIG', 24, @profileITAN2),
  ('InitPhase', NOW(), 'COMDIRECT REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 25, @profileRefusal)
;
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
-- Comdirect 1

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 1');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_1', 'PUSHED_TO_CONFIG', @currentRule),
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C2_COMDIRECT_1', 'PUSHED_TO_CONFIG', @currentRule);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_1' AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C2_COMDIRECT_1' AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

-- Comdirect 2

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 2');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_2', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_2' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_2' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);


-- Comdirect 3

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 3');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_3', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_3' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_3' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=FALSE);

-- Comdirect 4

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 4');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_4', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_4'
    AND mps.`fk_id_authentMean` = @authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_4'
  AND mps.`fk_id_authentMean`= @authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_4'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_4' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_4' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

-- Comdirect 5

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 5');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_5', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_5'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_5'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_5' AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_5'
  AND mps.`fk_id_authentMean`=@authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_5' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_5' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

-- Comdirect 6

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 6');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_6', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_6'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_6'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_6'
  AND mps.`fk_id_authentMean`=@authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_6' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_6' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

-- Comdirect 7

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 7');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_7', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_7'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_7'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_7'
  AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_7' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_7' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_7'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 8

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 8');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_8', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_8'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_8'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_8'
  AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_8' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_8' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_8'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 9

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 9');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_9', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_9'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_9'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_9'
  AND mps.`fk_id_authentMean`=@authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_9' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_9' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_9'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 10

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 10');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_10', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_10'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_10'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_10'
  AND mps.`fk_id_authentMean`=@authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_10' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_10' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_10'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 11

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 11');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_11', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_11'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_11'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_11'
  AND mps.`fk_id_authentMean`=@authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_11' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_11' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_11'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 12

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 12');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_12', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_12'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_12'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_12'
  AND mps.`fk_id_authentMean`=@authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_12' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_12' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_12'
  AND mps.`fk_id_authentMean`=@authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 13

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 13');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_13', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_13'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_13'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_13'
  AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_13' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_13' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_13'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 14

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 14');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_14', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_14'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_14'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_14'
  AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_14' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_14' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_14'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 15

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 15');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_15', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_15'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_15'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_15'
  AND mps.`fk_id_authentMean`=@authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_15' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_15' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_15'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 16

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 16');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_16', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_16'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_16'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_16'
  AND mps.`fk_id_authentMean`=@authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_16' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_16' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_16'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 17

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 17');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_17', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_17'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_17'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_17'
  AND mps.`fk_id_authentMean`=@authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_17' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_17' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_17'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 18

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 18');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_18', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_18'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_18'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_18'
  AND mps.`fk_id_authentMean`=@authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_18' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_18' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_18'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 19

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 19');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_19', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_19'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_19'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_19'
  AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_19' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_19' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_19'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 20

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 20');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_20', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_20'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_20'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_20'
  AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_20' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_20' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_20'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 21

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 21');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_21', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_21'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_21'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_21'
  AND mps.`fk_id_authentMean`= @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_21' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_21' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_21'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);

-- Comdirect 22

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 22');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_22', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_22'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_22'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_22'
  AND mps.`fk_id_authentMean`= @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_22' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_22' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_22'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 23

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 23');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_23', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_23'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_23'
    AND mps.`fk_id_authentMean`=@authMeanITan
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_23'
  AND mps.`fk_id_authentMean`= @authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_23' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_23' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_23'
    AND mps.`fk_id_authentMean`=@authMeanOTPPhototan
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 24

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 24');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_24', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_24'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_24'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`='C1_COMDIRECT_24'
  AND mps.`fk_id_authentMean`= @authMeanITan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_24' AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT_24' AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_24'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed`=FALSE);


-- Comdirect 25

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT 25');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT_25', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`='C1_COMDIRECT_25'
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

-- Default Refusal

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT REFUSAL_DEFAULT');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
  ('InitPhase', NOW(), NULL, NULL, NULL, 'C1_COMDIRECT REFUSAL_DEFAULT', 'PUSHED_TO_CONFIG', @currentRule);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`='C1_COMDIRECT REFUSAL_DEFAULT' AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);

/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;

SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = '00012_REFUSAL_01');
SET @profilePhototan1 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_PHOTOTAN_01');
SET @profileSMS1 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_SMS_01');
SET @profileITAN1 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_ITAN_01');
SET @profilePhototan2 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_PHOTOTAN_02');
SET @profileSMS2 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_SMS_02');
SET @profileITAN2 = (SELECT id FROM `Profile` WHERE `name` = '16600_COMDIRECT_ITAN_02');

SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleIVRnormal = (SELECT id FROM `Rule` WHERE `description`='IVR_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileIVR);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = 'PS_Comdirect_01' AND r.`id` IN
        (SELECT id FROM Rule r where r.DESCRIPTION in ('COMDIRECT 1',
                                                'COMDIRECT 2',
                                                'COMDIRECT 3',
                                                'COMDIRECT 4',
                                                'COMDIRECT 5',
                                                'COMDIRECT 6',
                                                'COMDIRECT 7',
                                                'COMDIRECT 8',
                                                'COMDIRECT 9',
                                                'COMDIRECT 10',
                                                'COMDIRECT 11',
                                                'COMDIRECT 12',
                                                'COMDIRECT 13',
                                                'COMDIRECT 14',
                                                'COMDIRECT 15',
                                                'COMDIRECT 16',
                                                'COMDIRECT 17',
                                                'COMDIRECT 18',
                                                'COMDIRECT 19',
                                                'COMDIRECT 20',
                                                'COMDIRECT 21',
                                                'COMDIRECT 22',
                                                'COMDIRECT 23',
                                                'COMDIRECT 24',
                                                'COMDIRECT 25',
                                                'COMDIRECT REFUSAL_DEFAULT'));

/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
SET @issuerId = (SELECT id FROM `Issuer` WHERE `code` = '00002');
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, NULL);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

COMMIT;