USE U5G_ACS_BO;
SET @value = '<style>
div#optGblPage {
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	font-size:14px;
}
#helpButton button {
	font: 300 16px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
	display:inline-block;
	white-space: nowrap;
	text-align: center;
	height: 40px;
	background: #fff;
	color: #323232;
	border: 1px solid rgba(0,0,0,.25);
	min-width: 15rem;
	border-radius: 4px;
	font-size: 16px;
	padding-left: 0px !important;
}
#helpButton button:hover {
	border-color: rgba(255,106,16,.75);
}
#helpButton button:active {
	background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
	border-color: rgba(0,0,0,.25) rgba(0,0,0,.2) rgba(0,0,0,.15);
	box-shadow: none;
	outline: 0px;
}
#helpButton button custom-text {
	vertical-align:8px;
}
#footer #helpButton button span:before {
	content:'''';
}
#footer #cancelButton button span:before {
	content:'''';
}
#footer #helpButton button span.fa {
	background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
	width:24px;
	height:26px;
	background-position-y: -1px;
	background-position-x: -2px;
	background-size: 115%;
	display:inline-block;
}
#helpCloseButton button {
	padding-left: 0px !important;
}
#helpCloseButton button span.fa {
	background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
	width:24px;
	height:26px;
	background-position-x: -2px;
	background-size: 115%;
	display:inline-block;
}
#helpCloseButton button span + span {
	margin-top: 1px;
}
#footer {
	padding-top: 12px;
	padding-bottom:12px;
	clear:both;
	width:100%;
	background-color: #CED8F6;
	text-align:center;
	margin-top: 15px;
	margin-bottom : 15px;
}
#i18n-container {
	width:100%;
	clear:both;
}
#i18n-inner {
	display: block;
	margin-left: auto;
	margin-right: auto;
	clear:both;
}
#i18n > button {
	background: transparent;
	color: #557a8e;
	border: none;
	box-shadow: none;
}
#i18n > button.active {
	background: #06446c !important;
	color:#FFFFFF!important;
	border-radius: 5px !important;
}
#issuerLogo {
	max-height: 64px;
	max-width:100%;
	padding-left: 0px;
	padding-right: 0px;
}
#networkLogo {
    max-height: 70px;
    max-width: 100%;
    margin-right: 16px;
    margin-top: 13px;
}
#pageHeader {
	width: 100%;
	height: 96px;
	border-bottom: 1px solid #DCDCDC;
}
#pageHeaderLeft {
	width: 20%;
	float: left;
	padding-left: 16px;
	padding-top: 16px;
}
#pageHeaderRight {
	float: right;
	text-align: right;
}
.paragraph {
	margin: 0px 0px 10px;
	text-align: justify;
}
.leftColumn {
	width:40%;
	display:block;
	float:left;
	padding:1em;
}
.rightColumn {
	width:60%;
	margin-left:40%;
	display:block;
	text-align:left;
	padding:20px 10px;
}
.contentRow {
	width:100%;
	padding:1em;
	padding:0px;
	padding-top:1em;
	clear:both;
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
	display:inline;
	padding-left:50.9%;
	text-align:left;
	font-size: 18px;
}
div.side-menu div.menu-elements {
	margin-top:5px;
}
@media all and (max-width: 1199px) and (min-width: 701px) {
	h1 { font-size:24px; }
	#issuerLogo {max-height : 64px;  max-width:140%; padding-top: 5px;}
    #networkLogo {max-height: 62px; margin-top: 17px;}
	div#optGblPage {     font-size : 13px; }
	.leftColumn { display:block; float:none; width:100%; }
	.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 53px;}
	.paragraph { text-align:center; }
	div.side-menu div.menu-title { padding-left:0px; text-align:center; }
	side-menu div.text-center { text-align:center; }
}
@media all and (max-width: 700px) and (min-width: 481px) {
	h1 { font-size:18px; }
	div#optGblPage { font-size : 12px;}
	#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
    #networkLogo {max-height : 34px; margin-top: 31px;}
	.leftColumn { display:block; float:none; width:100%; }
	.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 53px;}
	.paragraph { text-align:center; }
	div.side-menu div.menu-title { font-size : 16px; padding-left:0px; text-align:center; }
	side-menu div.text-center { text-align:center; }
}
@media all and (max-width: 480px) {
	h1 { font-size:16px; }
	div#optGblPage {   font-size : 11px;}
	#issuerLogo { max-height : 54px;  max-width:200%; padding-top: 10px;}
    #networkLogo { max-height : 34px; margin-top: 31px; }
	.leftColumn { display:block; float:none; width:100%; }
	.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 53px;}
	.paragraph { text-align:center; }
	div.side-menu div.menu-title { font-size : 14px; padding-left:0px; text-align:center; }
	side-menu div.text-center { text-align:center; }
	#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
	#pageHeader { height: 70px; }
}
@media all and (max-width: 347px) {
	h1 { font-size:14px; }
	div#optGblPage { font-size : 10px; }
	#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 4px;}
	div.side-menu div.menu-title { font-size : 13px; padding-left:0px; text-align:center; }
	.paragraph { font-size : 12px; text-align:center; }
	.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 53px;}
	#pageHeader {height: 60px;}
    #networkLogo {max-height: 22px; margin-top: 19px;}
}
@media all and (max-width: 309px) {
	h1 { font-size:12px; }
	div#optGblPage { font-size : 8px; }
	div.side-menu div.menu-title { font-size : 11px; padding-left:0px; text-align:center; }
	.paragraph { font-size : 10px; text-align:center; }
	.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 44px;}
}
@media all and (max-width: 250px) {
	h1 { font-size:10px; }
	div#optGblPage { font-size : 8px; }
	div.side-menu div.menu-title { font-size : 11px; padding-left:0px; text-align:center; }
	.paragraph { font-size : 8px; text-align:center; }
	.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 44px;}
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
    <div id="i18n-container" class="text-center">
        <div id="i18n-inner">
            <i18n></i18n>
        </div>
    </div>
    <div id="displayLayout" class="row">
        <div id="green-banner"></div>
    </div>
    <style>
		div#green-banner {
			height: 50px !important;
			background-color: #CED8F6;
			border-bottom: 5px solid #CED8F6;
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
</div>';
SET @BankB = 'EWB';
SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (',@BankB, ')%') );
UPDATE CustomComponent SET value = @value WHERE fk_id_layout = @layoutId;