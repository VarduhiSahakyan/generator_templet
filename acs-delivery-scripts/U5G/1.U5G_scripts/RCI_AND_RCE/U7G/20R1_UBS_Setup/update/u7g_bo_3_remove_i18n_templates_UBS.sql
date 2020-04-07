USE U7G_ACS_BO;

SET @BankB = 'UBS';

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style> 
        #main-container {
                font-family: FrutigerforUBSWeb;
                max-width: 600px;
                max-height: 600px;
                margin-left: auto;
                margin-right: auto;
        }
        #main-container   #pageHeader {
                width: 100%;
                height: 74px;
                border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
                width: 20%;
                float: left;
                padding-left: 16px;
                padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
                width: 25%;
                float: right;
                text-align: right;
                padding-top: 16px;
		}
		#main-container  #issuerLogo {
                max-height: 64px;
                max-width:100%;
                padding-left: 0px;
                padding-right: 0px;
		}
		#main-container   #networkLogo {
                max-height: 100%;
                max-width: 100%;
		}
		#main-container   #content {
                text-align:left;
                margin-left: 3em;
		}
        div#contentHeaderLeft h3 {
                font-family: FrutigerforUBSWeb-Lt;
                font-size: 24px;
                color: #1C1C1C;
                line-height: 28px;
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
                color: #1C1C1C;
                letter-spacing: 0;
                line-height: 24px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
                font-family: Frutiger55Roman;
                font-weight: normal;
                font-size: 16px;
                color: #646464;
                letter-spacing: 0;
                line-height: 24px;
        }
        #main-container .menu-title {
                display:none;
        }
        #main-container .menu-elements {
                margin-right:9%;
        }
        #main-container #contentBottom {
                padding-left: 32%;
                padding-right: 0px
        }
		#main-container   .mtan-input {
			    padding-bottom:10px;
		}

		#main-container   .input-label {
                flex-direction: row;
                align-items: center;
		}
        #main-container   .mtan-label {
                text-align:left;
                flex: 0 0 180px;
                font-family: Frutiger55Roman;
                font-size: 12px;
                color: #646464;
                letter-spacing: 0;
                line-height: 16px
		}
		#main-container   .otp-field input {
                font-size: 16px;
                color: #1C1C1C;
                background: #FFFFFF;
                margin-left:0px;
                border: 1px solid #AAAAAA;
                width: 196px;
		}
		#main-container   .otp-field input:focus {
			    outline:none;
		}
        #main-container   message-banner {
                display: inline-block;
                margin-top: 5px;
                position: relative;
                width: 196px;
		}
        #main-container #resend button {
                border-style: none;
                padding:0px
        }
        #main-container #resend button span{
                color:#007099;
        }
		#main-container   .resendTan {
                font-size: 14px;
                line-height: 20px;
                display:block;
                margin-top:10px;
                margin-bottom: 25px;
                color:#007099;
		}
		#main-container   .resendTan a {
			    color:#007099;
		}
        #main-container   .row .left {
                float:left;
                width:180px;
                text-align:right;
		}
		#main-container   .row .left span {
			    margin-right:0.5em
		}
		#main-container   .row .submit-btn {
                text-align:left;
                float:left;
		}
		#main-container   #validateButton button{
                font-size: 14px;
                height: 38px;
                border-radius: 2px;
                background: #6A7D39;
                opacity: 1;
                box-shadow: none;
                border: 0px;
                color: #FFFFFF;
        }
        #main-container   #cancelButton button{
                font-size: 14px;
                height: 38px;
                border-radius: 2px;
                border: 1px solid #919191;
                box-shadow: none;
                background: #FFFFFF;
        }
        #main-container   #validateButton span.fa-check-square{
                display:none;
        }
        #main-container   #cancelButton span.fa-ban{
                display:none;
        }
        #main-container   #helpButton span.fa-info{
                display:none;
        }
        #main-container #validateButton button:disabled {
                font-size: 14px;
                height: 38px;
                border-radius: 2px;
                background: #6A7D39;
                box-shadow: none;
                border: 0px;
                color: #FFFFFF;
        }
		#main-container   div#footer {
                background-image:none;
                height:100%;
		}
		#main-container   #footer {
                width:100%;
                clear:both;
                margin-top:3em;
		}
		#main-container   #footer:after {
                content: "";
                height:100%;
                display: table;
                clear: both;
                padding-bottom: 0.5em;
		}
        #main-container  #footer .help-area {
                display: flex;
                flex-direction: row;
		}
        #main-container  .help-link {
                font-size: 14px;
                line-height: 20px;
                width: 50%;
                order: 2;
                text-align: left;
                color:#007099;
		}
        #main-container #helpButton  button {
                border-style: none;
                padding:0px
        }
        #main-container #helpButton  button span{
                color:#007099;
                background-color: #f7f7f7;
        }
		#main-container   .col-lg-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-md-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-sm-4 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-5 {
                width: 34%;
        }
		#main-container   .col-sm-6 {
			    width: 65%;
		}
		#main-container   .col-xs-12 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
                margin-left: 0%;
        }
        @media all and (max-width: 600px) {
                #main-container #content { text-align: left; margin-left: 3em; }
                span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
        }
        @media all and (max-width: 500px) {
                #main-container #content { text-align: left; margin-left: 2em; }
                #main-container .menu-elements {margin-right: 9%;}
                #main-container .otp-field input { width: 196px; }
                #main-container message-banner { width: 196px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
        }

        @media all and (max-width: 390px) {
                #main-container #content { text-align: left; margin-left: 1em; }
                #main-container .menu-elements {margin-right: 0%;}
                #main-container #contentBottom { padding-left: 32%; padding-right: 0px; }
                #main-container .otp-field input { width: 180px; }
                #main-container message-banner { width: 180px; }
                #main-container .row .submit-btn { text-align: left; float: left; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link {width: 50%;text-align: left;}
        }

        @media all and (max-width: 250px) {
                #main-container #content { text-align: center; margin-left: 0em; }
                #main-container .menu-elements {margin-right: 0px;}
                #main-container #contentBottom { padding-left: 0%; }
                #main-container .otp-field input { width: 196px; }
                #main-container message-banner { width: 196px; }
                #main-container .row .submit-btn { text-align: center; float: none; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link {width: 100%;text-align: center;}
        }

</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div id="contentHeaderLeft">
					<h3><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h3>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div class="mtan-input">
                        <div class="input-label">
                            <div class="otp-field">
                                <otp-form></otp-form>
                            </div>
                        </div>
                        <message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>
                    </div>

                    <div class="resendTan">
                          <span class="fa fa-angle-right"></span>
                          <re-send-otp id="resend" rso-Label="''network_means_pageType_19''"></re-send-otp>
                    </div>

                    <div id="form-controls">
                        <div class="row">
                            <div class="submit-btn">
                                <val-button id="validateButton" val-label="''network_means_pageType_42''"></val-button>
                                <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
                            </div>
                        </div>
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
	</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
        #main-container {
                font-family: FrutigerforUBSWeb;
                max-width: 600px;
                max-height: 600px;
                margin-left: auto;
                margin-right: auto;
        }
        #main-container   #pageHeader {
                width: 100%;
                height: 74px;
                border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
                width: 20%;
                float: left;
                padding-left: 16px;
                padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
                width: 25%;
                float: right;
                text-align: right;
                padding-top: 16px;
		}
		#main-container  #issuerLogo {
                max-height: 64px;
                max-width:100%;
                padding-left: 0px;
                padding-right: 0px;
		}
		#main-container   #networkLogo {
                max-height: 100%;
                max-width: 100%;
		}
		#main-container  #content {
                text-align:left;
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
                color: #1C1C1C;
                letter-spacing: 0;
                line-height: 24px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
                font-family: Frutiger55Roman;
                font-weight: normal;
                font-size: 16px;
                color: #646464;
                letter-spacing: 0;
                line-height: 24px;
        }
        #main-container .menu-title {
                display:none;
        }
        #main-container #contentBottom {
                padding-left: 35%;
        }
        #main-container   message-banner {
                display: inline-block;
                margin-top: 5px;
                position: relative;
                width: 196px;
		}
		#main-container   div#footer {
			    background-image:none;
			    height:100%;
		}
		#main-container   #footer {
                width:100%;
                clear:both;
                margin-top:2em;
		}
		#main-container   #footer:after {
                content: "";
                height:100%;
                display: table;
                clear: both;
                padding-bottom: 0.5em;
		}
		#main-container  #footer .help-area {
                display: flex;
                flex-direction: row;
		}
        #main-container  .help-link {
                font-size: 14px;
                line-height: 20px;
                width: 50%;
                order: 2;
                text-align: left;
                color:#007099;
		}
        #main-container #helpButton  button span{
                color:#007099;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
                border-style: none;
                padding:0px
        }
        #main-container   #helpButton span.fa-info{
                display:none;
        }
		#main-container   .col-lg-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-md-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-sm-4 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-5 {
                width: 34%;
        }
		#main-container   .col-sm-6 {
			    width: 65%;
		}
		#main-container   .col-xs-12 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
                margin-left: 0%;
        }
		#main-container   .row .left {
                float:left;
                width:180px;
                text-align:right;
		}
		#main-container   .row .left span {
			    margin-right:0.5em
		}
        @media all and (max-width: 600px) {
                #main-container #content { text-align: left; margin-left: 3em; }
                span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
        }
        @media all and (max-width: 500px) and (min-width: 391px) {
                #main-container #content { text-align: left; margin-left: 2em; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
        }

        @media all and (max-width: 390px) {
                #main-container #content { text-align: left; margin-left: 1em; }
                #main-container #contentBottom { padding-left: 35%; padding-right: 0px; }
                #main-container message-banner { width: 180px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link {width: 50%;text-align: left;}
        }

        @media all and (max-width: 250px) {
                #main-container #content { text-align: center; margin-left: 0em; }
                #main-container #contentBottom { padding-left: 0%; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link { width: 100%;text-align: center;}
        }
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div>
                        <message-banner></message-banner>
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
</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
        #main-container {
                font-family: FrutigerforUBSWeb;
                max-width: 600px;
                max-height: 600px;
                margin-left: auto;
                margin-right: auto;
        }
        #main-container   #pageHeader {
                width: 100%;
                height: 74px;
                border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
                width: 20%;
                float: left;
                padding-left: 16px;
                padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
                width: 25%;
                float: right;
                text-align: right;
                padding-top: 16px;
		}
		#main-container  #issuerLogo {
                max-height: 64px;
                max-width:100%;
                padding-left: 0px;
                padding-right: 0px;
		}
		#main-container   #networkLogo {
                max-height: 100%;
                max-width: 100%;
		}
		#main-container  #content {
                text-align:left;
                margin-left: 3em;
		}
        div#contentHeaderLeft h3 {
                font-family: FrutigerforUBSWeb-Lt;
                font-size: 24px;
                color: #1C1C1C;
                line-height: 28px;
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
                color: #1C1C1C;
                letter-spacing: 0;
                line-height: 24px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
                font-family: Frutiger55Roman;
                font-weight: normal;
                font-size: 16px;
                color: #646464;
                letter-spacing: 0;
                line-height: 24px;
        }
        #main-container .menu-title {
                display:none;
        }
        #main-container .menu-elements {
                padding-right:10%;
        }
        #main-container #contentBottom {
                padding-left: 32%;
        }
        #main-container   message-banner {
                display: inline-block;
                margin-top: 5px;
                position: relative;
                width: 196px;
		}
        #main-container #link-text {
               font-size: 12px;
               display: inline-block;
               margin-top: 5px;
               position: relative;
               text-align: left;
               width: 196px;
        }
		#main-container   div#footer {
			    background-image:none;
			    height:100%;
		}
		#main-container   #footer {
                width:100%;
                clear:both;
                margin-top:2em;
		}
		#main-container   #footer:after {
                content: "";
                height:100%;
                display: table;
                clear: both;
                padding-bottom: 0.5em;
		}
		#main-container  #footer .help-area {
                display: flex;
                flex-direction: row;
		}
        #main-container  .help-link {
                font-size: 14px;
                line-height: 20px;
                width: 50%;
                order: 2;
                text-align: left;
                color:#007099;
		}
        #main-container #helpButton  button span{
                color:#007099;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
                border-style: none;
                padding:0px
        }
        #main-container   #helpButton span.fa-info{
                display:none;
        }
        #main-container   #return-button-row-2 button{
                font-family: FrutigerforUBSWeb;
                font-size: 16px;
                border-radius: 0px;
                margin-top: 8px;
        }
		#main-container   .col-lg-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-md-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-sm-4 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-5 {
                width: 34%;
        }
		#main-container   .col-sm-6 {
			    width: 65%;
		}
		#main-container   .col-xs-12 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
                margin-left: 0%;
        }
		#main-container   .row .left {
                float:left;
                width:180px;
                text-align:right;
		}
		#main-container   .row .left span {
			    margin-right:0.5em
		}
        @media all and (max-width: 600px) {
                #main-container #content { text-align: left; margin-left: 3em; }
                span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
        }
        @media all and (max-width: 500px) {
                #main-container #content { text-align: left; margin-left: 2em; }
                #main-container .menu-elements {padding-right: 10%;}
                #main-container message-banner { width: 196px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
        }
        @media all and (max-width: 390px) {
                #main-container #content { text-align: left; margin-left: 1em; }
                #main-container .menu-elements {padding-right: 0%;}
                #main-container #contentBottom { padding-left: 32%; padding-right: 0px; }
                #main-container message-banner { width: 180px; }
                #main-container #link-text { text-align: left; width: 180px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link {width: 50%;text-align: left;}
        }
        @media all and (max-width: 250px) {
                #main-container #content { text-align: center; margin-left: 0em; }
                #main-container #contentBottom { padding-left: 0%; }
                #main-container message-banner { width: 196px; }
                #main-container #link-text { text-align: center; width: 196px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link { width: 100%;text-align: center;}

        }
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div id="contentHeaderLeft">
					<h3><custom-text custom-text-key="''network_means_pageType_1''"></custom-text></h3>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div>
                        <message-banner></message-banner>
                    </div>
                    <div id="link-text">
                        <custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
                    </div>
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
                            </div>
                        </div>
                        <div id="return-button-row-2">
                              <button class="btn btn-default" ng-click="returnButtonAction()"> <custom-text custom-text-key="''network_means_pageType_40''" class="ng-isolate-scope"></custom-text> </button>
                        </div>
                    </div>
                </div>
		</div>
</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
        #main-container {
                font-family: FrutigerforUBSWeb;
                max-width: 600px;
                max-height: 600px;
                margin-left: auto;
                margin-right: auto;
        }
        #main-container   #pageHeader {
                width: 100%;
                height: 74px;
                border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
                width: 20%;
                float: left;
                padding-left: 16px;
                padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
                width: 25%;
                float: right;
                text-align: right;
                padding-top: 16px;
		}
		#main-container  #issuerLogo {
                max-height: 64px;
                max-width:100%;
                padding-left: 0px;
                padding-right: 0px;
		}
		#main-container   #networkLogo {
                max-height: 100%;
                max-width: 100%;
		}
		#main-container  #content {
                text-align:left;
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
                color: #1C1C1C;
                letter-spacing: 0;
                line-height: 24px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
                font-family: Frutiger55Roman;
                font-weight: normal;
                font-size: 16px;
                color: #646464;
                letter-spacing: 0;
                line-height: 24px;
        }
        #main-container .menu-title {
                display:none;
        }
        #main-container #contentBottom {
                padding-left: 35%;
        }
        #main-container   message-banner {
                display: inline-block;
                margin-top: 5px;
                position: relative;
                width: 196px;
		}
		#main-container   div#footer {
			    background-image:none;
			    height:100%;
		}
		#main-container   #footer {
                width:100%;
                clear:both;
                margin-top:2em;
		}
		#main-container   #footer:after {
                content: "";
                height:100%;
                display: table;
                clear: both;
                padding-bottom: 0.5em;
		}
		#main-container  #footer .help-area {
                display: flex;
                flex-direction: row;
		}
        #main-container  .help-link {
                font-size: 14px;
                line-height: 20px;
                width: 50%;
                order: 2;
                text-align: left;
                color:#007099;
		}
        #main-container #helpButton  button span{
                color:#007099;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
                border-style: none;
                padding:0px
        }
        #main-container   #helpButton span.fa-info{
                display:none;
        }
		#main-container   .col-lg-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-md-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-sm-4 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-5 {
                width: 34%;
        }
		#main-container   .col-sm-6 {
			    width: 65%;
		}
		#main-container   .col-xs-12 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
                margin-left: 0%;
        }
		#main-container   .row .left {
                float:left;
                width:180px;
                text-align:right;
		}
		#main-container   .row .left span {
			    margin-right:0.5em
		}
        @media all and (max-width: 600px) {
                #main-container #content { text-align: left; margin-left: 3em; }
                span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
        }
        @media all and (max-width: 500px) and (min-width: 391px) {
                #main-container #content { text-align: left; margin-left: 2em; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
        }

        @media all and (max-width: 390px) {
                #main-container #content { text-align: left; margin-left: 1em; }
                #main-container #contentBottom { padding-left: 35%; padding-right: 0px; }
                #main-container message-banner { width: 180px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link {width: 50%;text-align: left;}
        }

        @media all and (max-width: 250px) {
                #main-container #content { text-align: center; margin-left: 0em; }
                #main-container #contentBottom { padding-left: 0%; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link { width: 100%;text-align: center;}
        }
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div>
                        <message-banner></message-banner>
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
</div>
' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('INFO Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '
<style>
        #main-container {
                font-family: FrutigerforUBSWeb;
                max-width: 600px;
                max-height: 600px;
                margin-left: auto;
                margin-right: auto;
        }
        #main-container   #pageHeader {
                width: 100%;
                height: 74px;
                border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
                width: 20%;
                float: left;
                padding-left: 16px;
                padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
                width: 25%;
                float: right;
                text-align: right;
                padding-top: 16px;
		}
		#main-container  #issuerLogo {
                max-height: 64px;
                max-width:100%;
                padding-left: 0px;
                padding-right: 0px;
		}
		#main-container   #networkLogo {
                max-height: 100%;
                max-width: 100%;
		}
		#main-container  #content {
                text-align:left;
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
                color: #1C1C1C;
                letter-spacing: 0;
                line-height: 24px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
                font-family: Frutiger55Roman;
                font-weight: normal;
                font-size: 16px;
                color: #646464;
                letter-spacing: 0;
                line-height: 24px;
        }
        #main-container .menu-title {
                display:none;
        }
        #main-container .menu-elements {
                padding-right:10%;
        }
        #main-container #contentBottom {
                padding-left: 32%;
        }
        #message-container {
                display: inline-block;
                margin-top: 5px;
                position: relative;
                width: 196px;
		}
        div#message-content {
                text-align: center;
                background-color: inherit;
                padding-bottom: 5px;
                background-color:#F7E1DF;
                font-family: FrutigerforUBSWeb;
                font-size:12px;
                color: #E0B519;
        }
        span#info-icon {
                font-size: 1em;
                top: 5px;
                left: 5px;
                float: left;
                margin-right: 5px;
        }
        #message {
                font-family: FrutigerforUBSWeb;
                color: #1C1C1C;
                font-size:12px;
                line-height: 16px;
                text-align:center;
        }
        span#message {
                font-size:10px;
                width: 100%;
        }
        div.message-button {
                padding-top: 0px;
                display: none;
        }
        div#spinner-row .spinner div div{
                background: #E0B519!important;
        }
		#main-container   div#footer {
			    background-image:none;
			    height:100%;
		}
		#main-container   #footer {
                width:100%;
                clear:both;
                margin-top:2em;
		}
		#main-container   #footer:after {
                content: "";
                height:100%;
                display: table;
                clear: both;
                padding-bottom: 0.5em;
		}
		#main-container  #footer .help-area {
                display: flex;
                flex-direction: row;
		}
        #main-container  .help-link {
                font-size: 14px;
                line-height: 20px;
                width: 50%;
                order: 2;
                text-align: left;
                color:#007099;
		}
        #main-container #helpButton  button span{
                color:#007099;
                background-color: #f7f7f7;
        }
        #main-container #helpButton  button {
                border-style: none;
                padding:0px
        }
        #main-container   #helpButton span.fa-info{
                display:none;
        }
		#main-container   .col-lg-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-md-4 {
                width: 100%;
                margin-bottom: 20px;
		}
		#main-container   .col-sm-4 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-5 {
                width: 34%;
        }
		#main-container   .col-sm-6 {
			    width: 65%;
		}
		#main-container   .col-xs-12 {
                width: 100%;
                margin-bottom: 20px;
		}
        #main-container   .col-sm-offset-1 {
                margin-left: 0%;
        }
		#main-container   .row .left {
                float:left;
                width:180px;
                text-align:right;
		}
		#main-container   .row .left span {
			    margin-right:0.5em
		}
        @media all and (max-width: 600px) {
                #main-container #content { text-align: left; margin-left: 3em; }
                span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
        }
        @media all and (max-width: 500px) and (min-width: 391px) {
                #main-container #content { text-align: left; margin-left: 2em; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
        }

        @media all and (max-width: 390px) {
                #main-container #content { text-align: left; margin-left: 1em; }
                #main-container #contentBottom { padding-left: 32%; padding-right: 0px; }
                #main-container message-container { width: 180px; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link {width: 50%;text-align: left;}
        }

        @media all and (max-width: 250px) {
                #main-container #content { text-align: center; margin-left: 0em; }
                #main-container #contentBottom { padding-left: 0%; }
                span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
                #main-container  .help-link { width: 100%;text-align: center;}
        }
</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
		<div id="headerLayout" class="row">
			<div id="pageHeader" class="text-center col-xs-12">
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<div id="content">
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
				<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div id="message-container" ng-class="[style, {unfold: unfolded}]" ng-click="foldUnfold()" click-outside="fold()" class="ng-scope error unfold" style="">
                        <div id="message-content">
                            <span id="info-icon" class="fa fa-exclamation-triangle"></span>
                            <custom-text id="message" custom-text-key="''network_means_pageType_23''"></custom-text>
                        </div>
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
</div>
' WHERE `fk_id_layout` = @layoutId;
