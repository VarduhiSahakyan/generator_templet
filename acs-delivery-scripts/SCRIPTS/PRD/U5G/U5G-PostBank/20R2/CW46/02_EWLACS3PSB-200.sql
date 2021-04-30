

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` = 'Info Refusal Page (Postbank FBK)');

UPDATE CustomComponent SET value = '
<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
		text-align:center;
	}
	div#message-container.success {
		background-color:#DB1818 !important;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
	#issuerLogo {
		max-height: 64px;
		max-width:100%;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-bottom: 10px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #DCDCDC;
	}
	#pageHeaderLeft {
		width: 20%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 80%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		font-size:18px;
	}
	.leftColumn {
		width:40%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:38%;
		display:table-cell;
		text-align:left;
		padding: 0px 10px 20px;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
		text-align: right;
	}
	side-menu div.text-center {
		text-align:left;
	}
	div.side-menu div.menu-title::before {
		display:inline;
	}
	div.side-menu div.menu-title::after {
		display:inline;
	}
	div.side-menu div.menu-title {
		max-width: 100%;
		text-align: center;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

	@media all and (max-width: 1610px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left; }
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.rightColumn { display:table-cell; float:none; width:100%; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height:64px; max-width:140%; padding-top: 5px;}
		#networkLogo {max-height:72px; max-width:100%; }
		div#optGblPage { font-size : 14px; }
		.paragraph { font-size : 14px; text-align: center;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		div#optGblPage { font-size : 14px;}
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:200%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px; }
		.rightColumn { margin-left:0px; margin-top: 110px; display:block; float:none; width:100%; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
	}
	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div#optGblPage { font-size : 14px;}
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 14px; text-align: center;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 52px;  max-width:250%; padding-top: 10px;}
		.leftColumn { display:block; float:none; width:100%; margin-top: -40px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 110px; text-align: center;}
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: right;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		h1 { font-size:14px; }
		div#optGblPage { font-size : 12px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 12px; text-align: center;}
		#issuerLogo { max-height : 30px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 42px;  max-width:250%; padding-top: 10px;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 100px; text-align: center;}
		#pageHeader {height: 60px;}
	}
	@media all and (max-width: 309px) {
		h1 { font-size:12px; }
		div#optGblPage { font-size : 10px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 10px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 90px; text-align: center;}
		div#otp-fields {display:inherit;}
	}
	@media all and (max-width: 250px) {
		h1 { font-size:10px; }
		div#optGblPage { font-size : 8px; }
		div.side-menu div.menu-title { display: flow-root; }
		.paragraph { font-size : 8px; text-align: center;}
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 70px; text-align: center;}
		div#otp-fields {display:inherit;}
	}
	div#message-container.info {
		background-color:#DB1818 !important;
		font-family: Arial, standard;
		font-size:12px;
		color: #EAEAEA;
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderCenter" ng-style="style" class="ng-scope"></div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner display-type="''1''" heading-attr="''network_means_pageType_22''" message-attr="''network_means_pageType_23''" close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''" show=true ></message-banner>

	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''''"></side-menu>
		</div>
    </div>
    <div class="rightColumn">
        <alternative-display attribute="''currentProfileName''" value="''18502_PB_MISSING_AUTHENT_MEANS_REFUSAL''"
         enabled="''MISSING_AUTHENT_MEANS''"
         default-fallback="''defaultContent''">
         </alternative-display>

        <alternative-display attribute="''currentProfileName''" value="''18502_PB_MISSING_PWD_AUTHENT_MEANS_REFUSAL''"
         enabled="''MISSING_PWD_AUTHENT_MEANS''"
         default-fallback="''defaultContent''">
         </alternative-display>
        <div class="MISSING_AUTHENT_MEANS" style="display: none;" >
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
        <div class="MISSING_PWD_AUTHENT_MEANS" style="display: none;">
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_pageType_201''" id="paragraph1"></custom-text>
            </div>
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_pageType_202''" id="paragraph2"></custom-text>
            </div>
            <div class="paragraph">
                <custom-text custom-text-key="''network_means_pageType_203''" id="paragraph3"></custom-text>
            </div>
        </div>

        <div class="defaultContent" ng-style="style" class="ng-scope" style="display: none;"></div>
    </div>

	<div id="footer"></div>
</div>



' WHERE `fk_id_layout` = @layoutId;

SET @cisID = (SELECT `id` FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_3_REFUSAL');

UPDATE `CustomItem` SET `ordinal` = 201,
                        `name` = 'VISA_UNDEFINED_REFUSAL_PAGE_201'
                            WHERE `ordinal` = 1 AND
                                  `fk_id_customItemSet` = @cisID AND
                                  `DTYPE` = 'T';
UPDATE `CustomItem` SET `ordinal` = 202,
                        `name` = 'VISA_UNDEFINED_REFUSAL_PAGE_202'
                            WHERE `ordinal` = 2 AND
                                  `fk_id_customItemSet` = @cisID AND
                                  `DTYPE` = 'T';
UPDATE `CustomItem` SET `ordinal` = 203,
                        `name` = 'VISA_UNDEFINED_REFUSAL_PAGE_203'
                            WHERE `ordinal` = 3 AND
                                  `fk_id_customItemSet` = @cisID AND
                                  `DTYPE` = 'T';


SET @BankUB = '18502_PB';
SET @authMeanPassword = (SELECT `id` FROM `AuthentMeans` WHERE `name` = 'PASSWORD');
SET @mpsIdOLD = (SELECT  `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanPassword
                                                            AND `meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE'
                                                            AND `reversed`=TRUE);
SET @mpsIdNEW = (SELECT  `id` FROM `MeansProcessStatuses` WHERE `fk_id_authentMean`=@authMeanPassword
                                                            AND `meansProcessStatusType`='HUB_AUTHENTICATION_MEAN_AVAILABLE'
                                                            AND `reversed`=FALSE);
SET @ruleConditionId = (SELECT `id` FROM `RuleCondition` WHERE `name`= CONCAT('C1_P_',@BankUB,'_01_MISSING_AUTHENTMEAN'));

UPDATE `Condition_MeansProcessStatuses`  SET `id_meansProcessStatuses` = @mpsIdNEW WHERE `id_condition` = @ruleConditionId AND
                                                                                         `id_meansProcessStatuses` = @mpsIdOLD;