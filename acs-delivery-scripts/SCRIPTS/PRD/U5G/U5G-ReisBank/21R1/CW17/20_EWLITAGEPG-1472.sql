use U5G_ACS_BO;

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @issuerCode = '10300';
SET @subIssuerCode = '12000';

SET @updateState =  'PUSHED_TO_CONFIG';
SET @status = 'DEPLOYED_IN_PRODUCTION';
SET @activatedAuthMeans = '
[ {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
}  ]';


SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @BankUB);

/* SubIssuer */
UPDATE `SubIssuer` SET `authentMeans` = @activatedAuthMeans WHERE `fk_id_issuer` = @issuerId AND `code` = @subIssuerCode;

/* CustomPageLayout */
INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES  (NULL,'INFO_REFUSAL_PAGE', CONCAT('INFO Refusal Page (', @BankUB, ')'));

/* CustomPageLayout_ProfileSet */
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_12232_REISEBANK_SMS_01');

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
    SELECT cpl.id, p.id
    FROM `CustomPageLayout` cpl, `ProfileSet` p
    WHERE cpl.description = CONCAT('INFO Refusal Page (', @BankUB, ')') and p.id = @ProfileSet;

/* CustomComponent */
SET @layoutIdRefusalPage =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @BankUB, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
	VALUES( 'div', '
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
	#headingTxt {
		font-size: large;
		font-weight: bold;
		width: 80%;
		margin: auto;
		display: block;
		text-align: center;
		padding: 4px 1px 1px 1px;
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
	div#message-container.info {
			background-color:#C9302C;
	}
	div#message-controls {
		text-align: center;
		padding-bottom: 10px;
		padding-top: 0px;
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
		width: 60%;
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
	button span.fa {
		padding-right: 7px;
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
		.menu-title {display: none;}
		#centerPieceLayout {width: 100%; min-height: 120px;}
		div#centerPieceLayout {min-height: 120px;}
		div#leftMenuLayout {width: 100%;}
		.paragraph {text-align: center;}
	}
	@media screen and (max-width: 480px) {
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
<div id = "main-container" class="container-fluid">
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
						<custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
						</custom-text>
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

	<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''"
	back-button="''network_means_pageType_175''" show=true></message-banner>

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
			<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
					</custom-text>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
					</custom-text>
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
</div>', @layoutIdRefusalPage);

/* CustomItemSet */
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
  (@createdBy, NOW(), CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '__MISSING_AUTHENTICATION_REFUSAL_Current'), NULL, NULL,
	CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'), @updateState, @status, 1, NULL, NULL, @subIssuerID);

/* Profile */
SET @customItemSetINFORefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @authMeanINFO = (SELECT id FROM `AuthentMeans` WHERE `name` = 'INFO');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
  (@createdBy, NOW(), 'INFO', NULL, NULL, CONCAT(@subIssuerCode, '_', @BankUB,'_MISSING_AUTHENTICATION_REFUSAL'), @updateState, -1,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanINFO, @customItemSetINFORefusal, NULL, NULL, @subIssuerID);

/* Rule */
SET @profileINFO = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@subIssuerCode, '_', @BankUB,'_MISSING_AUTHENTICATION_REFUSAL'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
  (@createdBy, NOW(), 'MISSING_AUTHENTICATION', NULL, NULL, 'REFUSAL(Missing Authentication)', @updateState,2, @profileINFO);

UPDATE   `Rule` SET `orderRule` = 3 WHERE `name` = 'OTP_SMS (NORMAL)' AND `description` = '12000_BASEPS_OTP_SMS_NORMAL_REISEBANK';
UPDATE   `Rule` SET `orderRule` = 4 WHERE `name` = 'REFUSAL (DEFAULT)' AND `description` = '12000_BASEPS_REFUSAL_DEFAULT_REISEBANK';

/* RuleCondition */
SET @ruleINFOnormal = (SELECT id FROM `Rule` WHERE `description`='MISSING_AUTHENTICATION' AND `fk_id_profile`=@profileINFO);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
  (@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB), @updateState, @ruleINFOnormal);

/* Condition_TransactionStatuses */
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
  SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
  WHERE c.`name`=CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB) AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=TRUE);

/* Condition_MeansProcessStatuses */
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB)
	AND mps.`fk_id_authentMean`=@authMeanINFO
	AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
  SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
  WHERE c.`name`=CONCAT('C1_P_', @subIssuerCode, '_01_MISSING_AUTHENTICATION_REFUSAL_', @BankUB)
	AND mps.`fk_id_authentMean`=@authMeanINFO AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

/* ProfileSet_Rule */
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
	SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
	WHERE ps.`name` = CONCAT('PS_12232_REISEBANK_SMS_01') AND r.`id` = @ruleINFOnormal;

/* CustomItem */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_DEFAULT_REFUSAL'));
SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_MISSING_AUTHENTICATION_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, @customItemSetRefusalMissing FROM `CustomItem` n WHERE fk_id_customItemSet = @customItemSetREFUSAL;

SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroMID = NULL;
SET @currentAuthentMean = 'INFO';
SET @locale = 'de';
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Zahlungsfreigabe nicht möglich';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 1
                                           AND `value` ='Aus Sicherheitsgründen wurde der Einkauf mit Mastercard® Identity Check™ abgelehnt.';

SET @value = 'Leider konnten wir Ihre Anfrage nicht ausführen, da wir keine Freigabe-Methode für Ihre Karte gefunden haben.  Um Mastercard® Identity Check™ nutzen zu können, registrieren Sie sich bitte für die RBMC Secure App. Bei Fragen kontaktieren Sie bitte unseren Kundenservice unter 0721 47666 3580.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 2
                                           AND `value` ='Bitte wenden Sie sich an unseren Kundenservice unter der Telefonnummer 0721 47666 3580.';

SET @value = 'Zahlung nicht ausgeführt - Karte ist nicht für 3D Secure registriert';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 22
                                           AND `value` ='Zahlung abgelehnt';

SET @value = 'Die Zahlung konnte nicht ausgeführt werden, da Ihre Karte nicht für 3D Secure Zahlungen registriert ist. Sollten Sie den Kauf fortsetzen wollen, registrieren Sie sich bitte vorab für die RBMC Secure App.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 23
                                           AND `value` ='Ihre Zahlung mit Mastercard® Identity Check™ wurde abgelehnt.';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@pageTypes,'_175'), @updateState,
         @locale, 175, @pageTypes, 'Zurück zum Shop', @MaestroMID, NULL, @customItemSetRefusalMissing);

SET @pageTypes = 'HELP_PAGE';
SET @value = 'Mastercard hat das Verfahren Mastercard® Identity Check™ eingeführt, um Online-Shopping einfacher und sicherer zu gestalten.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 1
                                           AND `value` ='Mastercard hat das Verfahren Mastercard® Identity Check™ eingeführt, um Online-Shopping  einfacher und sicherer zu gestalten. Mit einer mobilen TAN werden ihre Kartendaten so vor Missbrauch im Internet geschützt.';

SET @value = 'Sie können Online-Zahlungen auf Ihrem Mobil-Telefon in Ihrer RBMC Secure App freigeben. Bei Fragen kontaktieren Sie bitte unseren Kundenservice unter 0721 47666 3580.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 2
                                           AND `value` ='Die TAN wird Ihnen per SMS an die hinterlegte Telefonnummer geschickt. Zusammen mit Mastercard bietet Ihnen die ReiseBank AG damit mehr Sicherheit bei ihren Online-Zahlungen mit Ihrer ReiseBank Mastercard. Falls Ihre Telefonnummer falsch ist oder Sie keine TAN erhalten, kontaktieren Sie bitte unseren Kundenservice unter 0721 47666 3580.';


SET @locale = 'en';
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Payment approval not possible.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 1
                                           AND `value` ='For sefety reasons, your Mastercard® Identity Check™ authentication has been refused.';

SET @value = 'Unfortunately, we were not able to complete your request because we could not find an authentication method for your card.  To use Mastercard® Identity Check™ please register for the RBMC Secure App. If you have any questions, please contact our customer service at 0721 47666 3580.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 2
                                           AND `value` ='Please contact customer service under 0721 47666 3580.';

SET @value = 'Payment not completed – card is not registered for 3D Secure.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 22
                                           AND `value` ='Payment refused';

SET @value = 'The payment could not be completed because your card is not registered for 3D Secure payments. If you wish to continue with the purchase, please register for the RBMC Secure App first.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 23
                                           AND `value` ='Your payment with Mastercard® Identity Check™  is refused!.';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@pageTypes,'_175'), @updateState,
         @locale, 175, @pageTypes, 'Back to merchant website', @MaestroMID, NULL, @customItemSetRefusalMissing);

SET @pageTypes = 'HELP_PAGE';
SET @value = 'Mastercard introduced Mastercard® Identity Check™ in order to increase simplicity and security of online shopping.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 1
                                           AND `value` ='Mastercard introduced Mastercard® Identity Check™ in order to increase simplicity and security of online shopping. You will receive a one-time password via SMS, which is sent to your registered and valid phone number.';

SET @value = 'You can enable online payments on your mobile phone in your RBMC Secure App. If you have any questions, please contact our customer service at 0721 47666 3580.';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetINFORefusal
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = 2
                                           AND `value` ='You have to submit this code into the authentication page to validate your 3-D Secure authentication. With this procedure, Mastercard and ReiseBank AG offer you higher security when paying online with your ReiseBank Mastercard at participating merchants. If your phone number is incorrect or if you don''t receive the SMS, please contact customer service under 0721 47666 3580.';