USE `U5G_ACS_BO`;

SET @pollingPageLayoutDesc = 'Polling Page (12000)';
SET @pollingPageType = 'POLLING_PAGE';

SET @idPollingFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @pollingPageType
			AND DESCRIPTION = @pollingPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
<style>
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		height: 100%;
		display: inline-flex;
		float: left;
	}
	#pageHeaderRight {
		width: 50%;
		height: 100%;
		display: inline-flex;
	}
	div#networkLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: right;
		align-self: center;
		padding-right: 16px;
	}
	div#issuerLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: left;
		align-self: center;
		padding-left: 16px;
	}
	#issuerLogo {
		max-height: 65px;
	}
	#networkLogo {
		max-height: 65px;
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
		padding: 10px;
		min-height: 150px;
		width: fit-content;
		width: auto;
		width: -moz-fit-content;
		margin-left: auto;
		margin-right: auto;
	}
	#rightContainer {
		width: 60%;
		padding-top: 10px;
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
	@media (max-width: 1200px){
		#main-container{max-width: 1200px}
		.col-lg-3{padding: 0px;}
		.menu-title {display: none;}
		#rightContainer {display:block; float:none; width:100%; margin-left:0px;}
		.paragraph{ margin: 0px 0px 10px;text-align: center;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div.side-menu{padding-bottom: 0px; padding-top: 20px}
		div#leftMenuLayout {width: 100%;min-height: 10px;}
		#switchId {padding-left: 10px;display: none;}
		#bottomLayout {display: block !important;}
		div#centerPieceLayout {width: 100%;padding: 0px;padding-top: 10px;}
		#i18n-container{padding-bottom: 0px;}
        #bottomMenu {width: 100%;margin-top: 0px;}
	}
	@media (max-width: 601px) {
		#main-container{max-width: 600px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; min-height: 10px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;display: none;}
		#i18n-container{padding-bottom: 0px;}
		#pageHeader { height: 85px; }
		#issuerLogo { max-height: 50px; }
		#networkLogo { max-height: 50px; }
        #bottomMenu {width: 100%;margin-top: 0px;}
	}
	@media (max-width: 501px) {
		#main-container{max-width: 500px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		body {font-size: 12px;}
		.btn {font-size: 12px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 0px; padding: 0px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;display: none;}
		#i18n-container{padding-bottom: 0px;}
		#bottomMenu {margin-top: 0px;margin-top: 0px;}
		#pageHeader { height: 70px; }
		#issuerLogo { max-height: 40px; }
		#networkLogo { max-height: 40px; }
	}
	@media (max-width: 391px) {
		#main-container{max-width: 390px; overflow: hidden;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		body {font-size: 11px;}
		.btn {font-size: 11px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px; padding: 0px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph{text-align: center;}
		#switchId button {min-width: 20rem;display: none;}
		#i18n-container{padding-bottom: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 70px; }
        #bottomMenu {width: 100%;margin-top: 0px;}
	}
	@media (max-width: 251px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px; padding-right: 10px; padding: 0px;}
		#switchId {padding-right: 0px;}
		#switchId button {min-width: 16rem;display: none;}
		#bottomMenu {width: 100%;margin-top: 0px;}
		.paragraph{text-align: center;font-size: 11px;}
		#i18n-container{padding-bottom: 0px;}
		.noLeftRightPadding { font-size: 10px;}
		#issuerLogo {padding-left: 3px; padding-top: 5px;}
		.btn {font-size: 11px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 60px; }
	}
</style>
<div id="main-container" class="container-fluid">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<div id="issuerLogoDiv">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<div id="networkLogoDiv">
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
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
' where fk_id_layout = @idPollingFormPage;

SET @refusalPageLayoutDesc = 'Refusal Page (ReiseBank)';
SET @refusalPageType = 'REFUSAL_PAGE';

SET @idRefusalFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @refusalPageType
			AND DESCRIPTION = @refusalPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '<style>
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		height: 100%;
		display: inline-flex;
		float: left;
	}
	#pageHeaderRight {
		width: 50%;
		height: 100%;
		display: inline-flex;
	}
	div#networkLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: right;
		align-self: center;
		padding-right: 16px;
	}
	div#issuerLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: left;
		align-self: center;
		padding-left: 16px;
	}
	#issuerLogo {
		max-height: 65px;
	}
	#networkLogo {
		max-height: 65px;
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
		padding: 10px 10px 0px;
		min-height: 200px;
		width: 60%;
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
	button span.fa {
		padding-right: 7px;
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
	@media (max-width: 1200px){
		#main-container{max-width: 1200px}
		.col-lg-3{padding: 0px;}
		.menu-title {display: none;}
		#rightContainer {display:block; float:none; width:100%; margin-left:0px;}
		.paragraph{ margin: 0px 0px 10px;text-align: center;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div.side-menu{padding-bottom: 0px; padding-top: 20px}
		div#leftMenuLayout {width: 100%;min-height: 10px;}
		#switchId {padding-left: 10px;}
		#bottomLayout {display: block !important;}
		div#centerPieceLayout {width: 100%;min-height: 10px ;padding-top: 10px;}
		#i18n-container{padding-bottom: 0px;}
	}
	@media (max-width: 601px) {
		#main-container{max-width: 600px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; min-height: 10px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		div#centerPieceLayout {padding-top: 10px;}
		#pageHeader { height: 85px; }
		#issuerLogo { max-height: 50px; }
		#networkLogo { max-height: 50px; }
	}
	@media (max-width: 501px) {
		#main-container{max-width: 500px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		body {font-size: 12px;}
		.btn {font-size: 12px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 10px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#bottomMenu {margin-top: 0px;}
		#pageHeader { height: 70px; }
		#issuerLogo { max-height: 40px; }
		#networkLogo { max-height: 40px; }
	}
	@media (max-width: 391px) {
		#main-container{max-width: 390px; overflow: hidden;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		body {font-size: 11px;}
		.btn {font-size: 11px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 10px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph{text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 70px; }
	}
	@media (max-width: 251px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px; padding-right: 10px;padding-top: 10px;}
		#switchId {padding-right: 0px;}
		#switchId button {min-width: 16rem;}
		#bottomMenu {width: 100%;}
		.paragraph{text-align: center;font-size: 11px;}
		#i18n-container{padding-bottom: 0px;}
		.noLeftRightPadding {padding-left: 10px; font-size: 11px;}
		#issuerLogo {padding-left: 3px; padding-top: 5px}
		.btn {font-size: 11px;}
		div#message-controls { margin-top: 0px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 60px; }
	}

</style>
<div id = "main-container" class="container-fluid">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<div id="issuerLogoDiv">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
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
			<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
					</custom-text>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
					</custom-text>
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
' where fk_id_layout = @idRefusalFormPage;

SET @refusalInfoPageLayoutDesc = 'INFO Refusal Page (ReiseBank)';
SET @refusalInfoPageType = 'INFO_REFUSAL_PAGE';

SET @idRefusalInfoFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @refusalInfoPageType
			AND DESCRIPTION = @refusalInfoPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
 <style>
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		height: 100%;
		display: inline-flex;
		float: left;
	}
	#pageHeaderRight {
		width: 50%;
		height: 100%;
		display: inline-flex;
	}
	div#networkLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: right;
		align-self: center;
		padding-right: 16px;
	}
	div#issuerLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: left;
		align-self: center;
		padding-left: 16px;
	}
	#issuerLogo {
		max-height: 65px;
	}
	#networkLogo {
		max-height: 65px;
	}
	#centeredTitle {
		color: rgb(0, 100, 62);
		font-weight: 500;
		display: block;
		font-size: 150%;
		margin-top: 10px;
	}
	#headingTxt {
		font-size: large;
		font-weight: bold;
		width: 80%;
		margin: auto;
		display: block;
		text-align: center;
		padding: 4px 1px 1px 1px;
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
	div#message-container.info {
			background-color:#C9302C;
	}
	div#message-controls {
		text-align: center;
		padding-bottom: 10px;
		padding-top: 0px;
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
		padding: 10px 10px 0px;
		min-height: 200px;
		width: 60%;
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
	button span.fa {
		padding-right: 7px;
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
	@media (max-width: 1200px){
		#main-container{max-width: 1200px}
		.col-lg-3{padding: 0px;}
		.menu-title {display: none;}
		#rightContainer {display:block; float:none; width:100%; margin-left:0px;}
		.paragraph{ margin: 0px 0px 10px;text-align: center;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div.side-menu{padding-bottom: 0px; padding-top: 20px}
		div#leftMenuLayout {width: 100%;min-height: 10px;}
		#switchId {padding-left: 10px;}
		#bottomLayout {display: block !important;}
		div#centerPieceLayout {width: 100%;min-height: 10px; padding-top: 10px;}
		#i18n-container{padding-bottom: 0px;}
	}
	@media (max-width: 601px) {
		#main-container{max-width: 600px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; min-height: 10px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#pageHeader { height: 85px; }
		#issuerLogo { max-height: 50px; }
		#networkLogo { max-height: 50px; }
	}

	@media (max-width: 501px) {
		#main-container{max-width: 500px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		body {font-size: 12px;}
		.btn {font-size: 12px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 10px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#bottomMenu {margin-top: 0px;}
		#pageHeader { height: 70px; }
		#issuerLogo { max-height: 40px; }
		#networkLogo { max-height: 40px; }
	}
	@media (max-width: 391px) {
		#main-container{max-width: 390px; overflow: hidden;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		body {font-size: 11px;}
		.btn {font-size: 11px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 10px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px; }
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph{text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 70px; }
	}
	@media (max-width: 251px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px; padding-right: 10px;padding-top: 10px;}
		#switchId {padding-right: 0px;}
		#switchId button {min-width: 16rem;}
		#bottomMenu {width: 100%;}
		.paragraph{text-align: center;font-size: 11px;}
		#i18n-container{padding-bottom: 0px;}
		.noLeftRightPadding {padding-left: 10px; font-size: 11px;}
		#issuerLogo {padding-left: 3px; padding-top: 5px}
		.btn {font-size: 11px;}
		div#message-controls { margin-top: 0px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 60px; }
	}

</style>
<div id = "main-container" class="container-fluid">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<div id="issuerLogoDiv">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<div id="networkLogoDiv">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''"
	back-button="''network_means_pageType_175''" show=true></message-banner>

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
			<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
					</custom-text>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
					</custom-text>
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
' where fk_id_layout = @idRefusalInfoFormPage;

SET @otpPageLayoutDesc = 'OTP Form Page (ReiseBank)';
SET @otpPageType = 'OTP_FORM_PAGE';

SET @idOTPFormPage = (SELECT id
			FROM `CustomPageLayout`
			WHERE `pageType` = @otpPageType
			AND DESCRIPTION = @otpPageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '
<style>
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		height: 100%;
		display: inline-flex;
		float: left;
	}
	#pageHeaderRight {
		width: 50%;
		height: 100%;
		display: inline-flex;
	}
	div#networkLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: right;
		align-self: center;
		padding-right: 16px;
	}
	div#issuerLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: left;
		align-self: center;
		padding-left: 16px;
	}
	#issuerLogo {
		max-height: 65px;
	}
	#networkLogo {
		max-height: 65px;
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
		padding: 10px 10px 0px;
		min-height: 200px;
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
	 .paragraphFooter {
		margin: 0px 0px 10px 3px;
		text-align: justify;
		color: #c9302c;
		max-width: 100%;
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
	@media (max-width: 1200px){
		#main-container{max-width: 1200px}
		.col-lg-3{padding: 0px;}
		.menu-title {display: none;}
		#rightContainer {display:block; float:none; width:100%; margin-left:0px;}
		.paragraph{ margin: 0px 0px 10px;text-align: center;}
		.paragraphFooter{ margin: 0px 0px 10px 3px ;text-align: center;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div.side-menu{padding-bottom: 0px; padding-top: 20px}
		div#leftMenuLayout {width: 100%;min-height: 10px;}
		#switchId {padding-left: 10px;}
		#bottomLayout {display: block !important;}
		div#centerPieceLayout {width: 100%;min-height: 10px;padding-top: 10px;}
		#i18n-container{padding-bottom: 0px;}
	}
	@media (max-width: 601px) {
		#main-container{max-width: 600px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; min-height: 10px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		.paragraphFooter {text-align: center; margin-top: 3px;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#pageHeader { height: 85px; }
		#issuerLogo { max-height: 50px; }
		#networkLogo { max-height: 50px; }
	}
	@media (max-width: 501px) {
		#main-container{max-width: 500px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		body {font-size: 12px;}
		.btn {font-size: 12px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 10px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		.paragraphFooter {text-align: center; margin-top: 3px;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#bottomMenu {margin-top: 0px;}
		#pageHeader { height: 70px; }
		#issuerLogo { max-height: 40px; }
		#networkLogo { max-height: 40px; }
	}
	@media (max-width: 391px) {
		#main-container{max-width: 390px; overflow: hidden;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		body {font-size: 11px;}
		.btn {font-size: 11px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 10px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px; }
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		.paragraph{text-align: center;}
		.paragraphFooter{text-align: center; margin-top: 3px;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 70px; }
	}
	@media (max-width: 251px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px; }
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px; padding-right: 10px;padding-top: 10px;}
		#switchId {padding-right: 0px;}
		#switchId button {min-width: 16rem;}
		#bottomMenu {width: 100%;}
		.paragraph{text-align: center;font-size: 11px; padding-top: 3px;}
		.paragraphFooter{text-align: center;font-size: 11px; margin-bottom: 3px; margin-top: 3px; }
		#i18n-container{padding-bottom: 0px;}
		.noLeftRightPadding {padding-left: 10px; font-size: 11px;}
		#issuerLogo {padding-left: 3px; padding-top: 5px;}
		.btn {font-size: 11px;}
		div#message-controls { margin-top: 0px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 60px; }
	}
</style>
<div id="main-container" class="container-fluid">
	<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
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
					<div class="text-center">
						<otp-form></otp-form>
						<div class="resendButton">
							<re-send-otp rso-label="''network_means_pageType_4''"></re-send-otp>
						</div>
					</div>
					<div class="text-center">
						<val-button val-label="''network_means_OTP_FORM_PAGE_42''" id="validateButton"></val-button>
					</div>
					<div class="paragraphFooter">
						<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
						</custom-text>
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
' where fk_id_layout = @idOTPFormPage;

SET @failurePageLayoutDesc = 'Failure Page (ReiseBank)';
SET @failurePageType = 'FAILURE_PAGE';

SET @idFailureFormPage = (SELECT id
				FROM `CustomPageLayout`
				WHERE `pageType` = @failurePageType
				AND DESCRIPTION = @failurePageLayoutDesc);

UPDATE `CustomComponent`
SET `value` = '<style>
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		height: 100%;
		display: inline-flex;
		float: left;
	}
	#pageHeaderRight {
		width: 50%;
		height: 100%;
		display: inline-flex;
	}
	div#networkLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: right;
		align-self: center;
		padding-right: 16px;
	}
	div#issuerLogoDiv {
		display: inline-block;
		width: 100%;
		text-align: left;
		align-self: center;
		padding-left: 16px;
	}
	#issuerLogo {
		max-height: 65px;
	}
	#networkLogo {
		max-height: 65px;
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
		padding: 10px 10px 0px;
		min-height: 200px;
		width: 60%;
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
	button span.fa {
		padding-right: 7px;
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
	@media (max-width: 1200px){
		#main-container{max-width: 1200px}
		.col-lg-3{padding: 0px;}
		.menu-title {display: none;}
		#rightContainer {display:block; float:none; width:100%; margin-left:0px;}
		.paragraph{ margin: 0px 0px 10px;text-align: center;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div.side-menu{padding-bottom: 0px; padding-top: 20px}
		div#leftMenuLayout {width: 100%;min-height: 10px;}
		#switchId {padding-left: 10px;}
		#bottomLayout {display: block !important;}
		div#centerPieceLayout {width: 100%;min-height: 10px;,Padding-top: 10px;}
		#i18n-container{padding-bottom: 0px;}
	}
	@media (max-width: 601px) {
		#main-container{max-width: 600px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; min-height: 10px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#pageHeader { height: 85px; }
		#issuerLogo { max-height: 50px; }
		#networkLogo { max-height: 50px; }
	}
	@media (max-width: 501px) {
		#main-container{max-width: 500px; overflow: hidden;}
		#rightContainer {width: 100%;}
		.col-lg-3{padding: 0px;}
		body {font-size: 12px;}
		.btn {font-size: 12px;}
		div.hideable-text {display: block !important;}
		#centeredTitle {margin-top: 3px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;padding-top: 0px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		div.hideable-text {display: block !important;}
		.paragraph {text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		#bottomMenu {margin-top: 0px;}
		#pageHeader { height: 70px; }
		#issuerLogo { max-height: 40px; }
		#networkLogo { max-height: 40px; }

	}
	@media (max-width: 391px) {
		#main-container{max-width: 390px; overflow: hidden;}
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		body {font-size: 11px;}
		.btn {font-size: 11px;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px; }
		div.hideable-text {display: block !important;}
		.paragraph{text-align: center;}
		#switchId button {min-width: 20rem;}
		#i18n-container{padding-bottom: 0px;}
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 70px; }
	}
	@media (max-width: 251px) {
		#main-container{max-width: 250px; overflow: hidden;}
		body {font-size: 8px;}
		.btn {font-size: 8px;}
		#centeredTitle {margin-top: 3px;}
		.side-menu .text-left, .side-menu .text-right {padding-right: 0px;padding-left: 3px;}
		div#leftMenuLayout {padding-left: 0px;padding-right: 0px; padding-bottom: 3px; }
		#rightContainer {width: 100%;}
		div.hideable-text {display: block !important;}
		div#centerPieceLayout {min-height: 50px; padding-left: 10px; padding-right: 10px;}
		#switchId {padding-right: 0px;}
		#switchId button {min-width: 16rem;}
		#bottomMenu {width: 100%;}
		.paragraph{text-align: center;font-size: 11px;}
		#i18n-container{padding-bottom: 0px;}
		.noLeftRightPadding {padding-left: 10px; font-size: 11px;}
		#issuerLogo {padding-left: 3px; padding-top: 5px}
		.btn {font-size: 11px;}
		div#message-controls { margin-top: 0px; }
		div.side-menu{padding-bottom: 0px; padding-top: 10px}
		#pageHeader { height: 60px; }
	}
	</style>
	<div id="main-container" class="container-fluid">
		<div id="pageHeader" ng-style="style" class="ng-scope">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<div id="issuerLogoDiv">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
				<div id="networkLogoDiv">
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
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
				<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
					<div class="paragraph">
						<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
						</custom-text>
					</div>
					<div class="paragraph">
						<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
						</custom-text>
					</div>
				</div>
			</div>
		</div>
		<div id="bottomLayout" class="row">
			<div id="bottomMenu">
				<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			</div>
		</div>
	</div>
' where fk_id_layout = @idFailureFormPage;

SET @helpPageLayoutDesc = 'Help Page (ReiseBank)';
SET @helpPageType = 'HELP_PAGE';

SET @idHelpFormPage = (SELECT id
				FROM `CustomPageLayout`
				WHERE `pageType` = @helpPageType
				AND DESCRIPTION = @helpPageLayoutDesc);


UPDATE `CustomComponent`
SET `value` = '<div class="container-fluid">
    <div class=" col-xs-12 col-md-10 col-md-offset-1">
        <div id="helpContent">
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_HELP_PAGE_1''" id="paragraph1">
                </custom-text>
                <custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph1">
                </custom-text>
            </div>
            <help-close-button id="helpCloseButton"></help-close-button>
        </div>
    </div>
</div>

<style>
    #helpContent {
        padding: 5px 10px 0px;
        min-height: 200px;
        text-align: center;
    }
    .paragraph {
        margin: 0px 0px 10px;
        text-align: justify;
    }
    @media (max-width: 1200px){
    .paragraph {text-align: center;}
    #helpContent {text-align: center;height: auto; min-height: 10px;}
	}
 	@media (max-width: 601px) {
    .paragraph {text-align: center;}
    #helpContent {text-align: center;height: auto; min-height: 10px;}
    }
	@media (max-width: 501px) {
    .paragraph {text-align: center;}
    #helpContent {text-align: center;height: auto; min-height: 10px;}
    }
	@media (max-width: 391px) {
    .paragraph {text-align: center;}
    #helpContent {text-align: center;height: auto; min-height: 10px;}
    }
	@media (max-width: 251px) {
    .paragraph {text-align: center;}
    #helpContent {text-align: center;height: auto; min-height: 10px;}
    }
</style>
' where fk_id_layout = @idHelpFormPage;