USE `U5G_ACS_BO`;
SET @createdBy = 'A758582';
SET @MaestroVName =  (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVID = NULL;
SET @currentPageType = 'ALL';
SET @BankUB = '16500';

SET @pageLayoutIdMessageBanner = (SELECT id FROM `CustomPageLayout` where `pageType` = 'MESSAGE_BANNER' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '
<div id="messageBanner">
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>
<style>
	#optGblPage {
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#messageBanner #headingTxt {
		font-size: large;
		font-weight: bold;
		width: 80%;
		margin: auto;
		display: block;
	}
	#messageBanner #message {
		width: 90%;
		margin: auto;
		display: block;
		font-weight: bold;
	}
	#messageBanner #spinner-row {
		padding-top: 20px;
	}
	#messageBanner .spinner {
		display: block;
		padding-top: 15px;
		padding-bottom: 15px;
	}
	#messageBanner {
		position: relative;
	}
	#message {
		display: block;
	}
	div#message-container.success {
		background-color: #ec971f;
		font-family: "INGme-Regular", Arial, Helvetica;
		color: #ffffff;
	}
	@media all and (max-width: 480px) {
		span#info-icon {
			position: absolute;
			font-size: 3em;
			top: 1px;
			left: 5px;
			display: inline-block;
		}
		.spinner {
			padding-top: 10px;
			padding-bottom: 10px;
		}
		#messageBanner #headingTxt {
			font-size: 15px;
		}
	}
	@media all and (max-width: 347px) {
		#messageBanner #headingTxt {
			font-size: 15px;
		}
	}
	@media all and (max-width: 309px) {
		#messageBanner #headingTxt {
			font-size: 12px;
		}
	}
	@media all and (max-width: 250px) {
		#messageBanner #headingTxt {
			width: 100%;
			font-size: 8px;
		}
	}
</style>' where fk_id_layout = @pageLayoutIdMessageBanner;

SET @pageLayoutIdPolling = (SELECT id FROM `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
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
</style>

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

	<style>
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
</style>
<message-banner></message-banner>
<style>
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	span#message {
		font-size: 18px !important;
		font-weight: normal !important;
	}
</style>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="center">
		<div id="left"> </div>
		<div id="mainLayout">
			<div class="row">
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>
		<div id="footer">
			<div class="row">
				<div class="col2 primary-color">
					<div class="img-text">
						<span class="mobapp-icon"></span>
						<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
					</div>
				</div>
				<div class="col3"></div>

			</div>

			<div class="row">
				<div class="col1">
				</div>

				<div class="col2 primary-color">
				</div>
				<div class="col3"></div>

			</div>


			<div class="row">
							<div class="col1">

				</div>
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
	<div id="right"> </div>
	</div>

</div>
<style>
	#title {
		margin-left: 35%;
	}
	#center {
		width: 100%;
		height: 96px;
	}
	#left {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
	}
	#mainLayout {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 30px;
		padding-top: 16px;
	}
	#right {
		width: 10%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
	}
	#optGblPage .col-sm-5 {
		width: 34%;
	}
	#optGblPage .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	.img-text {
		display: flex;
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
		margin-top: 5px;
	}
	#mainLayout {
		margin-top: -12px;
	}
	.paragraph {
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
	.col2.primary-color {
		width: 50%;
	}

	.col3 {
		width: 35%;
	}
	.colwidth2 {
		width: 70%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
	}
	div.side-menu div.menu-elements div div div span:nth-child(2) {
		padding-left: 0px;
		padding-right: 0px;
		font-weight: bold;
	}
	#optGblPage #footer {
		height: 120px;
		background-image: none;
		margin-left: 18%;
        margin-right: 10%;
	}
	.externalImage {
		margin: 0px;
		padding: 0px;
		margin-left: -15px;
		margin-top: -15px;
	}
	/* overrides for the cancel and validate button */
	cancel-button#cancelButton {
		margin-right: 50%;
	}
	cancel-button button.btn {
		width: 46%;
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
	@media screen and (min-width: 701px) {
		#optGblPage {
			font-size: 18px;
		}
		#center {
			width: 100%;
			height: 96px;
		}
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#optGblPage {
			font-size: 14px;
		}
	}
	@media screen and (max-width: 360px) {
		#optGblPage {
			font-size: 12px;
		}
	}
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display: flex;
			flex-direction: column;
			margin-top: 1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div span {
			display: block;
			float: none;
			text-align: left;
			width: 100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2) {
			padding-left: 0px;
			padding-right: 0px;
			display: block;
			width: 100%;
			float: none;
		}
		cancel-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			border: 1px solid #000;
			line-height: 12px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		cancel-button button.btn custom-text span {
			padding: 0px;
		}
		cancel-button button.btn span.fa {
			display: none;
		}
		val-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			background-color: #ff6200;
			color: #000;
			line-height: 12px;
			border: 1px solid #000;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		val-button button.btn span.fa {
			display: none;
		}
		val-button button.btn custom-text span {
			padding: 0px;
		}
		.col1 {
			display: block;
			width: 100%;
		}
		.col2 {
			display: block;
			width: 100%;
		}
		.col3 {
			display: block;
			width: 100%;
		}
		.colwidth2 {
			display: block;
			width: 100%;
		}
		#menu-separator {
			display: none;
		}
		.externalImage {
			margin: 0px;
			padding: 0px;
		}
	}

</style>
</div>
' where fk_id_layout = @pageLayoutIdPolling;

SET @pageLayoutIdPhotoTan = (SELECT id FROM `CustomPageLayout` where `pageType` = 'PHOTO_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
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
</style>

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

	<style>
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
	@media screen and (min-width: 701px) {
		#optGblPage {
			font-size: 18px;
		}
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#optGblPage {
			font-size: 14px;
		}
	}
	@media screen and (max-width: 360px) {
		#optGblPage {
			font-size: 12px;
		}
	}
</style>
<message-banner></message-banner>
<style>
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
</style>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
		<div id="center">
		<div id="left"> </div>
		<div id="mainLayout">
			<div class="row">
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>
		 <div id="footer">
			<div class="row">
				<div class="col2"><custom-text custom-text-key="''network_means_pageType_3''"></custom-text></div>
				<div class="col3"><external-image></external-image></div>

			</div>

			<div class="row">
				<div class="col1">

				</div>

				<div class="col2">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<div class="col3"><otp-form></otp-form></div>

			</div>

			<div class="row">
							<div class="col1">

				</div>
				<div class="col2">

				</div>
				<div class="col3">
					<div class="field-desc"><custom-text custom-text-key="''network_means_pageType_5''"></custom-text></div>
				</div>
			</div>

			<div class="row">
							<div class="col1">

				</div>
				<div class="col2">
					 <div>
					<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
					<hr>
					</div>
				</div>
				<div class="col3">
					<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
					<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
				</div>
			</div>
		</div>
		</div>
	  <div id="right"> </div>
	</div>
</div>
<style>
	#title {
		margin-left: 35%;
		font-weight: bold;
	}
	#center {
		width: 100%;
		height: 96px;
	}
	#left {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
	}
	#mainLayout {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 30px;
		padding-top: 16px;
	}
	#right {
		width: 10%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
	}
	#optGblPage .col-sm-5 {
		width: 34%;
	}
	#optGblPage .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #footer {
		height: 120px;
		background-image: none;
		margin-right: 30%;
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
	hr {
		padding-left: 2em;
		padding-right: 2em;
	}
	#content {
		background-color: #fff;
		border-radius: 1em;
		margin: 1.5em;
		padding: 1.5em;
		height: 700px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col2.primary-color {
		width: 50%;
	}
	.col2 {
		margin-right: 3%;
		width: 35%;
		text-align: right;
	}
	.col3 {
		display: flex;
		width: 35%;
	}
	.colwidth2 {
		width: 70%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
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
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display: flex;
			flex-direction: column;
			margin-top: 1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div span {
			display: block;
			float: none;
			text-align: left;
			width: 100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2) {
			padding-left: 0px;
			padding-right: 0px;
			display: block;
			width: 100%;
			float: none;
		}
		cancel-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			border: 1px solid #000;
			line-height: 12px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		cancel-button button.btn custom-text span {
			padding: 0px;
		}
		cancel-button button.btn span.fa {
			display: none;
		}
		val-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			background-color: #ff6200;
			color: #000;
			line-height: 12px;
			border: 1px solid #000;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		val-button button.btn span.fa {
			display: none;
		}
		val-button button.btn custom-text span {
			padding: 0px;
		}
		.col1 {
			display: block;
			width: 100%;
		}
		.col2 {
			display: block;
			width: 100%;
		}
		.col3 {
			display: -webkit-inline-box;
			width: 100%;
		}
		.colwidth2 {
			display: block;
			width: 100%;
		}
		#menu-separator {
			display: none;
		}
		.externalImage {
			margin: 0px;
			padding: 0px;
		}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdPhotoTan;


SET @pageLayoutIdOtpSmsExt = (SELECT id FROM `CustomPageLayout` where `pageType` = 'OTP_SMS_EXT_MESSAGE_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
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
</style>

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

	<style>
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
</style>
<message-banner></message-banner>
<style>
message-banner {
	display: block;
	width: 100%;
	position: relative;
}
</style>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
	<div id="center">
		<div id="left"> </div>
		<div id="mainLayout">
			<div class="row">
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>
		<div id="footer">
			<div class="row">
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
					<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
				</div>
			</div>
		 </div>
		</div>
	<div id="right"> </div>
	</div>
	</div>

<style>
	#title {
		margin-left: 35%;
		font-weight: bold;
	}
	#center {
		width: 100%;
		height: 96px;
	}
	#left {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
	}
	#mainLayout {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 30px;
		padding-top: 16px;
	}
	#right {
		width: 10%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
	}
	#optGblPage .col-sm-5 {
		width: 34%;
	}
	#optGblPage .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #footer {
		height: 160px;
		background-image: none;
		margin-left: 19%;
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
		margin: 1.5em;
		padding: 1.5em;
		height: 450px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col2.primary-color {
		width: 50%;
	}
	.col2 {
		margin-right: 3%;
	}
	.col3 {
		display: flex;
	}
	.colwidth2 {
		width: 70%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
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
	re-send-otp.ng-isolate-scope {
		margin-left: 29%;
	}
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display: flex;
			flex-direction: column;
			margin-top: 1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div span {
			display: block;
			float: none;
			text-align: left;
			width: 100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2) {
			padding-left: 0px;
			padding-right: 0px;
			display: block;
			width: 100%;
			float: none;
		}
		cancel-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			border: 1px solid #000;
			line-height: 12px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		cancel-button button.btn custom-text span {
			padding: 0px;
		}
		cancel-button button.btn span.fa {
			display: none;
		}
		val-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			background-color: #ff6200;
			color: #000;
			line-height: 12px;
			border: 1px solid #000;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		val-button button.btn span.fa {
			display: none;
		}
		val-button button.btn custom-text span {
			padding: 0px;
		}
		.col1 {
			display: block;
			width: 100%;
		}
		.col2 {
			display: block;
			width: 100%;
		}
		.col3 {
			display: -webkit-inline-box;
			width: 100%;
		}
		.colwidth2 {
			display: block;
			width: 100%;
		}
		#menu-separator {
			display: none;
		}
		.externalImage {
			margin: 0px;
			padding: 0px;
		}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdOtpSmsExt;

SET @pageLayoutIdMobileAppExt = (SELECT id FROM `CustomPageLayout` where `pageType` = 'MOBILE_APP_EXT_CHOICE_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
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
</style>

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

	<style>
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

@media screen and (max-width: 1200px) and (min-width: 701px) {
}
</style>
<message-banner></message-banner>
<style>
message-banner {
	display: block;
	width: 100%;
	position: relative;
}
</style>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
	<div id="center">
		<div id="left"> </div>
		<div id="mainLayout">
			<div class="row">
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>
		<div id="footer">
			<div class="row">
				<div class="col2 primary-color">
					<div class="img-text">
					<span class="mobapp-icon"></span>
					<custom-text custom-text-key="''network_means_pageType_18''"></custom-text>
					</div>
				</div>
				<div class="col3" id="deviceChoice"><device-select devices="deviceSelectValues" select-box-style-enabled="true" preselect-first-device="true"></device-select></div>

			</div>

			<div class="row">
							<div class="col1">

				</div>
				<div class="col2">
					 <div>
					<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
					<hr>
					</div>
				</div>
				<div class="col3">
					<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
					<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
				</div>
			</div>
		</div>
		</div>
	 <div id="right"> </div>
	</div>
	</div>

<style>
	#title {
		margin-left: 35%;
		font-weight: bold;
	}
	#center {
		width: 100%;
		height: 96px;
	}
	#left {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
	}
	#mainLayout {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 30px;
		padding-top: 16px;
	}
	#right {
		width: 10%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
	}
	#optGblPage .col-sm-5 {
		width: 34%;
	}
	#optGblPage .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #footer {
		height: 120px;
		background-image: none;
		margin-left: 12%;
	}
	#deviceChoice {
		margin-left: -5px;
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
		flex: 1;
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
	hr {
		padding-left: 2em;
		padding-right: 2em;
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
	.col2 {
		margin-right: 3%;
	}
	.col3 {
		display: flex;
		width: 35%;
	}
	.colwidth2 {
		width: 70%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
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
	#selection-group label {
		display: none;
	}
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display: flex;
			flex-direction: column;
			margin-top: 1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div span {
			display: block;
			float: none;
			text-align: left;
			width: 100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2) {
			padding-left: 0px;
			padding-right: 0px;
			display: block;
			width: 100%;
			float: none;
		}
		cancel-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			border: 1px solid #000;
			line-height: 12px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		cancel-button button.btn custom-text span {
			padding: 0px;
		}
		cancel-button button.btn span.fa {
			display: none;
		}
		val-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			background-color: #ff6200;
			color: #000;
			line-height: 12px;
			border: 1px solid #000;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		val-button button.btn span.fa {
			display: none;
		}
		val-button button.btn custom-text span {
			padding: 0px;
		}
		.col1 {
			display: block;
			width: 100%;
		}
		.col2 {
			display: block;
			width: 100%;
		}
		.col3 {
			display: block;
			width: 100%;
		}
		.colwidth2 {
			display: block;
			width: 100%;
		}
		#menu-separator {
			display: none;
		}
		.externalImage {
			margin: 0px;
			padding: 0px;
		}
	}

</style>
</div>
' where fk_id_layout = @pageLayoutIdMobileAppExt;

SET @pageLayoutIdITan = (SELECT id FROM `CustomPageLayout` where `pageType` = 'I_TAN_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
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
</style>

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

	<style>
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
</style>
<message-banner></message-banner>
<style>
message-banner {
	display: block;
	width: 100%;
	position: relative;
}
</style>
	<div id="content">
		<div id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
	<div id="center">
		<div id="left"> </div>
		<div id="mainLayout">
			<div class="row">
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>
		<div id="footer">
			<div class="row">
				<div class="col2">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<div class="col3">
					<otp-form></otp-form>
				</div>

			</div>

			<div class="row">
				<div class="col1">
				</div>
				<div class="col2">
					 <div>
					<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
					<hr>
					</div>
				</div>
				<div class="col3">
					<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
					<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
				</div>
			</div>
		</div>
		</div>
		 <div id="right"> </div>
	</div>
	</div>

<style>
	#title {
		margin-left: 35%;
		font-weight: bold;
	}
	#center {
		width: 100%;
		height: 96px;
	}
	#left {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
	}
	#mainLayout {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 30px;
		padding-top: 16px;
	}
	#right {
		width: 10%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
	}
	#optGblPage .col-sm-5 {
		width: 34%;
	}
	#optGblPage .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #footer {
		height: 120px;
		background-image: none;
		margin-left: 12%;
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
		margin: 1.5em;
		padding: 1.5em;
		height: 400px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col2.primary-color {
		width: 50%;
	}
	.col2 {
		margin-right: 3%;
	}
	.col3 {
		display: flex;
	}
	.colwidth2 {
		width: 70%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
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
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display: flex;
			flex-direction: column;
			margin-top: 1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div span {
			display: block;
			float: none;
			text-align: left;
			width: 100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2) {
			padding-left: 0px;
			padding-right: 0px;
			display: block;
			width: 100%;
			float: none;
		}
		cancel-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			border: 1px solid #000;
			line-height: 12px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		cancel-button button.btn custom-text span {
			padding: 0px;
		}
		cancel-button button.btn span.fa {
			display: none;
		}
		val-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			background-color: #ff6200;
			color: #000;
			line-height: 12px;
			border: 1px solid #000;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		val-button button.btn span.fa {
			display: none;
		}
		val-button button.btn custom-text span {
			padding: 0px;
		}
		.col1 {
			display: block;
			width: 100%;
		}
		.col2 {
			display: block;
			width: 100%;
		}
		.col3 {
			display: -webkit-inline-box;
			width: 100%;
		}
		.colwidth2 {
			display: block;
			width: 100%;
		}
		#menu-separator {
			display: none;
		}
		.externalImage {
			margin: 0px;
			padding: 0px;
		}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdITan;

SET @pageLayoutIdExtPassword = (SELECT id FROM `CustomPageLayout` where `pageType` = 'EXT_PASSWORD_OTP_FORM_PAGE' and DESCRIPTION = 'for ING 16500');

UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
<style>
	/* global styles */
	#optGblPage {
		background-color:#f7f7f7;
		margin:0px;
		padding:0px;
		padding-bottom:1.5em;
	}
	@font-face {
		font-family: "INGme-Regular", Arial, Helvetica;
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#optGblPage{
		 font-family: "INGme-Regular", Arial, Helvetica;
	}
	.background-default { background-color:#f7f7f7;}
	.primary-color { color:#ff6200; }
</style>

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

	<style>
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
</style>
<message-banner></message-banner>
<style>
message-banner {
	display: block;
	width: 100%;
	position: relative;
}
</style>
	<div id="content">
		<div  id="title">
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>
<div id="center">
		<div id="left"> </div>
		<div id="mainLayout">
			<div class="row">
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>
		<div id="footer">
			<div class="row">
				<div class="col2">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<div class="col3">
					<pwd-form hide-input="true"></pwd-form>
				</div>
			</div>
			<div class="row">
				<div class="col1">
				</div>
				<div class="col2">
					 <div>
					<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
					<hr>
					</div>
				</div>
				<div class="col3">
					<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
					<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
				</div>
			</div>
		</div>
		</div>
	<div id="right"> </div>
	</div>
	</div>

<style>
	#title {
		margin-left: 35%;
		font-weight: bold;
	}
	#center {
		width: 100%;
		height: 96px;
	}
	#left {
		width: 30%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
	}
	#mainLayout {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 30px;
		padding-top: 16px;
	}
	#right {
		width: 10%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
	}
	#optGblPage .col-sm-5 {
		width: 34%;
	}
	#optGblPage .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	.img-text span.custom-text.ng-binding {
		margin-left: 0%;
	}
	#optGblPage #footer {
		height: 120px;
		background-image: none;
		margin-left: 9%;
	}
	.helpButtonClass button {
		border: 0px;
	}
	.helpButtonClass span.fa-info:before {
		content: '''';
	}
	.fa-info:before {
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
		margin: 1.5em;
		padding: 1.5em;
		height: 450px;
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	.col2.primary-color {
		width: 50%;
	}
	.col2 {
		margin-right: 3%;
	}
	.col3 {
		display: flex;
	}
	.colwidth2 {
		width: 70%;
	}
	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div span {
		padding-left: 25px;
		padding-right: 0px;
		margin-left: 0px;
		width: 50%;
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
	@media screen and (max-width: 1200px) {
		#optGblPage .row {
			display: flex;
			flex-direction: column;
			margin-top: 1em
		}
		/* overrides for the side-menu element */
		div.side-menu div.menu-elements div div div span {
			display: block;
			float: none;
			text-align: left;
			width: 100%;
		}
		div.side-menu div.menu-elements div div div span:nth-child(2) {
			padding-left: 0px;
			padding-right: 0px;
			display: block;
			width: 100%;
			float: none;
		}
		cancel-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			border: 1px solid #000;
			line-height: 12px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		cancel-button button.btn custom-text span {
			padding: 0px;
		}
		cancel-button button.btn span.fa {
			display: none;
		}
		val-button button.btn {
			display: block;
			float: none;
			width: 100%;
			height: 30px;
			background-color: #ff6200;
			color: #000;
			line-height: 12px;
			border: 1px solid #000;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		val-button button.btn span.fa {
			display: none;
		}
		val-button button.btn custom-text span {
			padding: 0px;
		}
		val-button button.btn[disabled]:hover {
			width: 100%;
		}
		val-button button.btn:hover {
			width: 100%;
		}
		.col1 {
			display: block;
			width: 100%;
		}
		.col2 {
			display: block;
			width: 100%;
		}
		.col3 {
			display: -webkit-inline-box;
			width: 100%;
		}
		.colwidth2 {
			display: block;
			width: 100%;
		}
		#menu-separator {
			display: none;
		}
		.externalImage {
			margin: 0px;
			padding: 0px;
		}
	}
</style>
</div>
' where fk_id_layout = @pageLayoutIdExtPassword;



SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @customItemSetPhotoTan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PHOTO_TAN'));
SET @customItemSetSms = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ING_SMS'));
SET @customItemSetITan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ITAN'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD'));

UPDATE `CustomItem` SET `value` = '' WHERE `ordinal` = 12
                                            AND pageTypes = 'POLLING_PAGE'
                                            AND `fk_id_customItemSet` in (@customItemSetMobileApp);

UPDATE `CustomItem` SET `value` = 'Händler' WHERE `value` = 'Onlinehändler'
                                            AND `fk_id_customItemSet` in (@customItemSetMobileApp,
                                                                          @customItemSetPhotoTan,
                                                                          @customItemSetSms,
                                                                          @customItemSetITan,
                                                                          @customItemSetPassword);

UPDATE `CustomItem` SET `value` = '<b>Banking to go App starten und Auftrag freigeben</b>' WHERE `ordinal` = 13
                                            AND `fk_id_customItemSet` in (@customItemSetMobileApp);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_SIDE_MENU_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
		 'de', 103, @currentPageType, 'Visa Card', @MaestroVID, NULL, @customItemSetMobileApp),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_SIDE_MENU_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
		 'de', 103, @currentPageType, 'Visa Card', @MaestroVID, NULL, @customItemSetPhotoTan),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_SIDE_MENU_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
		 'de', 103, @currentPageType, 'Visa Card', @MaestroVID, NULL, @customItemSetSms),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_SIDE_MENU_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
		 'de', 103, @currentPageType, 'Visa Card', @MaestroVID, NULL, @customItemSetITan),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_SIDE_MENU_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
		 'de', 103, @currentPageType, 'Visa Card', @MaestroVID, NULL, @customItemSetPassword);