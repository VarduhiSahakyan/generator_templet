USE U5G_ACS_BO;

SET @createdBy = 'A709391';
SET @updateState =  'PUSHED_TO_CONFIG';

SET @BankUB = 'LBBW';
SET @BankB = 'Landesbank Baden-Württemberg';

SET @activatedAuthMeans = '[ {
  "authentMeans" : "OTP_SMS",
  "validate" : true
}, {
  "authentMeans" : "PASSWORD",
  "validate" : true
}, {
  "authentMeans" : "PWD_OTP",
  "validate" : true
}, {
  "authentMeans" : "REFUSAL",
  "validate" : true
}, {
  "authentMeans" : "MOBILE_APP",
  "validate" : true
}, {
  "authentMeans" : "INFO",
  "validate" : true
} ]';

SET @availableAuthMeans = 'OTP_SMS|PASSWORD|PWD_OTP|REFUSAL|MOBILE_APP|INFO';

SET @issuerCode = '19550';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);

update Issuer set availaibleAuthentMeans = @availableAuthMeans where id = @issuerId;

SET @subIssuerCode = '19550';
SET @subIssuerNameAndLabel = 'Landesbank Baden-Württemberg';
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode AND `name` = @subIssuerNameAndLabel);

update SubIssuer set authentMeans = @activatedAuthMeans where id = @subIssuerID;


/* CustomPageLayout - Insert the predefined layouts (in order to see the templates) */

SET @pageLayoutDescriptionPassword = CONCAT('Password OTP Form Page for ', @BankB);

INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'PASSWORD_OTP_FORM_PAGE', @pageLayoutDescriptionPassword);

/* CustomPageLayout_ProfileSet - Link the predefined layouts to the profileSet (in order to see the templates) */

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB, '_01'));

INSERT INTO `CustomPageLayout_ProfileSet` (`customPageLayout_id`, `profileSet_id`)
SELECT cpl.id, p.id
FROM `CustomPageLayout` cpl, `ProfileSet` p
WHERE cpl.description = @pageLayoutDescriptionPassword and p.id = @ProfileSet;

SET @layoutIdPassword = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` = @pageLayoutDescriptionPassword);

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	#optGblPage .warn {
		background-color: #3399ff
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
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
		max-width: 100%;
	}
	#networkLogo {
		max-height: 65px;
		max-width: 100%;
	}
	div#blue-banner {
        height: 50px !important;
        background-color: rgb(18,50,80);
        border-bottom: 5px solid rgb(18,50,80);
        width: 100%;
	}
	.paragraph {
		text-align: left;
		margin-bottom: 10px;
	}
	.paragraphDescription {
		text-align: left;
	}
	.paragraphDescription {
		text-align: left;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding-top: 1.5em;
		padding-right: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		padding-top: 1em;
		clear: both;
		font-size: 12px;
		color: #000000;
	}
	side-menu div.text-center {
		text-align: center;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		text-align: left;
		font-size: 14px;
		color: #000000;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
		display: grid;
	}
	#otp-form {
		display: inline-block;
		padding-top: 12px;
	}
	#otp-form input {
		box-sizing: content-box;
		padding: 5px 10px 3px;
		background-color: #fff;
		border: 1px solid rgba(0, 0, 0, .2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0, 0, 0, .1);
		font: 300 18px "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 35px;
	}
	#otp-form input:disabled {
		color: #bebebe !important;
		background-color: #dcdcdc !important;
		border-color: rgba(0, 0, 0, .05) !important;
		box-shadow: none !important;
	}
	#otp-form input:focus {
		border-color: #ff6a10 !important;
		outline-color: #ff6a10;
	}
	div#otp-fields-container {
		width: 100%;
		text-align: left;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	div#otp-fields {
		display: inline-block;
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
	#reSendOtp > button {
		background: none !important;
		color: #000000;
		border: none;
		padding: 0 !important;
		font: inherit;
		cursor: pointer;
		font-family: Arial, regular;
		font-size: 12px;
	}
	#reSendOtp > button:disabled {
		background: none !important;
		color: #000000;
		border: none;
		padding: 0 !important;
		font: inherit;
		cursor: not-allowed;
		font-family: Arial, regular;
		font-size: 12px;
	}
	#validateButton {
		display: inline-block;
		padding-top: 10px;
		margin-left: 1em;
		border-radius: 20px;
	}
	#validateButton button {
		display: inline-block;
		font-family: "Arial", Helvetica, Arial, sans-serif;
		font-size: 14px;
		border-radius: 20px;
		color: #ffffff;
		background: #449d44;
		padding: 10px 30px 10px 20px;
		border: solid #449d44 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton button:disabled {
		display: inline-block;
		font-family: "Arial", Helvetica, Arial, sans-serif;
		font-size: 14px;
		border-radius: 20px;
		color: #000;
		background: #fff;
		border-color: #dcdcdc;
		padding: 10px 30px 10px 20px;
		border: solid #000 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton > button > span {
		display: inline-block;
		float: left;
		margin-top: 3px;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		border: 1px solid #4e4e4e;
		min-width: 15rem;
		border-radius: 20px;
		font-size: 14px;
		padding-left: 0px !important;
		margin: 5px;
	}
	#validateButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		clear: both;
		width: 100%;
		background-color: rgb(18, 50, 80);
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-position-x: -2px;
		background-size: contain;
		display: inline-block;
		margin-right: 3px;
	}
	#footer #helpButton button span:before {
		content: '''';
	}
	#footer #cancelButton button span:before {
		content: '''';
	}
	#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	@media all and (max-width: 1610px) {
		#pageHeader {height: 96px;}
		.leftColumn { padding-bottom: 10em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#pageHeader {height: 96px;}
		#issuerLogo {max-height: 55px; }
		#networkLogo {max-height: 55px; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; }
		.paragraph { text-align: left;}
		.paragraphDescription {text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		#optGblPage { font-size: 14px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 10px; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size: 18px; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { margin-left: 0px; display: block; float: none; width: 100%; margin-top: 10px;}
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 480px) {
		h1 { font-size: 16px; }
		div.side-menu div.menu-title { display: inline; }
		#optGblPage { font-size: 14px;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 0em; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 10px; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 180px; margin-left: auto; margin-right: auto;}
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; }
		.paragraphDescription {text-align: center;}
		.rightColumn { margin-top: 10px; }
	}
	@media all and (max-width: 309px) {
		.rightColumn { margin-top: 10px; }
	}
	@media all and (max-width: 250px) {
		.rightColumn { margin-top: 10px; }
	}
</style>
<div id="optGblPage">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>

			<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>

			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>

		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

		<div id="displayLayout" class="row">
			<div id="blue-banner"></div>
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
				<div id="otp-fields-container">
					<div x-ms-format-detection="none" id="otp-fields">
						<pwd-form hide-input="true" min-length="8"></pwd-form>
					</div>
				</div>
				<div class="paragraph">
					<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
				</div>
			</div>
		</div>
		<div id="footer">
			<div ng-style="style" class="style">
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
				<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			</div>
		</div>
</div>', @layoutIdPassword);


-- CustomItemSet --

SET @status = 'DEPLOYED_IN_PRODUCTION';
INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_PASSWORD_UNIFIED_Current'), NULL, NULL,
 CONCAT('customitemset_', @BankUB, '_PASSWORD_UNIFIED'), @updateState, @status, 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @BankUB, '_OTP_SMS_UNIFIED_Current'), NULL, NULL,
 CONCAT('customitemset_', @BankUB, '_OTP_SMS_UNIFIED'), @updateState, @status, 1, NULL, NULL, @subIssuerID);


-- Profile --

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD_UNIFIED'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_OTP_SMS_UNIFIED'));

SET @authentMeansPWD_OTP = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PWD_OTP');
SET @authentMeansPassword = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'PASSWORD');
SET @authentMeansOTP_SMS = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS');

INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`,`dataEntryFormat`, `dataEntryAllowedPattern`, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'PWD_OTP', NULL, NULL, CONCAT(@BankUB,'_PWD_OTP'), @updateState, 3, '6:(:DIGIT:1)', '^[^OIi]*$', @authentMeansPWD_OTP, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'PASSWORD (UNIFIED)', NULL, NULL, CONCAT(@BankUB,'_PASSWORD_UNIFIED_01'), @updateState, 3, '25:(:ALPHA_MAJ:1)&(:ALPHA_MIN:1)&(:DIGIT:1)', NULL, @authentMeansPassword, @customItemSetPassword, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'OTP_SMS_UNIFIED (UNIFIED)', NULL, NULL, CONCAT(@BankUB,'_SMS_UNIFIED_01'), @updateState, 3,'6:(:DIGIT:1)','^[^OIi]*$', @authentMeansOTP_SMS, @customItemSetSMS, NULL, NULL, @subIssuerID);


-- Rule --

SET @profilePWD_OTP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PWD_OTP'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_PASSWORD_UNIFIED_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_UNIFIED_01'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'PWD_OTP (UNIFIED)', NULL, NULL, 'PWD_OTP (UNIFIED)', @updateState, 8, @profilePWD_OTP),
(@createdBy, NOW(), 'PASSWORD (UNIFIED)', NULL, NULL, 'PASSWORD (UNIFIED)', @updateState, 9, @profilePassword),
(@createdBy, NOW(), 'OTP_SMS_UNIFIED (UNIFIED)', NULL, NULL, 'OTP_SMS (UNIFIED)', @updateState, 10, @profileSMS);

SET @profileSMSNormal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_SMS_01'));
UPDATE Rule SET orderRule = 11 WHERE fk_id_profile = @profileSMSNormal AND name = 'OTP_SMS (NORMAL)';

SET @profileDefaultRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@BankUB,'_DEFAULT_REFUSAL'));
UPDATE Rule SET orderRule = 12 WHERE fk_id_profile = @profileDefaultRefusal AND name = 'REFUSAL (DEFAULT)';

-- Rule condition --

SET @rulePWD_OTP = (SELECT id FROM `Rule` WHERE `description` = 'PWD_OTP (UNIFIED)' AND `fk_id_profile` = @profilePWD_OTP);
SET @rulePassword = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD (UNIFIED)' AND `fk_id_profile` = @profilePassword);
SET @ruleSMS = (SELECT id FROM `Rule` WHERE `description` = 'OTP_SMS_UNIFIED (UNIFIED)' AND `fk_id_profile` = @profileSMS);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_PWD_OTP_UNIFIED'), @updateState, @rulePWD_OTP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_PASSWORD_UNIFIED'), @updateState, @rulePassword),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_UNIFIED'), @updateState, @ruleSMS);


-- Condition Transaction Statuses --

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PWD_OTP_UNIFIED') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_PASSWORD_UNIFIED') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name`=CONCAT('C1_P_', @BankUB, '_01_PASSWORD_UNIFIED') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name`=CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_UNIFIED') AND (ts.`transactionStatusType`='KNOWN_PHONE_NUMBER' AND ts.`reversed`=FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @BankUB, '_01_OTP_SMS_UNIFIED') AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = TRUE);


-- Condition Means Process Statuses --

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PWD_OTP_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PWD_OTP_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PWD_OTP_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PWD_OTP_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PWD_OTP_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('PARENT_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PWD_OTP_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('HUB_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('HUB_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPassword
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPassword
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_PASSWORD_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('PARENT_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('HUB_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_AVAILABLE') AND mps.`reversed`=FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPassword
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansOTP_SMS
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPassword
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed`=TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name`= CONCAT('C1_P_',@BankUB,'_01_OTP_SMS_UNIFIED')
  AND mps.`fk_id_authentMean`= @authentMeansPWD_OTP
  AND (mps.`meansProcessStatusType` IN ('PARENT_AUTHENTICATION_MEAN_AVAILABLE') AND mps.`reversed`=FALSE);


SET @ruleConditionPWD_OTP = (SELECT id FROM RuleCondition WHERE name = CONCAT('C1_P_', @BankUB, '_01_PWD_OTP_UNIFIED') AND fk_id_rule = @rulePWD_OTP);
INSERT INTO Thresholds (isAmountThreshold, reversed, thresholdType, value, fk_id_condition)
VALUES (b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 3, @ruleConditionPWD_OTP);

-- ProfileSet Rule --

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @BankUB, '_01') AND r.`id` IN (@rulePWD_OTP, @rulePassword, @ruleSMS);


-- VISA --

SET @MaestroVID = NULL;
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');

-- Elements for the profile PASSWORD
SET @currentAuthentMean = 'PASSWORD';
SET @currentPageType = 'OTP_FORM_PAGE';

/* Here are the images for all pages associated to the PASSWORD Profile */
SET @issuerLogoName = 'LBBW_LOGO';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', @BankB, @MaestroVID, im.id, @customItemSetPassword
FROM `Image` im WHERE im.name LIKE CONCAT('%',@issuerLogoName,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetPassword
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';



INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetPassword
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';


/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY',
        'Ihre SMS-TAN für die Zahlung bei @merchant über @amount lautet: @otp', @MaestroVID, NULL, @customItemSetPassword);

/*PASSWORD_PAGE*/
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>BW-Secure Passwort eingeben</b>', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte geben Sie das von Ihnen vergebene BW-Secure Passwort ein, um den genannten Vorgang zu bestätigen. Diese Information wird dem Händler nicht mitgeteilt. ', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, '<b>Informationen zur Zahlung</b>', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12,@currentPageType, 'Authentifizierung läuft', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13,@currentPageType, 'Bitte warten Sie ein paar Sekunden, Ihre Eingabe wird geprüft. ', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14,@currentPageType, 'Der Zahlungsvorgang wurde abgebrochen!', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15,@currentPageType, 'Ihr Kauf wird storniert, Sie werden automatisch zur Händler-Webseite weitergeleitet. ', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30,@currentPageType, 'Automatischer Abbruch', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31,@currentPageType, 'Aus Sicherheitsgründen wurde die Transaktion abgebrochen, da die Bestätigung nicht in der erforderlichen Zeit erfolgt ist. Der Einkauf wurde nicht durchgeführt. Bitte versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32,@currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33,@currentPageType, 'Auf Grund eines technischen Fehlers wurde die Transaktion abgebrochen. Der Kauf wurde nicht durchgeführt. Bitte versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Bestätigen', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Shop', @MaestroVID, NULL, @customItemSetPassword);

/* Elements for the FAILURE page, for PASSWORD Profile */

SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Transaktion', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, ' Unseren 24-Stunden Service erreichen Sie jederzeit unter +49 69-66571333', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Mit dem Klick auf "Zurück zum Shop" werden Sie in den Shop zurück geleitet.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
 'de', 7, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
'de', 32,@currentPageType, 'Technischer Fehler', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
'de', 33,@currentPageType, 'Auf Grund eines technischen Fehlers wurde die Transaktion abgebrochen. Der Kauf wurde nicht durchgeführt. Bitte versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
'de', 175, @currentPageType, 'Zurück zum Shop', @MaestroVID, NULL, @customItemSetPassword);

/* Elements for the HELP page, for PASSWORD Profile */

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Ihre Kreditkartenzahlung muss aus Sicherheitsgründen mit 3D-Secure bestätigt werden. ', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Um eine Zahlung freizugeben bestätigen Sie diese mit Ihrem Passwort, welches Sie bei der Registrierung für BW-Secure vergeben haben. Für Änderungen Ihres Passworts loggen Sie sich im BW-Secure Portal ein:', @MaestroVID, NULL, @customItemSetPassword),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetPassword);



/* Elements for the profile SMS : */

SET @currentAuthentMean = 'OTP_SMS';
SET @currentPageType = 'OTP_FORM_PAGE';

/* Here are the images for all pages associated to the SMS Profile */
SET @issuerLogoName = 'LBBW_LOGO';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG',
       'de', 1, 'ALL', @BankUB, @MaestroVID, im.id, @customItemSetSMS
FROM `Image` im WHERE im.name LIKE CONCAT('%',@issuerLogoName,'%');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG',
       'de', 2, 'ALL', 'Verified by Visa™', n.id, im.id, @customItemSetSMS
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_LOGO%' AND n.code LIKE '%VISA%';


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @createdBy, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL', 'se_MasterCard SecureCode™', n.id, im.id, @customItemSetSMS
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_ID_LOGO%' AND n.code LIKE '%MASTERCARD%';

/* Here is what the content of the SMS will be */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY',
        'Ihre SMS-TAN für die Zahlung bei @merchant über @amount lautet: @otp', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the OTP page, for SMS Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Transaktion', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_43'), 'PUSHED_TO_CONFIG',
 'de', 43, @currentPageType, 'BW-Secure mTan eingeben', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, 'Geben Sie die gerade erhaltene mTAN in das Feld "mTAN" ein, um den Vorgang fortzuführen. Diese Information wird dem Händler nicht mitgeteilt.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'mTan', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Bestätigen', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
 'de', 4, @currentPageType, '<span class="fa fa-refresh" aria-hidden="true"> </span>mTan neu anfordern', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL,  CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
 'de', 6,  @currentPageType, 'Abbrechen',  @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy,  NOW(), NULL, NULL, NULL,  CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
'de', 7,  @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26, @currentPageType, 'Vorgang erfolgreich bestätigt mit BW-Secure', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27, @currentPageType, 'Die Zahlung wird nun geprüft und abschließend vom Händler weiterberarbeitet.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
 'de', 28, @currentPageType, 'Ungültige Eingabe(n)', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
 'de', 29, @currentPageType, 'Das eingegebene Passwort und/oder die mTAN war(en) nicht korrekt. Bitte prüfen Sie die Eingaben und versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
 'de', 34, @currentPageType, 'SMS wird versendet.', @MaestroVID, NULL, @customItemSetSMS),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
 'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie eine neue mTAN. Alle vorherigen mTANs sind nicht mehr gültig.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, @currentPageType, 'Zurück zum Shop', @MaestroVID, NULL, @customItemSetSMS);



/* Elements for the FAILURE page, for SMS Profile */

SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Transaktion', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, ' Unseren 24-Stunden Service erreichen Sie jederzeit unter +49 69-66571333', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Mit dem Klick auf "Zurück zum Shop" werden Sie in den Shop zurück geleitet.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
 'de', 7, @currentPageType, 'Hilfe', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32,@currentPageType, 'Zahlungsabbruch', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33,@currentPageType, 'Sie haben zu oft ungültige Daten eingegeben. Zu Ihrer Sicherheit wird der Zahlungsvorgang daher abgebrochen. Bitte versuchen Sie es erneut.', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
    'de', 175, @currentPageType, 'Zurück zum Shop', @MaestroVID, NULL, @customItemSetSMS);


/* Elements for the HELP page, for SMS Profile */

SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hilfe</b>', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Ihre Kreditkartenzahlung muss aus Sicherheitsgründen mit 3D-Secure bestätigt werden. ', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Um eine Zahlung freizugeben bestätigen Sie diese mit Ihrem Passwort, welches Sie bei der Registrierung für BW-Secure vergeben haben. Für Änderungen Ihres Passworts loggen Sie sich im BW-Secure Portal ein:', @MaestroVID, NULL, @customItemSetSMS),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@currentPageType,'_11'), 'PUSHED_TO_CONFIG',
 'de', 11, @currentPageType, 'Hilfe schließen', @MaestroVID, NULL, @customItemSetSMS);
