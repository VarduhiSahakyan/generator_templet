USE U7G_ACS_BO;
SET @BankB = 'UBS';

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
        <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                                <otp-form ></otp-form>
                            </div>
                        </div>
                        <message-banner></message-banner>
                         <div class="mtan-label"><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></div>
                    </div>

                   <div class="resendTan">
                          <span class="fa fa-angle-right"></span>
                          <re-send-otp id="resend" rso-Label="''network_means_pageType_19''"></re-send-otp>
                   </div>

                    <div id="form-controls">
                        <div class="row">
                            <div class="submit-btn">
                                <val-button id="validateButton" val-label="''network_means_pageType_42''"></val-button>
                                <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
                            </div>
                        </div>
                    </div>

                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>

		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
            max-height: 64px;
            max-width:100%;
            padding-left: 0px;
            padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
            width:100%;
            text-align:center;
        }
        #main-container #i18n-inner {
            display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout {
            font-family: Frutiger55Roman;
            font-size: 16px;
            letter-spacing: 0;
            line-height: 24px;
        }
        div#leftMenuLayout label {
           color: #646464;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
        #main-container #resend button span{
            color:#007099;
        }
        #main-container #resend button {
            border-style: none;
            padding:0px
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
		#main-container   .mtan-input {
			padding-bottom:10px;
		}
		#main-container   .resendTan {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			display:block;
			margin-top:10px;
			margin-bottom: 25px;
            color:#007099;
		}
		#main-container   .input-label {
			flex-direction: row;
			align-items: center;
		}
		#main-container   .resendTan a {
			color:#007099;
		}
        #main-container   .help-link a {
			color:#007099;
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
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            background: #FFFFFF;
			margin-left:0px;
            border: 1px solid #AAAAAA;
		}
		#main-container   .otp-field input:focus {
			outline:none;
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
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 60%;
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
            font-family: FrutigerforUBSWeb;
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
            font-family: Arial;
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
        #main-container #validateButton button:disabled {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            height: 38px;
            border-radius: 2px;
            background: #6A7D39;
            box-shadow: none;
            border: 0px;
            color: #FFFFFF;
        }
	</style>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
         <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
          width:100%;
          text-align:center;
        }
        #main-container #i18n-inner {
          display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
        #main-container   .help-link a {
			color:#007099;
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
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:1em;
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
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 65%;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
	</style>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
         <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
          width:100%;
          text-align:center;
        }
        #main-container #i18n-inner {
          display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }
        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
        #main-container   .help-link a {
			color:#007099;
		}
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:1em;
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
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 65%;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
	</style>' WHERE `fk_id_layout` = @layoutId;

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE CustomComponent SET value = '<div id="main-container" class="" ng-style="style" class="ng-scope">
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
         <div id="i18n-container">
             <div id="i18n-inner">
               <i18n></i18n>
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
                    <div id="footer">
                        <div class="help-area">
                            <div class="help-link">
                                <span class="fa fa-angle-right"></span><a href="#"><custom-text custom-text-key="''network_means_pageType_41''"></custom-text></a>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
	</div>
	<style>
        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
            max-height: 80px;
            max-width:100%;
            padding-top: 16px;
		}
		#main-container   #pageHeader {
            width: 100%;
            height: 76px;
            border-bottom: 1px solid #DCDCDC;
		}
        #main-container   #pageHeaderLeft {
            width: 20%;
            float: left;
            padding-left: 16px;
            padding-top: 16px;
		}
		#main-container   #pageHeaderRight {
            width: 20%;
            float: right;
            text-align: right;
		}
        #main-container #i18n-container {
          width:100%;
          text-align:center;
        }
        #main-container #i18n-inner {
          display:inline-block;
        }
		#main-container   #centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		#main-container   #content {
			text-align:left;
            margin-left: 1.5em;
		}
		#main-container   #content contentHeaderLeft {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:0.25em;
		}
        div#contentHeaderLeft h3 {
            font-family: FrutigerforUBSWeb-Lt;
            font-size: 24px;
            color: #1C1C1C;
            line-height: 28px;
        }

        div#leftMenuLayout span.custom-text.ng-binding {
             font-weight: normal;
        }
        div#leftMenuLayout span.ng-binding {
            font-family: FrutigerforUBSWeb;
            font-size: 16px;
            color: #1C1C1C;
            font-weight: 500;
        }
        #main-container .menu-title {
            display:none;
        }
        #main-container .menu-elements {
            margin-right:25%;
        }
        #main-container #contentBottom {
            margin-left: 26%;
        }
		#main-container   .help-link {
            font-family: FrutigerforUBSWeb;
            font-size: 14px;
            line-height: 20px;
			width: 50%;
			order: 2;
			text-align: left;
            color:#007099;
		}
		#main-container   .contact {
			width: 70%;
			order: 1;
		}
        #main-container   .help-link a {
			color:#007099;
		}
		#main-container   div#footer {
			background-image:none;
			height:100%;
		}
		#main-container   #footer {
			width:100%;
			clear:both;
			margin-top:1em;
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
		#main-container   message-banner {
			display: block;
            margin-top: 5px;
			position: relative;
            width: 65%;
		}
		#main-container   .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container   .row .left span {
			margin-right:0.5em
		}
	</style>' WHERE `fk_id_layout` = @layoutId;
