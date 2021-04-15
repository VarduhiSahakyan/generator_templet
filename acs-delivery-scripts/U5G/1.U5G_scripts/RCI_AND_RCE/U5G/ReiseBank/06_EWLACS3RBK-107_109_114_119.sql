USE U5G_ACS_BO;

#-RBK-107

SET @createdBy ='A758582';
SET @BankUB = 'ReiseBank';
SET @subIssuerCode = '12000';

/* CustomItem */
SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_DEFAULT_REFUSAL'));
SET @locale = 'de';
SET @ordinal = 20;
SET @pageTypes = 'REFUSAL_PAGE';
SET @value = 'Zahlung abgelehnt';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSAL
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;


SET @locale = 'en';
SET @value = 'Payment refused';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSAL
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;



SET @customItemSetREFUSALFRAUD = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @subIssuerCode, '_', @BankUB, '_DEFAULT_FRAUD'));
SET @locale = 'de';
SET @value = 'Zahlung abgelehnt';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSALFRAUD
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;


SET @locale = 'en';
SET @value = 'Payment refused';
UPDATE `CustomItem` SET `value` = @value WHERE `fk_id_customItemSet` = @customItemSetREFUSALFRAUD
                                           AND `pageTypes` = @pageTypes
                                           AND `locale` = @locale
                                           AND `ordinal` = @ordinal;


SET @masterCardId = (SELECT `id` FROM `Image` WHERE `name` = 'MC_ID_LOGO');
SET @masterCard = (SELECT `id` FROM `Image` WHERE `name` = 'MC_LOGO'); 
SET @subIssuerId = (SELECT `id` FROM `SubIssuer` WHERE `code` = '12000'); 

UPDATE `CustomItem` SET `fk_id_image` = @masterCardId WHERE `fk_id_image` = @masterCard AND `fk_id_customItemSet` IN (SELECT  `id` FROM `CustomItemSet` WHERE `fk_id_subIssuer` = @subIssuerId);

# RBK-114
SET @locale = 'en';
SET @username = 'W100851';
SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_12000_REISEBANK_SMS_01');
SET @pageType_OTP_FORM_PAGE ='OTP_FORM_PAGE';

SET @text = 'The SMS authentication will no longer be supported and therefore will be switched off. To continue using
Mastercard® Identity Check™ and to be able to make payments on the Internet please register for the RBMC Secure App.
You can download the RBMC Secure App free of charge from the App Store and Google Play.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND	 `ordinal` = 3
					AND `pageTypes` = @pageType_OTP_FORM_PAGE
					AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;

SET @locale = 'de';
SET @text = 'Die Authentifizierung per SMS wird in Kürze nicht mehr unterstützt und daher abgeschaltet. Um Mastercard®
Identity Check™ weiterhin zu nutzen und Zahlungen im Internet durchführen zu können, registrieren Sie sich bitte umgehend
für die RBMC Secure App. Die RBMC Secure App können Sie kostenfrei im App Store und bei Google Play herunterladen.';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND	 `ordinal` = 3
					AND `pageTypes` =@pageType_OTP_FORM_PAGE
					AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;


# RBK-109
SET @createdBy = 'W100851';
SET @BankUB = '12000';
SET @currentAuthentMean = 'OTP_SMS';
SET @currentPageType = 'OTP_FORM_PAGE';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_12000_REISEBANK_SMS_01');

SET @MaestroMID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');

SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schliessen', @MaestroMID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'en', 174, @currentPageType, 'Close', @MaestroMID, NULL, @customItemSetSMS);

SET @customPageLayoutDesc_appView = 'OTP Form Page (ReiseBank)';
SET @pageType = 'OTP_FORM_PAGE';

SET @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent`
SET `value` = '
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
	 .paragraphFooter {
		margin: 0px 0px 10px;
		text-align: justify;
		color: #c9302c;
		max-width: 800px;
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
					<div class="text-center">
						<otp-form></otp-form>
						<div class="resendButton">
							<re-send-otp rso-label="''network_means_pageType_4''"></re-send-otp>
						</div>
					</div>
					<div class="text-center">
						<val-button val-label="''network_means_OTP_FORM_PAGE_42''" id="validateButton"></val-button>
					</div>
					<div class="paragraphFooter">
						<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
						</custom-text>
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
</div>'
WHERE `fk_id_layout` = @idAppViewPage;


# RBK-119


SET @ruleConditionAuthenticationName = 'C1_P_12000_01_MISSING_AUTHENTICATION_REFUSAL_ReiseBank';
SET @ruleConditionId = (SELECT id
                        FROM RuleCondition
                        WHERE name = @ruleConditionAuthenticationName);
SET @authMeanMobileApp = (SELECT id
                          FROM `AuthentMeans`
                          WHERE `name` = 'MOBILE_APP');

SET @idAuthMean = (SELECT id
                   FROM AuthentMeans
                   WHERE name = 'OTP_SMS');

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id
FROM `RuleCondition` c,
     `MeansProcessStatuses` mps
WHERE c.`name` = @ruleConditionAuthenticationName
  AND mps.`fk_id_authentMean` = @authMeanMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);


SET @IDMeansProcessStatuse = (SELECT id
                              FROM MeansProcessStatuses
                              WHERE meansProcessStatusType = 'HUB_AUTHENTICATION_MEAN_AVAILABLE'
                                AND reversed = TRUE
                                AND fk_id_authentMean = @idAuthMean);
DELETE
FROM Condition_MeansProcessStatuses
WHERE id_condition = @ruleConditionId
  AND id_meansProcessStatuses = @IDMeansProcessStatuse;

SET @ruleConditionSMS02Name = 'C1_P_12000_REISEBANK_SMS_02';

SET @ruleConditionId = (SELECT id
                        FROM RuleCondition
                        WHERE name = @ruleConditionSMS02Name);

SET @IDMeansProcessStatusUserChoise = (SELECT id
                                       FROM MeansProcessStatuses
                                       WHERE meansProcessStatusType = 'USER_CHOICE_DEMANDED'
                                         AND reversed = FALSE
                                         AND fk_id_authentMean = @idAuthMean);
DELETE
FROM Condition_MeansProcessStatuses
WHERE id_condition = @ruleConditionId
  AND id_meansProcessStatuses = @IDMeansProcessStatusUserChoise;

SET @IDMeansProcessStatusHubMean = (SELECT id
                                    FROM MeansProcessStatuses
                                    WHERE meansProcessStatusType = 'HUB_AUTHENTICATION_MEAN_AVAILABLE'
                                      AND reversed = FALSE
                                      AND fk_id_authentMean = @idAuthMean);
DELETE
FROM Condition_MeansProcessStatuses
WHERE id_condition = @ruleConditionId
  AND id_meansProcessStatuses = @IDMeansProcessStatusHubMean;

SET @ruleConditionId = (SELECT id
                        FROM RuleCondition
                        WHERE name = @ruleConditionSMS02Name);

SET @IDMeansProcessStatusHubMean = (SELECT id
                                    FROM MeansProcessStatuses
                                    WHERE meansProcessStatusType = 'HUB_AUTHENTICATION_MEAN_AVAILABLE'
                                      AND reversed = FALSE
                                      AND fk_id_authentMean = @idAuthMean);
DELETE
FROM Condition_MeansProcessStatuses
WHERE id_condition = @ruleConditionId
  AND id_meansProcessStatuses = @IDMeansProcessStatusHubMean;



INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id
FROM `RuleCondition` c,
     `MeansProcessStatuses` mps
WHERE c.`name` = @ruleConditionSMS02Name
  AND mps.`fk_id_authentMean` = @authMeanMobileApp
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = FALSE);


SET @ruleConditionUndefinedName = 'C1_P_12000_01_UNDEFINED';
SET @ruleConditionId = (SELECT id
                        FROM RuleCondition
                        WHERE name = @ruleConditionUndefinedName);

SET @IDMeansProcessStatuseHubMean = (SELECT id
                                     FROM MeansProcessStatuses
                                     WHERE meansProcessStatusType = 'HUB_AUTHENTICATION_MEAN_AVAILABLE'
                                       AND reversed = FALSE
                                       AND fk_id_authentMean = @idAuthMean);
DELETE
FROM Condition_MeansProcessStatuses
WHERE id_condition = @ruleConditionId
  AND id_meansProcessStatuses = @IDMeansProcessStatuseHubMean;


INSERT INTO Condition_TransactionStatuses (id_condition, id_transactionStatuses)
SELECT c.id,mps.id
FROM RuleCondition c,
     TransactionStatuses mps
WHERE c.name = @ruleConditionUndefinedName
  AND (mps.transactionStatusType = 'KNOWN_PHONE_NUMBER' AND mps.`reversed` = FALSE);


SET @profileFraud = (SELECT id FROM `Profile` WHERE `name` = '12000_REISEBANK_FRAUD_REFUSAL');
SET @ruleFraud = (SELECT id FROM `Rule` WHERE `fk_id_profile`=@profileFraud);
SET @fraudRuleConditionName = ('C1_P_12000_REISEBANK_05_REFUSAL_FRAUD');
SET @createdBy = ('W100851');
SET @updateState =	('PUSHED_TO_CONFIG');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL,@fraudRuleConditionName , @updateState, @ruleFraud);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name`=@fraudRuleConditionName AND (ts.`transactionStatusType`='PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed`=FALSE);


SET @customPageLayoutDesc = 'INFO Refusal Page (ReiseBank)';
SET @pageType = 'INFO_REFUSAL_PAGE';

SET @idAppViewPage = (select id
                      from `CustomPageLayout`
                      where `pageType` = @pageType
                        and DESCRIPTION = @customPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
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
</div>'
WHERE `fk_id_layout` = @idAppViewPage;

SET @profileSetName = 'PS_12232_REISEBANK_01';

UPDATE ProfileSet SET name = @profileSetName,description = @profileSetName
WHERE name = 'PS_12232_REISEBANK_SMS_01';