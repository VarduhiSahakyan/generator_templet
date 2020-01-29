USE U5G_ACS_BO;

SET @bankName = 'Spardabank';

INSERT INTO `CustomPageLayout` (`controller`,`pageType`,`description`)
VALUES (NULL,'MESSAGE_BANNER', CONCAT('Message Banner (', @bankName, ')')),
       (NULL,'OTP_FORM_PAGE', CONCAT('SMS OTP Form Page (', @bankName, ')')),
       (NULL,'REFUSAL_PAGE', CONCAT('Refusal Page (', @bankName, ')')),
       (NULL,'MEANS_PAGE', CONCAT('Means Page (', @bankName, ')')),
       (NULL,'FAILURE_PAGE', CONCAT('Failure Page (', @bankName, ')')),
       (NULL,'HELP_PAGE',CONCAT('Help Page (',@bankName, ')')),
       (NULL,'POLLING_PAGE', CONCAT('Polling Page (', @bankName, ')')),
       (NULL,'MOBILE_APP_EXT_CHOICE_PAGE', CONCAT('APP Choice Page (', @bankName, ')')),
       (NULL,'EXT_PASSWORD_OTP_FORM_PAGE', CONCAT('Password OTP Form Page (', @bankName, ')')),
       (NULL,'I_TAN_OTP_FORM_PAGE', CONCAT('ITAN OTP Form Page (', @bankName, ')'));

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @bankName, ')%'));

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div',
        '<div id="messageBanner">
          <span id="info-icon" class="fa fa-info-circle"></span>
          <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
          <custom-text id="message" custom-text-key="$parent.message"></custom-text>
      </div>
          <style>
              span#info-icon {
                  position:absolute;
                  top:15px;
                  left:15px;
                  float:none;
              }
              @media all and (max-width: 480px) {
                  span#info-icon {
                      position: absolute;
                      font-size: 3em;
                      top: 1px;
                      left: 5px;
                      display: inline-block;
                  }
              }
              #spinner-row {
                  padding-top: 20px;
              }
              .spinner {
                  position: relative;
                  display:block;
                  padding-top:15px;
                  padding-bottom:15px;
              }
              div#message-container.info {
                  background-color:#002395;
                  font-family: Arial, standard;
                  font-size:12px;
                  color: #EAEAEA;
              }
              div#message-container.success {
                  background-color:#04BD07;
                  font-family: Arial, standard;
                  font-size:12px;
                  color: #EAEAEA;
              }
              div#message-container.error {
                  background-color:#DB1818;
                  font-family: Arial, standard;
                  font-size:12px;
                  color: #EAEAEA;
              }
              div#message-container.warn {
                  background-color:#E0700A;
                  font-family: Arial, standard;
                  font-size:12px;
                  color: #EAEAEA;
              }
              #headingTxt {
                  font-family: Arial,bold;
                  color: #FFFFFF;
                  font-size:14px;
                  width : 70%;
                  margin : auto;
                  display : block;
                  text-align:center;
                  padding:4px 1px 1px 1px;
              }
              #message {
                  font-family: Arial,bold;
                  color: #FFFFFF; font-size:14px;
                  text-align:center;
              }
              span#message {
                  font-size:14px;
              }
              #message-container {
                  position:relative;
              }
              #optGblPage message-banner div#message-container {
                  width:100% ;
                  box-shadow: none ;
                  -webkit-box-shadow:none;
                  position: relative;
              }
              div.message-button {
                  padding-top: 0px;
              }
              div#message-content {
                  text-align: center;
                  background-color: inherit;
                  padding-bottom: 5px;
              }
          </style>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	/* overrides for the cancel and validate button */
    #cancelButton button {
	    width: 35%;
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
    }

    val-button button.btn {
        width: 35%;
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

    val-button button:active {
       background-color: #FF8C00;
       box-shadow: 0 3px #666;
    }

    val-button button.btn[disabled]:hover {
        width: 35%;
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

    val-button button.btn:hover {
        background-color: #FFA500;
    }

    val-button button.btn div {
        display:inline;
    }

    val-button button.btn custom-text span {
        vertical-align:10%;
        color: #fff;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
		margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
		padding-left: 16px;
		margin-right: 25%;
	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
		text-align: center;
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
    	padding-left:30.9%;
    	text-align:left;
    	font-size: 18px;
    }
    div.side-menu div.menu-elements {
    	margin-top:5px;
    }

    @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 10px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
        .tanContainer {margin-left: 22%; display:flex; justify-content: center;}
        .tanContainer > #tanLabel {margin-right: 1%;}
        .tanContainer > #otpForm {margin-right: 4%;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center; margin-top: 10px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { margin-left:0px; margin-top: 50px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
        .tanContainer {margin-left: 33%; display:flex; justify-content: center;}
        .tanContainer > #tanLabel {margin-right: 1%;}
        .tanContainer > #otpForm {margin-right: 4%;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center; margin-top: 10px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
        .tanContainer {margin-left: 33%; display:flex; justify-content: center;}
        .tanContainer > #tanLabel {margin-right: 1%;}
        .tanContainer > #otpForm {margin-right: 4%;}
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; margin-top: 60px;}
        .tanContainer {margin-left: 33%; display:flex; justify-content: center;}
	}

    .tanContainer {
      margin-left: 18%;
      display:flex;
      justify-content: center;
    }
    .tanContainer > #tanLabel {
      margin-right: 1%;
    }

    .tanContainer > #otpForm {
      margin-right: 4%;
    }

    .footerDiv {
		display:flex;
        flex-direction:row;
        margin-top:1em;
        width: 70%;
        margin-left: 15%;
	}

    .col1 {
	    width:50%;
    }
    .col2 {
	    width: 50%;
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
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>

	<style>
		div#grey-banner {
			height: 20px !important;
		    background-color:#F7F8F8;
		    width: 100%;
            position: relative;
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
            <means-choice-menu></means-choice-menu>

		</div>
        <div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
        <div class="tanContainer">
				<div id = "tanLabel">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<div id = "otpForm" >
					<otp-form></otp-form>
				</div>
		</div>
	</div>
    <div class="footerDiv">
			<div class="col1">
			</div>
			<div class="col2">
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			    <val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
			</div>

	</div>
</div>
', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (',@bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '
<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	/* overrides for the cancel and validate button */
    #cancelButton button {
	    width: 35%;
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
    }

    val-button button.btn {
        width: 35%;
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

    val-button button:active {
       background-color: #FF8C00;
       box-shadow: 0 3px #666;
    }

    val-button button.btn[disabled]:hover {
        width: 35%;
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

    val-button button.btn:hover {
        background-color: #FFA500;
    }

    val-button button.btn div {
        display:inline;
    }

    val-button button.btn custom-text span {
        vertical-align:10%;
        color: #fff;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
		margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
		padding-left: 16px;
		margin-right: 25%;
	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
		text-align: center;
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
    	padding-left:30.9%;
    	text-align:left;
    	font-size: 18px;
    }
    div.side-menu div.menu-elements {
    	margin-top:5px;
    }

    @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 10px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
        .additionalMenuContainer {margin-left: 22%; display:flex; justify-content: center;}
        .additionalMenuContainer > #additionalMenuLabel {margin-right: 1%;}
        .additionalMenuContainer > #additionalMenuValue {margin-right: 4%;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center; margin-top: 10px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { margin-left:0px; margin-top: 50px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
        .additionalMenuContainer {margin-left: 33%; display:flex; justify-content: center;}
        .additionalMenuContainer > #additionalMenuLabel {margin-right: 1%;}
        .additionalMenuContainer > #additionalMenuValue {margin-right: 4%;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center; margin-top: 10px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
        .additionalMenuContainer {margin-left: 33%; display:flex; justify-content: center;}
        .additionalMenuContainer > #additionalMenuLabel {margin-right: 1%;}
        .additionalMenuContainer > #additionalMenuValue {margin-right: 4%;}
	}
	@media all and (max-width: 347px) {
		.paragraph { text-align: center; margin-top: 60px;}
        .tanContainer {margin-left: 33%; display:flex; justify-content: center;}
	}

    .additionalMenuContainer {
      width : 100%;
      display:flex;
      justify-content: center;
    }
    .additionalMenuContainer > #additionalMenuLabel {
      width : 50%;
      text-align : right;
    }

    .additionalMenuContainer > #additionalMenuValue {
      margin-right: 28.5%;
      margin-left: 1.5%;
      width : 20%;
      text-align : left;
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
	<message-banner  close-button="''network_means_pageType_174''"
                    back-button="''network_means_pageType_175''"></message-banner>
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
            <means-choice-menu></means-choice-menu>

		</div>
        <div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
        <div class="additionalMenuContainer">
				<div id = "additionalMenuLabel">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<div id = "additionalMenuValue" >
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
		</div>
	</div>
</div>
', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('APP Choice Page (', @bankName, ')') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		font-size:14px;
	}

	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}

	#optGblPage #selection-group switch-means-button button span.fa-life-ring:before {
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
	#switch-means-mobile_app_ext-img {
		content:'''';
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
		content:'''';
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
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n > button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	/* overrides for the cancel and validate button */
    #cancelButton button {
	    width: 35%;
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
    }

    val-button button.btn {
        width: 35%;
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

    val-button button:active {
       background-color: #FF8C00;
       box-shadow: 0 3px #666;
    }

    val-button button.btn[disabled]:hover {
        width: 35%;
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

    val-button button.btn:hover {
        background-color: #FFA500;
    }

    val-button button.btn div {
        display:inline;
    }

    val-button button.btn custom-text span {
        vertical-align:10%;
        color: #fff;
    }

    .footerDiv {
		display:flex;
        flex-direction:row;
        margin-top:1em;
        width: 70%;
        margin-left: 15%;
	}
    .col1 {
	    width:50%;
    }
    .col2 {
	    width: 50%;
    }
	div#footer {padding-top: 12px;padding-bottom:12px;
		width:100%;
		background-color:#F0F0F0;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
		clear:both;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
		margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
		padding-left: 16px;
		margin-right: 25%;
	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	#meanParagraph{
		text-align: left;
		margin-top: -2px;
		margin-bottom : 20px;
	}
	#meanchoice{
		text-align: left;
		padding-left: 21%;
	}
	#meanchoice .text-center {
		margin-bottom: 20px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
		text-align: center;
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
	@media all and (max-width: 1610px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo {max-height : 64px;  max-width:100%; }
		#networkLogo {max-height : 72px;px;  max-width:100%; }
		#optGblPage {font-size : 14px;}
		.topColumn { display:block; float:none; width:100%; }
		.bottomColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#meanParagraph{ text-align: center; margin-top: 20px;}
		#meanchoice{ text-align: center; padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage {font-size : 14px;}
		#issuerLogo {max-height : 54px;  max-width:100%; }
		#networkLogo {max-height : 67px;  max-width:100%;}
		.topColumn { display:block; float:none; width:100%; }
		.bottomColumn { margin-left:0px; display:block; float:none; width:100%; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#meanParagraph{ text-align: center; margin-top: 20px;}
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 480px) {
		h1 {font-size:16px;}
		div.side-menu div.menu-title {display:inline;}
		#optGblPage {   font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:100%; }
		#networkLogo {max-height : 62px;  max-width:100%; }
		.topColumn { display:block; float:none; width:100%; }
		.bottomColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#meanParagraph{ text-align: center; margin-top: 20px;}
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
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
        <div id="meanchoice">
			<device-select devices="deviceSelectValues" select-box-style-enabled="true"></device-select>
		</div>
	</div>
	<div class="footerDiv">
	    <div class="col1"></div>
		<div class="col2">
		   	<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		    <val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Password OTP Form Page (',@bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>

	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background-color: #FF8C00;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
	    background-color: #FF8C00;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:disabled {
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:hover:enabled {
		border-color: #000000;
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#validateButton button:hover:enabled {
		border-color: #000000;
        background: #FFFFFF;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
    div#footerDiv {
		height: 40px !important;
		width: 50%;
		padding-top: 0px;
        padding-bottom: 0px;
        clear: both;
        display: inline-block;
        text-align: end;
        margin-left: 25%;
	}
	div#footerButtonDiv {
        width: 100%;
	    display: inline-block;
        vertical-align: middle;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
	    margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
	    padding-left: 16px;
		margin-right: 25%;
	}
     #paragraph1 {
    font-size: 18px;
    }
    #paragraph2, #paragraph3 {
    font-size: 14px;
    }
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		padding-top:1em;
		padding-bottom: 5em;
		clear:both;
	    text-align: center;
	}
    .kundennummer {
      margin-left: 5.5%;
      display:flex;
      justify-content: center;
    }
    .kundennummer > #kundennummerLabel{
      margin-right: 1%;
     }
     .kundennummer > #otpForm {
      margin-right: 4%;
    }
     .tanContainer {
      margin-left: 18.5%;
      display:flex;
      justify-content: center;
    }
    .tanContainer > #tanLabel {
      margin-right: 1%;
    }

    .tanContainer > #otpForm {
      margin-right: 4%;
    }
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
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
		display:flex;
		padding-left:9%;
		text-align:left;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	#otp-form {
		display:inline-block;
		padding-top:0px;
		padding-bottom: 10px;
	}
	#otp-form input {
		box-sizing:content-box;
		padding: 0px 0px 0px;
		background-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
		font-family: Arial,bold;
		color: #333333;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 25px;
		width: 220px;
	}
	#otp-form input:disabled {
		color: #bebebe!important;
		background-color: #dcdcdc!important;
		border-color: rgba(0,0,0,.05)!important;
		box-shadow: none!important;
	}
	#otp-form input:focus {
		border-color:#FF6A10 !important;
		outline-color: #FF6A10;
	}
	div#otp-fields-container {
		width:70%;
		text-align:center;
		margin-top:10px;
		margin-bottom:10px;
	}
	div#otp-fields {
		display:inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
     @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo {max-height : 72px;px;  max-width:100%; }
		#optGblPage {     font-size : 14px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 150px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { margin-left:0px; margin-top: 150px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage {   font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
    @media all and (max-width: 347px) {
		.paragraph { text-align: center; margin-top: 60px;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
        <div class="kundennummer">
                <div id = "kundennummerLabel">
                   <custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
                </div>
                <div id = "otpForm" >my secret question</div>
        </div>
        <div class="tanContainer">
				<div id = "tanLabel">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<div id = "otpForm" >
					<otp-form></otp-form>
				</div>
		</div>
	</div>
	<div  id="footerDiv" class="cn">
		<div ng-style="style" class="style inner" id="footerButtonDiv">
			<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
			<val-button cn-label="\'network_means_pageType_42\'" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('CHIPTAN OTP Form Page (',@bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>

	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background-color: #FF8C00;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
	    background-color: #FF8C00;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:disabled {
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:hover:enabled {
		border-color: #000000;
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#validateButton button:hover:enabled {
		border-color: #000000;
        background: #FFFFFF;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
    div#footerDiv {
		height: 40px !important;
		width: 50%;
		padding-top: 0px;
        padding-bottom: 0px;
        clear: both;
        display: inline-block;
        text-align: end;
        margin-left: 25%;
	}
	div#footerButtonDiv {
        width: 100%;
	    display: inline-block;
        vertical-align: middle;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
	    margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
	    padding-left: 16px;
		margin-right: 25%;
	}
     #paragraph1 {
    font-size: 18px;
    }
    #paragraph2, #paragraph3 {
    font-size: 14px;
    }
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		padding-top:1em;
		padding-bottom: 5em;
		clear:both;
	    text-align: center;
	}
    .tanContainer {
      margin-left: 18%;
      display:flex;
      justify-content: center;
    }
    .tanContainer > #tanLabel {
      margin-right: 1%;
    }

    .tanContainer > #otpForm {
      margin-right: 4%;
    }
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
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
		display:flex;
		padding-left:9%;
		text-align:left;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	#otp-form {
		display:inline-block;
		padding-top:0px;
		padding-bottom: 10px;
	}
	#otp-form input {
		box-sizing:content-box;
		padding: 0px 0px 0px;
		background-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
		font-family: Arial,bold;
		color: #333333;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 25px;
		width: 220px;
	}
	#otp-form input:disabled {
		color: #bebebe!important;
		background-color: #dcdcdc!important;
		border-color: rgba(0,0,0,.05)!important;
		box-shadow: none!important;
	}
	#otp-form input:focus {
		border-color:#FF6A10 !important;
		outline-color: #FF6A10;
	}
	div#otp-fields-container {
		width:70%;
		text-align:center;
		margin-top:10px;
		margin-bottom:10px;
	}
	div#otp-fields {
		display:inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
     @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo {max-height : 72px;px;  max-width:100%; }
		#optGblPage {     font-size : 14px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 150px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { margin-left:0px; margin-top: 150px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage {   font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
    @media all and (max-width: 347px) {
		.paragraph { text-align: center; margin-top: 60px;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<div id = "otpForm" >
					<otp-form></otp-form>
				</div>
		</div>
	</div>
	<div  id="footerDiv" class="cn">
		<div ng-style="style" class="style inner" id="footerButtonDiv">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<val-button val-label="''network_means_pageType_42''" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('ITAN OTP Form Page (',@bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;
	}
	#validateButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFCC33;
		border-color: #FFCC33;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
		color: #333333;
		display:inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #FFFFFF;
		border-color: #333333;
		color: #323232;
		border: 1px solid rgba(0,0,0,.25);
		min-width: 15rem;
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:disabled {
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
		border-radius: 4px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:hover:enabled {
		border-color: #000000;
		background: #FFFFFF;
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align:7px;
	}
	#validateButton button:hover {
		border-color: #000000;
	}
	#validateButton button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		border-color: #333333;
		box-shadow: none;
		outline: 0px;
	}
	#validateButton button custom-text {
		vertical-align:2px;
	}
	#footer #validateButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span:before {
		content:\'\';
	}
	#footer #cancelButton button span.fa {
		background-image:url(data:image/png;base64,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);
		width:24px;
		height:26px;
		background-position-y:1px;
		background-position-x:2px;
		background-size:contain;
		display:inline-block;
		margin-right: 3px;
	}
	#footer #validateButton > button > span.fa-check-square {
		display:none;
	}
	#footer {
		padding-top: 12px;
		padding-bottom:12px;
		width:100%;
		background-color: #FFFFFF;
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
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
	}
	.paragraph {
		margin: 5px 0px 10px;
		text-align: left;
		font-family: Arial,bold;
		color: #333333;
		font-size:18px;
	}
	.leftColumn {
		width:45%;
		display:block;
		float:left;
	}
	.rightColumn {
		width:55%;
		margin-left:45%;
		display:block;
		text-align:left;
		padding:20px 10px 20px;
		padding-left: 1em;
		border: 1px solid;
		background-color: #EAEAEA;
		border-color: #C1C1C1;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		padding-top:1em;
		padding-bottom: 5em;
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
		text-align: start;
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
		display:flex;
		padding-left:9%;
		text-align:left;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}
	#otp-form {
		display:inline-block;
		padding-top:0px;
		padding-bottom: 10px;
	}
	#otp-form input {
		box-sizing:content-box;
		padding: 0px 0px 0px;
		background-color: #FFFFFF;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0,0,0,.1);
		font-family: Arial,bold;
		color: #333333;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 25px;
		width: 150px;
	}
	#otp-form input:disabled {
		color: #bebebe!important;
		background-color: #dcdcdc!important;
		border-color: rgba(0,0,0,.05)!important;
		box-shadow: none!important;
	}
	#otp-form input:focus {
		border-color:#FF6A10 !important;
		outline-color: #FF6A10;
	}
	div#otp-fields {
		display:inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 { font-size:24px; }
		#issuerLogo {max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo {max-height : 72px;px;  max-width:100%; }
		#optGblPage {     font-size : 14px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 150px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div.side-menu div.menu-title { padding-left: 8.8%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#otp-form{ display:block; width:100px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields { width:100%; padding-right: 150px;}
		div#otp-fields-container { width:70%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo {max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo {max-height : 67px;  max-width:100%; padding-top: 25px;}
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { margin-left:0px; margin-top: 150px; display:block; float:none; width:100%; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#otp-form{ display:block; width:100px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%; }
		div#otp-fields { width:100%; padding-right: 100px;}
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage {   font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.leftColumn { display:block; float:none; width:100%; }
		.rightColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px; border: 1px solid; background-color: #EAEAEA; border-color: #C1C1C1;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#otp-form{ display:block; width:100px; margin-left:auto; margin-right:auto; }
		#otp-form input { width:100%;}
		div#otp-fields { width:100%;  padding-right: 0px;}
		div#otp-fields-container { width:100%; text-align:center; margin-top:10px; margin-bottom:10px; }
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="\'network_means_pageType_2\'"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</div>

			<custom-text custom-text-key="\'network_means_pageType_3\'" id="paragraph3"></custom-text>

			<div x-ms-format-detection="none" id="otp-fields">
				<otp-form></otp-form>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
			<val-button val-label="\'network_means_pageType_42\'" id="validateButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (',@bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		color: #333333;
		font-size:14px;

	}
	#cancelButton button {
	    width: 100%;
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
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
	}
	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display:flex;
		justify-content: space-between;
	}
	#pageHeaderLeft {
		padding-left: 16px;
		padding-top: 16px;
	}

	#pageHeaderRight {
		width: 20%;
		padding-right: 16px;
		padding-top: 16px;

	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
		text-align: center;
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
    	padding-left:30.9%;
    	text-align:left;
    	font-size: 18px;
    }
    div.side-menu div.menu-elements {
    	margin-top:5px;
    }
    div#footerDiv {
		background-color: #F7F8F8;

padding: 1em;
    clear: both;

        text-align: center;

	}

div#footerButtonDiv {
    width: 50%;
    display: inline-block;
    vertical-align: middle;
}

    @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
 @media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:75%; padding-top: 5px;}
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.paragraph { text-align: center; }
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:100%; padding-top: 10px;}
		#networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { margin-left:0px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:100%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { }
		#pageHeader { height: 75px; }
	}
@media all and (max-width: 347px) {
		.paragraph { text-align: center;}
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
	<div class="contentRow">
	     <div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
            <div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph2"></custom-text>
			</div>
		</div>
        <div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
	</div>
	<div id="footerDiv" class="cn">
		<div ng-style="style" class="style inner" id="footerButtonDiv">
            <cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Means Page (', @bankName, ')'));

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial,bold;
		font-size:14px;
	}

	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}

	#optGblPage #selection-group switch-means-button button span.fa-life-ring:before {
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
	#switch-means-mobile_app_ext-img {
		content:'''';
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
		content:'''';
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
	#cancelButton button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#i18n > button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	/* overrides for the cancel and validate button */
    #cancelButton button {
	    width: 35%;
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
    }

    val-button button.btn {
        width: 35%;
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

    val-button button:active {
       background-color: #FF8C00;
       box-shadow: 0 3px #666;
    }

    val-button button.btn[disabled]:hover {
        width: 35%;
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

    val-button button.btn:hover {
        background-color: #FFA500;
    }

    val-button button.btn div {
        display:inline;
    }

    val-button button.btn custom-text span {
        vertical-align:10%;
        color: #fff;
    }

    .footerDiv {
		display:flex;
        flex-direction:row;
        margin-top:1em;
        width: 70%;
        margin-left: 15%;
	}
    .col1 {
	    width:50%;
    }
    .col2 {
	    width: 50%;
    }
	div#footer {padding-top: 12px;padding-bottom:12px;
		width:100%;
		background-color:#F0F0F0;
		text-align:center;
		margin-top: 15px;
		margin-bottom : 15px;
		clear:both;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
		margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
		padding-left: 16px;
		margin-right: 25%;
	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	#meanParagraph{
		text-align: left;
		margin-top: -2px;
		margin-bottom : 20px;
	}
	#meanchoice{
		text-align: center;
        width: 100%;
	}
	#meanchoice .text-center {
		margin-bottom: 20px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		clear:both;
		text-align: center;
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
	@media all and (max-width: 1610px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		#meanParagraph{ text-align: left;}
		#meanchoice{ text-align: center;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo {max-height : 64px;  max-width:100%; }
		#networkLogo {max-height : 72px;px;  max-width:100%; }
		#optGblPage {font-size : 14px;}
		.topColumn { display:block; float:none; width:100%; }
		.bottomColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#meanParagraph{ text-align: center; margin-top: 20px;}
		#meanchoice{ text-align: center; padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage {font-size : 14px;}
		#issuerLogo {max-height : 54px;  max-width:100%; }
		#networkLogo {max-height : 67px;  max-width:100%;}
		.topColumn { display:block; float:none; width:100%; }
		.bottomColumn { margin-left:0px; display:block; float:none; width:100%; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#meanParagraph{ text-align: center; margin-top: 20px;}
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}
	@media all and (max-width: 480px) {
		h1 {font-size:16px;}
		div.side-menu div.menu-title {display:inline;}
		#optGblPage {   font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:100%; }
		#networkLogo {max-height : 62px;  max-width:100%; }
		.topColumn { display:block; float:none; width:100%; }
		.bottomColumn { display:block; float:none; width:100%; margin-left:0px; }
		div.side-menu div.menu-title { padding-left:0px; text-align:center; }
		side-menu div.text-center { text-align:center; }
		#meanParagraph{ text-align: center; margin-top: 20px;}
		#meanchoice{ text-align: center;padding-right: 0rem;padding-left: 1.3rem;}
	}

    .additionalMenuContainer {
      width : 100%;
      display:flex;
      justify-content: center;
    }
    .additionalMenuContainer > #additionalMenuLabel {
      width : 50%;
      text-align : right;
    }

    .additionalMenuContainer > #additionalMenuValue {
      margin-left: 1%;
      width : 50%;
      text-align : left;
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
        <div class="additionalMenuContainer">
				<div id = "additionalMenuLabel">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
                <div id = "additionalMenuValue">
                    <div id="meanchoice">
                        <means-select means-choices="meansChoices"></means-select>
                    </div>
                </div>

		</div>
	</div>
	<div class="footerDiv">
	    <div class="col1"></div>
		<div class="col2">
		   	<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		    <val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId=(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size:14px;
	}
	#helpCloseButton button {
		font: 300 16px/20px Arial,bold;
	    width: 100%;
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
    div#footerDiv {
		height: 40px !important;
		width: 50%;
		padding-top: 0px;
        padding-bottom: 0px;
        clear: both;
        display: inline-block;
        text-align: center;
        margin-left: 25%;
	}
	div#footerButtonDiv {
        width: 100%;
	    display: inline-block;
        vertical-align: middle;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
        margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
        padding-left: 16px;
		margin-right: 25%;
	}
    #paragraph1 {
    font-size: 18px;
    }

    #paragraph2, #paragraph3 {
    font-size: 14px;
    }
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		padding-top:1em;
		padding-bottom: 5em;
		clear:both;
        text-align: center;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
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
		display:flex;
		padding-left:9%;
		text-align:left;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

    @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 150px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center; margin-top: 60px;}
		.topColumn { margin-left:0px; margin-top: 150px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
     @media all and (max-width: 347px) {
		.paragraph { text-align: center; margin-top: 60px;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

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
           <div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
		</div>
	</div>
	<div  id="footerDiv" class="cn">
		<div ng-style="style" class="style inner" id="footerButtonDiv">
			<help-close-button id="helpCloseButton" cn-label="''network_means_pageType_174''" ></help-close-button>
		</div>
	</div>
</div>', @layoutId);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @bankName, ')%') );

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
VALUES( 'div', '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size:14px;
	}
	#cancelButton button {
		font: 300 16px/20px Arial,bold;
	    width: 100%;
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
    div#footerDiv {
		height: 40px !important;
		width: 50%;
		padding-top: 0px;
        padding-bottom: 0px;
        clear: both;
        display: inline-block;
        text-align: center;
        margin-left: 25%;
	}
	div#footerButtonDiv {
        width: 100%;
	    display: inline-block;
        vertical-align: middle;
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
        padding-top: 16px;
	}
	#networkLogo {
		max-height: 80px;
		max-width:100%;
		padding-top: 16px;
		padding-right: 16px;
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
        margin-left: 25%;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 20%;
		float: right;
		text-align: right;
        padding-left: 16px;
		margin-right: 25%;
	}
    #paragraph1 {
    font-size: 18px;
    }

    #paragraph2, #paragraph3 {
    font-size: 14px;
    }
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom : 5px;
	}
	.topColumn {
		width:50%;
		display:inline-block;
	}
	.bottomColumn {
		width:50%;
		display:inline-block;
		text-align:left;
		padding-left: 1em;
	}
	.contentRow {
		width:100%;
		padding:1em;
		padding:0px;
		padding-top:1em;
		padding-bottom: 5em;
		clear:both;
        text-align: center;
	}
	side-menu .text-left {
		padding-right: 5px;
		padding-left: 5px;
		text-align: start;
	}
	side-menu .text-right {
		padding-right: 5px;
		padding-left: 5px;
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
		display:flex;
		padding-left:9%;
		text-align:left;
		font-size: 16px;
	}
	div.side-menu div.menu-elements {
		margin-top:5px;
	}

    @media all and (max-width: 1610px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1278px) and (min-width: 764px) {
		.topColumn { display:block; float:none; width:100%; margin-left:0px; }
		.paragraph{ text-align: left;}
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size:24px;}
		#issuerLogo { max-height : 64px;  max-width:140%; padding-top: 5px;}
		#networkLogo { max-height : 72px;px;  max-width:100%; }
		#optGblPage { font-size : 14px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 150px;}
		div.side-menu div.menu-title { padding-left: 9.2%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size:18px; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 54px;  max-width:200%; padding-top: 10px;}
		#networkLogo { max-height : 67px;  max-width:100%; padding-top: 25px;}
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { margin-left:0px; margin-top: 150px; display:block; float:none; width:100%;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
	}

	@media all and (max-width: 480px) {
		h1 { font-size:16px; }
		div.side-menu div.menu-title { display:inline; }
		#optGblPage { font-size : 14px;}
		#issuerLogo { max-height : 42px;  max-width:250%; padding-top: 10px;}
		#networkLogo {max-height : 62px;  max-width:100%; padding-top: 25px; }
		.paragraph { text-align: center; margin-top: 60px;}
		.bottomColumn { display:block; float:none; width:100%; }
		.topColumn { display:block; float:none; width:100%; margin-left:0px; margin-top: 200px;}
		div.side-menu div.menu-title { padding-left: 1%; display: flex; }
		side-menu div.text-center { text-align:center; }
		side-menu .text-left { padding-right: 5px; padding-left: 5px; text-align: start;}
		side-menu .text-right { padding-right: 5px; padding-left: 5px; text-align: start;}
		#footer { margin-top: 7px; margin-bottom : 10px; padding-top: 6px; padding-bottom: 6px; }
		#pageHeader { height: 75px; }
	}
     @media all and (max-width: 347px) {
		.paragraph { text-align: center; margin-top: 60px;}
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="\'network_means_pageType_1_IMAGE_ALT\'" image-key="\'network_means_pageType_1_IMAGE_DATA\'" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="\'network_means_pageType_2_IMAGE_ALT\'"  image-key="\'network_means_pageType_2_IMAGE_DATA\'" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="\'network_means_pageType_174\'" back-button="\'network_means_pageType_175\'"></message-banner>

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
           <div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
		</div>
        <div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
	</div>
	<div  id="footerDiv" class="cn">
		<div ng-style="style" class="style inner" id="footerButtonDiv">
			<cancel-button cn-label="\'network_means_pageType_174\'" id="cancelButton" ></cancel-button>
		</div>
	</div>
</div>', @layoutId);
