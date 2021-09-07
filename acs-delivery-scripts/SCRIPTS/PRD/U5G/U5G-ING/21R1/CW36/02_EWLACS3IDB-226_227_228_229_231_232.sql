USE `U5G_ACS_BO`;
SET @createdBy = 'A758582';

SET @customItemSetSMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16500_ING_SMS');
SET @updateState = 'PUSHED_TO_CONFIG';
SET @pageType = 'OTP_FORM_PAGE';
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @authentMean = 'OTP_SMS';

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                           `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                           `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@authentMean,'_',@pageType,'_34'), @updateState,
  'de', 34, @pageType, 'Sende SMS.', @MaestroVID, NULL, @customItemSetSMS),
 ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@authentMean,'_',@pageType,'_35'), @updateState,
  'de', 35, @pageType, 'Bitte warten. Sie werden in Kuerze ein neues Einmalpasswort erhalten.', @MaestroVID, NULL, @customItemSetSMS);

SET @username =  'InitPhase';
SET @locale = 'de';
SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_16500_MOBILE_APP');
SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
-- 3x VISA logo

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
   SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW_DEVICE_SELECT', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSetId
   FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.id = @networkVISA;

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
   SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW_DEVICE_SELECT', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSetId
   FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.id = @networkVISA;

 INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
   SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW_DEVICE_SELECT', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSetId
   FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.id = @networkVISA;

SET @pageLayoutIdPolling = (SELECT id FROM `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
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
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div id="title">
			<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div id="menuLayout">
					<side-menu></side-menu>
				</div>
			</div>
			<div class="row">
				<div id="centerLayout">
					<div class="img-text">
						<span class="mobapp-icon"></span>
						<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col1"></div>
				<div class="col2">
					<div>
						<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
						<hr>
					</div>
				</div>
				<div class="col3">
					<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
				</div>
			</div>
		</div>
	</div>
</div>
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
		background-color: #fff;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-left: 1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-right: 1em;
	}
	#title {
		text-align: center;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#mainLayout {
		width: 100%;
		float: left;
		text-align: center;
		line-height: 30px;
	}
	div#menuLayout {
		width: 100%;
	}
	div.side-menu label {
		display: inline;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	.img-text {
		display: inline-flex;
	}
	.img-text + span {
		flex: 1;
	}
	.mobapp-icon {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAgCAYAAADwvkPPAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH4wIIDwgS00wEfgAAAmpJREFUSMet1k2oVVUUB/Dfvu8+X4rwSBAFiRBx1KAiVFAEUyFolCNJlODgJKzAnAhCTZ2JICpoW9SkBAehg5o4cmAKEqEDiexDuEYJgork17u7ybpyPO9+GS7YcBZr7f9e67/W2vukUlmEr7EByWwpte9+9hmcxZ42TgVQP7mHb+J7GuuwuOEzgU2Yn0qlO+BE+DVly6FUluIk1gzwLe0hQPBqqXwWqS7CkiG+KZXqOU66eFjTW5iqcfc4fHr8TaLdc243iL4WqUwYLgWvYCPW9gN7ipyy/caUUvm7DtZq2CfDqblpXqymzKkr7b5M5mcgC/BOrC6ulsqVlP3Tb197SAoL8SV2NEwnS2V3ym6NBVYqU9gSQA9wOar3JrbhftjqnTCLs/oh2yO10ylbn7J3cTDsK0vltSjawMhSqUzjPSyLqDqlsgodHIixutlvVptgLazCiahUwU58hEMp24tPa3RMDkuz1+V3avr90P8d1XftPmA/RTQ5ODuG7/BXVPiTSPlsk7NZkaXsLs7hN8zFQvyMu/gcX2BX2LrjVHMGX8WMbsW3OI6Pw/5Dyn5vZtYaMAGP4tI8HBFsijWNo9g3TjXrgLdLZQ/OY3ls/AUXU9YZpwDd3qCnTMru4EypTCCl/DzhzQloNx6L6fqg16KcGZDARLPjS+2UW7g+pDAah7+OpYMiWzLinh8qrTH97r0MsA7exxv4ADdeZJzq8gBHUvZ9VLiDBTFmLxzZU/xRa5WCP/9vmvOxudcqcc99OLS8jUe4KU9wFRewAqtHcXYZKwfYJ/E23hrxGwE/tuKBuD6iOVsjwC5h139YPazyRgJrLAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		background-position-y: 5px;
		margin-right: 0.5em;
		width: 1em;
		height: 2em;
	}
	.field-desc {
		color: #aaa;
		font-size: 0.6em;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	helpButtonClass .fa-info {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align: 10%;
	}
	paragraph {
		margin: 0px 5px 10px;
		text-align: left;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin: 1.5em;
		padding: 1.5em;
		height: 400px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	#centerLayout {
		width: 100%;
		text-align: center;
	}
	.col1 {
		width: 30%;
	}
	.col2 {
		width: 20%;
	}
	.col3 {
		width: 20%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		padding-left: 0px;
		padding-right: 0px;
		font-weight: bold;
	}
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		padding-left: 0px;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	cancel-button button.btn {
		height: 30px;
		border: 1px solid #000;
		line-height: 12px;
	}
	cancel-button button.btn custom-text span {
		padding: 0px;
	}
	cancel-button button.btn span.fa {
		display: none;
	}
	val-button button.btn {
		width: 46%;
		height: 30px;
		background-color: #ff6200;
		color: #fff;
		line-height: 12px;
		border: 1px solid #000;
	}
	val-button button.btn[disabled]:hover {
		background-color: #ff7210;
	}
	val-button button.btn:hover {
		background-color: #ff7210;
	}
	val-button button.btn span.fa:before {
		content: '''';
	}
	val-button button.btn span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	val-button button.btn div {
		display: inline;
	}
	val-button button.btn custom-text span {
		vertical-align: 10%
	}
	hr { margin-top: 0px; margin-bottom: 0px; }
	@media all and (max-width: 601px) {
		#optGblPage #title { text-align:center;}
		#content { height: 300px; }
		#mainLayout {  width: 100%; float: left; text-align: center; line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%;  margin-right: 20px; }
		.col3 { width: 25%; display: flex; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		#optGblPage #title { text-align:center;}
		.col1 { width: 10%; }
		.col2 { width: 40%; margin-right: 5px;}
		.col3 { width: 30%; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title {text-align:center;}
		.col1 { width: 0%; }
		.col2 { width: 50%; }
		.col3 { width: 40%; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		#mainLayout {float: left; text-align: center; line-height: 20px; padding-top: 16px;}
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {width: 40%;font-size: 10px;}
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%;font-size: 10px;}
		.col2 { width: 60%; }
		.col3 { width: 40%; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		#optGblPage .btn-default {font-size: 10px;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdPolling;

SET @pageLayoutIdPhotoTan = (SELECT id FROM `CustomPageLayout` where `pageType` = 'PHOTO_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

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
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div id="menuLayout">
					<side-menu></side-menu>
				</div>
			</div>
			 <div id="center">
				<div class="row">
					<div id="photoTanLayout">
						<div id="photoTanLeft"></div>
						<div id="photoTanCenter"><custom-text custom-text-key="''network_means_pageType_3''"></custom-text></div>
						<div id="photoTanRight"><external-image></external-image></div>
					</div>
				</div>
				<div class="row">
					<div class="col1"></div>
					<div class="col2">
						<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
					</div>
					<div class="col3"><otp-form></otp-form></div>
				</div>
				<div class="row">
					<div class="col1"></div>
					<div class="col2"></div>
					<div class="col3">
						<div class="field-desc"><custom-text custom-text-key="''network_means_pageType_5''"></custom-text></div>
					</div>
				</div>
			</div>
			<div class="row">
				<div id="buttonsLayout">
					<div id="left"></div>
					<div id="helpDiv" >
						<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
						<hr>
					</div>
					<div id="buttonsDiv">
						<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
						<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<style>
	/* global styles */
	#optGblPage {
		background-color: #f7f7f7;
		margin: 0px;
		padding: 0px;
		padding-bottom: 1.5em;
	}
	.background-default { background-color: #f7f7f7;}
	.primary-color { color: #ff6200; }
	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#header {
		background-color: #fff;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-left: 1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-right: 1em;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#title {
		text-align: center;
	}
	#mainLayout {
		width: 100%;
		text-align: center;
		line-height: 30px;
	}
	div#menuLayout {
		width: 100%;
	}
	div#photoTanLayout {
		display: flex;
		width: 100%;
	}
	div#photoTanLeft {
		width: 20%;
	}
	div#photoTanCenter {
		width: 30%;
		text-align: right;
	}
	div#photoTanRight {
		margin-left: 3%;
	}
	div#buttonsLayout {
		display: flex;
		width: 100%;
	}
	div#left {
		width: 36%;
	}
	div#helpDiv {
		width: 15%;
	}
	div#buttonsDiv {
		display: flex;
	}
	div.side-menu label {
		display: inline;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #center {
		height: auto;
		background-image: none;
	}
	.field-desc {
		color: #aaa;
		font-size: 0.6em;
		line-height: 20px;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	.helpButtonClass .fa-info {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align: 10%;
	}
	hr {
		padding-left: 2em;
		padding-right: 2em;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin-top: 1.5em;
		margin-bottom: 1.5em;
		height: 700px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col1 {
		width: 25%;
	}
	.col2 {
		width: 25%;
		text-align: right;
	}
	.col3 {
		margin-left: 3%;
		display: flex;
		width: 35%;
	}
	/* overrides for the side-menu element */
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		width: 50%;
		margin-left: 0%;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		width: 50%;
		padding-left: 15px;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		font-weight: bold;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	/* overrides for the cancel and validate button */
	cancel-button#cancelButton {
		margin-right: 20%;
	}
	cancel-button button.btn {
		height: 30px;
		border: 1px solid #000;
		line-height: 12px;
	}
	cancel-button button.btn custom-text span {
		padding: 0px;
	}
	cancel-button button.btn span.fa {
		display: none;
	}
	val-button button.btn {
		height: 30px;
		background-color: #ff6200;
		color: #fff;
		line-height: 12px;
		border: 1px solid #000;
	}
	val-button button.btn[disabled]:hover {
		background-color: #ff7210;
	}
	val-button button.btn:hover {
		background-color: #ff7210;
	}
	val-button button.btn span.fa:before {
		content: '''';
	}
	val-button button.btn span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	val-button button.btn div {
		display: inline;
	}
	val-button button.btn custom-text span {
		vertical-align: 10%
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		div#photoTanLeft { width: 20%; }
		div#photoTanCenter { width: 30%; text-align: right;}
		div#photoTanRight { margin-left: 3%; }
		div#left { width: 25%; }
		div#helpDiv { width: 30%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left { width: 40%; }
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%; }
		.col1 { width: 5%; }
		.col2 { width: 35%; }
		.col3 { margin-left: 5%; }
		div#photoTanLeft { width: 10%; }
		div#left { width: 5%; }
		div#helpDiv { width: 40%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title { margin-left: inherit; text-align: center;}
		#mainLayout {line-height: 20px; }
		#optGblPage .otp-field input { width: 218px; }
		.col1 { width: 2%; }
		div#left { width: 0%; }
		div#helpDiv { width: 42%; }
		div#buttonsDiv { display: flex; width: 58%; }
		cancel-button#cancelButton { margin-right: 5%; }
		#optGblPage .col3 { width: auto;}
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage cancel-button#cancelButton { margin-right: 10%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		#mainLayout { line-height: 20px; }
		div#photoTanLayout { display: block; }
		div#photoTanLeft { width: 0%; }
		div#photoTanCenter { width: 100%; text-align: center; }
		div#photoTanRight { margin-left: 0%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage .col-sm-5 { font-size: 10px;}
		#optGblPage .col-sm-6 { font-size: 10px;}
		#optGblPage .otp-field input { width: 218px; }
		div#buttonsLayout { display: block; width: 100%; }
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdPhotoTan;


SET @pageLayoutIdOtpSmsExt = (SELECT id FROM `CustomPageLayout` where `pageType` = 'OTP_SMS_EXT_MESSAGE_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
	<div id="header">
		<div>
			<custom-image id="issuerLogo"
					alt-key="''network_means_pageType_1_IMAGE_ALT''"
					image-key="''network_means_pageType_1_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
		<div>
			<custom-image id="networkLogo"
					alt-key="''network_means_pageType_2_IMAGE_ALT''"
					image-key="''network_means_pageType_2_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
	</div>
	<!-- header -->
	<message-banner></message-banner>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div id="menuLayout">
					<side-menu></side-menu>
				</div>
			</div>
			<div id="center">
				<div class="row">
					<div class="col1"></div>
					<div class="col2">
						<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
					</div>
					<div class="col3">
						<otp-form></otp-form>
					</div>
				</div>
				<div class="row">
					<div class="col1"></div>
					<div class="col2"></div>
					<div class="col3">
						<re-send-otp rso-label="''network_means_pageType_5''"></re-send-otp>
					</div>
				</div>
			</div>
			<div class="row">
				<div id="buttonsLayout">
					<div id="left"></div>
					<div id="helpDiv" >
						<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
						<hr>
						</div>
						<div id="buttonsDiv">
							<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
							<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<style>
	/* global styles */
	#optGblPage {
		background-color: #f7f7f7;
		margin: 0px;
		padding: 0px;
		padding-bottom: 1.5em;
	}
	.background-default { background-color: #f7f7f7;}
	.primary-color { color: #ff6200; }
	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#header {
		background-color: #fff;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-left: 1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-right: 1em;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	div#menuLayout {
		width: 100%;
	}
	#title {
		text-align: center;
		font-weight: bold;
	}
	#mainLayout {
		width: 100%;
		float: left;
		text-align: center;
		line-height: 30px;
	}
	div#menuLayout {
		width: 100%;
	}
	div#buttonsLayout {
		display: flex;
		width: 100%;
	}
	div#left {
		width: 36%;
	}
	div#helpDiv {
		width: 15%;
	}
	div#buttonsDiv {
		display: flex;
	}
	div.side-menu label {
		display: inline;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #center {
		height: auto;
		background-image: none;
	}
	.field-desc {
		color: #aaa;
		font-size: 0.6em;
		line-height: 20px;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	.helpButtonClass .fa-info {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align: 10%;
	}
	hr {
		padding-left: 2em;
		padding-right: 2em;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin-top: 1.5em;
		margin-bottom: 1.5em;
		height: 450px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col1 {
		width: 25%;
	}
	.col2 {
		width: 25%;
		text-align: right;
	}
	.col3 {
		margin-left: 1%;
		display: flex;
		width: 35%;
	}
	/* overrides for the side-menu element */
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		width: 50%;
		margin-left: 0%;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		width: 50%;
		padding-left: 15px;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		font-weight: bold;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	/* overrides for the cancel and validate button */
	cancel-button#cancelButton {
		margin-right: 20%;
	}
	cancel-button button.btn {
		height: 30px;
		border: 1px solid #000;
		line-height: 12px;
	}
	cancel-button button.btn custom-text span {
		padding: 0px;
	}
	cancel-button button.btn span.fa {
		display: none;
	}
	val-button button.btn {
		height: 30px;
		background-color: #ff6200;
		color: #fff;
		line-height: 12px;
		border: 1px solid #000;
	}
	val-button button.btn[disabled]:hover {
		background-color: #ff7210;
	}
	val-button button.btn:hover {
		background-color: #ff7210;
	}
	val-button button.btn span.fa:before {
		content: '''';
	}
	val-button button.btn span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	val-button button.btn div {
		display: inline;
	}
	val-button button.btn custom-text span {
		vertical-align: 10%
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		.col3 { margin-left: 3%;}
		div#left { width: 25%; }
		div#helpDiv { width: 30%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left { width: 40%; }
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%; }
		.col1 { width: 5%; }
		.col2 { width: 35%; }
		.col3 { margin-left: 5%; }
		div#left { width: 5%; }
		div#helpDiv { width: 40%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title { margin-left: inherit; text-align: center;}
		#mainLayout {line-height: 20px; }
		#optGblPage .otp-field input { width: 218px; }
		.col1 { width: 2%; }
		div#left { width: 0%; }
		div#helpDiv { width: 42%; }
		div#buttonsDiv { display: flex; width: 58%; }
		cancel-button#cancelButton { margin-right: 5%; }
		#optGblPage .col3 { width: auto;}
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage cancel-button#cancelButton { margin-right: 5%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		#mainLayout { line-height: 20px; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage .col-sm-5 { font-size: 10px;}
		#optGblPage .col-sm-6 { font-size: 10px;}
		#optGblPage .otp-field input { width: 218px; }
		div#buttonsLayout { display: block; width: 100%; }
		re-send-otp button.btn.btn-default { padding-left: 4px; padding-right: 4px; font-size: 12px;}
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdOtpSmsExt;

SET @pageLayoutIdMobileAppExt = (SELECT id FROM `CustomPageLayout` where `pageType` = 'MOBILE_APP_EXT_CHOICE_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
	<div id="header">
		<div>
			<custom-image id="issuerLogo"
					alt-key="''network_means_pageType_1_IMAGE_ALT''"
					image-key="''network_means_pageType_1_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
		<div>
			<custom-image id="networkLogo"
					alt-key="''network_means_pageType_2_IMAGE_ALT''"
					image-key="''network_means_pageType_2_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
	</div>
	<!-- header -->
	<message-banner></message-banner>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div id="menuLayout">
					<side-menu></side-menu>
				</div>
			</div>
				<div class="row">
					<div id="centerLayout">
						<div class="img-text">
							<span class="mobapp-icon"></span>
							<custom-text custom-text-key="''network_means_pageType_18''"></custom-text>
						</div>
                        <div class="col3" id="deviceChoice">
						    <device-select devices="deviceSelectValues" select-box-style-enabled="true" preselect-first-device="true"></device-select>
					    </div>
					</div>
				</div>
			<div class="row">
				<div id="buttonsLayout">
					<div id="left"></div>
					<div id="helpDiv">
						<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
						<hr>
						</div>
						<div id="buttonsDiv">
							<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
							<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<style>
	/* global styles */
	#optGblPage {
		background-color: #f7f7f7;
		margin: 0px;
		padding: 0px;
		padding-bottom: 1.5em;
	}
	.background-default { background-color: #f7f7f7;}
	.primary-color { color: #ff6200; }
	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#header {
		background-color: #fff;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-left: 1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-right: 1em;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#title {
		text-align: center;
		font-weight: bold;
	}
	#mainLayout {
		width: 100%;
		float: left;
		text-align: center;
		line-height: 30px;
	}
	div#menuLayout {
		width: 100%;
	}
	div#buttonsLayout {
		display: flex;
		width: 100%;
	}
	div#left {
		width: 36%;
	}
	div#helpDiv {
		width: 15%;
	}
	div#buttonsDiv {
		display: flex;
	}
	div.side-menu label {
		display: inline;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #footer {
		height: 70px;
		background-image: none;
		margin-left: 12%;
	}
	.help {
		display: block;
		margin-left: 2%;
	}
	#deviceChoice {
		margin-left: 20px;
	}
	.text-center {
		text-align: justify;
	}
	.img-text {
		display: flex;
	}
	.img-text + span {
		flex: 1;
	}
	.img-text custom-text {
		flex: inherit;
		margin-top: 4px;
	}
	.mobapp-icon {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAgCAYAAADwvkPPAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH4wIIDwgS00wEfgAAAmpJREFUSMet1k2oVVUUB/Dfvu8+X4rwSBAFiRBx1KAiVFAEUyFolCNJlODgJKzAnAhCTZ2JICpoW9SkBAehg5o4cmAKEqEDiexDuEYJgork17u7ybpyPO9+GS7YcBZr7f9e67/W2vukUlmEr7EByWwpte9+9hmcxZ42TgVQP7mHb+J7GuuwuOEzgU2Yn0qlO+BE+DVly6FUluIk1gzwLe0hQPBqqXwWqS7CkiG+KZXqOU66eFjTW5iqcfc4fHr8TaLdc243iL4WqUwYLgWvYCPW9gN7ipyy/caUUvm7DtZq2CfDqblpXqymzKkr7b5M5mcgC/BOrC6ulsqVlP3Tb197SAoL8SV2NEwnS2V3ym6NBVYqU9gSQA9wOar3JrbhftjqnTCLs/oh2yO10ylbn7J3cTDsK0vltSjawMhSqUzjPSyLqDqlsgodHIixutlvVptgLazCiahUwU58hEMp24tPa3RMDkuz1+V3avr90P8d1XftPmA/RTQ5ODuG7/BXVPiTSPlsk7NZkaXsLs7hN8zFQvyMu/gcX2BX2LrjVHMGX8WMbsW3OI6Pw/5Dyn5vZtYaMAGP4tI8HBFsijWNo9g3TjXrgLdLZQ/OY3ls/AUXU9YZpwDd3qCnTMru4EypTCCl/DzhzQloNx6L6fqg16KcGZDARLPjS+2UW7g+pDAah7+OpYMiWzLinh8qrTH97r0MsA7exxv4ADdeZJzq8gBHUvZ9VLiDBTFmLxzZU/xRa5WCP/9vmvOxudcqcc99OLS8jUe4KU9wFRewAqtHcXYZKwfYJ/E23hrxGwE/tuKBuD6iOVsjwC5h139YPazyRgJrLAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		background-position-y: 5px;
		margin-right: 0.5em;
		width: 1em;
		height: 2em;
	}
	.field-desc {
		color: #aaa;
		font-size: 0.6em;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	.helpButtonClass .fa-info {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align: 10%;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin-top: 1.5em;
		margin-bottom: 1.5em;
		height: 400px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	#centerLayout {
		width: 100%;
		text-align: center;
		display: flex;
        margin-left: 39%;
	}
	.col1 {
		width: 30%;
	}
	.col2 {
		width: 20%;
	}
	.col3 {
		display: flex;
		width: 20%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
	}
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		padding-left: 0px;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		padding-left: 0px;
		padding-right: 0px;
		font-weight: bold;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	/* overrides for the cancel and validate button */
	cancel-button#cancelButton {
		margin-left: 5%;
	}
	cancel-button button.btn {
		height: 30px;
		border: 1px solid #000;
		line-height: 12px;
	}
	cancel-button button.btn custom-text span {
		padding: 0px;
	}
	cancel-button button.btn span.fa {
		display: none;
	}
	val-button button.btn {
		height: 30px;
		background-color: #ff6200;
		color: #fff;
		line-height: 12px;
		border: 1px solid #000;
	}
	val-button button.btn[disabled]:hover {
		background-color: #ff7210;
	}
	val-button button.btn:hover {
		background-color: #ff7210;
	}
	val-button button.btn span.fa:before {
		content: '''';
	}
	val-button button.btn span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	val-button button.btn div {
		display: inline;
	}
	val-button button.btn custom-text span {
		vertical-align: 10%
	}
	hr { margin-top: 0px; margin-bottom: 0px; }
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#mainLayout { line-height: 20px; }
		#centerLayout { margin-left: 15%;}
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		div#left { width: 25%; }
		div#helpDiv { width: 30%; }
		div#buttonsDiv { display: flex; width: 40%; }
        #deviceChoice { margin-left: 20px; margin-top: -20px;}
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left { width: 40%; }
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%; }
		.col1 { width: 5%; }
		.col2 { width: 35%; }
		.col3 { margin-left: 5%; }
		#centerLayout { margin-left: 5%;}
        .img-text { width: 40%;}
        #deviceChoice { margin-left: 0px;}
		div#left { width: 5%; }
		div#helpDiv { width: 40%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title { margin-left: inherit; text-align: center;}
		#mainLayout {line-height: 20px; }
		#optGblPage .otp-field input { width: 218px; }
		.col1 { width: 2%; }
		#centerLayout { margin-left: 5%; height: 40px;}
		div#left { width: 0%; }
		div#helpDiv { width: 42%; }
		div#buttonsDiv { display: flex; width: 58%; }
        #deviceChoice { margin-left: 2px;}
		cancel-button#cancelButton { margin-right: 5%; }
		#optGblPage .col3 { width: min-content;}
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage cancel-button#cancelButton { margin-right: 10%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		div.side-menu div.menu-elements div div div span { padding-left: 15px;}
		#mainLayout { line-height: 20px; }
		#optGblPage .col3 {width: 20%;}
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage .col-sm-5 { font-size: 10px;}
		#optGblPage .col-sm-6 { font-size: 10px;}
		#optGblPage .otp-field input { width: 218px; }
        #centerLayout { display: block; height: 50px; margin-left: 10%;}
        .img-text { width: 100%;}
        #deviceChoice { margin-left: 2px;}
		div#buttonsLayout { display: block; width: 100%; }
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdMobileAppExt;

SET @pageLayoutIdITan = (SELECT id FROM `CustomPageLayout` where `pageType` = 'I_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
	<div id="header">
		<div>
			<custom-image id="issuerLogo"
					alt-key="''network_means_pageType_1_IMAGE_ALT''"
					image-key="''network_means_pageType_1_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
		<div>
			<custom-image id="networkLogo"
					alt-key="''network_means_pageType_2_IMAGE_ALT''"
					image-key="''network_means_pageType_2_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
	</div>
	<!-- header -->
	<message-banner></message-banner>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div id="menuLayout">
					<side-menu></side-menu>
				</div>
			</div>
			<div id="center">
				<div class="row">
					<div class="col1"></div>
					<div class="col2">
						<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
					</div>
					<div class="col3">
						<otp-form></otp-form>
					</div>
				</div>
			</div>
			<div class="row">
				<div id="buttonsLayout">
					<div id="left"></div>
					<div id="helpDiv" >
						<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
						<hr>
						</div>
						<div id="buttonsDiv">
							<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
							<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<style>
	/* global styles */
	#optGblPage {
		background-color: #f7f7f7;
		margin: 0px;
		padding: 0px;
		padding-bottom: 1.5em;
	}
	.background-default { background-color: #f7f7f7;}
	.primary-color { color: #ff6200; }
	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#header {
		background-color: #fff;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-left: 1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-right: 1em;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	div#menuLayout {
		width: 100%;
	}
	#title {
		text-align: center;
		font-weight: bold;
	}
	#mainLayout {
		width: 100%;
		float: left;
		text-align: center;
		line-height: 30px;
	}
	div#menuLayout {
		width: 100%;
	}
	div#buttonsLayout {
		display: flex;
		width: 100%;
	}
	div#left {
		width: 36%;
	}
	div#helpDiv {
		width: 15%;
	}
	div#buttonsDiv {
		display: flex;
	}
	div.side-menu label {
		display: inline;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #center {
		height: auto;
		background-image: none;
	}
	.field-desc {
		color: #aaa;
		font-size: 0.6em;
		line-height: 20px;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	.helpButtonClass .fa-info {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align: 10%;
	}
	hr {
		padding-left: 2em;
		padding-right: 2em;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin-top: 1.5em;
		margin-bottom: 1.5em;
		height: 450px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col1 {
		width: 25%;
	}
	.col2 {
		width: 25%;
		text-align: right;
	}
	.col3 {
		margin-left: 1%;
		display: flex;
		width: 35%;
	}
	/* overrides for the side-menu element */
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		width: 50%;
		margin-left: 0%;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		width: 50%;
		padding-left: 15px;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		font-weight: bold;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	/* overrides for the cancel and validate button */
	cancel-button#cancelButton {
		margin-right: 20%;
	}
	cancel-button button.btn {
		height: 30px;
		border: 1px solid #000;
		line-height: 12px;
	}
	cancel-button button.btn custom-text span {
		padding: 0px;
	}
	cancel-button button.btn span.fa {
		display: none;
	}
	val-button button.btn {
		height: 30px;
		background-color: #ff6200;
		color: #fff;
		line-height: 12px;
		border: 1px solid #000;
	}
	val-button button.btn[disabled]:hover {
		background-color: #ff7210;
	}
	val-button button.btn:hover {
		background-color: #ff7210;
	}
	val-button button.btn span.fa:before {
		content: '''';
	}
	val-button button.btn span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	val-button button.btn div {
		display: inline;
	}
	val-button button.btn custom-text span {
		vertical-align: 10%
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		.col3 { margin-left: 3%;}
		div#left { width: 25%; }
		div#helpDiv { width: 30%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left { width: 40%; }
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%; }
		.col1 { width: 5%; }
		.col2 { width: 35%; }
		.col3 { margin-left: 5%; }
		div#left { width: 5%; }
		div#helpDiv { width: 40%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title { margin-left: inherit; text-align: center;}
		#mainLayout {line-height: 20px; }
		#optGblPage .otp-field input { width: 218px; }
		.col1 { width: 2%; }
		div#left { width: 0%; }
		div#helpDiv { width: 42%; }
		div#buttonsDiv { display: flex; width: 58%; }
		cancel-button#cancelButton { margin-right: 5%; }
		#optGblPage .col3 { width: auto;}
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage cancel-button#cancelButton { margin-right: 5%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		#mainLayout { line-height: 20px; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage .col-sm-5 { font-size: 10px;}
		#optGblPage .col-sm-6 { font-size: 10px;}
		#optGblPage .otp-field input { width: 218px; }
		div#buttonsLayout { display: block; width: 100%; }
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdITan;

SET @pageLayoutIdExtPassword = (SELECT id FROM `CustomPageLayout` where `pageType` = 'EXT_PASSWORD_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
	<div id="header">
		<div>
			<custom-image id="issuerLogo"
					alt-key="''network_means_pageType_1_IMAGE_ALT''"
					image-key="''network_means_pageType_1_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
		<div>
			<custom-image id="networkLogo"
					alt-key="''network_means_pageType_2_IMAGE_ALT''"
					image-key="''network_means_pageType_2_IMAGE_DATA''"
					straight-mode="false"></custom-image>
		</div>
	</div>
	<!-- header -->
	<message-banner></message-banner>
	<div id="content">
		<div  id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div id="menuLayout">
					<side-menu></side-menu>
				</div>
			</div>
			<div id="center">
				<div class="row">
					<div class="col1"></div>
					<div class="col2">
						<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
					</div>
					<div class="col3">
						<pwd-form hide-input="true"></pwd-form>
					</div>
				</div>
			</div>
			<div class="row">
				<div id="buttonsLayout">
					<div id="left"></div>
					<div id="helpDiv" >
						<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
						<hr>
						</div>
						<div id="buttonsDiv">
							<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
							<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<style>
	/* global styles */
	#optGblPage {
		background-color: #f7f7f7;
		margin: 0px;
		padding: 0px;
		padding-bottom: 1.5em;
	}
	.background-default { background-color: #f7f7f7;}
	.primary-color { color: #ff6200; }
	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	.background-default { background-color: #f7f7f7;}
	.primary-color { color: #ff6200; }
	#header {
		background-color: #fff;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	#issuerLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-left: 1em;
	}
	#networkLogo {
		max-height: 43px;
		width: initial;
		margin-top: 1em;
		margin-bottom: 1em;
		margin-right: 1em;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	div#menuLayout {
		width: 100%;
	}
	#title {
		text-align: center;
		font-weight: bold;
	}
	#mainLayout {
		width: 100%;
		float: left;
		text-align: center;
		line-height: 30px;
	}
	div#menuLayout {
		width: 100%;
	}
	div#buttonsLayout {
		display: flex;
		width: 100%;
	}
	div#left {
		width: 36%;
	}
	div#helpDiv {
		width: 15%;
	}
	div#buttonsDiv {
		display: flex;
	}
	div.side-menu label {
		display: inline;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #center {
		height: auto;
		background-image: none;
	}
	.field-desc {
		color: #aaa;
		font-size: 0.6em;
		line-height: 20px;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	.helpButtonClass .fa-info {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	.helpButtonClass span.custom-text {
		vertical-align: 10%;
	}
	hr {
		padding-left: 2em;
		padding-right: 2em;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin-top: 1.5em;
		margin-bottom: 1.5em;
		height: 450px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col1 {
		width: 25%;
	}
	.col2 {
		width: 25%;
		text-align: right;
	}
	.col3 {
		margin-left: 1%;
		display: flex;
		width: 35%;
	}
	/* overrides for the side-menu element */
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		width: 50%;
		margin-left: 0%;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		width: 50%;
		padding-left: 15px;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		font-weight: bold;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	/* overrides for the cancel and validate button */
	cancel-button#cancelButton {
		margin-right: 20%;
	}
	cancel-button button.btn {
		height: 30px;
		border: 1px solid #000;
		line-height: 12px;
	}
	cancel-button button.btn custom-text span {
		padding: 0px;
	}
	cancel-button button.btn span.fa {
		display: none;
	}
	val-button button.btn {
		height: 30px;
		background-color: #ff6200;
		color: #fff;
		line-height: 12px;
		border: 1px solid #000;
	}
	val-button button.btn[disabled]:hover {
		background-color: #ff7210;
	}
	val-button button.btn:hover {
		background-color: #ff7210;
	}
	val-button button.btn span.fa:before {
		content: '''';
	}
	val-button button.btn span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		width: 1em;
		height: 1em;
	}
	val-button button.btn div {
		display: inline;
	}
	val-button button.btn custom-text span {
		vertical-align: 10%
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		.col3 { margin-left: 3%;}
		div#left { width: 25%; }
		div#helpDiv { width: 30%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left { width: 40%; }
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%; }
		.col1 { width: 5%; }
		.col2 { width: 35%; }
		.col3 { margin-left: 5%; }
		div#left { width: 5%; }
		div#helpDiv { width: 40%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title { margin-left: inherit; text-align: center;}
		#mainLayout {line-height: 20px; }
		#optGblPage .otp-field input { width: 218px; }
		.col1 { width: 2%; }
		div#left { width: 0%; }
		div#helpDiv { width: 42%; }
		div#buttonsDiv { display: flex; width: 58%; }
		cancel-button#cancelButton { margin-right: 5%; }
		#optGblPage .col3 { width: auto;}
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage cancel-button#cancelButton { margin-right: 5%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		#mainLayout { line-height: 20px; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage .col-sm-5 { font-size: 10px;}
		#optGblPage .col-sm-6 { font-size: 10px;}
		#optGblPage .otp-field input { width: 218px; }
		div#buttonsLayout { display: block; width: 100%; }
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdExtPassword;

SET @pageLayoutIdHelpPage = (SELECT id FROM `CustomPageLayout` where `pageType` = 'HELP_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage" style="margin:auto;" class="container-fluid">
<div class="container-fluid">
	   <div class="hr-line"></div>
		  <div class="leftPadding20" id="helpTitle">
		  <custom-text custom-text-key="''network_means_HELP_PAGE_1''"></custom-text></div>
		<div class="hr-line"></div>

	<div class=" col-xs-12 col-md-10 ">
		<div id="helpContent">
<div class="paragraph" id="divMedia">
	<custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph1">
	</custom-text>
</div>
<help-close-button id="helpCloseButton" help-close-label="''network_means_HELP_PAGE_3''" ></help-close-button>
		</div>
	</div>
</div>

<style>

	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#helpContent {
		padding: 7px 0px 0px;
		min-height: 200px;
		text-align: justify;
	}
	#helpCloseButton button span.fa {
		display: none;
	}
	#helpCloseButton {
		color: blue;
		text-decoration: underline;
	}
	#helpTitle {
		padding-left: 20px;
		text-align: center;
	}
	.paragraph {
		margin: 0px 5px 10px;
		text-align: justify;
	}
	.hr-line {
		position: relative;
		display: inline-block;
		margin-left: 5px;
		margin-right: 5px;
		width: 100%;
		border-bottom: 1px solid #eaebeb;
	}
	.btn {
		border: 0px solid transparent;
		font-size: 16px;
	}
	.btn-default:hover {
		color: blue;
		background-color: white;
		border-color: white;
		text-decoration: underline;
	}
	@media screen and (min-width: 701px) {
		#optGblPage, #divMedia {max-width: 800px;font-size: 18px;}
		.paragraph {margin: 0px 5px 10px; text-align: justify; }
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#optGblPage, #divMedia {max-width: 650px; font-size: 14px;}
		.paragraph {margin: 0px 5px 10px; text-align: left; }
	}
	@media screen and (max-width: 360px) {
		#optGblPage, #divMedia {max-width: 360px;font-size: 12px;}
		.paragraph {margin: 0px 5px 10px; text-align: left; }
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdHelpPage;