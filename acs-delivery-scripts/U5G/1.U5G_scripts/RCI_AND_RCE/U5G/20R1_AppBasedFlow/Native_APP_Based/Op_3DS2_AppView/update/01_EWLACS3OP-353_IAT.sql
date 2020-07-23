USE U5G_ACS_BO;

SET @customPageLayoutDesc_appView = 'LANGUAGE_Choice_App_View (OP)';
SET @pageType = 'APP_VIEW_LANGUAGE_SELECT';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent` SET `value` = '<style>
	.acs-container {
		padding: 0.5em;
	}
	.acs-header {
		margin-bottom: 0.5em;
	}
	div#bankLogoDiv {
		width: 50%;
		float: left;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#issuerLogo {
		max-height: 96px;
		max-width: 100%;
	}
	div#networkLogoDiv {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#networkLogo {
		max-height: 96px;
		max-width: 100%;
	}
	.acs-purchase-context {
		margin-bottom: 2em;
		margin-top: 0.5em;
		height: 24.5em;
	}
	.acs-purchase-context button,
	.acs-purchase-context input {
		width: 100%;
		margin-bottom: 0.5em;
		text-transform: uppercase;
	}
	.acs-challengeInfoHeader {
		text-align: center;
		font-weight: bold;
		font-size: 1.15em;
		margin-bottom: 1.1em;
	}
	.acs-challengeInfoText {
		white-space: normal;
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
	.select-radio {
		width: 10% !important;
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
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
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
</style>
</head>
<body>
<div class="acs-container col-md-12">
	<!-- ACS HEADER | Branding zone-->
	<div class="acs-header row branding-zone">
		<div id="bankLogoDiv" class="col-md-6">
			<img src="network_means_pageType_251" id = "issuerLogo" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
		</div>
		<div id="networkLogoDiv" class="col-md-6">
			<img src="network_means_pageType_254" id = "networkLogo" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
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
			<!-- DO NOT change the id attribute of the form tag -->
			<form id="select-languages-form" action="HTTPS://EMV3DS/challenge" method="get">
				<!-- The list of selectable values will be inserted here by the challenge-app service -->
				<div>
					<!-- The value attribute of the input tag can be set as a customItem -->
					<input type="submit" id="select-languages-submit" class="btn btn-primary" value="network_means_pageType_154" data-cy="CHALLENGE_LANGUAGE_SELECT_FORM_SUBMIT" />
				</div>
			</form>
		</div>
	</div>
	<!-- ACS FOOTER | Information zone -->
	<div class="acs-footer col-md-12 information-zone">
		<div class="row">
			<div class="col-md-10">network_means_pageType_156</div>
			<div class="acs-footer-icon col-md-2">
				<a tabindex="0" role="button"
				   data-container="body" data-toggle="popover" data-placement="top"
				   data-trigger="focus" data-content="network_means_pageType_157">
					<i class="fa fa-plus"></i>
				</a>
			</div>
		</div>
	</div>
</div>' WHERE fk_id_layout = @idAppViewPage ;



SET @amName = 'OOB';
SET @username = 'A757435';
SET @BankB = 'OP';
SET @Banklb = LOWER(@BankB);
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_20000_MOBILE_APP_01');

SET @networkVISA = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @updateState = 'PUSHED_TO_CONFIG';
SET @pageType = 'APP_VIEW_LANGUAGE_SELECT';

SET @locale = 'fi';
/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 251, @pageType, CONCAT(@BankB, '_SMALL_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_small.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 252, @pageType, CONCAT(@BankB, '_MEDIUM_LOGO'), NULL, im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_medium.png');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', @updateState, @locale, 253, @pageType, CONCAT(@BankB, '_LARGE_LOGO'),NULL,im.id, @customItemSetId
  FROM `Image` im WHERE im.name = CONCAT(@Banklb, '_large.png');

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 254, @pageType, 'MC_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 255, @pageType, 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', @updateState, @locale, 256, @pageType, 'MC_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';

-- 3x VISA logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 254, @pageType, 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 255, @pageType, 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', @updateState, @locale, 256, @pageType, 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
  FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';


SET @ordinal = 151;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);

SET @ordinal = 152;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


SET @ordinal = 153;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


SET @ordinal = 155;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);

SET @ordinal = 156;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);

SET @ordinal = 157;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);

SET @ordinal = 160;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


SET @ordinal = 161;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


SET @ordinal = 162;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'fi'), @updateState, 'fi', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'en'), @updateState, 'en', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code, '_', @amName, '_', @pageType, '_', @ordinal, '_', 'se'), @updateState, 'se', @ordinal, @pageType, @text, NULL, NULL, @customItemSetId FROM `Network` n WHERE  n.id in (@networkVISA);


