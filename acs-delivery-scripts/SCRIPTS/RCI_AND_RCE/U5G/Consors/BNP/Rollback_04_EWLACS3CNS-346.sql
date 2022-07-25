USE `U5G_ACS_BO`;

SET @pageLayoutId_BNP_Polling = (select id from `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'Polling Page (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_301_FONT_TITLE''"
			 font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_304_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_304_FONT_TITLE''"
			 font-key="''network_means_pageType_304_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_305_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_305_FONT_TITLE''"
			 font-key="''network_means_pageType_305_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_306_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_306_FONT_TITLE''"
			 font-key="''network_means_pageType_306_FONT_DATA''"></custom-font>
<div id="main-container">
	<div id="header" class="row-flex">
		<div id="bankLogo">
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false">
		</div>
	</div>
	<div id="content">
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
        <custom-text id="title" custom-text-key="''network_means_pageType_1''"></custom-text>
        <div class="transaction-details">
            <side-menu></side-menu>
        </div>
        <div class="mobile-app-info-title">
            <custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
        </div>
        <div class="mobile-app-info-text">
            <span>
                <custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
            </span>
        </div>
        <div class="mobile-app-img">
            <custom-image id="mobileAppLogo" alt-key="''network_means_pageType_3_IMAGE_ALT''" image-key="''network_means_pageType_3_IMAGE_DATA''" straight-mode="false">
        </div>
	</div>
    <div class="row">
        <div class="back-link">
            <span class="fa fa-angle-left"></span>
            <cancel-button cn-label="''network_means_pageType_11''" id="cancelButton" ></cancel-button>
        </div>
    </div>
	<div id="footer">
        <div class="row-flex">
            <div class="contact">
                <div class="contact-text">
                      <custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
                </div>
                <div class="contact-text">
                    <div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
                </div>
                <div class="contact-text-small">
                    <div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
                </div>
            </div>
            <div class="help-area">
                <div class="help-link">
                     <help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
                    <span class="fa fa-angle-right"></span>
                </div>
            </div>
        </div>
        <div id="copyright" class="row-flex small">
            <div class="copyright-left">
                <span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span>
            </div>
            <div class="copyright-right">
                <div class="copyright-right-content">
                    <span><custom-text custom-text-key="''network_means_pageType_44''"></custom-text></span>
                </div>
            </div>
        </div>
	</div>
</div>
<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
    .row-flex {
        display: flex;
    }
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
		width: 480px;
		margin-left: auto;
		margin-right: auto;
	}
	#header {
        align-items: center;
	}
    #bankLogo {
        width: 50%;
        height: 72px;
    }
	#schemeLogo {
        width: 50%;
        height: 40px;
        text-align: end;
	}
	#issuerLogo {
		max-height: 100%;
	}
	#networkLogo {
		max-height: 100%;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#content {
		text-align: left;
		color: #403f3d;
		background-color: #f7f7f7;
	}
	custom-text#title {
		font-weight: bold;
		font-size: 25px;
		font-family: BNPPSans;
		color: #403f3d;
	}
    .transaction-details {
        height: 100px;
        margin-top: 10px;
    }
	.side-menu .text-left, .side-menu .text-right {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
	}
	.mobile-app-info-title {
        display: inline-block;
		font-family: BNPPSansLight;
		font-size: 25px;
		color: #403f3d;
	}
	.mobile-app-info-text {
        margin-top: 5px;
        margin-bottom: 5px;
	}
	.mobile-app-img {
		text-align: center;
	}
    .back-link {
        padding-top: 10px;
        padding-bottom: 10px;
		text-align: left;
        background-color: #f7f7f7;
		color: #749bb3;
	}
    .back-link button {
		border-style: none;
        border-radius: 0px;
		background: none;
		padding: 0px;
		background-color: #f7f7f7;
        color: #749bb3;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	.back-link span.fa-ban {
		display: none;
	}
    div#footer {
		height: auto;
        padding: 10px;
        background-color: #d1d1d1;
		background-image: none;
    }
    .contact {
        width: 70%;
    }
    .contact-text {
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
    .contact-text-small {
		font-size: 12px;
		font-weight: normal;
        color: #6b6b6b;
    }
    .help-area {
       width: 30%;
       text-align: end;
    }
    #helpButton button {
        padding: 2px;
		border-style: none;
        border-radius: 0px;
		background-color: #5b7f95;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		color: white;
	}
    #helpButton .fa-info {
		display: none;
	}
    #footer .small {
		font-size: 12px;
		font-weight: normal;
	}
    #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
    #footer #copyright {
        border-top: 1px solid #6b6b6b;
        margin-top: 10px;
        padding-top: 5px;
    }
    #copyright .copyright-left {
        width: 60%;
    }
    #copyright .copyright-right {
        width: 40%;
        text-align: end;
    }

    @media all and (max-width: 252px) {
        #main-container {
            font-size: 12px;
            width: 98%;
            margin-left: auto;
            margin-right: auto;
        }
        #bankLogo {
            height: 52px;
        }
        #schemeLogo {
            height: 30px;
        }
        custom-text#title {
            font-size: 14px;
        }
        .transaction-details {
            height: 70px;
            margin-top: 8px;
        }
        .side-menu .text-left, .side-menu .text-right {
            font-family: BNPPSans;
            font-size: 10px;
            color: #403f3d;
        }
        .mobile-app-info-title {
            display: inline-block;
            font-size: 18px;
        }
        .mobile-app-img img {
            height: 50px;
        }
        #main-container .back-link button span {
            font-size: 11px;
        }
        .contact-text {
            font-size: 11px;
        }
        #main-container #helpButton button span {
            font-size: 10px;
        }
    }
    @media all and (min-width: 252px) and (max-width: 392px) {
        #main-container {
            font-size: 12px;
            width: 96%;
            margin-left: auto;
            margin-right: auto;
        }
        #bankLogo {
            height: 52px;
        }
        #schemeLogo {
            height: 30px;
        }
        custom-text#title {
            font-size: 16px;
        }
        .transaction-details {
            height: 70px;
        }
        .side-menu .text-left, .side-menu .text-right {
            font-size: 12px;
        }
        .mobile-app-info-title {
            display: inline-block;
            margin-top: 10px;
            font-size: 20px;
        }
        .mobile-app-img img {
            height: 60px;
        }
        #main-container .back-link button span {
            font-size: 12px;
        }
        .contact-text {
            font-size: 11px;
        }
        #main-container #helpButton button span {
            font-size: 11px;
        }
    }
    @media all and (min-width: 392px) and (max-width: 502px) {
        #main-container {
            width: 96%;
            margin-left: auto;
            margin-right: auto;
        }
        custom-text#title {
            font-size: 20px;
        }
        .mobile-app-img img {
            height: 68px;
        }
    }
</style>' WHERE fk_id_layout = @pageLayoutId_BNP_Polling;




SET @pageLayoutId_CNS_Polling = (select id from `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'Polling Page (Consorsbank)');

UPDATE `CustomComponent`
SET `value` = '
	<div id="main-container">
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
		<div id="content">
			<message-banner></message-banner>
			<h2>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h2>
			<div class="transactiondetails">
				<side-menu></side-menu>
			</div>
			<div id="newLine">
				<br></br>
				<br></br>
				<p></p>
			</div>
			<h2>
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph1"></custom-text>
			</h2>
			<span>
				<custom-text custom-text-key="''network_means_pageType_4''" id="paragraph1"></custom-text>
			</span>
			<p></p>
			<div class="mobileapp">
			<custom-image id="mobileAppLogo" alt-key="''network_means_pageType_3_IMAGE_ALT''" image-key="''network_means_pageType_3_IMAGE_DATA''" straight-mode="false">
			</div>
			<means-choice-menu></means-choice-menu>
			<div id="form-controls">
				<div class="row">
					<div class="back-link">
						<span class="fa fa-angle-left"></span>
						<cancel-button cn-label="''network_means_pageType_11''" id="cancelButton" ></cancel-button>
					</div>
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
				<div><span><custom-text custom-text-key="''network_means_pageType_44''"></custom-text></span></div>
			</div>
		</div>
	<style>
	/* Switchpoints: 780, */
		:root {
			font-family: proximaLight, Times;
			padding:0px;
			margin:0px;
		}
		.mobileapp{
			text-align: center;
		}
		#main-container {
			width:480px;
			max-width:480px;
			margin-left:auto;
			margin-right:auto;
		}

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


		#content {
			text-align:center;
		}
		#content h2 {
			font-size:1.25em;
			margin-bottom:0.25em;
			margin-top:8px;
		}
		#main-container	  #footer {
			margin-top: 5px;
			width:100%;
			background-color:#d1d1d1;
			clear:both;
			background-image:none;
			height: auto;
		}
		#main-container	  #footer:after {
			content: "''";
			height:100%;
			display: table;
			clear: both;
			padding-bottom: 0.5em;
		}
		#main-container	  #footer .extra-small {
			font-size:0.7em;
		}
		#main-container	  #footer .small {
			font-size:0.8em;
		}
		#main-container	  #footer .bold {
			font-weight: bold;
		}
		#main-container	 #footer .grey {
			color: #6b6b6b;
		}
		#main-container	  #footer .bottom-margin {
			margin-bottom:10px;
		}
		#main-container	  #footer #copyright {
			width:100%;
			border-top : 1px solid #6b6b6b;
			padding-top:0.5em;
			padding-bottom:1em;
			display:flex;
			flex-direction: row;
		}
		#main-container	  #footer #copyright div:nth-child(1) {
			order:1;
			text-align:left;
			width:50%;
			padding-left:12px;
		}
		#main-container	  #footer #copyright div:nth-child(2) {
			order:2;
			text-align: right;
			width:50%;
			padding-right:12px;
		}
		#main-container	 #footer .help-area {
			display: flex;
			flex-direction: row;
			padding: 16px;
		}
		p {
			margin-bottom:10px;
		}
		#main-container #footer .small-font {
			font-size:0.75em;
		}
		.splashtext {
			width:80%;
			margin-left:auto;
			margin-right:auto
		}
		input {
			border: 1px solid #d1d1d1;
			border-radius: 6px;
			color: #464646;
			padding: 7px 10px 5px;
			height: 20px;
			box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
		}
		.spinner-container {
			display:block;
			width:100%;
		}
		#messageBanner-innerContainer {
			padding:20px;
		}
		#messageBanner {
			width:100%;
			margin-left: 0px;
			margin-right: 0px;
			background-color:#F5F5F5;
			box-sizing:border-box;
		}
		.error {
			color:#D00;
		}
		#messageBanner p {
			margin-top:0.25em;
			margin-bottom:0.25em;
		}
		#messageBanner h3 {
			margin-top:0.25em;
			margin-bottom:0.25em;
		}
		#main-container .row button {
			font-size: 16px;
			height: 38px;
			border-radius: 6px;
			background: linear-gradient(#4dbed3,#007ea5);
			box-shadow:none;
			border:0px;
			color:#FFF;
		}
		#main-container .row button:hover:enabled {
			background: linear-gradient(#2fa8be,#005772);
		}
		#switchId button span.fa {
			display:none;
		}
		#switchId button span.fa-check-square {
			display:none;
		}
		#cancelButton button span.fa {
			display:none;
		}
		.transactiondetails ul {
			list-style-type: none;
			padding-left: 0px;
		}
		.transactiondetails ul li {
			width:100%;
			text-align: left;
		}
		.transactiondetails ul li label {
			display:block;
			float:left;
			width:180px;
			text-align: right;
			font-size:14px;
			color: #909090;
			margin-right:0.5em;
		}
		.transactiondetails ul li span.value {
			clear:both;
			text-align: left;
			margin-left:0.5em;
		}
		a {
			color:#000;
			text-decoration:none;
		}
		a:hover {
			color:#000;
			border-bottom:1px dotted black;
		}
		#main-container .row .left {
			float:left;
			width:180px;
			text-align:right;
		}
		#main-container .row .left span {
			margin-right:0.5em
		}
		#main-container .row .back-link {
			text-align:left;
			float:left;
		}
		#main-container	  .row .back-link button {
			border-style:none;
			background:none;
			padding:0px;
			color:#06c2d4;
		}
		#main-container .row .back-link span {
			text-align:left;
		}
		#main-container	  .row .back-link span.fa-ban {
			display:none;
		}
		#main-container .row .submit-btn {
			text-align:right;
			float:right;
		}
		.mtan-input {
			padding-top:25px;
			padding-bottom:10px;
		}
		.resendTan {
			display: block;
			margin-left:196px;
			margin-top: 10px;
			margin-bottom: 25px;
		}
		.input-label {
			display:flex;
			flex-direction: row;
			align-items: center;
		}
		.resendTan a {
			color:#06c2d4;
		}
		.mtan-label {
			text-align:right;
			flex: 0 0 180px
		}
		.btn {
			border-radius: 0px;
			text-align: left;
		}
		#main-container #footer .help-area {
			display:flex;
			flex-direction: row;
			padding:16px;
		}
		#main-container #helpButton	 button span{
			color:#06c2d4;
			background-color: #f7f7f7;
		}
		#main-container #helpButton	 button {
			border-style: none;
			padding:0px
		}
		#main-container #helpButton .fa-info {
			display:none;
		}
		.help-link {
			width:30%;
			order:2;
			text-align:right
		}
		.contact {
			width:70%;
			order:1;
		}
		#otp-error-message {
			margin-top: 10px;
			position: relative;
			background-color: #F5F5F5;
			text-align: center;
			width:300px;
			margin-left:56px;
			padding:12px;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #F5F5F5;
			border-top: 0;
			margin-left: 166px;
			margin-top: -10px;
		}
		#otp-error-message p {
			color:#D00;
		}
		@media (max-width: 560px) {
			#main-container { width:auto; }
			body{ font-size:14px; }
			#header { height:65px; }
			transactiondetails ul li { text-align:left; }
			transactiondetails ul li label { display:block; float:left; width:50%; text-align: right; font-size:14px; color: #909090; margin-right:0.5em; }
			.transactiondetails ul li span.value { clear:both; text-align: left; margin-left:0.5em; }
			.row { width:auto; clear:none; }
			.row .back-link { float:none; text-align:center; padding-top:0.5em; }
			.row .submit-btn { float:none; text-align:center; padding-bottom:0.5em; }
			.row button { width:90%; }
			.mtan-input { display: flex; flex-direction: column; width:100%; padding-bottom:1em; padding-top:1em; }
			.resendTan { margin-left: 0px; flex-grow: 2; text-align: center; }
			.resendTan a { color:#06c2d4; margin-left: 90px; padding-left: 16px; }
			.mtan-label { flex: 0 0 90px; }
			.input-label { justify-content: center; }
			#main-container #footer { width:100%; background-image:none; background-color:#F5F5F5; clear:both; height:unset; }
			#main-container #footer .help-area { display:flex; flex-direction: column; padding:16px; text-align:center; }
			.help-link { width:100%; order:2; text-align:center; padding-top:1em; }
			.contact { width:100%; order:1; }
			#main-container #footer .small-font { font-size:0.75em; }
			#otp-error-message { margin-top:0px; position: relative; background-color: #F5F5F5; text-align:center; width:100%; margin-left:0px; margin-bottom:16px; box-sizing:border-box; }
			#otp-error-message:after { content: ''''; position: absolute; top: 0; left: 0px; width: 0; height: 0; border: 10px solid transparent; border-bottom-color: #F5F5F5; border-top: 0; margin-left: 50%; margin-top: -10px; }
		}
		@media all and (max-width: 601px) {
			.btn{white-space: nowrap;}
			.message {padding: 5px;padding-bottom: 0px;}
			.spinner{margin-bottom: 30px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 14px;}
			.row button { width:95%; }
			#issuerLogo { max-height: 50px; }
			#networkLogo { max-height: 50px; }
		}

		@media all and (max-width: 501px) {
			.btn{white-space: nowrap;}
			.message {padding: 0px;padding-bottom: 0px;}
			.spinner{margin-bottom: 30px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 14px;}
			.row button { width:95%; }
		}
		@media all and (max-width: 480px) {
			span#info-icon {display: inline;}
		}
		@media all and (max-width: 391px){
			.btn{white-space: nowrap;}
			.message {margin-left: 0px;padding: 0px;padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: center;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#newLine {display: none;}
			.row button { width:95%; }
			#messageBanner {margin-top:0px;margin-bottom:0px;}
			#pageHeader { height: 70px; }
			#networkLogo { max-height: 35px;}
			#issuerLogo { max-height: 35px;}
			span#info-icon {display: none;}
		}

		@media all and (max-width: 251px) {
			.btn{white-space: inherit;}
			.message {margin-left: 0px;padding: 0px;padding-bottom: 0px;}
			.spinner{margin-bottom: 20px;}
			#content {text-align: left;}
			div#message-content{padding-bottom: 0px;padding-top: 0px;}
			div#message-controls {padding-top: 0px;}
			body {font-size: 12px;}
			#main-container .row .back-link button {font-size: 12px;}
			#main-container #helpButton button span {font-size: 12px;}
			#main-container .help-link {width: 100%;text-align: center;}
			message-banner #spinner-row{height: 50px;}
			#main-container #message-container {width: 100%; }
			#main-container #content { text-align: center; margin-left: 0em; font-size: 9px }
			#newLine {display: none;}
			#pageHeader { height: 60px; }
			#issuerLogo { max-height: 30px; }
			#networkLogo { max-height: 30px; }
			span#info-icon {display: none;}
		}
	 </style>' WHERE fk_id_layout = @pageLayoutId_CNS_Polling;