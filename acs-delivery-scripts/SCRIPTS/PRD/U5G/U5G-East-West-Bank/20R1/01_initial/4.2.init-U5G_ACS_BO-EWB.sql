/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

/* Issuer
   At first, the different authentication means need to be activated, so 'validate' is set to 'true'.
*/
/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @activatedAuthMeans = '[{"authentMeans" : "OTP_SMS","validate" : true}, {"authentMeans":"REFUSAL", "validate":true}]';
SET @availableAuthMeans = 'OTP_SMS|REFUSAL';
SET @issuerNameAndLabel = 'East West Bank';
SET @issuerCode = '00062';
SET @createdBy ='A699391';

INSERT INTO `Issuer` (`code`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                      `updateState`, `label`, `authentMeans`, `availaibleAuthentMeans`) VALUES
  (@issuerCode, @createdBy, NOW(), NULL, NULL, NULL, @issuerNameAndLabel, 'PUSHED_TO_CONFIG', @issuerNameAndLabel,
    @activatedAuthMeans, @availableAuthMeans);
/*!40000 ALTER TABLE `Issuer` ENABLE KEYS */;

/* SubIssuer */
/*!40000 ALTER TABLE `SubIssuer` DISABLE KEYS */;
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerNameAndLabel = 'East West Bank';
SET @subIssuerCode = '00062';
/* @backUpLanguage corresponds to a (comma separated) list of locales that should be displayed to the user,
   and @defaultLanguage a default locale which should be selected by default. */
SET @backUpLanguages = '';
SET @defaultLanguage = 'en';
/* Provides option to call the authentication HUB at PA or VE step */
SET @HUBcallMode = 'VE_AND_PA_MODE';
/* Correspond to URL to configure for the BinRanges extraction */
SET @acsURLVEMastercard = 'https://ssl-liv-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-liv-u5g-fo-acs-ve.wlp-acs.com/acs-ve-service/ve/veRequest';
/* Corresponds to the authentication mean to use primarily */
SET @preferredAuthMean = 'OTP_SMS';
/* See en_countrycode.json, 250 is France's country code. It is important in order to know if the transaction
   was initiated from an IP from the same location as the ACS (local purchase) */
SET @issuerCountryCode = '250';
SET @maskParam = '*,6,4';
SET @dateFormat = 'DD.MM.YYYY HH.mm';

INSERT INTO `SubIssuer` (`acsId`, `authenticationTimeOut`, `backupLanguages`, `code`, `codeSvi`, `currencyCode`,
                         `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
                         `defaultLanguage`, `freshnessPeriod`, `label`, `manageBackupsCombinedAmounts`, `manageChoicesCombinedAmounts`,
                         `otpExcluded`, `otpAllowed`, `personnalDataStorage`, `resetBackupsIfSuccess`, `resetChoicesIfSuccess`,
                         `transactionTimeOut`, `acs_URL1_VE_MC`, `acs_URL2_VE_MC`, `acs_URL1_VE_VISA`, `acs_URL2_VE_VISA`,
                         `automaticDeviceSelection`, `userChoiceAllowed`, `backupAllowed`, `defaultDeviceChoice`, `preferredAuthentMeans`,
                         `issuerCountry`, `hubCallMode`, `fk_id_issuer`, `maskParams`, `dateFormat`) VALUES
  ('ACS_U5G', 300, @backUpLanguages, @subIssuerCode, @subIssuerCode, '978', @createdBy, NOW(), NULL, NULL, NULL, @subIssuerNameAndLabel,
   'PUSHED_TO_CONFIG', @defaultLanguage, 600, @subIssuerNameAndLabel, TRUE, TRUE, '^[^OIi]*$', '6:(:DIGIT:1)', NULL, TRUE, TRUE, 300,
   @acsURLVEMastercard, @acsURLVEMastercard, @acsURLVEVisa, @acsURLVEVisa, FALSE, TRUE, TRUE, TRUE, @preferredAuthMean,
   @issuerCountryCode, @HUBcallMode, @issuerId, @maskParam, @dateFormat);
/*!40000 ALTER TABLE `SubIssuer` ENABLE KEYS */;

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);
/* Network_SubIssuer */
/*!40000 ALTER TABLE `Network_SubIssuer` DISABLE KEYS */;
INSERT INTO `Network_SubIssuer` (`id_network`, `id_subIssuer`)
    SELECT n.id, si.id
    FROM `Network` n, `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId and si.id = @subIssuerID
	AND n.code in('VISA','MASTERCARD');
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
    FROM `SubIssuer` si WHERE si.fk_id_issuer=@issuerId and si.id = @subIssuerID;
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
    WHERE n.code in('VISA','MASTERCARD') AND si.fk_id_issuer=@issuerId and si.id = @subIssuerID;


/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'EWB';
SET @BankUB = 'EWB';
INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy, NOW(), CONCAT(@BankB,' profile set'), NULL, NULL, CONCAT('PS_', @BankUB, '_01'), 'PUSHED_TO_CONFIG', si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer=@issuerId and si.id = @subIssuerID;
/*!40000 ALTER TABLE `ProfileSet` ENABLE KEYS */;

/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (',@BankB, ')')),
	   (NULL,'HELP_PAGE',CONCAT('Help Page (',@BankB, ')')),
	   (NULL,'OTP_FORM_PAGE',CONCAT('OTP Form Page (',@BankB, ')')),
	   (NULL,'REFUSAL_PAGE',CONCAT('Refusal Page (',@BankB, ')')),
	   (NULL,'FAILURE_PAGE',CONCAT('Failure Page (',@BankB, ')'));

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` DISABLE KEYS */;
INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p
	WHERE cpl.description like CONCAT('%(',@BankB, '%') and p.id=@ProfileSet;
/*!40000 ALTER TABLE `CustomPageLayout_ProfileSet` ENABLE KEYS */;

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
  '<div id="messageBanner">
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
	}
	div#message-container.info {
		background-color:#069AF9;
	}
	#headingTxt {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:22px;
		width : 70%;
		margin : auto;
		display : block;
		text-align:center;
		padding:4px 1px 1px 1px;
	}
	#message {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif; font-size:14px;
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
</style>
  ', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_1\'"></custom-text></p>
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_2\'"></custom-text></p>
		<p><custom-text custom-text-key="\'network_means_HELP_PAGE_3\'"></custom-text></p>
	</div>

	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button id="helpCloseButton" help-label="toto"></help-close-button>
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
	#helpCloseButton button {
		display: flex;
		align-items: center;
		width: 120px; 
		margin-left: auto;
		margin-right: auto;
		justify-content: center;
	}
	help-page {
		font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
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
</style>
', @layoutId);
  
SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('OTP Form Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
    VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
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
		border-radius: 4px;
		font-size: 16px;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
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
	#footer #helpButton button span:before {
		content:'';
	}
	#footer #cancelButton button span:before {
		content:'';
	}
	#footer #helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-y: -1px;
		background-position-x: -2px;
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
		background-position-x: -2px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x: 2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #CED8F6;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
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
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
	.valbtn {
		margin: 0px 8px 10px 06px;
		text-align: justify;
	}
	.leftColumn {
		width:30%;
		display:block;
		float:left;
		padding:1em;
	}
	.rightColumn {
		width:70%;
		margin-left:30%;
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
		padding-left:50.9%;
		text-align:left;
		font-size: 18px;
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
		min-height: 25px;
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
		text-align:center;
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
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	#validateButton {
		display:inline-block;
		padding-top:10px;
		margin-left:1em;
		vertical-align:4px;
	}
	#validateButton button {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:16px;
		border-radius: 4px;
		color: #FFF;
		background:#00AC32;
		padding: 10px 10px 5px 10px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width:200px;
		height: 40px;
		text-align: center;
		white-space: nowrap;
		display: inline-block;
	}
	#validateButton button:disabled {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:16px;
		border-radius: 4px; 
		color: #969696;
		background:#fff;
		border-color: #dcdcdc;
		padding: 10px 10px 5px 10px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width:200px;
		height: 40px;
		text-align: center;
		white-space: nowrap;
		display: inline-block;
	}
	#validateButton > button > span {
		width:100%;
	}
	#validateButton > button > span.fa-check-square {
		display: inline-block;
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-position-x: -2px;
		background-size: contain;
		display: inline-block;
		margin-right: 3px;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height : 64px;  max-width:200%; }
		#networkLogo {max-height : 72px;px;  max-width:100%; }
		#optGblPage {     font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.valbtn { margin: 0px 8px 10px 29px; text-align: justify; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#otp-form{ display:block; width:250px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields { width:100%; }
		#validateButton { display:block; width:200px; margin-left:auto; margin-right:auto; }
		#validateButton button { width:100%; }
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo {max-height : 54px;  max-width:200%; }
		#networkLogo {max-height : 67px;  max-width:100%;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; }
		.valbtn { margin: 0px 8px 10px 29px; text-align: justify; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#otp-form{ display:block; width:250px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields { width:100%; }
		#validateButton { display:block; width:200px; margin-left:auto; margin-right:auto; }
		#validateButton button { width:100%; }
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage {   font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:200%; }
		#networkLogo {max-height : 62px;  max-width:100%; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#otp-form{ display:block; width:250px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; padding:0px; }
		div#otp-fields { width:100%; }
		#validateButton { display:block; width:200px; margin-left:auto; margin-right:auto; }
		#validateButton button { width:100%; }
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 90px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>		
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #CED8F6;
			border-bottom: 5px solid #CED8F6;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="\'TRANSACTION_SUMMARY\'"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_3\'" id="paragraph3"></custom-text>
			</div>
			<div id="otp-fields-container">
				<div x-ms-format-detection="none" id="otp-fields">
					<otp-form></otp-form>
					<div class="valbtn">
						<val-button id="validateButton"></val-button>
					</div>
				</div>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph2"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
			<help help-label="\'network_means_pageType_41\'" id="helpButton" ></help>
		</div>
	</div>
</div>
', @layoutId);  

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
	#footer #helpButton button span:before {
		content:'';
	}
	#footer #cancelButton button span:before {
		content:'';
	}
	#footer #helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-y: -1px;
		background-position-x: -2px;
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
		background-position-x: -2px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		clear:both; 
		width:100%;
		background-color:#CED8F6;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
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
	#issuerLogo {
		max-height: 64px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 82px;
		padding-top: 16px;
		padding-right: 16px;
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
	.leftColumn {
		width:30%;
		display:block;
		float:left;
		padding:1em;
	}
	.rightColumn {
		width:70%;
		margin-left:30%;
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
		padding-left:50.9%;
		text-align:left;
		font-size: 18px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px; 
	}

	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:200%; }
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; }
		#networkLogo { max-height : 67px;  max-width:100%;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:200%; }
		#networkLogo { max-height : 62px;  max-width:100%; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 90px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #CED8F6;
			border-bottom: 5px solid #CED8F6;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="\'TRANSACTION_SUMMARY\'"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_2\'" id="paragraph2"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="\'network_means_pageType_41\'" id="helpButton" ></help>
		</div>
	</div>
</div>
', @layoutId);  

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (',@BankB, ')%') );
  
INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
	#footer #helpButton button span:before {
		content:'';
	}
	#footer #cancelButton button span:before {
		content:'';
	}
	#footer #helpButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width:24px;
		height:26px;
		background-position-y: -1px;
		background-position-x: -2px;
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
		background-position-x: -2px;
		background-size: 115%;
		display:inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		clear:both; 
		width:100%;
		background-color:#CED8F6;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
	}
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
	#issuerLogo {
		max-height: 64px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 82px;
		padding-top: 16px;
		padding-right: 16px;
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
	.leftColumn {
		width:30%;
		display:block;
		float:left;
		padding:1em;
	}
	.rightColumn {
		width:70%;
		margin-left:30%;
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
		padding-left:50.9%;
		text-align:left;
		font-size: 18px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px; 
	}

	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:200%; }
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; }
		#networkLogo { max-height : 67px;  max-width:100%;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; display:block; float:none; width:100%; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:200%; }
		#networkLogo { max-height : 62px;  max-width:100%; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 90px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #CED8F6;
			border-bottom: 5px solid #CED8F6;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="\'TRANSACTION_SUMMARY\'"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="\'network_means_pageType_41\'" id="helpButton" ></help>
		</div>
	</div>
</div>
', @layoutId);  

/*!40000 ALTER TABLE `CustomPageLayout` ENABLE KEYS */;


/* BinRange */
/* In this table, in the case of co-branding the primary network will be present as a foreign key (fk_id_network) and
   the 'alternative' network will be present through the field 'coBrandedCardNetwork' which contains a string that matches
   the field 'code' of the Network (it plays the same role as a foreign key, because the code is unique for each Network)
*/
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');


INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                        `name`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`,
                        `sharedBinRange`, `updateDSDate`, `upperBound`, `toExport`, `fk_id_profileSet`, `fk_id_network`,
                        `coBrandedCardNetwork`) VALUES
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4009920000', 16, FALSE, NULL, '4009929999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4009930000', 16, FALSE, NULL, '4009939999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4126110000', 16, FALSE, NULL, '4126119999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4126120000', 16, FALSE, NULL, '4126129999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4185420000', 16, FALSE, NULL, '4185429999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4375070000', 16, FALSE, NULL, '4375079999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4375500000', 16, FALSE, NULL, '4375509999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4450860000', 16, FALSE, NULL, '4450869999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4501770000', 16, FALSE, NULL, '4501779999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4575560000', 16, FALSE, NULL, '4575569999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4575570000', 16, FALSE, NULL, '4575579999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4585520000', 16, FALSE, NULL, '4585529999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4585530000', 16, FALSE, NULL, '4585539999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4687670000', 16, FALSE, NULL, '4687679999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '4838920000', 16, FALSE, NULL, '4838929999', FALSE, @ProfileSet, @MaestroVID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5149210000', 16, FALSE, NULL, '5149219999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5166370000', 16, FALSE, NULL, '5166379999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5179880000', 16, FALSE, NULL, '5179889999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5180960000', 16, FALSE, NULL, '5180969999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5188860000', 16, FALSE, NULL, '5188869999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5191490000', 16, FALSE, NULL, '5191499999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5242240000', 16, FALSE, NULL, '5242249999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5489240000', 16, FALSE, NULL, '5489249999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5545500000', 16, FALSE, NULL, '5545509999', FALSE, @ProfileSet, @MaestroMID, NULL),
  ('ACTIVATED', @createdBy, NOW(), NULL, NULL, NULL, NULL, 'PUSHED_TO_CONFIG', TRUE, NOW(), '5546010000', 16, FALSE, NULL, '5546019999', FALSE, @ProfileSet, @MaestroMID, NULL);


/* BinRange_SubIssuer */
INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4009920000' AND b.upperBound='4009929999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4009930000' AND b.upperBound='4009939999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4126110000' AND b.upperBound='4126119999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4126120000' AND b.upperBound='4126129999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4185420000' AND b.upperBound='4185429999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4375070000' AND b.upperBound='4375079999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4375500000' AND b.upperBound='4375509999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4450860000' AND b.upperBound='4450869999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4501770000' AND b.upperBound='4501779999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4575560000' AND b.upperBound='4575569999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4575570000' AND b.upperBound='4575579999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4585520000' AND b.upperBound='4585529999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4585530000' AND b.upperBound='4585539999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4687670000' AND b.upperBound='4687679999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='4838920000' AND b.upperBound='4838929999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5149210000' AND b.upperBound='5149219999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5166370000' AND b.upperBound='5166379999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5179880000' AND b.upperBound='5179889999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5180960000' AND b.upperBound='5180969999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5188860000' AND b.upperBound='5188869999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5191490000' AND b.upperBound='5191499999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5242240000' AND b.upperBound='5242249999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5489240000' AND b.upperBound='5489249999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5545500000' AND b.upperBound='5545509999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;

INSERT INTO `BinRange_SubIssuer` (`id_binRange`, `id_subIssuer`)
  SELECT b.id, s.id
  FROM BinRange b, SubIssuer s
  WHERE b.lowerBound='5546010000' AND b.upperBound='5546019999' AND b.fk_id_profileSet=@ProfileSet
  AND s.code=@subIssuerCode;


/* Image - The image is stored as 'Blob' so you need to convert you image (ex.png) to Base64 before inserting it.
  Or, rather, use the tool in the Back-Office (Custom items creator) and then extract the information from the database */
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `binaryData`)
VALUES (@createdBy, NOW(), CONCAT(@BankB,' Logo'), NULL, NULL, @BankB, 'PUSHED_TO_CONFIG', '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');
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;

/* CustomItemSet */
/*!40000 ALTER TABLE `CustomItemSet` DISABLE KEYS */;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_1_REFUSAL_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_1_REFUSAL'), 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_SMS_Current'), NULL, NULL,
    CONCAT('customitemset_', @BankUB, '_SMS'), 'PUSHED_TO_CONFIG', 'BEING_MODIFIED_IN_ACCEPTANCE', 1, NULL, NULL, @subIssuerID);
/*!40000 ALTER TABLE `CustomItemSet` ENABLE KEYS */;


/* CustomItem */
/* Create custom items for default language and backup languages - in this example de and en */
/*!40000 ALTER TABLE `CustomItem` DISABLE KEYS */;

/* Elements for the profile DEFAULT_REFUSAL : */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_1_REFUSAL'));
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, @BankB, @MaestroVID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, @BankB, @MaestroMID, im.id, @customItemSetREFUSAL 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Verified by Visa™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetREFUSAL
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_LOGO%' AND n.code LIKE '%MASTERCARD%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'For safety reasons, the use of your card has been refused on this site displaying the Verified by Visa logo. As such, your purchase will be cancelled. One possible reason for this is because your mobile number may not be updated.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Please contact EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free for further inquiries.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, '<h3>Payment declined</h3>', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'Your payment with Verified by Visa™ is refused!', @MaestroVID, NULL, @customItemSetREFUSAL),
		 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetREFUSAL);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'For safety reasons, the use of your card has been refused on this site displaying the Mastercard Identity Check logo. As such, your purchase will be cancelled. One possible reason for this is because your mobile number may not be updated.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Please contact EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free for further inquiries.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, '<h3>Payment declined</h3>', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'Your payment with Mastercard® Identity Check™ is refused!', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetREFUSAL);

	 
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'EastWest has chosen the solution Verified by Visa, the security program of Visa, designed to enhance the security of your internet purchases. Intended for Visa cardholders, it protects against possible fraudulent use of your credit card in online shops that display the Verified by Visa logo.', @MaestroVID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'Your purchases on a Verified by Visa site will from now on be validated by entering a one-time password that will be sent to the cardholder via SMS to the mobile number on record.', @MaestroVID, NULL, @customItemSetREFUSAL),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'If you are a supplementary cardholder, please ensure that you have called EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free to provide your mobile number prior to making any online transaction, so that you may be able to receive the one-time password.', @MaestroVID, NULL, @customItemSetREFUSAL);
		 
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'EastWest has chosen the solution Mastercard SecureCode, the security program of Mastercard, designed to enhance the security of your internet purchases. Intended for Mastercard cardholders, it protects against possible fraudulent use of your credit card in online shops that display the Mastercard SecureCode logo.', @MaestroMID, NULL, @customItemSetREFUSAL),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'Your purchases on a Mastercard SecureCode site will from now on be validated by entering a one-time password that will be sent to the principal cardholder via SMS to the mobile number on record.', @MaestroMID, NULL, @customItemSetREFUSAL),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'If you are a supplementary cardholder, please ensure that you have called EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free to provide your mobile number prior to making any online transaction, so that you may be able to receive the one-time password.', @MaestroMID, NULL, @customItemSetREFUSAL);


/* Elements for the profile SMS : */
SET @currentAuthentMean = 'OTP_SMS';
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetSMS 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
         'en', 1, 'ALL', @BankB, @MaestroMID, im.id, @customItemSetSMS 
		 FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankB,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG',
         'en', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_LOGO%' AND n.code LIKE '%MASTERCARD%';
  
/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'DONT DISCLOSE your OTP to fraudsters who may pose as bank staff. The OTP for your CARD PURCHASE is @otp, expires in 4mins. Call 8881700 for queries.', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'en', 0, 'MESSAGE_BODY',
        'DONT DISCLOSE your OTP to fraudsters who may pose as bank staff. The OTP for your CARD PURCHASE is @otp, expires in 4mins. Call 8881700 for queries.', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Enter the one-time password received via SMS</b>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'This identification is required to complete your transaction. If you refuse to identify yourself, your purchase will be cancelled.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'To protect you against possible fraudulent use of your VISA card online, EastWest adopted the Verified by Visa solution. A one time-time password has been sent to you via SMS to the mobile number on record, and it is required to complete your transaction. Failure to enter the correct one-time password will cancel your transaction. If necessary, please contact EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, '<h3>Authentication in progress</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Your input is being checked and the page will be updated automatically in a few seconds.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, '<h3>Transaction cancelled</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'The transaction has been cancelled.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, '<h3>Authentication successful</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'Your authentication has been validated, you will be redirected to the the shop.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, '<h3>Wrong one-time password</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The one-time password you have entered is incorrect.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, '<h3>Session expired</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'We´re sorry. Your session has expired and your purchase has been cancelled. You may go back to the shop and purchase again.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, '<h3>Technical Error</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Your purchases cannot be completed. We apologize for any inconvenience this may have caused. You may go back to the shop and purchase again.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel purchase', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, '<b>Enter the one-time password received via SMS</b>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'This identification is required to complete your transaction. If you refuse to identify yourself, your purchase will be cancelled.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @currentPageType, 'To protect you against possible fraudulent use of your credit card online, EastWest adopted the MasterCard Identity Check solution. A one time-time password has been sent to you via SMS to the mobile number on record, and it is required to complete your transaction. Failure to enter the correct one-time password will cancel your transaction. If necessary, please contact EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
         'en', 12, @currentPageType, '<h3>Authentication in progress</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
         'en', 13, @currentPageType, 'Your input is being checked and the page will be updated automatically in a few seconds.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
         'en', 14, @currentPageType, '<h3>Transaction cancelled</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
         'en', 15, @currentPageType, 'The transaction has been cancelled.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
         'en', 26, @currentPageType, '<h3>Authentication successful</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
         'en', 27, @currentPageType, 'Your authentication has been validated, you will be redirected to the the shop.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
         'en', 28, @currentPageType, '<h3>Wrong one-time password</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
         'en', 29, @currentPageType, 'The one-time password you have entered is incorrect.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
         'en', 30, @currentPageType, '<h3>Session expired</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
         'en', 31, @currentPageType, 'We´re sorry. Your session has expired and your purchase has been cancelled. You may go back to the shop and purchase again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
         'en', 32, @currentPageType, '<h3>Technical Error</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
         'en', 33, @currentPageType, 'Your purchases cannot be completed. We apologize for any inconvenience this may have caused. You may go back to the shop and purchase again.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
         'en', 40, @currentPageType, 'Cancel purchase', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */
SET @helpPage = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'EastWest has chosen the solution Verified by Visa, the security program of Visa, designed to enhance the security of your internet purchases. Intended for Visa cardholders, it protects against possible fraudulent use of your credit card in online shops that display the Verified by Visa logo.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'Your purchases on a Verified by Visa site will from now on be validated by entering a one-time password that will be sent to the cardholder via SMS to the mobile number on record.', @MaestroVID, NULL, @customItemSetSMS),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'If you are a supplementary cardholder, please ensure that you have called EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free to provide your mobile number prior to making any online transaction, so that you may be able to receive the one-time password.', @MaestroVID, NULL, @customItemSetSMS);
		 
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @helpPage, 'EastWest has chosen the solution Mastercard SecureCode, the security program of Mastercard, designed to enhance the security of your internet purchases. Intended for Mastercard cardholders, it protects against possible fraudulent use of your credit card in online shops that display the Mastercard SecureCode logo.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @helpPage, 'Your purchases on a Mastercard SecureCode site will from now on be validated by entering a one-time password that will be sent to the principal cardholder via SMS to the mobile number on record.', @MaestroMID, NULL, @customItemSetSMS),
  
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@helpPage,'_3'), 'PUSHED_TO_CONFIG',
         'en', 3, @helpPage, 'If you are a supplementary cardholder, please ensure that you have called EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free to provide your mobile number prior to making any online transaction, so that you may be able to receive the one-time password.', @MaestroMID, NULL, @customItemSetSMS);


/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'We´re sorry. We were not able to verify your identity. Your purchase will be cancelled.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, '<h3>Identification failure</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'Your purchase will be cancelled.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'Weâ€™re sorry. We were not able to verify your identity. Your purchase will be cancelled.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
         'en', 16, @currentPageType, '<h3>Identification failure</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
         'en', 17, @currentPageType, 'Your purchase will be cancelled.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS);

/* Elements for the REFUSAL page, for SMS Profile */
SET @currentPageType = 'REFUSAL_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'For safety reasons, the use of your card has been refused on this site displaying the Verified by Visa logo. As such, your purchase will be cancelled. One possible reason for this is because your mobile number may not be updated.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Please contact EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free for further inquiries.', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, '<h3>Payment declined</h3>', @MaestroVID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'Your payment with Verified by Visa™ is refused!', @MaestroVID, NULL, @customItemSetSMS),
		 
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetSMS);


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
         'en', 1, @currentPageType, 'For safety reasons, the use of your card has been refused on this site displaying the Mastercard Identity Check logo. As such, your purchase will be cancelled. One possible reason for this is because your mobile number may not be updated.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
         'en', 2, @currentPageType, 'Please contact EastWest´s 24-Hour Customer Service at 888-1700 or 1-800-1888-8600 Domestic Toll-Free for further inquiries.', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
         'en', 22, @currentPageType, '<h3>Payment declined</h3>', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
         'en', 23, @currentPageType, 'Your payment with Mastercard® Identity Check™ is refused!', @MaestroMID, NULL, @customItemSetSMS),

  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
         'en', 41, @currentPageType, 'Help', @MaestroMID, NULL, @customItemSetSMS);
		 
/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;

/* Profile */
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB,'_SMS'));
SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'REFUSAL (FRAUD)', NULL, NULL, CONCAT(@BankUB,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1, @authMeanRefusal, @customItemSetRefusal, NULL, NULL, @subIssuerID),
  (@createdBy, NOW(), 'OTP_SMS', NULL, NULL, CONCAT(@BankUB,'_SMS_01'), 'PUSHED_TO_CONFIG', 3, @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID);

/* Rule */
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'REFUSAL_FRAUD', NULL, NULL, 'REFUSAL (FRAUD)', 'PUSHED_TO_CONFIG', 1, @profileRefusal),
  (@createdBy, NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'SMS (NORMAL)', 'PUSHED_TO_CONFIG', 2, @profileSMS),
  (@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 4, @profileRefusal);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;

/* RuleCondition */
/*!40000 ALTER TABLE `RuleCondition` DISABLE KEYS */;
SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES 
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C2_P_',@BankUB,'_01_FRAUD'), 'PUSHED_TO_CONFIG', @ruleRefusalFraud),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL'), 'PUSHED_TO_CONFIG', @ruleSMSnormal),
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_',@BankUB,'_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleRefusalDefault);
/*!40000 ALTER TABLE `RuleCondition` ENABLE KEYS */;

/* Condition_TransactionStatuses */
/*!40000 ALTER TABLE `Condition_TransactionStatuses` DISABLE KEYS */;
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C2_P_',@BankUB,'_01_FRAUD') AND (ts.`transactionStatusType`='MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL') AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_DEFAULT') AND (ts.`transactionStatusType`='DEFAULT' AND ts.`reversed`=FALSE);
/*!40000 ALTER TABLE `Condition_TransactionStatuses` ENABLE KEYS */;

/* Condition_MeansProcessStatuses */
/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` DISABLE KEYS */;
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms
    AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_NORMAL')
    AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

/*!40000 ALTER TABLE `Condition_MeansProcessStatuses` ENABLE KEYS */;

/* ProfileSet_Rule */
/*!40000 ALTER TABLE `ProfileSet_Rule` DISABLE KEYS */;
SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));

SET @ruleRefusalFraud = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_FRAUD' AND `fk_id_profile`=@profileRefusal);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description`='SMS_AVAILABLE_NORMAL' AND `fk_id_profile`=@profileSMS);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description`='REFUSAL_DEFAULT' AND `fk_id_profile`=@profileRefusal);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
    SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
    WHERE ps.`name` = CONCAT('PS_',@BankUB,'_01') AND r.`id` IN (@ruleRefusalFraud, @ruleSMSnormal, @ruleRefusalDefault);
/*!40000 ALTER TABLE `ProfileSet_Rule` ENABLE KEYS */;

/* MerchantPivotList */
/*!40000 ALTER TABLE `MerchantPivotList` DISABLE KEYS */;
INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES
  ('ISSUER', 'TestMerchant', 'NAME', 0, 0, @issuerId, @subIssuerID);
/*!40000 ALTER TABLE `MerchantPivotList` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
