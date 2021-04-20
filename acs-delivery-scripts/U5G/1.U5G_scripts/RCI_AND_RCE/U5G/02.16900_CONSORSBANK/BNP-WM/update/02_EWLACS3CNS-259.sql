USE `U5G_ACS_BO`;
SET @BankUB = 'BNP_WM';
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankUB, ')%') );

UPDATE CustomComponent SET value = '

<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_301_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_301_FONT_TITLE''''"
			 font-key="''''network_means_pageType_301_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_304_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_304_FONT_TITLE''''"
			 font-key="''''network_means_pageType_304_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_305_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_305_FONT_TITLE''''"
			 font-key="''''network_means_pageType_305_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_306_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_306_FONT_TITLE''''"
			 font-key="''''network_means_pageType_306_FONT_DATA''''"></custom-font>

<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container #issuerLogo {
		max-height: 72px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#main-container #networkLogo {
		max-height: 33px;
		max-width: 100%;
	}
	#main-container #pageHeader {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		height: 76px;
		padding-bottom: 4px;
		margin-top: 8px;
		margin-bottom: 0px;
		border-bottom: 1px solid #dcdcdc;
	}
	#main-container #pageHeaderLeft {
		text-align: left;
	}
	#main-container #pageHeaderRight {
		text-align: right;
	}
	#main-container #centerPieceLayout {
		padding: 5px 10px 0px;
		min-height: 200px;
	}
	div#leftMenuLayout {
		background-color: #f7f7f7;
	}
	#main-container #content #contentHeader custom-text.ng-isolate-scope {
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
		padding-left: 100px;
	}
	custom-text#headingTxt {
        font-size: 22px !important;
    }
	.btn {
		border-radius: 0px;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		font-family: BNPPSans;
	}
	.side-menu .text-left, .side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		font-size: 15px;
		font-family: BNPPSans;
		color: #403f3d;
	}
	#main-container #content {
		text-align: left;
		background-color: #f7f7f7;
	}
	#main-container #content h2 {
		font-size: 1.25em;
		line-height: 0.8;
		margin-top: 0px;
		margin-bottom: 0.25em;
	}
	#main-container #content #paragraph1 {
		font-family: BNPPSans;
		font-size: 25px;
		font-weight: bold;
		text-align: center;
		color: #403f3d;
	}
	#main-container #content contentHeaderLeft {
		font-size: 1.25em;
		margin-bottom: 0.25em;
		margin-top: 0.25em;
	}
	#main-container .paragraph {
		display: block;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .help-link {
		width: 30%;
		order: 2;
		text-align: right;
	}
	#main-container .contact {
		width: 70%;
		order: 1;
		font-weight: bold;
	}
	#main-container div#footer {
		background-image: none;
		height: 100%;
	}
	#main-container #footer {
		width: 100%;
		background-color: #f7f7f7;
		border-radius: 1em;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .extra-small {
		font-size: 12px;
	}
	#main-container #footer .small {
		font-size: 0.8em;
		font-weight: normal;
	}
	#main-container #footer .bold {
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
	#main-container #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
	#main-container #footer #copyright {
		width: 100%;
		border-top: 1px solid #6b6b6b;
		padding-top: 0.5em;
		padding-bottom: 1em;
		display: flex;
		flex-direction: row;
	}
	#main-container #footer #copyright custom-text.ng-isolate-scope {
		font-weight: normal;
		text-align: center;
		color: #403f3d;
	}
	#main-container #footer #copyright div:nth-child(1) {
		order: 1;
		text-align: left;
		width: 50%;
		padding-left: 12px;
	}
	#main-container #footer #copyright div:nth-child(2) {
		order: 2;
		text-align: right;
		width: 50%;
		padding-right: 12px;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	#main-container #footer .contact custom-text.ng-isolate-scope {
		text-align: center;
		color: #403f3d;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		font-weight: normal;
		text-align: center;
		color: white;
		background-color: #5b7f95;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton .fa-info {
		display: none;
	}
	#main-container .col-lg-4 {
		width: 100%;
	}
	#main-container .col-md-4 {
		width: 100%;
	}
	#main-container .col-sm-4 {
		width: 100%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	#main-container .halfdivsRight {
		width: 50%;
		float: right;
	}
	#main-container .halfdivsLeft {
		width: 50%;
		float: left;
	}
</style>
<div id="main-container" ng-style="style" class="ng-scope">
		<div id="headerLayout">
			<div id="pageHeader" >
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
		</div>
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
		<div id="mainLayout" class="row">
			<div id="content">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
			</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
						<span class="fa fa-angle-right"></span>

					</div>
					<div class="contact">
						<div class="line bottom-margin">
							<custom-text custom-text-key="''network_means_pageType_6''"></custom-text>

						</div>
						<div class="line small bold">

							<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
						</div>
						<div class="line small grey">
							<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
						</div>
					</div>
				</div>
				<div id="copyright" class="extra-small">
					<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
					<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
				</div>
			</div>
		</div>
	</div>' WHERE `fk_id_layout` = @layoutId;