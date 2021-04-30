USE `U5G_ACS_BO`;

SET @availableAuthMeans = '|UNDEFINED';
SET @issuerCode = '10300';
SET @issuerName = '10300';
SET @BankUB = '12000';
SET @subIssuerCode = '12000';
SET @createdBy = 'W100851';
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @currentAuthentMean = 'MOBILE_APP';
SET @currentPageType = 'POLLING_PAGE';
SET @updateState =	'PUSHED_TO_CONFIG';
SET @subIssuerName = 'ReiseBank';




SET @activatedAuthMeans = '[ {
	"authentMeans" : "OTP_SMS",
	"validate" : true
}, {
	"authentMeans" : "REFUSAL",
	"validate" : true
},	{
	"authentMeans" : "INFO",
	"validate" : true
}, {
	"authentMeans" : "MOBILE_APP",
	"validate" : true
}, {
	"authentMeans" : "UNDEFINED",
	"validate" : true
} ]';




UPDATE Issuer
SET availaibleAuthentMeans = 'OTP_SMS|REFUSAL|INFO|MOBILE_APP|UNDEFINED'
WHERE code = @issuerCode
AND name = @issuerName;

SET @issuerId = (SELECT `id`
				 FROM `Issuer`
				 WHERE `code` = @issuerCode);


UPDATE SubIssuer
SET authentMeans = @activatedAuthMeans,
				   userChoiceAllowed = TRUE
WHERE fk_id_issuer = @issuerId
AND name = @subIssuerName;


SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerName);
/* Profile */

SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					   `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
					   `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
					   `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@BankUB,'_UNDEFINED_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authMeanUNDEFINED, NULL , NULL, NULL, @subIssuerID);


/* Rule */


SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));


INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
					`updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, 'UNDEFINED', @updateState, 5, @profileUNDEFINED);

SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_REISEBANK_DEFAULT_REFUSAL'));

UPDATE `Rule` SET `orderRule` = 6
WHERE `fk_id_profile` = @profileSMS;


/* RuleCondition */

SET @undefinedRuleConditionName = CONCAT('C1_P_',@BankUB,'_01_UNDEFINED');
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);
INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
	(@createdBy, NOW(), NULL, NULL, NULL, @undefinedRuleConditionName, @updateState, @ruleUNDEFINED);


SET @profileMobileApp = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
/* ProfileSet_Rule */
SET @ruleMobileApp = (SELECT id FROM `Rule` WHERE `description` = 'UNDEFINED' AND `fk_id_profile` = @profileMobileApp);
SET @RuleId = (SELECT  r.`id` FROM	`Rule` r WHERE	r.`id` = @ruleMobileApp);
SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = 'PS_12232_REISEBANK_SMS_01');
INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`) VALUES
	(@ProfileSet , @RuleId);
/* Condition_MeansProcessStatuses */



SET @authMeanMOBILE_APP = (SELECT id FROM `AuthentMeans` WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');

INSERT INTO Condition_TransactionStatuses (id_condition, id_transactionStatuses)
SELECT c.id,mps.id
FROM RuleCondition c,
     TransactionStatuses mps
WHERE c.name = @undefinedRuleConditionName
  AND (mps.transactionStatusType = 'KNOWN_PHONE_NUMBER' AND mps.`reversed` = FALSE);



INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @undefinedRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanUNDEFINED AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @undefinedRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanMOBILE_APP AND (mps.`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed`=FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @undefinedRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @undefinedRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`=	 @undefinedRuleConditionName
		AND mps.`fk_id_authentMean`=@authMeanMOBILE_APP AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`=	 @undefinedRuleConditionName
		AND mps.`fk_id_authentMean`=@authMeanMOBILE_APP AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);



SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_REISEBANK_SMS_01'));
SET @ruleSMS = (SELECT id FROM `Rule` WHERE `fk_id_profile`=@profileSMS);
SET @smsRuleConditionName = CONCAT('C1_P_', @BankUB, '_REISEBANK_SMS_02');

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
							 `updateState`, `fk_id_rule`) VALUES
	(@createdBy, NOW(), NULL, NULL, NULL,@smsRuleConditionName , @updateState, @ruleSMS);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name`=@smsRuleConditionName AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
	SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
	WHERE c.`name` = @smsRuleConditionName AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = TRUE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @smsRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_AVAILABLE' AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @smsRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_DISABLED' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @smsRuleConditionName
	AND mps.`fk_id_authentMean`=@authMeanOTPsms AND (mps.`meansProcessStatusType`='MEANS_PROCESS_ERROR' AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
	SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
	WHERE c.`name`= @smsRuleConditionName
		AND mps.`fk_id_authentMean`=@authMeanMOBILE_APP AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=FALSE);


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





SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), @updateState,
 'de', 10, @currentPageType, 'Alternativ Freigabe durch SMS anfordern', NULL, NULL, @customItemSetMobileApp),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_10'), @updateState,
 'en', 10, @currentPageType, 'Request authentication with SMS instead', NULL, NULL, @customItemSetMobileApp);


SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankUB, ')%') );


UPDATE CustomComponent SET value = '
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
	#switchId button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 26px;
		background: #FFFFFF;
		border-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 25rem;
		border-radius: 4px;
		font-size: 14px;
		padding-left: 2px !important;
        padding-right: 2px !important;
        padding: inherit;
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
		min-height: 150px;
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
		#rightContainer {display:block; float:none; width:100%; margin-left:0px;}
		.paragraph{ margin: 0px 0px 10px;text-align: left;}
		div#leftMenuLayout {width: 100%;}
        div#centerPieceLayout {min-height: 100px;}
        #switchId {padding-left: 10px;}
        #bottomLayout {display: block !important;}
	}
	@media screen and (max-width: 480px) {
		#main-container{max-width: 480px}
		.btn {font-size: 12px;}
        div#leftMenuLayout {width: 80%;}
		#centeredTitle {margin-top: 8px;}
		#bottomLayout {display: block !important;}
		#rightContainer {display:block;float:none;width:100%;margin-left:0px;  margin-top: 75px; }
        div.hideable-text {display: block !important;}
		.paragraph {text-align: left;}
        div#centerPieceLayout {min-height: 100px;}
        #switchId {padding-left: 10px;}
	}
	@media screen and (max-width: 390px) {
		#main-container{max-width: 390px; overflow: hidden;}
		#rightContainer {width: 100%;}
        div.hideable-text {display: block !important;}
	}
	@media (max-width: 360px) {
		#main-container{max-width: 360px; overflow: hidden;}
		body {font-size: 9px;}
		.btn {font-size: 9px;}
        div#leftMenuLayout {width: 83%;}
		#centeredTitle {margin-top: 4px;}
		#rightContainer {width: 100%;}
        div.hideable-text {display: block !important;}
        div#centerPieceLayout {min-height: 100px;}
        #switchId button {min-width: 22rem;}
	}
	@media (max-width: 347px) {
		#main-container{max-width: 347px; overflow: hidden;}
		body {font-size: 9px;}
		.btn {font-size: 9px;}
		#centeredTitle {margin-top: 4px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
		#rightContainer { margin-top: 75px; width: 100%; }
        div.hideable-text {display: block !important;}
        .paragraph {text-align: left;}
        div#centerPieceLayout {min-height: 100px;}
        #switchId button {min-width: 22rem;}
	}
	@media (max-width: 309px) {
		#main-container{max-width: 309px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
		#rightContainer {width: 100%;}
        div.hideable-text {display: block !important;}
        .paragraph {text-align: left;}
        #switchId button {min-width: 20rem;}
	}
	@media (max-width: 250px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
		#rightContainer {width: 100%;}
        div.hideable-text {display: block !important;}
        #switchId {padding-right: 0px;}
        #switchId button {min-width: 16rem;}
        #bottomMenu {width: 100%;}
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
			<div id="form-controls">
				<div class="row">
					<div class="back-link">
						<switch-means-button change-means-label="''network_means_pageType_10''" id="switchId"></switch-means-button>
					</div>
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
</div>
' WHERE `fk_id_layout` = @layoutId;

SET @profileSetName = 'PS_12232_REISEBANK_01';

UPDATE ProfileSet SET name = @profileSetName,description = @profileSetName
WHERE name = 'PS_12232_REISEBANK_SMS_01';