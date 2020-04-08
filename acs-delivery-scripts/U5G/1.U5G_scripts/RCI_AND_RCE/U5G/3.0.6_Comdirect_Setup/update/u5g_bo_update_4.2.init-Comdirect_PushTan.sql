USE `U5G_ACS_BO`;
START TRANSACTION;
SET @createdBy = 'A707825';
SET @issuerCode = '16600';
SET @subIssuerCode = '16600';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);
SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = @currentAuthentMean);
SET @updateState = 'PUSHED_TO_CONFIG';
SET @pollingPageCustomPageLayoutDesc = 'Polling Page (Comdirect)';


SET @activatedAuthMeans =
'[ {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "OTP_SMS_EXT_MESSAGE",
  "validate" : true
}, {
  "authentMeans" : "PHOTO_TAN",
  "validate" : true
}, {
  "authentMeans" : "I_TAN",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP_EXT",
  "validate" : true
} ]';

SET @availableAuthMeans = 'OTP_SMS_EXT_MESSAGE|PHOTO_TAN|I_TAN|REFUSAL|MOBILE_APP_EXT';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);

UPDATE `Issuer` SET  `availaibleAuthentMeans`=  @availableAuthMeans WHERE id  = @issuerId;
UPDATE  `SubIssuer` SET `authentMeans` = @activatedAuthMeans WHERE code = @subIssuerCode AND fk_id_issuer  = @issuerId;

INSERT INTO CustomPageLayout (controller, pageType, description) VALUES
	( NULL, 'POLLING_PAGE', @pollingPageCustomPageLayoutDesc);

INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
	SELECT cpl.id, ps.id
	FROM CustomPageLayout cpl, ProfileSet ps
	WHERE cpl.description = @pollingPageCustomPageLayoutDesc AND ps.name LIKE '%Comdirect%';

SET @idPollingPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'POLLING_PAGE' AND description = @pollingPageCustomPageLayoutDesc) ;

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
	VALUES( 'div', '<div id="main-container"> <style type="text/css">:root {
	font-family: Verdana, Helvetica, sans-serif;
	padding: 0px;
	margin: 0px;
}
#main-container {
	width: 480px;
	max-width: 480px;
	margin-left: auto;
	margin-right: auto;
	padding-left: 10px;
	padding-right: 10px;
}
#main-container .btn {
	border-radius: 20px;
	border: 0px;
	height: 40px;
	margin-left: 10px;
}
#main-container #header {
	height: 64px;
	position: relative;
}
#issuerLogo {
	background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg");
	background-size: contain;
	height: 25px;
	margin-left: 5px;
	margin-top: 1em;
}
#networkLogo {
	background: no-repeat url("../img/verified_logo_white.png");
	width: 100px;
	position: absolute;
	right: 1px;
	top: 5px;
	padding-right: 1em;
}
#main-container #content {
	text-align: left;
	display: flex;
	flex-direction: column;
}
#main-container #footer {
	display: flex;
	width: 100%;
	border-top: 1px solid #000;
	padding-top: 10px;
	justify-content: space-between;
	background-image: none;
}
#main-container #cancelButton .btn-default {
	background-color: #f4f4f4;
	align-content: flex-start;
}
.fa-ban {
	display: none;
}
#main-container #validateButton .btn-default {
	background-color: #FFF500;
	align-content: flex-end;
}
#validateButton {
	outline: 0px;
	border: 0px;
	border-radius: 20px;
	height: 40px;
	width: 120px;
	background-color: #FFF500;
	margin-right: 10px;
	align-content: flex-end;
}
.fa-check-square {
	display: none
}
.fa-ban {
	display: none;
}
#cancelButton {
	background-color: #f4f4f4;
	border-radius: 20px;
	border: 0px;
	height: 40px;
	width: 120px;
	margin-left: 10px;
	align-content: flex-start;
}
.splashtext {
	width: 80%;
	margin-left: auto;
	margin-right: auto;
}
input {
	border: 1px solid #d1d1d1;
	border-radius: 6px;
	color: #464646;
	height: 20px;
	box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
}
/* message banner overrides */
message-banner #spinner-row {
	height: 50px;
	padding-top: 25px;
	margin-bottom: 10px;
}
.spinner-container {
	display: block;
	width: 100%;
}
#messageBanner {
	width: 100%;
	margin-left: 0px;
	margin-right: 0px;
	margin-top: 10px;
	background-color: #F5F5F5;
	box-sizing: border-box;
}
#messageBanner p {
	margin-top: 0.25em;
	margin-bottom: 0.25em;
}
#messageBanner h3 {
	margin-top: 0.25em;
	margin-bottom: 0.25em;
}
div#message-controls {
	padding-top: 0px;
}
#close-button-row, #return-button-row {
	margin-bottom: 10px;
	margin-top: 10px;
}
.error {
	color: #FFF;
	background-color: #F00 !important;
}
.spinner {
	display: block;
	width: 120px;
	height: 120px;
}
#otp-error-message {
	margin-top: 10px;
	position: relative;
	background-color: #F5F5F5;
	text-align: center;
	width: 300px;
	margin-left: 56px;
	padding: 12px;
}
#otp-error-message:after {
	content: '''';
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
	color: #D00;
}
#meansSelect {
	padding-top: 10px;
	padding-bottom: 10px;
	text-align: center;
}
#tan_input_ctrl {
	align-items: center;
}
.autharea {
	padding-top: 10px;
	padding-bottom: 10px;
}
external-image {
	margin-left: auto;
	margin-right: auto;
	display: block;
	width: 214px;
}
#phototan_ctrl {
	align-content: center;
}
#mtan_ctrl {
	align-content: center;
}
#itan_ctrl {
	align-content: center;
}
span#tan-label {
	padding-right: 5px;
	padding-left: 5px;
	margin-left: 8.33333333%;
	width: 41.66666667%;
	text-align: right;
	float: left;
	font-weight: 700;
}
.otp-field {
	padding-right: 5px;
	padding-left: 5px;
	margin-right: 8.33333333%;
	width: 41.66666667%;
	text-align: left;
	float: left;
}
@media (max-width: 560px) {
	#main-container {
		width: auto;
	}
	body {
		font-size: 14px;
	}
	#header {
		height: 65px;
	}
	.transactiondetails ul li {
		text-align: left;
	}
	.transactiondetails ul li label {
		display: block;
		float: left;
		width: 50%;
		text-align: right;
		font-size: 14px;
		color: #909090;
		margin-right: 0.5em;
	}
	.transactiondetails ul li span.value {
		clear: both;
		text-align: left;
		margin-left: 0.5em;
	}
	.mtan-input {
		display: flex;
		flex-direction: column;
		width: 100%;
		padding-bottom: 1em;
		padding-top: 1em;
	}
	.resendTan {
		margin-left: 0px;
		flex-grow: 2;
	}
	.resendTan a {
		color: #06c2d4;
		margin-left: 90px;
		padding-left: 16px;
	}
	.mtan-label {
		flex: 0 0 90px;
	}
	.input-label {}
	.otp-field {
		display: inline;
	}
	.otp-field input {}
	#main-container #footer {
		width: 100%;
		clear: both;
		margin-top: 3em;
		background-image: none;
	}
	.help-link {
		width: 100%;
		order: 2;
		text-align: center;
		padding-top: 1em;
	}
	.contact {
		width: 100%;
		order: 1;
	}
	#footer .small-font {
		font-size: 0.75em;
	}
	#otp-error-message {
		margin-top: 0px;
		position: relative;
		background-color: #F5F5F5;
		text-align: center;
		width: 100%;
		margin-left: 0px;
		margin-bottom: 16px;
		box-sizing: border-box;
	}
	#otp-error-message:after {
		content: '''';
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
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_170_IMAGE_ALT''"
						  image-key="''network_means_pageType_170_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_171_IMAGE_ALT''"
						  image-key="''network_means_pageType_171_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_5''"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
	</div>
</div>', @idPollingPage);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
	VALUES  (@createdBy, NOW(), CONCAT('customitemset_', @subIssuerCode, '_APP_1'), NULL, NULL,
	CONCAT('customitemset_', @subIssuerCode, '_APP_1'), @updateState, 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_APP_1'));

SET @profileNameApp = 'COMDIRECT_APP_01';
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
	(@createdBy, NOW(), 'Authentication APP 01', NULL, NULL, @profileNameApp, @updateState, 3, @authentMeansMobileApp, @customItemSetMobileApp, NULL, NULL, @subIssuerID);

SET @profileAPP1 = (SELECT id FROM `Profile` WHERE `name` = @profileNameApp);
SET @customer_ids = (SELECT group_concat(id)
					 FROM `Profile`
					 WHERE name in ('16600_COMDIRECT_FRAUD_REFUSAL', '16600_COMDIRECT_RBA_ACCEPT',
									'16600_COMDIRECT_RBA_REFUSAL', '16600_COMDIRECT_PHOTOTAN_01',
									'16600_COMDIRECT_SMS_01', @profileNameApp,
									'16600_COMDIRECT_ITAN_01', '16600_COMDIRECT_PHOTOTAN_02',
									'16600_COMDIRECT_SMS_02', '16600_COMDIRECT_ITAN_02',
									'16600_COMDIRECT_DEFAULT_REFUSAL'));
SET @shiftOrder = 6;
UPDATE Rule set orderRule = orderRule + 1
	WHERE orderRule >= @shiftOrder and find_in_set(fk_id_profile, @customer_ids) order by orderRule;

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
	(@createdBy, NOW(), 'COMDIRECT OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', @updateState, @shiftOrder, @profileAPP1);

SET @currentRule = (SELECT id FROM `Rule` WHERE `description`='COMDIRECT OTP_APP (NORMAL)');
SET @ruleConditionName = 'C1_COMDIRECT_OTP_APP_NORMAL';
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
	(@createdBy, NOW(), NULL, NULL, NULL, @ruleConditionName, @updateState, @currentRule);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = @ruleConditionName
	AND mps.`fk_id_authentMean` = @authentMeansMobileApp
	AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = @ruleConditionName
	AND mps.`fk_id_authentMean` = @authentMeansMobileApp
	AND (mps.`meansProcessStatusType` = 'MEANS_DISABLED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name` = @ruleConditionName
	AND mps.`fk_id_authentMean` = @authentMeansMobileApp
	AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name`=@ruleConditionName AND (ts.`transactionStatusType`='ALWAYS_ACCEPT' AND ts.`reversed`=TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name`=@ruleConditionName AND (ts.`transactionStatusType`='ALWAYS_DECLINE' AND ts.`reversed`=TRUE);

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
	SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
	WHERE ps.`name` = 'PS_Comdirect_01' AND r.`id` = @currentRule;


SET @networkId = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @networkName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

SET @idImageBank = (SELECT id FROM `Image` im WHERE im.name = 'Comdirect_Logo');
SET @idImageVisaScheme = (SELECT id FROM `Image` im WHERE im.name LIKE '%VISA_LOGO%');
SET @locale = 'de';

-- bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
	( 'I', @createdBy, NOW(), 'Comdirect Logo', NULL, NULL, 'Comdirect Logo', @updateState,
	@locale, 170, 'ALL', 'Comdirect Logo™', NULL, @idImageBank, @customItemSetMobileApp),
	('I', @createdBy, NOW(), 'Visa Logo german', NULL, NULL, 'Visa Logo', @updateState,
	@locale, 171, 'ALL', 'Verified by Visa™', @networkId, @idImageVisaScheme, @customItemSetMobileApp);

SET @currentPageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_1'), @updateState,
	@locale, 1, @currentPageType, 'Bitte bestätigen Sie folgende Zahlung', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_2'), @updateState,
	@locale, 2, @currentPageType, 'Freigabe mit photoTAN-App', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_3'), @updateState,
	@locale, 3, @currentPageType, 'Öffnen Sie jetzt die photoTAN-App, um die Zahlung dort freizugeben.', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_40'), @updateState,
	@locale, 40, @currentPageType, 'Abbrechen', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_100'), @updateState,
	@locale, 100, 'ALL', 'Händler', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_101'), @updateState,
	@locale, 101, 'ALL', 'Betrag', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_102'), @updateState,
	@locale, 102, 'ALL', 'Datum', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_103'), @updateState,
	@locale, 103, 'ALL', 'Kartennummer', @networkId, NULL, @customItemSetMobileApp),

-- authentication in progress
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_12'), @updateState,
	@locale, 12, @currentPageType, 'Authentifizierung erforderlich', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_13'), @updateState,
	@locale, 13, @currentPageType, '', @networkId, NULL, @customItemSetMobileApp),

-- Authentication cancelled
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_14'), @updateState,
	@locale, 14, @currentPageType, 'Die Zahlung wurde abgebrochen', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_15'), @updateState,
	@locale, 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @networkId, NULL, @customItemSetMobileApp),

-- Authentication successful
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_26'), @updateState,
	@locale, 26, @currentPageType, 'Authentifizierung erfolgreich', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_27'), @updateState,
	@locale, 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', @networkId, NULL, @customItemSetMobileApp),

-- Session expired
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_30'), @updateState,
	@locale, 30, @currentPageType, 'Die Session ist abgelaufen', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_31'), @updateState,
	@locale, 31, @currentPageType, 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', @networkId, NULL, @customItemSetMobileApp),

-- technical error
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_32'), @updateState,
	@locale, 32, @currentPageType, 'Technischer Fehler', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_33'), @updateState,
	@locale, 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.', @networkId, NULL, @customItemSetMobileApp);

SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

-- authentication failure
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_1'), @updateState,
	@locale, 1, @currentPageType, '', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_16'), @updateState,
	@locale, 16, @currentPageType, 'Der Zugang wurde gesperrt', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_17'), @updateState,
	@locale, 17, @currentPageType, 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.', @networkId, NULL, @customItemSetMobileApp),

-- technical error
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_32'), @updateState,
	@locale, 32, @currentPageType, 'Technischer Fehler', @networkId, NULL, @customItemSetMobileApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkName, '_', @currentAuthentMean, '_', @currentPageType, '_33'), @updateState,
	@locale, 33, @currentPageType, 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.', @networkId, NULL, @customItemSetMobileApp);

COMMIT