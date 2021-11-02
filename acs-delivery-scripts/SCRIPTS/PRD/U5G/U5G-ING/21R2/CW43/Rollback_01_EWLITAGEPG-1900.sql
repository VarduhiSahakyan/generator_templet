USE U5G_ACS_BO;

SET @pageLayoutId = (select id from `CustomPageLayout` where `pageType` = 'PHOTO_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

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
' where fk_id_layout = @pageLayoutId;