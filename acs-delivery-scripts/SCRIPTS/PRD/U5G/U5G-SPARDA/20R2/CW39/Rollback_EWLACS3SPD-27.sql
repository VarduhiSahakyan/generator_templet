
USE `U5G_ACS_BO`;

SET @bankName = 'Spardabank';
SET @layoutId =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @bankName, ')%'));


UPDATE CustomComponent
SET value ='<style>
div#optGblPage {
    font-family: Arial, bold;
    color: #333333;
    font-size: 14px;
}

/* Start Bootstrap reset */
.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
    margin:0;
    width:auto;
    float:none;
    position:static;
}

.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
    margin:0;
    float:none;
    position:static;
}

.text-right, .text-center, .text-left {
    text-align: unset;
}
/* End Bootstrap reset */

#helpButton {
    text-align: left;
    padding-left: 52.5em;
    padding-right: 0.5em;
}
#helpButton button {
    display: inline-block;
    cursor: pointer;
    text-align: left;
    text-decoration: none;
    outline: none;
    color: #fff;
    background-color: #FF8C00;
    border: none;
    border-radius: 5px;
    box-shadow: 0 2px #999;
}
#helpButton button:hover {
    background-color: #FFA500
}
#helpButton button:active {
    background-color: #FF8C00;
    box-shadow: 0 3px #666;
    transform: translateY(2px);
}
#helpButton button span:before {
    content:'''';
}
#helpButton button custom-text {
    
}
#cancelButton {
    /*flex: 1 1 50%;
    text-align:right;
    padding-right:0.5em;*/
}
#cancelButton button {
    display: inline-block;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    outline: none;
    color: #fff;
    background-color: #FF8C00;
    border: none;
    border-radius: 5px;
    box-shadow: 0 2px #999;
}

#cancelButton button:hover {
    background-color: #FFA500
}

#cancelButton button:active {
    background-color: #FF8C00;
    box-shadow: 0 3px #666;
    transform: translateY(2px);
}

/* reset for default styles */
#valButton button.btn.disabled {
    opacity:1;
}

#valButton {
    flex: 1 1 50%;
    padding-left:0.5em;
}

#valButton button.btn[disabled] {
    opacity:1;
}

#valButton button div {
    display:inline;
}

#valButton button {
    display: inline-block;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    outline: none;
    color: #fff;
    background-color: #FF8C00;
    border: none;
    border-radius: 5px;
    box-shadow: 0 2px #999;
}

#valButton button:hover {
    background-color: #FFA500
}

#valButton button:active {
    background-color: #FF8C00;
    box-shadow: 0 3px #666;
    transform: translateY(2px);
}

#i18n-container {
    width: 100%;
    clear: both;
}

#issuerLogo {
    max-height: 64px;
    max-width: 100%;}

#networkLogo {
    max-height: 64px;
    max-width: 100%;
}

#pageHeader {
    width: 100%;
    height: 96px;
    border-bottom: 1px solid #DCDCDC;
    display: flex;
    justify-content: space-between;
}

#pageHeaderLeft {

    padding-left: 0.5em;
    padding-top: 0.5em;
}

#pageHeaderRight {
    padding-right: 0.5em;
    padding-top: 0.5em;
}

.paragraph {
    text-align: left;
    margin-top: -2px;
    margin-bottom: 5px;
}

.topColumn {
    padding:0.5em;
}

.bottomColumn {
    display:block;
    text-align: left;
    padding-left: 1em;
}

.contentRow {
    width: 100%;
    padding: 0;
    clear: both;
    text-align: center;
}

side-menu .menu-elements div div div {
    display:flex;
    flex-direction:row;
    width:max-context;
}

side-menu .menu-elements div div div span {
    flex: 1 1 50%;
    text-align:right;
}

side-menu .menu-elements div div div span + span {
    flex: 1 1 50%;
    text-align:left;
}

.tanContainer {
    width:100%;
    display:flex;
    justify-content:space-evenly;
	margin-top: -20px;
}

#tanLabel {
    text-align:right;
    flex: 1 1 50%;
}

#otpForm {
    flex: 1 1 50%;
    text-align:left;
    padding-left: 5px;
}

#phNumber {
	margin-left: 7px;
}

#footerDiv {
    height: 40px;
    background-color: #F7F8F8;
    width:100%;
    margin-top:1em;
    padding-top:0.5em;
    padding-bottom:0.5em;
    display:flex;
}
div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > label:nth-child(1) > custom-text:nth-child(1) > span:nth-child(1) {
	display:none;
}
div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(2) {
	display:none;
}
#sideLayout {
	margin-left: 677px;
	margin-top: -30px;
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
    <div id="displayLayout" class="row">
		<div id="grey-banner"></div>
	</div>
	<message-banner  close-button="''network_means_pageType_174''"
                    back-button="''network_means_pageType_175''"></message-banner>

	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
        <div x-ms-format-detection="none" class="bottomColumn">
	<side-menu></side-menu>
	</div>
        <div class="tanContainer">
				<div id = "tanLabel">
				   <div>
					<custom-text custom-text-key="''network_means_pageType_104''"></custom-text>
				   </div>
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<div id = "otpForm" >
				    <div id = "phNumber">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
					</div>
					<otp-form></otp-form>
				</div>
		</div>
	</div>
    <div id="footerDiv">
				<help help-label="''network_means_pageType_41''" id="helpButton"></help>
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			    <val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
	</div>
</div>'
WHERE fk_id_layout =@layoutId;


SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @currentPageType = 'OTP_FORM_PAGE';
SET @networkVISA = 'VISA';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_','SPB_sharedBIN','_SMS'));

UPDATE CustomItem SET VALUE = '<b>Mobilfunknummer :</b>' WHERE pageTypes = 'ALL' AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 104 and DTYPE='T';

delete from CustomItem where fk_id_customItemSet in( @customItemSetId) and ordinal =4 and pageTypes=@currentPageType;

SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_','SPB_sharedBIN','_SMS_CHOICE'));


delete from CustomItem where fk_id_customItemSet in( @customItemSetId) and ordinal =4 and pageTypes=@currentPageType;

UPDATE CustomItem SET VALUE = '<b>Mobilfunknummer :</b>' WHERE pageTypes = 'ALL' AND fk_id_customItemSet in (@customItemSetId) AND ordinal = 104 and DTYPE='T';

