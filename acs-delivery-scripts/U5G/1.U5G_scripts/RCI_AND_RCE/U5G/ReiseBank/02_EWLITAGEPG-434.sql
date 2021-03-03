USE `U5G_ACS_BO`;


SET @activatedAuthMeans = '[ {
	"authentMeans" : "OTP_SMS",
	"validate" : true
}, {
	"authentMeans" : "REFUSAL",
	"validate" : true
}, {
	"authentMeans" : "INFO",
	"validate" : true
}, {
	"authentMeans" : "MOBILE_APP",
	"validate" : true
} ]';
SET @BankUB = '12000';
SET @availableAuthMeans = '|MOBILE_APP';
SET @issuerName = '10300';
SET @issuerCode = '10300';
SET @subIssuerCode = '12000';
SET @createdBy = 'W100851';
SET @subIssuerName = 'ReiseBank';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @BankName = 'ReiseBank_LOGO';

SET @largeLogo = 'REISE_LARGE_Logo';
SET @mediumLogo = 'REISE_MEDIUM_Logo';
SET @smallLogo = 'REISE_SMALL_Logo';

SET @largeLogoName = 'reise_large';
SET @mediumLogoName = 'reise_medium';
SET @smallLogoName = 'reise_small';

SET @netLargeLogo = 'MC_LARGE_LOGO';
SET @netMediumLogo = 'MC_MEDIUM_LOGO';
SET @netSmallLogo = 'MC_SMALL_LOGO';

SET @netLargeLogoName = 'MC_large';
SET @netMediumLogoName = 'MC_medium';
SET @netSmallLogoName = 'MC_small';

SET @MCLogo = 'MC_ID_LOGO';

SET @pageType = 'APP_VIEW';

SET @bankLogo = 'Bank Logo';
SET @netLogo ='Mastercard Logo';


UPDATE Issuer
SET availaibleAuthentMeans = CONCAT(availaibleAuthentMeans, @availableAuthMeans)
WHERE code = @issuerCode
AND name = @issuerName;

SET @issuerId = (SELECT `id`
				 FROM `Issuer`
				 WHERE `code` = @issuerCode);


UPDATE SubIssuer
SET authentMeans = @activatedAuthMeans
WHERE fk_id_issuer = @issuerId
AND name = @subIssuerName;

SET @authMeanMobileApp = (SELECT id FROM `AuthentMeans`	 WHERE `name` = 'MOBILE_APP');

SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerName);

SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`) VALUES
	(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_MOBILE_APP_Current'), NULL, NULL,
	CONCAT('customitemset_', @BankUB, '_MOBILE_APP'), @updateState, @status, 1, NULL, NULL, @subIssuerID);

SET @customItemSetMOBILEAPP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'Authentication by Mobile App', NULL, NULL, CONCAT(@BankUB,'_REISEBANK_MOBILE_APP_01'), @updateState, 3,
 '6:(:DIGIT:1)', '^[^OIi]*$', @authMeanMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID);

INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'POLLING_PAGE', CONCAT('Polling Page (', @BankUB, ')'));

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_12232_REISEBANK_SMS_01');

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
	SELECT cpl.id, p.id
	FROM `CustomPageLayout` cpl, `ProfileSet` p
	WHERE cpl.description like CONCAT('Polling Page (', @BankUB, ')%') and p.id = @ProfileSet;


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`) VALUES ( 'div', '
<style>
	#pageHeader {
		margin-top: 1em;
		margin-bottom: 1em;
	}
	#issuerLogo,
	#networkLogo {
		max-height: 46px;
		max-width: 100%;
		height: auto;
		padding: 0px;
	}
	#centeredTitle {
		color: rgb(0, 100, 62);
		font-weight: 500;
		display: block;
		font-size: 150%;
		margin-top: 10px;
	}
	#i18n-container {
		width: 100%;
		text-align: center;
		background: #ced8f6;
		padding-bottom: 10px;
	}
	#i18n-inner {
		display: inline-block;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	.noLeftRightMargin {
		margin-left: 0px;
		margin-right: 0px;
	}
	.noLeftRightPadding {
		padding-left: 0px;
		padding-right: 0px;
	}
	div#leftMenuLayout {
		width: 40%;
	}
	#centerPieceLayout {
		padding: 5px 10px 0px;
		min-height: 200px;
		width: fit-content;
		width: auto;
		width: -moz-fit-content;
		margin-left: auto;
		margin-right: auto;
	}
	#rightContainer {
		width: 60%;
		display: inline-block;
	}
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
	.menu-elements {
		display: grid;
	}
	.menu-title {
		color: rgb(0, 100, 62);
	}
	.menu-title span {
		display: block;
		font-size: 18px;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#validateButton {
		background-color: rgb(255, 255, 255);
		color: rgb(51, 51, 51);
		white-space: normal;
		border-radius: 4px;
		border-color: rgb(204, 204, 204);
	}
	#validateButton button {
		margin-top: 5px;
	}
	#validateButton .btn div {
		display: inline;
	}
	button span.fa {
		padding-right: 7px;
	}
	.resendButton {
		position: relative;
		color: #f7f7f7;
		padding-top: 1px;
	}
	.resendButton button {
		border: 0px;
	}
	#headerLayout {
		/* border-bottom-color:#85aafd;
		 border-bottom-width:1px;
		 border-bottom-style:solid;*/
	}
	#bottomMenu {
		/* border-top: 5px solid rgb(0, 100, 62); */
		margin-top: 10px;
		text-align: center;
		width: 100%;
		background: #ced8f6;
	}
	#cancelButton, #helpButton {
		color: rgb(51, 51, 51);
		white-space: normal;
		display: inline-block;
		border-width: 1px;
		border-style: solid;
		border-color: rgb(0, 166, 235);
		border-image: initial;
		margin: 10px;
	}
	@media (max-width: 1200px) {
		#main-container{max-width: 1200px}
		.menu-title {display: none;}
		#rightContainer {width: 100%; display: inline-flex;}
		div#leftMenuLayout {width: 100%;}
	}
	@media screen and (max-width: 480px) {
		#main-container{max-width: 480px}
		.btn {font-size: 12px;}
		#centeredTitle {margin-top: 8px;}
		#bottomLayout {display: block !important;}
	}
	@media screen and (max-width: 390px) {
		#main-container{max-width: 390px; overflow: hidden;}
	}
	@media (max-width: 360px) {
		#main-container{max-width: 360px; overflow: hidden;}
		body {font-size: 9px;}
		.btn {font-size: 9px;}
		#centeredTitle {margin-top: 4px;}
	}
	@media (max-width: 347px) {
		#main-container{max-width: 347px; overflow: hidden;}
		body {font-size: 9px;}
		.btn {font-size: 9px;}
		#centeredTitle {margin-top: 4px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
	}
	@media (max-width: 309px) {
		#main-container{max-width: 309px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
	}
	@media (max-width: 250px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
	}
</style>
<div id="main-container" class="container-fluid">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div class="row">
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_1_IMAGE_ALT''"
								  image-key="''network_means_pageType_1_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
				<div class=" col-xs-4 col-lg-6">
					<div id="centeredTitle">
					</div>
				</div>
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="networkLogo"
								  alt-key="''network_means_pageType_2_IMAGE_ALT''"
								  image-key="''network_means_pageType_2_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
			</div>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_99''"></message-banner>
	<div id="i18n-container">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="mainLayout" class="row">
		<div class="noLeftRightMargin">
			<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
				<div class="noLeftRightPadding">
					<side-menu menu-title="''network_means_pageType_9''"></side-menu>
				</div>
			</div>
			<div id="rightContainer">
				<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
					<div class="paragraph hideable-text">
						<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
						</custom-text>
						<p>
							<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
							</custom-text>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bottomLayout" class="row">
		<div id="bottomMenu">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>', @layoutId);


SET @profileFraudRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REISEBANK_FRAUD_REFUSAL'));
UPDATE `Rule` SET `orderRule` = 1
WHERE  `fk_id_profile` = @profileDefaultRefusal;

SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REISEBANK_SMS_01'));
UPDATE `Rule` SET `orderRule` = 4
WHERE `fk_id_profile` = @profileSMS;

SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REISEBANK_DEFAULT_REFUSAL'));
UPDATE `Rule` SET `orderRule` = 5
WHERE `fk_id_profile` = @profileSMS;



SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_REISEBANK_MOBILE_APP_01'));
INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'MOBILE_APP_AVAILABLE_NORMAL', NULL, NULL, 'MOBILE_APP(NORMAL)', @updateState, 3, @profileMobileApp);

SET @ProfileId = (SELECT id FROM `Profile` WHERE  `name` = CONCAT(@BankUB,'_REISEBANK_SMS_01'));
UPDATE Rule SET name = 'OTP_SMS (FALLBACK)' WHERE fk_id_profile = @ProfileId;

SET @ruleMobileApp = (SELECT id FROM `Rule` WHERE `description` = 'MOBILE_APP_AVAILABLE_NORMAL' AND `fk_id_profile` = @profileMobileApp);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_MOBILE_APP_NORMAL'), @updateState, @ruleMobileApp);



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



SET @RuleId = (SELECT  r.`id` FROM	`Rule` r WHERE	r.`id` = @ruleMobileApp);
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES
	(@ProfileSet , @RuleId);



SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @currentPageType = 'POLLING_PAGE';
SET @currentAuthentMean = 'MOBILE_APP';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo, @updateState,
	   'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankName,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo, @updateState,
	   'de', 2, 'ALL', 'Verified by MASTERCARD™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@MCLogo,'%') AND n.code LIKE '%MASTERCARD%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo, @updateState,
	   'en', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetMobileApp
FROM `Image` im WHERE im.name LIKE CONCAT('%',@BankName,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo, @updateState,
	   'en', 2, 'ALL', 'Verified by MASTERCARD™', n.id, im.id, @customItemSetMobileApp
FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@MCLogo,'%') AND n.code LIKE '%MASTERCARD%';




INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
	'de', 1, @currentPageType, 'Freigabe mit Ihrer RBMC Secure App', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
	'de', 2, @currentPageType, 'Öffnen Sie Ihre RBMC Secure App und klicken Sie auf den neuen Vorgang "Kreditkartenzahlung", um die Transaktion zu bestätigen. Bitte prüfen Sie die aufgeführten Transaktionsdetails der Zahlung und geben Sie diese frei.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @updateState,
	'de', 9, @currentPageType, 'Transaktionsdetails', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
	'de', 12, @currentPageType, 'Authentifizierung wird durchgeführt', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
	'de', 13, @currentPageType, 'Bitte verwenden Sie zur Identifikation Ihre RBMC Secure App.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
	'de', 14, @currentPageType, 'Bezahlvorgang abgebrochen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
	'de', 15, @currentPageType, 'Zur Sicherheit wurde der Bezahlvorgang auf der Webseite mit diesem Logo Mastercard ID Check abgebrochen und Ihre Karte nicht belastet. Sie werden nun automatisch zum Haendler weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
	'de', 26, @currentPageType, 'Authentifizierung erfolgreich', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
	'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zur Händler-Website weitergeleitet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
	'de', 30, @currentPageType, 'Sitzung abgelaufen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
	'de', 31, @currentPageType, 'Die Sitzung ist abgelaufen. Aus Sicherheitsgründen wurde Ihre Transaktion storniert. Bitte kehren Sie zum Online-Shop zurück und starten Sie den Zahlungsvorgang erneut, wenn Sie die Zahlung vornehmen möchten.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
	'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
	'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut. Ihre Karte wurde nicht belastet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
	'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
	'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_99'), @updateState,
	'de', 99, @currentPageType, 'Zurück zum Shop', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
	'de', 100, 'ALL', 'Händler', @MaestroVID, NULL, @customItemSetMobileApp),



('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
	'en', 1, @currentPageType, 'Confirmation with your RBMC Secure App', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
	'en', 2, @currentPageType, 'Open your RBMC Secure App and click on "Card payment", to confirm your transaction. Please check listed transaction details and approve transaction.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @updateState,
	'en', 9, @currentPageType, 'Transaction summary', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), @updateState,
	'en', 12, @currentPageType, 'Authentication in progress', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), @updateState,
	'en', 13, @currentPageType, 'Please use your RBMC Secure App for identification.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), @updateState,
	'en', 14, @currentPageType, 'Payment canceled', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), @updateState,
	'en', 15, @currentPageType, 'For security reasons, your purchase is canceled on the website displaying this logo Mastercard ID Check and your card was not debited. You will be automatically redirected to the merchant website.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), @updateState,
	'en', 26, @currentPageType, 'Authentication successful', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), @updateState,
	'en', 27, @currentPageType, 'Your authentication has been validated, you will be redirected to the merchant website.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), @updateState,
	'en', 30, @currentPageType, 'Session expired', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), @updateState,
	'en', 31, @currentPageType, 'The session has expired. Your payment procedure was therefore cancelled for security reasons. Please return to the online shop and restart the payment process, if you wish to make the payment.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
	'en', 32, @currentPageType, 'Technical Error', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
	'en', 33, @currentPageType, 'A technical error occured and your payment has been cancelled. Please try again. Your card was not debited.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), @updateState,
	'en', 40, @currentPageType, 'Cancel', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
	'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_99'), @updateState,
	'en', 99, @currentPageType, 'Back to merchant website', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_100'), @updateState,
	'en', 100, 'ALL', 'Merchant', @MaestroVID, NULL, @customItemSetMobileApp);





SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
 'de', 1, @currentPageType, 'Freigabe mit Ihrer RBMC Secure App', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
 'de', 2, @currentPageType, 'Öffnen Sie Ihre RBMC Secure App und klicken Sie auf den neuen Vorgang "Kreditkartenzahlung", um die Transaktion zu bestätigen. Bitte prüfen Sie die aufgeführten Transaktionsdetails der Zahlung und geben Sie diese frei.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @updateState,
 'de', 9, @currentPageType, 'Transaktionsdetails', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
 'de', 16, @currentPageType, 'Freigabe fehlgeschlagen', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
 'de', 17, @currentPageType, 'Die Authentifizierung mit Ihrer RBMC Secure App und somit die Zahlungsfreigabe ist fehlgeschlagen. Der Zahlungsprozess wurde abgebrochen und Ihre Karte nicht belastet. Sofern Sie den Kaufprozess fortsetzen möchten, starten Sie den Zahlungsversuch bitte erneut.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_20'), @updateState,
 'de', 20, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut. Ihre Karte wurde nicht belastet.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
 'de', 32, @currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
 'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_99'), @updateState,
 'de', 99, @currentPageType, 'Zurück zum Shop', @MaestroVID, NULL, @customItemSetMobileApp),



('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
 'en', 1, @currentPageType, 'Confirmation with your RBMC Secure App', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
 'en', 2, @currentPageType, 'Open your RBMC Secure App and click on "Card payment", to confirm your transaction. Please check listed transaction details and approve transaction.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_9'), @updateState,
 'en', 9, @currentPageType, 'Transaction summary', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_16'), @updateState,
 'en', 16, @currentPageType, 'Approval failed', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_17'), @updateState,
 'en', 17, @currentPageType, 'The authentication with your RBMC Secure App and thus the payment approval failed. The payment process was cancelled and your card was not debited. If you wish to continue the payment process, please start the payment attempt again.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_20'), @updateState,
 'en', 20, @currentPageType, '', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), @updateState,
 'en', 32, @currentPageType, 'Technical Error', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), @updateState,
 'en', 33, @currentPageType, 'A technical error occured and your payment has been cancelled. Please try again. Your card was not debited.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), @updateState,
 'en', 41, @currentPageType, 'Help', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_99'), @updateState,
 'en', 99, @currentPageType, 'Back to merchant website', @MaestroVID, NULL, @customItemSetMobileApp);



SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
	'de', 1, @currentPageType, 'Mastercard hat das Verfahren Mastercard® Identity Check™ eingeführt, um Online-Shopping einfacher und sicherer zu gestalten. Sie können Online-Zahlungen auf Ihrem Mobil-Telefon in Ihrer RBMC Secure App freigeben.', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
	'de', 2, @currentPageType, 'Bei Fragen oder Unklarheiten kontaktieren Sie bitte unseren Kundenservice unter 0721 47666 3580.', @MaestroVID, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), @updateState,
	'en', 1, @currentPageType, 'Mastercard introduced Mastercard® Identity Check™ in order to increase simplicity and security of online shopping. You can enable online payments on your mobile phone in your RBMC Secure App. ', @MaestroVID, NULL, @customItemSetMobileApp),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), @updateState,
	'en', 2, @currentPageType, 'If you have any questions or concerns, please contact our customer service at 0721 47666 3580.', @MaestroVID, NULL, @customItemSetMobileApp);



SET @locale = 'de';
SET @amName = 'MOBILE_APP';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));

SET @networkMC = (SELECT id FROM `Network` WHERE `code` = 'MASTERCARD');




INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
 `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo , @updateState, @locale, 251, @pageType, @smallLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@smallLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
 `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo, @updateState, @locale, 252, @pageType, @mediumLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@mediumLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
 `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo, @updateState, @locale, 253, @pageType, @largeLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@largeLogoName,'%') AND n.id = @networkMC;


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo , @updateState, @locale, 254, @pageType, @netSmallLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@netSmallLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo, @updateState, @locale, 255, @pageType, @netMediumLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@netMediumLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo, @updateState, @locale, 256, @pageType, @netLargeLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@netLargeLogoName,'%') AND n.id = @networkMC;



SET @ordinal = 151;
SET @text = 'Freigabe mit Ihrer RBMC Secure App';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @ordinal = 152;
SET @text = 'Öffnen Sie die RBMC Secure App und klicken Sie auf den neuen Vorgang \"Kreditkartenzahlung\", um die Transaktion zu bestätigen. Bitte prüfen Sie die aufgeführten Transaktionsdetails der Zahlung und geben Sie diese frei. Klicken Sie im Anschluss auf dieser Seite \"Fortfahren\".';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @ordinal = 157;
SET @text = 'Ihre Kreditkartenzahlung muss mit 3-D Secure bestätigt werden.\n \n Nähere Informationen finden Sie im ReiseBank Mastercard Portal.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 160;
SET @text = 'Die Zahlung konnte nicht mit Ihrer RBMC Secure App bestätigt werden, bitte versuchen Sie es erneut.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 165;
SET @text = 'Fortfahren';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @locale = 'en';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
 `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo , @updateState, @locale, 251, @pageType, @smallLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@smallLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
 `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo, @updateState, @locale, 252, @pageType, @mediumLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@mediumLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`,
 `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @bankLogo, @updateState, @locale, 253, @pageType, @largeLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@largeLogoName,'%') AND n.id = @networkMC;


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo , @updateState, @locale, 254, @pageType, @netSmallLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@netSmallLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo, @updateState, @locale, 255, @pageType, @netMediumLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@netMediumLogoName,'%') AND n.id = @networkMC;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, @netLogo, @updateState, @locale, 256, @pageType, @netLargeLogo, n.id, im.id, @customItemSetId
	FROM `Image` im, `Network` n WHERE im.name LIKE CONCAT('%',@netLargeLogoName,'%') AND n.id = @networkMC;



SET @ordinal = 151;
SET @text = 'Approve with your RBMC Secure App';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @ordinal = 152;
SET @text = 'Open your RBMC Secure App and click on \"Card payment\" to confirm transaction. Please check transaction details of payment and approve it. Afterwards click on \"Continue\" on this page.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 156;
SET @text = 'Help';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @ordinal = 157;
SET @text = 'Your payment has to be approved with 3-D Secure.\n \n Further information can be found in ReiseBank Mastercard portal.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 160;
SET @text = 'Payment could not be confirmed by your RBMC Secure App yet, please retry.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;



SET @ordinal = 165;
SET @text = 'Continue';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
	SELECT 'T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), @updateState, @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE	n.id = @networkMC;


INSERT INTO CustomPageLayout (controller, pageType, description) VALUES
( NULL, 'MOBILE_APP_APP_VIEW', 'TA_App_View (REISEBANK)');

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_12232_REISEBANK_SMS_01');


SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_APP_VIEW' and DESCRIPTION = 'TA_App_View (REISEBANK)') ;

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
'<style>
	.acs-container {
		padding: 0em;
	}
	.scrollbar{
		overflow: auto;
	}
	.acs-header {
		display: flex;
		align-items: center;
		margin-bottom: 0.5em;
		margin-top: 0.5em;
	}
	.card-logo-container {
		text-align: right;
	}
	.acs-purchase-context {
		margin-bottom: 2em;
		margin-top: 0.5em;
		height: 24.5em;
	}
	.acs-purchase-context button{
		width: 100%;
		margin-bottom: 0.5em;
		text-transform: uppercase;
	}
	.acs-purchase-context input {
		width: 100%;
		margin-bottom: 0.5em;
	}
	.acs-challengeInfoHeader {
		text-align: center;
		font-weight: bold;
		font-size: 1.15em;
		margin-bottom: 1.1em;
	}
	.acs-challengeInfoText {
		margin-bottom: 2em;
	}
	.acs-footer {
		font-size: 0.9em;
		margin-bottom: 0.5em;
	}
	.acs-footer-icon {
		text-align: right;
	}
	.row {
		margin-right: -15px;
		margin-left: -15px;
	}
	.col-md-12,
	.col-md-10,
	.col-md-6,
	.col-md-2 {
		position: relative;
		min-height: 1px;
		padding-right: 15px;
		padding-left: 15px;
	}
	.col-md-12 {
		width: 100%;
	}
	.col-md-10 {
		width: 83.33333333%;
	}
	.col-md-6 {
		width: 50%;
	}
	.col-md-2 {
		width: 16.66666667%;
	}
	.form-group {
		margin-bottom: 15px;
	}
	.form-control {
		display: block;
		width: 100%;
		height: 34px;
		padding: 6px 12px;
		font-size: 14px;
		line-height: 1.42857143;
		color: #555;
		background-color: #fff;
		background-image: none;
		border: 1px solid #ccc;
		border-radius: 4px;
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
		-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
		transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	}
	.form-control:focus {
		border-color: #66afe9;
		outline: 0;
		-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
		box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
	}
	.btn {
		display: inline-block;
		padding: 6px 12px;
		margin-bottom: 0;
		font-size: 14px;
		font-weight: normal;
		line-height: 1.42857143;
		text-align: center;
		white-space: nowrap;
		vertical-align: middle;
		-ms-touch-action: manipulation;
		touch-action: manipulation;
		cursor: pointer;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
		background-image: none;
		border: 1px solid transparent;
		border-radius: 4px;
	}
	.btn:hover,
	.btn:focus,
	.btn {
		color: #333;
		text-decoration: none;
	}
	.btn-default {
		color: #333;
		background-color: #fff;
		border-color: #ccc;
	}
	.btn-default:focus,
	.btn-default {
		color: #333;
		background-color: #e6e6e6;
		border-color: #8c8c8c;
	}
	.btn-default:hover {
		color: #333;
		background-color: #e6e6e6;
		border-color: #adadad;
	}
	.btn-primary {
		color: #fff;
		background-color: #337ab7;
		border-color: #2e6da4;
	}
	.btn-primary:focus,
	.btn-primary.focus {
		color: #fff;
		background-color: #286090;
		border-color: #122b40;
	}
	.btn-primary:hover {
		color: #fff;
		background-color: #286090;
		border-color: #204d74;
	}

	 #show,#content{display:none;}

	[data-tooltip],
		.tooltip {
			position: relative;
			cursor: pointer;
			text-align:start;
	}

	[data-tooltip]:before,
	[data-tooltip]:after,
	.tooltip:before,
	.tooltip:after {
	position: absolute;
	visibility: hidden;
	-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
	filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
	opacity: 0;
	-webkit-transition:
		opacity 0.2s ease-in-out,
		visibility 0.2s ease-in-out,
		-webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	-moz-transition:
		opacity 0.2s ease-in-out,
		visibility 0.2s ease-in-out,
		-moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	transition:
		opacity 0.2s ease-in-out,
		visibility 0.2s ease-in-out,
		transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
		-webkit-transform: translate3d(0, 0, 0);
		-moz-transform:	 translate3d(0, 0, 0);
		transform:		 translate3d(0, 0, 0);
		pointer-events: none;
	}

	[data-tooltip]:hover:before,
	[data-tooltip]:hover:after,
	[data-tooltip]:focus:before,
	[data-tooltip]:focus:after,
	.tooltip:hover:before,
	.tooltip:hover:after,
	.tooltip:focus:before,
	.tooltip:focus:after {
		visibility: visible;
		-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
		filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
		opacity: 1;
	}

	.tooltip:before,
	[data-tooltip]:before {
		z-index: 1001;
		border: 6px solid transparent;
		background: transparent;
		content: "";
	}

	.tooltip:after,
	[data-tooltip]:after {
		z-index: 1001;
		padding: 8px;
		width: 250px;
		border-radius: 4px;
		border: 1px solid #d3d3d3;
		background-color: #fff;
		background-color: #fff;;
		color: #333;
		content: attr(data-tooltip);
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size: 14px;
			font-weight: normal;
			line-height: 1.42857143;
			vertical-align: middle;
	}


	[data-tooltip]:before,
	[data-tooltip]:after,
	.tooltip:before,
	.tooltip:after,
	.tooltip-top:before,
	.tooltip-top:after {
		bottom: 100%;
		left: 50%;
	}

	[data-tooltip]:before,
	.tooltip:before,
	.tooltip-top:before {
		margin-left: -6px;
		margin-bottom: -12px;
		color: #000;
		border-top-color: #fff;
	}

	[data-tooltip]:after,
	.tooltip:after,
	.tooltip-top:after {
	  margin-left: -235px;
	}

	[data-tooltip]:hover:before,
	[data-tooltip]:hover:after,
	[data-tooltip]:focus:before,
	[data-tooltip]:focus:after,
	.tooltip:hover:before,
	.tooltip:hover:after,
	.tooltip:focus:before,
	.tooltip:focus:after,
	.tooltip-top:hover:before,
	.tooltip-top:hover:after,
	.tooltip-top:focus:before,
	.tooltip-top:focus:after {
	  -webkit-transform: translateY(-12px);
	  -moz-transform:	 translateY(-12px);
	  transform:		 translateY(-12px);
	}


</style>
</head>
<body>
	<div class="acs-container">
			<div class="scrollbar col-md-12">
				<!-- ACS HEADER | Branding zone-->
				<div class="acs-header row branding-zone">
					<div class="col-md-6">
						<img src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
					</div>
					<div class="col-md-6 card-logo-container">
						<img src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
					</div>
				</div>
				<!-- ACS BODY | Challenge/Processing zone -->
				<div class="acs-purchase-context col-md-12 challenge-processing-zone">
					<div class="row">
						<div class="acs-challengeInfoHeader col-md-12" data-cy="CHALLENGE_INFO_HEADER">
							network_means_pageType_151
						</div>
						<div class="row">
							<div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
								network_means_pageType_152
							</div>
						</div>
						<div class="col-md-12">
							<form action="HTTPS://EMV3DS/challenge" method="get">
							  <input type="hidden" name="submitted-oob-continue-value" value="Y">
							  <input type="submit" value="network_means_pageType_165" class="btn btn-primary" id="challenge-oob-continue-submit" data-cy="CHALLENGE_OOB_CONTINUE_FORM_SUBMIT"/>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- ACS FOOTER | Information zone -->
			<div class="acs-footer col-md-12 information-zone">
				<div class="row">
					<div class="col-md-10">network_means_pageType_156</div>
					<div class="acs-footer-icon col-md-2">
						<input type=checkbox id="show" class="div-right">
						<label for="show"><a data-tooltip="network_means_pageType_157"><i class="fa fa-plus"></i></a></label>
						<span id="content">network_means_pageType_157 </span>
					</div>
				</div>
			</div>
		</div>', @idAppViewPage);

INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
	from CustomPageLayout cpl, ProfileSet ps
	where cpl.description = 'TA_App_View (REISEBANK)' and pageType ='MOBILE_APP_APP_VIEW'and ps.name = 'PS_12232_REISEBANK_SMS_01';
