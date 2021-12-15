USE U5G_ACS_BO;

SET @createdBy = 'A758582';


SET @pageType = 'OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'OTP Form Page (CBC)');

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
		line-height: normal;
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
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 4px;
	}
	#cancelButton button {
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
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 4px;
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
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-position-x: 2px;
		background-size: contain;
		display: inline-block;
		margin-right: 3px;
	}
	#footer {
		padding: 12px 8px;
		width: 100%;
		background-color: rgb(0, 137, 145);
		border-top: 5px solid rgb(0, 100, 62);
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
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
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding: 1em;
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
		padding: 0px;
		padding-top: 1em;
		clear: both;
	}
	side-menu div.text-center {
		text-align: left;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		padding-left: 50.9%;
		text-align: left;
		font-size: 18px;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
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
		margin-bottom: 10px;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	#validateButton {
		display: inline-block;
		padding-top: 10px;
		margin-left: 1em;
		vertical-align: 4px;
	}
	#validateButton button {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		border-radius: 20px;
		color: #fff;
		background: #00ac32;
		padding: 10px 20px 10px 20px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton button:disabled {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		border-radius: 20px;
		color: #969696;
		background: #fff;
		border-color: #dcdcdc;
		padding: 10px 20px 10px 20px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width: 150px;
	}
	#validateButton > button > span {
		width: 100%;
	}
	#validateButton > button > span.fa-check-square {
		display: none;
	}
	@media all and (max-width: 1199px) and (min-width: 601px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size: 13px; }
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 53px;}
		.paragraph { text-align: center; }
		div.side-menu div.menu-title { padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
	}
	@media all and (max-width: 600px) and (min-width: 501px) {
		h1 { font-size: 10px; }
		div#optGblPage { font-size: 11px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 56px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 16px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 11px; text-align: center; margin: 0px 0px 5px; }
		div#otp-fields-container { margin-top: 5px; margin-bottom: 5px; text-align: center;}
		#otp-form {padding-top: 0px; display: block;}
		#otp-form input { min-height: unset; padding: 2px 2px;}
		div#otp-form div.tooltips span { margin-bottom: 0px; }
		div#otp-fields {display: inherit;}
		#validateButton { padding-top: 5px;}
		#validateButton button:disabled { height: 35px; padding: 4px 0px; }
		#validateButton button { height: 35px; padding: 4px 0px; }
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#cancelButton button { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: 14px; height: 35px; padding: 3px; margin-bottom: 1px; }
		#footer #cancelButton button span.fa { width: 18px; height: 18px; background-repeat: no-repeat; background-position-y: 1px; background-position-x: 1px; background-size: 100%;}
		#cancelButton button custom-text { vertical-align: 4px; }
		#helpButton button {font: 300 14px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 35px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 24px; height: 22px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		h1 { font-size: 10px; }
		div#optGblPage { font-size: 11px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 65px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 16px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 11px; text-align: center; margin: 0px 0px 7px; }
		div#otp-fields-container { margin-top: 7px; margin-bottom: 7px; text-align: center;}
		#otp-form {padding-top: 0px; display: block;}
		#otp-form input { min-height: unset; padding: 2px 2px;}
		div#otp-form div.tooltips span { margin-bottom: 0px; }
		div#otp-fields {display: inherit;}
		#validateButton { padding-top: 7px;}
		#validateButton button:disabled { height: 35px; padding: 4px 0px; }
		#validateButton button { height: 35px; padding: 4px 0px; }
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#cancelButton button { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: 14px; height: 35px; padding: 3px; margin-bottom: 1px; }
		#footer #cancelButton button span.fa { width: 18px; height: 18px; background-repeat: no-repeat; background-position-y: 1px; background-position-x: 1px; background-size: 100%;}
		#cancelButton button custom-text { vertical-align: 4px; }
		#footer #helpButton button span.fa {width: 24px; height: 22px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	}

	@media all and (max-width: 391px) {
		h1 { font-size: 10px; }
		div#optGblPage { font-size: 10px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 80px; padding: 0px 10px;}
		side-menu div.text-center { text-align: center; }
		div.side-menu div.menu-title { font-size: 11px; padding-left: 0px; text-align: center; }
		.paragraph { font-size: 10px; text-align: center; margin: 0px 0px 7px; }
		div#otp-fields-container { margin-top: 7px; margin-bottom: 7px; text-align: center;}
		#otp-form {padding-top: 0px; display: block;}
		#otp-form input { min-height: unset; padding: 2px 2px;}
		div#otp-form div.tooltips span { margin-bottom: 0px; }
		div#otp-fields {display: inherit;}
		#validateButton { padding-top: 7px;}
		#validateButton button:disabled { height: 30px; padding: 4px 0px; }
		#validateButton button { height: 30px; padding: 4px 0px; }
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#cancelButton button { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: 12px; height: 30px; padding: 3px; margin-bottom: 1px; }
		#footer #cancelButton button span.fa { width: 18px; height: 18px; background-repeat: no-repeat; background-position-y: 1px; background-position-x: 1px; background-size: 100%;}
		#cancelButton button custom-text { vertical-align: 4px; }
		#helpButton button {font: 300 12px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 30px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 19px; height: 19px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	    span.ng-binding { word-break: break-word; }
	}
	@media all and (max-width: 250px) {
		h1 { font-size: 10px; }
		div#optGblPage { font-size: 8px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 65px; padding: 0px 10px;}
		side-menu div.text-center { text-align: center; }
		div.side-menu div.menu-title { font-size: 11px; padding-left: 0px; text-align: center; }
		.paragraph { font-size: 8px; text-align: center; margin: 0px 0px 7px; }
		div#otp-fields-container { margin-top: 7px; margin-bottom: 7px; text-align: center;}
		#otp-form {padding-top: 0px; display: block;}
		#otp-form input { min-height: unset; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #008991;
			border-bottom: 5px solid #DE1300;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
			<div id="otp-fields-container">
				<div x-ms-format-detection="none" id="otp-fields">
					<otp-form></otp-form>
					<val-button val-label="''network_means_pageType_42''" id="validateButton"></val-button>
				</div>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;


SET @pageType = 'REFUSAL_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Refusal Page (CBC)');

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
		line-height: normal;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
	#footer #helpButton button span:before {
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
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#footer {
		padding: 12px 8px;
		clear: both;
		width: 100%;
		background-color: #ced8f6;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
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
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding: 1em;
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
		padding: 0px;
		padding-top: 1em;
		clear: both;
	}
	side-menu div.text-center {
		text-align: left;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		padding-left: 50.9%;
		text-align: left;
		font-size: 18px;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
	}
	@media all and (max-width: 1199px) and (min-width: 601px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size: 13px; }
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 53px;}
		.paragraph { text-align: center; }
		#footer { padding: 8px 8px;}
		div.side-menu div.menu-title { padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
	}
	@media all and (max-width: 600px) and (min-width: 501px) {
		h1 { font-size: 10px; }
		div#optGblPage { font-size: 11px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 56px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 16px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 11px; text-align: center; margin: 0px 0px 5px; }
		#footer { padding: 8px 8px;}
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#helpButton button {font: 300 14px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 35px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 24px; height: 22px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size: 11px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 65px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 16px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 11px; text-align: center; margin: 0px 0px 7px; }
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#helpButton button {font: 300 14px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 35px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 24px; height: 22px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	}
	@media all and (max-width: 391px) {
		div#optGblPage { font-size: 10px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 80px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 11px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 10px; text-align: center; margin: 0px 0px 7px; }
		#helpButton button {font: 300 12px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 30px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 19px; height: 19px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
	    span.ng-binding { word-break: break-word; }
	}
	@media all and (max-width: 250px) {
		div#optGblPage { font-size: 8px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 65px; padding: 0px 10px;}
		.paragraph { font-size: 8px; text-align: center; margin: 0px 0px 7px; }
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

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #008991;
			border-bottom: 5px solid #DE1300;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
' WHERE `fk_id_layout` = @layoutId;


SET @pageType = 'FAILURE_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Failure Page (CBC)');

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
		line-height: normal;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
	#footer #helpButton button span:before {
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
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	#footer {
		padding: 12px 8px;
		clear: both;
		width: 100%;
		background-color: #ced8f6;
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
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
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding: 1em;
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
		padding: 0px;
		padding-top: 1em;
		clear: both;
	}
	side-menu div.text-center {
		text-align: left;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		padding-left: 50.9%;
		text-align: left;
		font-size: 18px;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
	}
	@media all and (max-width: 1199px) and (min-width: 601px) {
		h1 { font-size: 24px; }
		#pageHeader {height: 90px;}
		#issuerLogo {max-height: 50px; }
		#networkLogo {max-height: 50px; }
		div#optGblPage { font-size: 13px; }
		.leftColumn { display: block; float: none; width: 100%; }
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 53px;}
		.paragraph { text-align: center; }
		#footer { padding: 8px 8px;}
		div.side-menu div.menu-title { padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
	}
	@media all and (max-width: 600px) and (min-width: 501px) {
		h1 { font-size: 10px; }
		div#optGblPage { font-size: 11px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 56px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 16px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 11px; text-align: center; margin: 0px 0px 5px; }
		 #footer { padding: 8px 8px;}
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#helpButton button {font: 300 14px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 35px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 24px; height: 22px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size: 11px; }
		#pageHeader {height: 70px;}
		#issuerLogo {max-height: 45px; }
		#networkLogo {max-height: 45px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 65px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 16px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 11px; text-align: center; margin: 0px 0px 7px; }
		div#footer {height: unset; margin: 0px 0px; padding-top: 2px; padding-bottom: 2px;}
		#helpButton button {font: 300 14px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 35px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 24px; height: 22px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
		#helpButton button custom-text {vertical-align: 4px;}
	}
	@media all and (max-width: 391px) {
		div#optGblPage { font-size: 10px; }
		#pageHeader {height: 65px;}
		#issuerLogo {max-height: 35px; }
		#networkLogo {max-height: 30px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 80px; padding: 0px 10px;}
		div.side-menu div.menu-title { font-size: 11px; padding-left: 0px; text-align: center; }
		side-menu div.text-center { text-align: center; }
		.paragraph { font-size: 10px; text-align: center; margin: 0px 0px 7px; }
		#helpButton button {font: 300 12px/15px "Helvetica Neue", Helvetica, Arial, sans-serif; height: 30px; padding: 0px; margin-bottom: 0px;}
		#footer #helpButton button span.fa {width: 19px; height: 19px; background-position-y: 1px; background-repeat: no-repeat; background-size: 100%;}
	    span.ng-binding { word-break: break-word; }
	}
	@media all and (max-width: 250px) {
		div#optGblPage { font-size: 8px; }
		.leftColumn { display: block; width: 100%; float: none; padding: 0px 1em;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; margin-top: 65px; padding: 0px 10px;}
		.paragraph { font-size: 8px; text-align: center; margin: 0px 0px 7px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #008991;
			border-bottom: 5px solid #DE1300;
			width: 100%;
		}
	</style>

	<div class="contentRow">
		<div class="leftColumn">
			<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
		</div>

		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>
' WHERE `fk_id_layout` = @layoutId;


SET @pageType = 'HELP_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Help Page (CBC)');

UPDATE `CustomComponent` SET `value` = '
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_1''"></custom-text></p>
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_2''"></custom-text></p>
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_3''"></custom-text></p>
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_4''"></custom-text></p>
	</div>
	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button id="helpCloseButton"></help-close-button>
		</div>
	</div>
</div>
<style>
	help-page {
		font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		padding:14px;
		overflow:auto;
		text-align:left;
	}
	#help-contents {
		text-align:left;
		margin-top:20px;
		margin-bottom:20px;
	}
	#help-container #help-modal {
		overflow:hidden;
	}
	#helpCloseButton button {
		display: flex;
		align-items: center;
		margin-left: auto;
		margin-right: auto;
		justify-content: center;
	}
	#helpCloseButton button custom-text {
		vertical-align:0px;
	}

	@media screen and (max-width: 700px) and (min-width: 361px) {
		#helpCloseButton > button {		}
	}
	@media screen and (max-width: 360px) {
		#helpCloseButton > button {		}
	}
	@media only screen and (max-width: 480px) {
		div#message-container {
			width:100%;
			box-shadow: none;
			-webkit-box-shadow:none;
		}
		#help-page {
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:9.19px;
		}
	}
	@media only screen and (max-width: 309px) {
		#help-page {
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:8px;
		}
	}
	@media only screen and (max-width: 250px) {
		#help-page {
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:7.8px;
		}
	}
</style>' WHERE `fk_id_layout` = @layoutId;