USE `U5G_ACS_BO`;

SET @bankName = 'Spardabank';
SET @layoutId =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Password OTP Form Page (', @bankName, ')%'));


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
    opacity:0.65;
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
    text-align: center;
    text-decoration: none;
    outline: none;
    color: #fff;
    background-color: #FF8C00;
    border: none;
    border-radius: 5px;
    box-shadow: 0 2px #999;
}

	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		white-space: nowrap;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
	}
	#validateButton button:disabled {
		font: 300 16px/20px Arial,bold;
		color: #858585;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #858585;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
		margin-bottom: 5px;
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
    background-color: #F7F8F8;
    width:100%;
    margin-top:1em;
    padding-top:0.5em;
    padding-bottom:0.5em;
    display:flex;
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

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
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
				<div id = "kundennummerLabel">
                   <custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
                </div>
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<div id = "otpForm" >
					<div id = "phNumber">
						<custom-text custom-text-key="''network_means_pageType_5''"></custom-text>
					</div>
					<pwd-form></pwd-form>
				</div>
		</div>
	</div>
	<div  id="footerDiv">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
	</div>
</div>'
WHERE fk_id_layout =@layoutId;


SET @layoutId =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Means Page (', @bankName, ')%'));


UPDATE CustomComponent
SET value ='<style>
div#optGblPage {
    font-family: Arial, bold;
    color: #333333;
    font-size: 14px;
}
	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;	
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button {
		margin-right: 16px;	
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}	
	#optGblPage #selection-group switch-means-button:nth-child(2) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)); 
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#switch-means-mobile_app_ext-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-otp_sms_ext_message-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-chip_tan-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;} 
	#optGblPage #selection-group switch-means-button:nth-child(2) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	
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

.text-center {
    text-align: justify;
}

.text-right,.text-left {
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
/*
    flex: 1 1 50%;
    text-align:right;
    padding-right:0.5em;
*/
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
/*
    flex: 1 1 50%;
    padding-left:0.5em;
*/
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

.meansSelect {
    display:flex;
    flex-direction:row;
}

.meansSelectLabel {
    flex:1 1 50%;
    text-align:right;
    padding-right:5px;
}

.meansSelectValue {
    flex:1 1 50%;
    text-align:left;
    padding-left:5px;
}

#footerDiv button {
    display: block;
    margin-left:0.5em;
    margin-right:0.5em;
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

#footerDiv {
    height: 40px;
    background-color: #F7F8F8;
    width:100%;
    margin-top:1em;
    padding-top:0.5em;
    padding-bottom:0.5em;
    display:flex;
    justify-content:center;
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

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

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
        <div class="meansSelect">
				<div class = "meansSelectLabel">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
                <div class = "meansSelectValue">
				<div id="meanchoice">
					<means-select means-choices="meansChoices"></means-select>
				</div>
                </div>

		</div>
	</div>
    <div  id="footerDiv">
            <help help-label="''network_means_pageType_41''" id="helpButton"></help>
		   	<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
	</div>
</div>'
WHERE fk_id_layout =@layoutId;