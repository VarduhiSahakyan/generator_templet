USE U7G_ACS_BO;

set @BankUB = 'UBS';
set @createdBy = 'A757435';

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP_EXT'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
/*EWLACS3SWK-215*/
/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
UPDATE `CustomItem` SET `value` = 'Zahlung abgelehnt' WHERE `locale` = 'de'
                                                        AND `pageTypes` = @currentPageType
                                                        AND `ordinal` = 16
                                                        AND `fk_id_customItemSet` = @customItemSetMobileApp;
UPDATE `CustomItem` SET `value` = '' WHERE `locale` = 'de'
                                        AND `pageTypes` = @currentPageType
                                        AND `ordinal` = 17
                                        AND `fk_id_customItemSet` = @customItemSetMobileApp;

/********* EN_START *********/
UPDATE `CustomItem` SET `value` = 'Payment declined' WHERE `locale` = 'en'
                                                        AND `pageTypes` = @currentPageType
                                                        AND `ordinal` = 16
                                                        AND `fk_id_customItemSet` = @customItemSetMobileApp;
UPDATE `CustomItem` SET `value` = '' WHERE `locale` = 'en'
                                       AND `pageTypes` = @currentPageType
                                       AND `ordinal` = 17
                                       AND `fk_id_customItemSet` = @customItemSetMobileApp;
/********* EN_END *********/

/********* FR_START *********/
UPDATE `CustomItem` SET `value` = 'Paiement refusé' WHERE `locale` = 'fr'
                                                       AND `pageTypes` = @currentPageType
                                                       AND `ordinal` = 16
                                                       AND `fk_id_customItemSet` = @customItemSetMobileApp;
UPDATE `CustomItem` SET `value` = '' WHERE `locale` = 'fr'
                                       AND `pageTypes` = @currentPageType
                                       AND `ordinal` = 17
                                       AND `fk_id_customItemSet` = @customItemSetMobileApp;

/********* FR_END *********/

/********* IT_START *********/
UPDATE `CustomItem` SET `value` = 'Pagamento respinto' WHERE `locale` = 'it'
                                                      AND `pageTypes` = @currentPageType
                                                      AND `ordinal` = 16
                                                      AND `fk_id_customItemSet` = @customItemSetMobileApp;
UPDATE `CustomItem` SET `value` = '' WHERE `locale` = 'it'
                                       AND `pageTypes` = @currentPageType
                                       AND `ordinal` = 17
                                       AND `fk_id_customItemSet` = @customItemSetMobileApp;

/********* IT_END *********/


/*EWLITAGEPG-933*/

/*removes 'OK' button text from Failure pages */
DELETE FROM `CustomItem` WHERE `ordinal` = 40 AND `pageTypes` = @currentPageType AND `fk_id_customItemSet` = @customItemSetMobileApp;
DELETE FROM `CustomItem` WHERE `ordinal` = 40 AND `pageTypes` = @currentPageType AND `fk_id_customItemSet` = @customItemSetSMS;

/*removes 'OK' button  from Failure Page */
SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankUB, ')%') );
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
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt;
		font-size: 24px;
		color: #1c1c1c;
		line-height: 28px;
		padding-bottom: 24px;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
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
	#main-container .menu-elements {
		padding-right: 10%;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	#main-container #contentBottom {
		padding-left: 32%;
	}
	#main-container #link-text {
		font-size: 12px;
		display: inline-block;
		margin-top: 5px;
		position: relative;
		text-align: left;
		width: 218px;
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
		#main-container #contentBottom { padding-left: 3%; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
		#main-container .help-link { width: 69%;text-align: center;}
	}
	@media all and (max-width: 500px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {padding-right: 10%;}
		#main-container #contentBottom { padding-left: 10%; }
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 59%;text-align: center;}
	}
	@media all and (max-width: 390px) {
		#main-container #content { text-align: center; margin-left: 0em; }
		#main-container .menu-elements {padding-right: 0%;}
		#main-container #contentBottom { padding-left: 30%;}
		#main-container #link-text { text-align: center; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 33%;text-align: center;}
	}
	@media all and (max-width: 250px) {
		#main-container {padding-left: 16px; }
        #main-container #pageHeader {padding-left: 0px; }
        #main-container #pageHeaderLeft {padding-left: 0px; }
        #main-container #pageHeaderRight {padding-right: 0px; }
        #main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
        #main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements {margin-right: 0px;}
        .break-word.ng-scope {width: 100%; display: inline-table;}
        #main-container .col-sm-5 {width: auto; display: inline-table;}
        #main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container #contentBottom { padding-left: 0%; }
		#main-container #link-text { text-align: left; width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link { width: 29%;text-align: left;}
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
		<div id="contentHeaderLeft">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</h3>
		</div>
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="link-text">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
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





