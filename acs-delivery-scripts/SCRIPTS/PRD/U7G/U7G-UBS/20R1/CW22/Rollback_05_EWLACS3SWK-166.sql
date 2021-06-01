
USE U7G_ACS_BO;
SET @BankB = 'UBS';

set @createdBy = 'A757435';
SET @BankUB = 'UBS';
SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @customItemSetMobile = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @currentPageType = 'POLLING_PAGE';
SET @ordinal = 1;

UPDATE `CustomItem` SET `value` = ''
WHERE `fk_id_customItemSet` = @customItemSetMobile
  AND `ordinal` = @ordinal AND `locale` = 'de' AND `pageTypes` = @currentPageType;

UPDATE `CustomItem` SET `value` = ''
WHERE `fk_id_customItemSet` = @customItemSetMobile
  AND `ordinal` = @ordinal AND `locale` = 'en' AND `pageTypes` = @currentPageType;

UPDATE `CustomItem` SET `value` = ''
WHERE `fk_id_customItemSet` = @customItemSetMobile
  AND `ordinal` = @ordinal AND `locale` = 'fr' AND `pageTypes` = @currentPageType;

UPDATE `CustomItem` SET `value` = ''
WHERE `fk_id_customItemSet` = @customItemSetMobile
  AND `ordinal` = @ordinal AND `locale` = 'it' AND `pageTypes` = @currentPageType;


SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVID = NULL;


DELETE FROM `CustomItem` WHERE `ordinal` = 2 AND `pageTypes` = @currentPageType AND `fk_id_customItemSet` = @customItemSetMobile;
DELETE FROM `CustomItem` WHERE `ordinal` = 40 AND `pageTypes` = @currentPageType AND `fk_id_customItemSet` = @customItemSetMobile;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		padding-right: 16px;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
		margin-left: 3em;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		margin-top: 10px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: Frutiger55Roman, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 35%;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	@media all and (max-width: 600px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 8%; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link { width: 69%;text-align: center;}
	}
	@media all and (max-width: 500px) and (min-width: 391px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 16%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 59%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 30%;}
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 30%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container #content { text-align: c; margin-left: 0em; }
		#main-container #contentBottom { padding-left: 5%; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 29%;text-align: center;}
	}
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;
