
USE `U5G_ACS_BO`;

set @subIssuerCode = '16500';
set @customITemSetDefaultRefusal= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_16500_DEFAULT_REFUSAL' );
set @customITemSetRefusal= (SELECT `id` from `CustomItemSet` where `name` = 'customitemset_16500_REFUSAL' );
SET @currentPageType = 'REFUSAL_PAGE';
SET @locale = 'de';
SET @value8Text = 'Nutzen Sie noch mTAN als Freigabe-Verfahren?';
SET @value10Text = '<ul><li>Seit April 2021 wird das mTAN-Verfahren von uns nicht mehr unterstützt und nach und nach für alle Kunden, die zurzeit noch mTAN verwenden, abgeschaltet.</li><li>Das bedeutet: Sie können Ihre Zahlungen ab sofort nicht mehr wie gewohnt mit einer mTAN freigeben und benötigen ein neues Freigabe-Verfahren. Die Einrichtung Ihres neuen Freigabe-Verfahrens dauert nur wenige Minuten – wie es geht, können Sie hier im Video sehen: www.ing.de/hilfe/adieu-mtan</li></ul>';
SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');


INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, 
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, 'VISA_OTP_REFUSAL_8_de', 'PUSHED_TO_CONFIG', @locale, 8, @currentPageType, @value8Text, NULL, NULL, @customITemSetRefusal FROM `Network` n WHERE  n.id in (@networkVISA);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, 
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
  SELECT 'T', 'InitPhase', NOW(), NULL, NULL, NULL, 'VISA_OTP_REFUSAL_10_de', 'PUSHED_TO_CONFIG', @locale, 10, @currentPageType, @value10Text, NULL, NULL, @customITemSetRefusal FROM `Network` n WHERE  n.id in (@networkVISA);
  
set @id_layout = (SELECT id from `CustomPageLayout` where `description` IN ('for ING 16500') and `pageType` = 'REFUSAL_PAGE');

UPDATE `CustomComponent` SET `value` = '

<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<style>
	/* global styles */
	#optGblPage {
		background-color:#f7f7f7;
		margin:0px;
		padding:0px;
		padding-bottom:1.5em;
	}
	.background-default { background-color:#f7f7f7;}
	.primary-color { color:#ff6200; }

    @font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
    #optGblPage{
		font-family: "INGme-Regular", Arial, Helvetica;
    }
	#header {
		background-color:#fff;
		display:flex;
		flex-direction:row;
		justify-content:space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top:1em;
		margin-bottom:1em;
		margin-left:1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top:1em;
		margin-bottom:1em;
		margin-right:1em;
	}
	@media screen and (min-width: 701px) {
		#optGblPage{
			font-size: 18px;
		}
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#optGblPage{
			font-size: 14px;
		}
	}
	@media screen and (max-width: 360px) {
		#optGblPage{
			font-size: 12px;
		}
	}
	.helpButtonClass button {
		border:0px;
	}
	.helpButtonClass span.fa-info:before {
		content:'''';
	}
	.helpButtonClass .fa-info {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width:1em;
		height:1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align:10%;
	}
	hr {
		padding-left:2em;
		padding-right:2em;
	}
	#content {
		background-color:#FFF;
		border-radius:1em;
		margin:1.5em;
		padding:1.5em;
	}
	#optGblPage .row {
		display:flex;
		flex-direction:row;
		margin-top:1em;
	}
	.col1 {
		width:30%;
	}
	.col2 {
		width: 35%;
	}
	.col3 {
		width:35%;
	}
	.colwidth2 {
			width:70%;
	}

	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div  span  {
		text-align:left;
		padding-left:0px;
		padding-right:0px;
		margin-left:0px;
		width:50%;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2)  {
		padding-left:0px;
		padding-right:0px;
	}
	/* overrides for the cancel and validate button */
	cancel-button button.btn {
		width:46%;
		height:30px;
		border:1px solid #000;
		line-height:12px;
	}
	cancel-button button.btn custom-text span {
		padding:0px;
	}
	cancel-button button.btn span.fa {
		display:none;
	}
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display:flex;
			flex-direction:column;
			margin-top:1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div  span  {
			display:block;
			float:none;
			text-align:left;
			width:100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2)  {
			padding-left:0px;
			padding-right:0px;
			display:block;
			width:100%;
			float:none;
		}
		cancel-button button.btn {
			display:block;
			float:none;
			width:100%;
			height:30px;
			border:1px solid #000;
			line-height:12px;
			margin-top:10px;
			margin-bottom:10px;
		}
		cancel-button button.btn custom-text span {
			padding:0px;
		}
		cancel-button button.btn span.fa {
			display:none;
		}
		.col1 {
			display:block;
			width:100%;
		}
		.col2 {
			display:block;
			width:100%;
		}
		.col3 {
			display:block;
			width:100%;
		}
		.colwidth2 {
			display:block;
			width:100%;
		}
		#menu-separator {
			display:none;
		}
		.externalImage {
			margin:0px;
			padding:0px;
		}
	}
</style>
<div id="optGblPage">
	<div id="header">
		<div>
			<custom-image id="issuerLogo"
				alt-key="''network_means_pageType_1_IMAGE_ALT''"
				image-key="''network_means_pageType_1_IMAGE_DATA''"
				straight-mode="false"> </custom-image>
		</div>
		<div>
			<custom-image id="networkLogo"
				alt-key="''network_means_pageType_2_IMAGE_ALT''"
				image-key="''network_means_pageType_2_IMAGE_DATA''"
				straight-mode="false"> </custom-image>
		</div>

	</div> <!-- header -->

	<message-banner></message-banner>
	<style>
		message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
	</style>
	<alternative-display attribute="''externalWSResponse''" value="''WRONG_AUTHENTICATION''"
		enabled="''wrongAuthentication''"
		disabled="''defaultContent''"
		default-fallback="''defaultContent''">
	</alternative-display>

	<!-- Display - REFUSAL_CAUSE : WRONG_AUTHENTICATION -->
	<div class="wrongAuthentication" style="display: none;">
		<div id="content">
			<div>
				<hr>
			</div>
			<div id="mainLayout">
				<h3><custom-text custom-text-key="''network_means_pageType_5''"></custom-text></h3>
				<div><custom-text custom-text-key="''network_means_pageType_6''"></custom-text></div>
				<custom-text custom-text-key="''network_means_pageType_7''"></custom-text>
			</div>
			<div id="mainLayout">
				<h3><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></h3>
				<div><custom-text custom-text-key="''network_means_pageType_6''"></custom-text></div>
				<custom-text custom-text-key="''network_means_pageType_10''"></custom-text>
				<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
			</div>
		</div>
	</div>

	<div class="defaultContent" style="display: none;">
		<div id="content">
			<div>
				<hr>
			</div>
			<div id="mainLayout">
				<h3><custom-text custom-text-key="''network_means_pageType_5''"></custom-text></h3>
				<div><custom-text custom-text-key="''network_means_pageType_6''"></custom-text></div>
				<custom-text custom-text-key="''network_means_pageType_7''"></custom-text>
				<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;
