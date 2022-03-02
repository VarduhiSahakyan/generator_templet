USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @BankUB = 'ING';
SET @description = 'for ING 16500';
SET @pageType = 'MOBILE_APP_EXT_CHOICE_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	}
	#optGblPage .row {
		display: flex;
		flex-direction: row;
		margin-top: 1em;
	}
	#centerLayout {
		width: 100%;
		text-align: center;
		display: inherit;
		margin-left: 38.3%;
	}
	.col1 {
		width: 30%;
	}
	.col2 {
		width: 20%;
	}
	.col3 {
		display: flex;
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
	@media all and (max-width: 1030px) and (min-width: 701px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		#centerLayout { margin-left: 28%; }
		div#left { width: 25%; }
		div#helpDiv { width: 26%; }
	}
	@media all and (max-width: 700px) and (min-width: 601px) {
		#centerLayout { margin-left: 19%; }
		div#left { width: 29%; }
		div#helpDiv { width: 24%; }
	}
	@media all and (max-width: 600px) {
		#optGblPage #title {text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#mainLayout { line-height: 20px; }
		#centerLayout { margin-left: 15%;}
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		div#left { width: 25%; }
		div#helpDiv { width: 30%; }
		div#buttonsDiv { display: flex; width: 40%; }
		#deviceChoice { margin-left: 20px;}
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left { width: 40%; }
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%; }
		.col1 { width: 5%; }
		.col2 { width: 35%; }
		.col3 { margin-left: 5%; }
		#centerLayout { margin-left: 1%;}
		.img-text { width: 40%; display: contents;}
		.img-text custom-text { text-align: start; }
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
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		#mainLayout {line-height: 20px; }
		#optGblPage .otp-field input { width: 218px; }
		.col1 { width: 2%; }
		#centerLayout { display: block;  margin-left: 28%;}
		.img-text { width: 100%; display: flex;}
		div#left { width: 0%; }
		div#helpDiv { width: 42%; }
		div#buttonsDiv { display: flex; width: 58%; }
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
		#centerLayout { display: block; margin-left: 10%;}
		.img-text { width: 100%;}
		div#buttonsLayout { display: block; width: 100%; }
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		span.ng-binding { word-break: break-word; }
	}
</style>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'EXT_PASSWORD_OTP_FORM_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
		</div>
	</div>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	 @media all and (max-width: 1030px) and (min-width: 601px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#left { width: 25%; }
		div#helpDiv { width: 26%; }
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		.col3 { margin-left: 3%;}
		div#left { width: 25%; }
		div#helpDiv { width: 28%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
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
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
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
		span.ng-binding { word-break: break-word; }
	}
</style>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'I_TAN_OTP_FORM_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	@media all and (max-width: 1030px) and (min-width: 601px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#left { width: 25%; }
		div#helpDiv { width: 26%; }
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		.col3 { margin-left: 3%;}
		div#left { width: 25%; }
		div#helpDiv { width: 28%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
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
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
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
		span.ng-binding { word-break: break-word; }
	}
</style>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'OTP_SMS_EXT_MESSAGE_OTP_FORM_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	@media all and (max-width: 1030px) and (min-width: 601px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#left { width: 25%; }
		div#helpDiv { width: 26%; }
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#mainLayout { line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%; }
		.col3 { margin-left: 3%;}
		div#left { width: 25%; }
		div#helpDiv { width: 28%; }
		div#buttonsDiv { display: flex; width: 40%; }
		cancel-button#cancelButton { margin-right: 10%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
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
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
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
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em; margin-top: 0em;}
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
		span.ng-binding { word-break: break-word; }
	}
</style>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'PHOTO_TAN_OTP_FORM_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	@media all and (max-width: 1030px) and (min-width: 601px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#left { width: 25%; }
		div#helpDiv { width: 26%; }
	}
	@media all and (max-width: 601px) {
		#optGblPage #title {text-align: center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
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
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
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
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
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
		div#photoTanLayout { display: block;}
		div#photoTanCenter { width: 50%; margin-left: auto; margin-right: auto; text-align: center;}
		div#photoTanRight { margin-top: 5%; }
	}
	@media all and (max-width: 251px) {
		#optGblPage #header {padding-left: 0px; }
		#optGblPage #issuerLogo {padding-left: 0px; max-height: 35px;}
		#optGblPage #networkLogo {padding-right: 0px; max-height: 35px;}
		#optGblPage #content { text-align: left; margin-left: 0em; margin-right: 0em;}
		#mainLayout { line-height: 20px; }
		div#photoTanLayout { display: block; }
		div#photoTanCenter { width: 80%; margin-left: auto; margin-right: auto; text-align: center;}
		div#photoTanRight { margin-top: 5%; }
		hr { margin-top: 5px; margin-bottom: 5px; }
		#optGblPage .col-sm-5 { font-size: 10px;}
		#optGblPage .col-sm-6 { font-size: 10px;}
		#optGblPage .otp-field input { width: 218px; }
		div#buttonsLayout { display: block; width: 100%; }
		div#helpDiv { width: 100%; }
		div#buttonsDiv { display: flex; width: 100%; justify-content: center; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		span.ng-binding { word-break: break-word; }
	}
</style>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'REFUSAL_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	@media all and (max-width: 1200px) {
		#optGblPage .row { display:flex; flex-direction:column; margin-top:1em}
	}
	@media all and (max-width: 700px) and (min-width: 600px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 18px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
	}
	@media all and (max-width: 600px) and (min-width: 500px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#content {margin: 0em; }
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		#content {margin: 0em; }
		hr { display: none; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 10px; }
		#content {padding: 0.5em; }
		hr { display: none; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
		</div>
	</div>

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

SET @pageType = 'FAILURE_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner></message-banner>
	<div id="content">
		<div>
			<hr>
		</div>
		<div id="mainLayout">
			<custom-text custom-text-key="''network_means_pageType_5''"></custom-text>
			<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
			<help help-label="''network_means_pageType_11''" id="helpButton" class="helpButtonClass"></help>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
	message-banner {
		display: block;
		width: 100%;
		position: relative;
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
	div#mainLayout {
		display: grid;
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
	@media all and (max-width: 1200px) {
		#optGblPage .row { display:flex; flex-direction:column; margin-top:1em}
	}
	@media all and (max-width: 700px) and (min-width: 600px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 18px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
	}
	@media all and (max-width: 600px) and (min-width: 500px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#content {margin: 0em; }
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 12px;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
	}
	@media all and (max-width: 390px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		#content {margin: 0em; }
		hr { display: none; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 10px; }
		#content {padding: 0.5em; }
		hr { display: none; }
	}
</style>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'HELP_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

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
		background-color: #f7f7f7;
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	.container-fluid {
		max-width: 700px;
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
		#optGblPage, #divMedia {font-size: 18px;}
		.paragraph {margin: 0px 5px 10px; text-align: justify; }
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#optGblPage, #divMedia { font-size: 14px;}
		.paragraph {margin: 0px 5px 10px; text-align: left; }
	}
	@media screen and (max-width: 360px) {
		#optGblPage, #divMedia {font-size: 12px;}
		.paragraph {margin: 0px 5px 10px; text-align: left; }
	}
</style>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'POLLING_PAGE';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''"
						  image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo"
						  straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"
						  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo"
						  straight-mode="false"></custom-image>
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
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#pageHeaderRight {
		width: 50%;
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
		padding: 0.5em;
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
	hr { margin-top: 0px; margin-bottom: 0px; }

	@media all and (max-width: 1030px) and (min-width: 601px) {
		#pageHeader {height: 80px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		.col2 { width: 26%}
	}
	@media all and (max-width: 601px) {
		#optGblPage #title { text-align:center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		#mainLayout {  width: 100%; float: left; text-align: center; line-height: 20px; }
		.col1 { width: 20%; }
		.col2 { width: 30%;  margin-right: 20px; }
		.col3 { width: 25%; display: flex; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 501px) {
		#optGblPage #title { text-align:center;}
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.col1 { width: 10%; }
		.col2 { width: 40%; margin-right: 5px;}
		.col3 { width: 30%; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 391px) {
		#optGblPage #title {text-align:center;}
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
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
		#optGblPage .row { margin-top: 0em;}
		#mainLayout {float: left; text-align: center; line-height: 20px; }
		span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {width: 40%;font-size: 10px;}
		span.col-sm-6.col-xs-6.text-left.padding-left { width: 60%;font-size: 10px;}
		.col2 { width: 60%; }
		.col3 { width: 40%; }
		hr { margin-top: 0px; margin-bottom: 0px; }
		#optGblPage .btn-default {font-size: 10px;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		span.ng-binding { word-break: break-word; }
	}
</style>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @pageType = 'MESSAGE_BANNER';
SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `pageType` =@pageType AND  `DESCRIPTION`= @description);

UPDATE `CustomComponent` SET `value` = '
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
</style>' WHERE `fk_id_layout` = @id_layout;




