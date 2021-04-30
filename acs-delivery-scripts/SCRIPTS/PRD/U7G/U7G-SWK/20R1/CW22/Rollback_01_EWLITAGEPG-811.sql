USE `U7G_ACS_BO`;

SET @BankB = 'SWISSKEY';
SET @BankUB = 'SGKB';
SET @issuerCode = '41001';
SET @subIssuerCode = '78100';
SET @subIssuerNameAndLabel = 'St. Galler Kantonalbank AG';

START TRANSACTION;
SET FOREIGN_KEY_CHECKS = 0;

-- update CustomComponent
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION`like CONCAT('Polling Page (', @BankB, ')%'));

UPDATE CustomComponent SET value = '
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
		width: 40%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderCenter {
		width: 30%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 30%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width:100%;
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
		text-align:center;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}

	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		display:inline;
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
		content:'''''''';
	}
	#footer #cancelButton button span:before {
		content:'''''''';
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
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height : 55px; }
		#networkLogo {max-height : 55px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#pageHeader {height: 90px;}
		#issuerLogo {max-height : 50px; }
		#networkLogo {max-height : 50px; }
		#optGblPage {     font-size : 14px; }
		.leftColumn {display:block;float:none;width:100%;}
		.rightColumn {display:block;float:none;width:100%;margin-left:0px;  margin-top: 60px; }
		.paragraph {margin: 0px 0px 10px;text-align: center;}
		.paragraphDescription {text-align: center;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage {font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height : 45px; }
		#networkLogo {max-height : 45px; }
		.leftColumn {display:block;float:none;width:100%;}
		.rightColumn {margin-left:0px;display:block;float:none;width:100%;  margin-top: 65px; }
		.paragraph {margin: 0px 0px 10px;text-align: center;}
		.paragraphDescription {text-align: center;}
	}
	@media all and (max-width: 480px) {
		h1 {font-size:16px;}
		div.side-menu div.menu-title {display:inline;}
		#optGblPage {   font-size : 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height : 35px; }
		#networkLogo {max-height : 30px; }
		.leftColumn {display:block;float:none;width:100%;}
		.rightColumn {display:block;float:none;width:100%;margin-left:0px;  margin-top: 75px; }
		.paragraph {text-align: center;}
		.paragraphDescription {text-align: center;}
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

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
' WHERE `fk_id_layout` = @layoutId;

-- delete from CustomItem
SET @MaestroMName = (SELECT `name` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @currentPageType = 'POLLING_PAGE';
SET @currentAuthentMean = 'MOBILE_APP';
DELETE FROM CustomItem WHERE  `name` = CONCAT(@MaestroMName,'_',@currentAuthentMean,'_',@currentPageType,'_10');

-- update Issuer and SubIssuer
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);
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
}]';
SET @availableAuthMeans = 'REFUSAL|OTP_SMS_EXT_MESSAGE|MOBILE_APP|INFO';

UPDATE `Issuer` SET `availaibleAuthentMeans` = @availableAuthMeans WHERE `id` = @issuerId;
UPDATE `SubIssuer` SET `authentMeans` = @activatedAuthMeans WHERE `id` = @subIssuerID;


SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanUNDEFINED = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');

SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_TA_01'));
SET @profileUNDEFINED = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_UNDEFINED_01'));
SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB, '_DEFAULT_REFUSAL'));

SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_EXT (FALLBACK)' AND `fk_id_profile` = @profileSMS);
SET @ruleUNDEFINED = (SELECT id FROM `Rule` WHERE `description`='UNDEFINED' AND `fk_id_profile`=@profileUNDEFINED);

SET @idConditionUndefined = (SELECT id FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_UNDEFINED'));
SET @idConditionOTPSMSEXT = (SELECT id FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK'));
SET @idConditionOTPAPPNORMAL = (SELECT id FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_', @BankUB, '_01_OTP_APP_NORMAL'));

SET @idMeansProcessStatuses1 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanUNDEFINED AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses2 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses3 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed`=TRUE));
SET @idMeansProcessStatuses4 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses5 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed`=FALSE));
SET @idMeansProcessStatuses6 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed`=TRUE));
SET @idMeansProcessStatuses7 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `reversed`=FALSE));

SET @idMeansProcessStatuses8 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_AVAILABLE' AND `reversed` = FALSE));
SET @idMeansProcessStatuses9 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='MEANS_DISABLED' AND `reversed` = TRUE));
SET @idMeansProcessStatuses10 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authMeanOTPsms AND (`meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE' AND `reversed` = FALSE));
SET @idMeansProcessStatuses11 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND `reversed` = FALSE));

SET @idMeansProcessStatuses12 = (SELECT id FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`= @authentMeansMobileApp AND (`meansProcessStatusType`='USER_CHOICE_DEMANDED' AND `reversed` = TRUE));

-- delete from Condition_MeansProcessStatuses
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = @idConditionUndefined
                                             AND `id_meansProcessStatuses` in (@idMeansProcessStatuses1, @idMeansProcessStatuses2, @idMeansProcessStatuses3, @idMeansProcessStatuses4, @idMeansProcessStatuses5, @idMeansProcessStatuses6, @idMeansProcessStatuses7);
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = @idConditionOTPSMSEXT
                                             AND `id_meansProcessStatuses` in (@idMeansProcessStatuses8, @idMeansProcessStatuses9, @idMeansProcessStatuses10, @idMeansProcessStatuses11);
DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition` = @idConditionOTPAPPNORMAL
                                             AND `id_meansProcessStatuses` in (@idMeansProcessStatuses12);

-- delete from RuleCondition
DELETE FROM `RuleCondition` WHERE (`name` = CONCAT('C1_P_', @BankUB, '_01_UNDEFINED') AND `fk_id_rule` = @ruleUNDEFINED)
                              or  (`name` = CONCAT('C1_P_', @BankUB, '_02_OTP_SMS_EXT_FALLBACK') AND `fk_id_rule` = @ruleSMSnormal);

-- delete from ProfileSet_Rule
SET @idProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));
DELETE FROM `ProfileSet_Rule` WHERE `id_profileSet` = @idProfileSet
                                AND `id_rule` = @ruleUNDEFINED;
-- delete and update Rule
DELETE FROM `Rule` WHERE `description` = 'UNDEFINED' AND `fk_id_profile` = @profileUNDEFINED;

UPDATE `Rule` SET `orderRule` = 7
WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileDefaultRefusal;

-- delete from Profile
DELETE FROM `Profile` WHERE `description` = 'UNDEFINED' AND `name` = CONCAT(@BankUB,'_UNDEFINED_01') AND `fk_id_subIssuer` =  @subIssuerID;


SET FOREIGN_KEY_CHECKS = 1;
COMMIT;