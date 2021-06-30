
USE `U5G_ACS_BO`;

SET @pollingPageType = 'POLLING_PAGE';
SET @customPageLayoutDesc_appView = 'Polling Page (BNP_WM)';


SET @idViewPage = (select id
						from `CustomPageLayout`
						where `pageType` = @pollingPageType
						and DESCRIPTION = @customPageLayoutDesc_appView);


UPDATE `CustomComponent`
SET `value` = '<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
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
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false">
		</div>
	</div>
	<div id="content">
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
			<h2>
				<custom-text custom-text-key="''network_means_pageType_1''" id="title"></custom-text>
			</h2>
			<div class="transactiondetails">
				<side-menu></side-menu>
			</div>
			<br></br>
			<br></br>
			<p></p>
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
	</div>
	<div id="form-controls">
		<div class="row">
			<div class="back-link">
				<span class="fa fa-angle-left"></span>
				<cancel-button cn-label="''network_means_pageType_11''" id="cancelButton" ></cancel-button>
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
</div>
<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
	.mobileapp {
		text-align: center;
	}
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#header {
		height: 100px;
		position: relative;
	}
	#main-container #networkLogo {
		max-height: 33px;
		max-width: 100%;
	}
	#main-container #issuerLogo {
		max-height: 72px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#mobileAppLogo {
		position: relative;
	}
	#schemeLogo {
		width: 100px;
		height: 100px;
		position: absolute;
		right: 0px;
		top: 1em;
		padding-right: 1em;
	}
	div#contentHeader {
		background-color: #f7f7f7;
	}
	div#transactionDetails {
		background-color: #f7f7f7;
	}
	custom-text#title {
		font-weight: bold;
		font-size: 25px;
		font-family: BNPPSans;
		color: #403f3d;
	}
	#content {
		text-align: left;
		color: #403f3d;
		background-color: #f7f7f7;
	}
	#content h2 {
		font-family: BNPPSansLight;
		font-size: 25px;
		line-height: 1.2;
		font-weight: normal;
		margin-bottom: 0.25em;
		margin-top: 0.25em;
		color: #403f3d;
		padding-top: 7px;
	}
	.btn {
		border-radius: 0px;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		font-family: BNPPSans;
	}
	.side-menu .text-left, .side-menu .text-right {
		font-family: BNPPSans;
		padding-right: 5px;
		padding-left: 5px;
		font-size: 15px;
		color: #403f3d;
	}
	.menu-elements {
		color: #403f3d;
	}
	div#form-controls {
		background-color: #f7f7f7;
	}
	#main-container #footer {
		width: 100%;
		background-color: #d1d1d1;
		clear: both;
		background-image: none;
		height: auto;
		color: #403f3d;
	}
	#main-container #footer:after {
		content: '''';
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
	p {
		margin-bottom: 10px;
	}
	#main-container #footer .small-font {
		font-size: 0.75em;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto
	}
	input {
		border: 1px solid #d1d1d1;
		color: #464646;
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner-innerContainer {
		padding: 20px;
	}
	#messageBanner {
		width: 100%;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		margin-bottom: 10px;
		background-color: #f5f5f5;
		padding: 5px;
		box-sizing: border-box;
	}
	.error {
		color: #d00;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#main-container .row button {
		font-family: BNPPSans;
		font-size: 15px;
		height: 38px;
		background: linear-gradient(#4dbed3, #007ea5);
		box-shadow: none;
		border: 0px;
		color: #000;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	#switchId button span.fa {
		display: none;
	}
	#switchId button span.fa-check-square {
		display: none;
	}
	#cancelButton button span.fa {
		display: none;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container .row .back-link {
		text-align: left;
		float: left;
	}
	#main-container .row .back-link button {
		border-style: none;
		background: none;
		padding: 0px;
		background-color: #f7f7f7;
		color: #06c2d4;
	}
	#main-container .row .back-link span {
		text-align: left;
		margin-left: 0.5em;
		color: #749bb3;
	}
	#main-container .row .back-link span.fa-ban {
		display: none;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding: 16px;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		color: white;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 2px;
		background-color: #5b7f95;
	}
	#main-container #helpButton .fa-info {
		display: none;
	}
	.help-link {
		width: 30%;
		order: 2;
		text-align: right
	}
	.contact {
		width: 70%;
		order: 1;
		font-weight: bold;
	}
	@media (max-width: 560px) {
		#main-container {width: auto;}
		body {font-size: 14px;}
		#header {height: 65px;}
		#schemeLogo {margin-top: 1em;width: 70px;height: 70px;}
		.row {width: auto;clear: none;}
		.row .back-link {float: none;text-align: center;padding-top: 0.5em;}
		.row button {width: 90%;}
		#main-container #footer {width: 100%;background-image: none;background-color: #f5f5f5;clear: both;height: unset;}
		#main-container #footer .help-area {display: flex;flex-direction: column;padding: 16px;text-align: center;}
		.help-link {width: 100%;order: 2;text-align: center;padding-top: 1em;}
		.contact {width: 100%;order: 1;}
		#main-container #footer .small-font {font-size: 0.75em;}
	}
</style> '
WHERE `fk_id_layout` = @idViewPage;


SET @pollingPageType = 'POLLING_PAGE';
SET @customPageLayoutDesc_appView = 'Polling Page (Consorsbank)';


SET @idViewPage = (select id
						from `CustomPageLayout`
						where `pageType` = @pollingPageType
						and DESCRIPTION = @customPageLayoutDesc_appView);


UPDATE `CustomComponent`
SET `value` = '
<div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false">
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
			<br></br>
			<br></br>
			<p></p>
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
	 padding-left:10px;
	 padding-right:10px;
}
 #header {
	 height:100px;
	 position:relative;
}

#main-container #networkLogo {
	max-height: 33px;
	max-width: 100%;
}


#main-container #issuerLogo {
	max-height: 72px;
	padding-left: 0px;
	padding-right: 0px;
}

#mobileAppLogo {
	position:relative;
}
 #schemeLogo {
	 width:100px;
	 height:100px;
	 position:absolute;
	 right:0px;
	 top:1em;
	 padding-right:1em;
}
 #content {
	 text-align:left;
}
 #content h2 {
	 font-size:1.25em;
	 margin-bottom:0.25em;
	 margin-top:0.25em;
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
	 margin-top:10px;
	 margin-bottom:10px;
	 background-color:#F5F5F5;
	 padding:5px;
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
	 margin-left:0.5em;
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
 .otp-field input {
	 margin-left:16px;
}
 .otp-field input:focus {
	 outline:none;
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
	 #main-container {
		 width:auto;
	}
	 body {
		 font-size:14px;
	}
	 #header {
		 height:65px;
	}
	 #schemeLogo {
		 margin-top:1em;
		 width:70px;
		 height:70px;
	}
	 .transactiondetails ul li {
		 text-align:left;
	}
	 .transactiondetails ul li label {
		 display:block;
		 float:left;
		 width:50%;
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
	 .row {
		 width:auto;
		 clear:none;
	}
	 .row .back-link {
		 float:none;
		 text-align:center;
		 padding-top:0.5em;
	}
	 .row .submit-btn {
		 float:none;
		 text-align:center;
		 padding-bottom:0.5em;
	}
	 .row button {
		 width:90%;
	}
	 .mtan-input {
		 display: flex;
		 flex-direction: column;
		 width:100%;
		 padding-bottom:1em;
		 padding-top:1em;
	}
	 .resendTan {
		 margin-left: 0px;
		 flex-grow: 2;
		 text-align: center;
	}
	 .resendTan a {
		 color:#06c2d4;
		 margin-left: 90px;
		 padding-left: 16px;
	}
	 .mtan-label {
		 flex: 0 0 90px;
	}
	 .input-label {
		 justify-content: center;
	}
	 .otp-field {
		 display:inline;
	}
	 .otp-field input {
	}
	 #main-container #footer {
		 width:100%;
		 background-image:none;
		 background-color:#F5F5F5;
		 clear:both;
		 height:unset;
	}
	 #main-container #footer .help-area {
		 display:flex;
		 flex-direction: column;
		 padding:16px;
		 text-align:center;
	}
	 .help-link {
		 width:100%;
		 order:2;
		 text-align:center;
		 padding-top:1em;
	}
	 .contact {
		 width:100%;
		 order:1;
	}
	 #main-container #footer .small-font {
		 font-size:0.75em;
	}
	 #otp-error-message {
		 margin-top:0px;
		 position: relative;
		 background-color: #F5F5F5;
		 text-align:center;
		 width:100%;
		 margin-left:0px;
		 margin-bottom:16px;
		 box-sizing:border-box;
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
		 margin-left: 50%;
		 margin-top: -10px;
	}
}
 </style>
'
WHERE `fk_id_layout` = @idViewPage;